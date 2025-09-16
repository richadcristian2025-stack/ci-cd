import fs from 'fs';
import path from 'path';

// Create icons directory if it doesn't exist
const iconsDir = path.join(process.cwd(), 'public', 'icons');
if (!fs.existsSync(iconsDir)) {
  fs.mkdirSync(iconsDir, { recursive: true });
}

// Icon sizes needed for PWA
const sizes = [72, 96, 128, 144, 152, 192, 384, 512];

// Create SVG template for the icon
const createIconSVG = (size) => `
<svg width="${size}" height="${size}" viewBox="0 0 ${size} ${size}" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="grad" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" style="stop-color:#667eea;stop-opacity:1" />
      <stop offset="100%" style="stop-color:#764ba2;stop-opacity:1" />
    </linearGradient>
  </defs>
  <rect width="${size}" height="${size}" rx="${size * 0.2}" fill="url(#grad)"/>
  <text x="50%" y="50%" font-family="Inter, Arial, sans-serif" font-size="${size * 0.4}" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central">R</text>
  <circle cx="${size * 0.8}" cy="${size * 0.2}" r="${size * 0.05}" fill="#feca57" opacity="0.8"/>
  <text x="${size * 0.8}" y="${size * 0.85}" font-family="Arial, sans-serif" font-size="${size * 0.1}" fill="white" text-anchor="middle" opacity="0.7">∫π</text>
</svg>`;

// Generate icons
sizes.forEach(size => {
  const svgContent = createIconSVG(size);
  const filename = `icon-${size}x${size}.svg`;
  const filepath = path.join(iconsDir, filename);
  
  fs.writeFileSync(filepath, svgContent.trim());
  console.log(`Generated ${filename}`);
});

console.log('All icons generated successfully!');
