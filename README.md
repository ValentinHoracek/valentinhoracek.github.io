# Valentin Horacek — Systems & Performance

A high-impact, split-screen portfolio designed to bridge two professional domains: Software Architecture and Performance Art.

## The Concept

The site utilizes a diagonal "Slash" geometry to visualize the duality of the user's career:
- **Systems (Left/Dark):** Focuses on structure, governance, and logic.
- **Performance (Right/Light):** Focuses on awareness, improvisation, and execution.

## Architecture & Tech Stack

### Frontend Engineering
- **Semantic HTML5:** Structured for accessibility (ARIA) and SEO.
- **CSS Architecture:** Implemented via **Dart Sass** using a layered, modular approach (inspired by ITCSS) to ensure scalability and maintainability.
- **Dynamic Geometry:** Leverages CSS Custom Properties (`--split-angle`) and `clip-path` for a responsive, non-rectangular layout.
- **Visual Effects:** `backdrop-filter` for the frosted-glass nameplate and high-contrast color theory (#2d0a0a "Black Cherry").

### Design System
- **Typography:** Monospaced **Hack** (Local) and **IBM Plex Mono** (Fallback) to reflect a "System Terminal" aesthetic.
- **Iconography:** Font Awesome 5 for high-density professional links.

## Project Structure (SCSS Layers)
0-Utils/    # Variables (Colors, Spacing)
1-Tools/    # Third-party mixins
2-Base/     # Reset and Typography
3-Modules/  # Reusable components (Panels, Nameplate)
4-Pages/    # Layout-specific logic for the diagonal split