# Backend FAQs Dietética (Vercel + Supabase + pgvector)

Este proyecto serverless expone una base de FAQs (`FAQ_Dietetica.csv`) con búsqueda semántica utilizando Supabase y pgvector.

## 1. Configuración

1. Ejecuta `schema.sql` en Supabase para activar `pgvector`, crear la tabla/índice y la función RPC.
2. Importa el fichero `FAQ_Dietetica.csv` en la tabla `faqs` mediante el panel o ejecuta el script `npm run ingest:csv`.
3. Genera los embeddings con `npm run embeddings:backfill`.

## 2. Variables de entorno

Configura `.env.local` o las variables en Vercel con:

```env
SUPABASE_URL=your-supabase-url
SUPABASE_ANON_KEY=your-anon-key
SUPABASE_SERVICE_ROLE_KEY=your-service-role-key  # Solo en el servidor
OPENAI_API_KEY=your-openai-key
EMBEDDING_MODEL=text-embedding-3-small
EMBEDDING_DIM=1536
```

## 3. Endpoints

- `POST /api/faqs/search` - realiza una búsqueda semántica.
- `POST /api/faqs/ingest` - inserta una nueva pregunta y respuesta con su embedding.

## 4. Desarrollo

Instala las dependencias y ejecuta el entorno de desarrollo:

```bash
npm install
npm run dev
```