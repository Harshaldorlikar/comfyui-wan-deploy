#!/bin/bash
set -e

echo "🚀 Starting COMPLETE 1-Click Setup for NextDiffusion Wan 2.2 Animate..."

# 1. Core Dependencies
sudo apt update && sudo apt install -y git python3-venv python3-pip ffmpeg wget

# 2. Clone ComfyUI & Setup Environment
git clone https://github.com/comfyanonymous/ComfyUI.git
cd ComfyUI
python3 -m venv venv
source venv/bin/activate

# 3. Install PyTorch & Core Requirements
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121
pip install -r requirements.txt

# 4. Install Custom Nodes (Now including ControlNet Aux for DWPose)
echo "📦 Installing Custom Nodes..."
cd custom_nodes

git clone https://github.com/ltdrdata/ComfyUI-Manager.git
git clone https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite.git

git clone https://github.com/kijai/ComfyUI-WanVideoWrapper.git
cd ComfyUI-WanVideoWrapper && pip install -r requirements.txt && cd ..

git clone https://github.com/kijai/ComfyUI-KJNodes.git

git clone https://github.com/ltdrdata/ComfyUI-Impact-Pack.git
cd ComfyUI-Impact-Pack && python3 install.py && cd ..

git clone https://github.com/kijai/ComfyUI-segment-anything-2.git
cd ComfyUI-segment-anything-2 && pip install -r requirements.txt && cd ..

# -> NEW: ControlNet Aux for DW Pose skeleton tracking
git clone https://github.com/Fannovel16/comfyui_controlnet_aux.git
cd comfyui_controlnet_aux && pip install -r requirements.txt && cd ..

cd .. # Back to ComfyUI root

# 5. Create Folders & Download Detection Models
echo "📁 Creating model directories and downloading Detection Models..."
mkdir -p models/detection
mkdir -p models/loras

# -> NEW: YOLOv8 Bbox/Seg models for Impact Pack and NextDiffusion Masking
wget -nc -P models/detection/ https://huggingface.co/Bingsu/adetailer/resolve/main/face_yolov8m.pt
wget -nc -P models/detection/ https://huggingface.co/Bingsu/adetailer/resolve/main/person_yolov8m-seg.pt

# 6. Download the Wan 2.2 FP8 Models and LoRAs
echo "📥 Downloading Wan 14B Models (15GB+)..."

wget -nc -P models/diffusion_models/ https://huggingface.co/Kijai/WanVideo_comfy_fp8_scaled/resolve/main/Wan22Animate/Wan2_2-Animate-14B_fp8_e4m3fn_scaled_KJ.safetensors
wget -nc -P models/text_encoders/ https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/umt5_xxl_fp8_e4m3fn_scaled.safetensors
wget -nc -P models/vae/ https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/vae/wan_2.1_vae.safetensors
wget -nc -P models/clip_vision/ https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/clip_vision/clip_vision_h.safetensors
wget -nc -P models/loras/ https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/loras/lightx2v_I2V_14B_480p_cfg_step_distill_rank64_bf16.safetensors
wget -nc -P models/loras/ https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/loras/WanAnimate_relight_lora_fp16.safetensors

echo "✅ Setup 100% Complete. No red boxes awaiting you."