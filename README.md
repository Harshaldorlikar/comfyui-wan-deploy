# 🚀 ComfyUI + Wan 2.2 Animate Setup

Automated deployment scripts to install **ComfyUI** with the **Wan 2.2 Animate** workflow (NextDiffusion). Optimized for Ubuntu AI/ML GPU Droplets.

## ⚡ One-Line Install

Run this on a fresh DigitalOcean GPU Droplet:

```bash
git clone [https://github.com/Harshaldorlikar/comfyui-wan-deploy.git](https://github.com/Harshaldorlikar/comfyui-wan-deploy.git) && bash comfyui-wan-deploy/install.sh

```
📁 Repository Structure
install.sh - Installs system dependencies, Python environment, ComfyUI, and all required Custom Nodes. Automatically triggers the model download script.

download_models.sh - Downloads the FP8 scaled Wan 14B models, Text Encoders, VAE, LoRAs, and YOLOv8 detection models.

🎮 How to Run
Once the installation is complete, start your ComfyUI server:
```bash
cd ComfyUI
source venv/bin/activate
python main.py --listen 0.0.0.0

```
Access the interface at http://YOUR_DROPLET_IP:8188. Load the JSON workflow, and you are ready to animate!

