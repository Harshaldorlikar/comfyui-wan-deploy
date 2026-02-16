#!/bin/bash
set -e

echo "========================================================"
echo "🚀 Starting Setup for ComfyUI + Wan 2.2 Animate"
echo "========================================================"

echo "📦 [1/4] Updating system and installing core dependencies..."
sudo apt update -y && sudo apt install -y git python3-venv python3-pip ffmpeg wget

echo "📦 [2/4] Cloning ComfyUI..."
if [ ! -d "ComfyUI" ]; then
    git clone https://github.com/comfyanonymous/ComfyUI.git
else
    echo "ComfyUI folder already exists. Skipping clone."
fi

cd ComfyUI

echo "🐍 [3/4] Setting up Python Virtual Environment..."
python3 -m venv venv
source venv/bin/activate

pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121
pip install -r requirements.txt

echo "🧩 [4/4] Installing Custom Nodes..."
cd custom_nodes

# Essential Management & Video Handling
git clone https://github.com/ltdrdata/ComfyUI-Manager.git
git clone https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite.git

# Kijai's Nodes (Required for NextDiffusion Wan workflows)
git clone https://github.com/kijai/ComfyUI-WanVideoWrapper.git
cd ComfyUI-WanVideoWrapper && pip install -r requirements.txt && cd ..
git clone https://github.com/kijai/ComfyUI-KJNodes.git

# Detection and Masking
git clone https://github.com/ltdrdata/ComfyUI-Impact-Pack.git
cd ComfyUI-Impact-Pack && python3 install.py && cd ..
git clone https://github.com/kijai/ComfyUI-segment-anything-2.git
cd ComfyUI-segment-anything-2 && pip install -r requirements.txt && cd ..

# ControlNet Aux for DW Pose skeleton tracking
git clone https://github.com/Fannovel16/comfyui_controlnet_aux.git
cd comfyui_controlnet_aux && pip install -r requirements.txt && cd ..

cd ../.. # Back to root of execution

echo "✅ Installation of ComfyUI and Nodes is complete!"
echo "⏳ Now starting Model Downloads..."

# Automatically trigger the model download script
bash $(dirname "$0")/download_models.sh
