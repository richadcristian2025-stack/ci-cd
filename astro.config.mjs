// @ts-check
import { defineConfig } from 'astro/config';
import tailwind from '@astrojs/tailwind';

// https://astro.build/config
export default defineConfig({
  site: 'https://richadcristian2025-stack.github.io/ci-cd',
  base: '/ci-cd',
  integrations: [
    tailwind({
      applyBaseStyles: false,
    })
  ],
  server: {
    headers: {
      'Service-Worker-Allowed': '/',
    },
  },
  vite: {
    build: {
      rollupOptions: {
        external: ['/sw.js', '/manifest.json']
      }
    }
  }
});
