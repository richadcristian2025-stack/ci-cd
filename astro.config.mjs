// @ts-check
import { defineConfig } from 'astro/config';
import tailwind from '@astrojs/tailwind';

// https://astro.build/config
export default defineConfig({
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
  },
  // Enable View Transitions API
  // Note: Removed experimental.viewTransitions as it's not a valid option
});
