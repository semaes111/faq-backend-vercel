create extension if not exists vector;

create table if not exists faqs (
  id uuid primary key default gen_random_uuid(),
  tema text,
  pregunta text not null,
  respuesta text not null,
  embedding vector(1536),
  created_at timestamptz default now()
);

create index if not exists faqs_embedding_ivfflat
on faqs using ivfflat (embedding vector_cosine_ops)
with (lists = 100);

create or replace view public_faqs as
select id, tema, pregunta, respuesta, created_at
from faqs;

alter table faqs enable row level security;

create or replace function match_faqs(query_embedding vector(1536), match_count int default 5)
returns table(id uuid, tema text, pregunta text, respuesta text, score float)
language sql stable as $$
  select f.id, f.tema, f.pregunta, f.respuesta,
         1 - (f.embedding <#> query_embedding) as score
  from faqs f
  where f.embedding is not null
  order by f.embedding <#> query_embedding
  limit match_count;
$$;

grant execute on function match_faqs(vector, int) to anon, authenticated;