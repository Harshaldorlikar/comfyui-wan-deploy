#!/bin/bash
set -e

echo "========================================================"
echo "📥 Downloading Exact NextDiffusion Models & Dependencies"
echo "========================================================"

if [ -d "ComfyUI" ]; then
    cd ComfyUI
else
    echo "❌ Error: ComfyUI directory not found. Please run install.sh first."
    exit 1
fi

echo "📁 Creating required model directories..."
mkdir -p models/diffusion_models
mkdir -p models/text_encoders
mkdir -p models/vae
mkdir -p models/clip_vision
mkdir -p models/loras
mkdir -p models/detection

download_model() {
    local url=$1
    local dir=$2
    local filename=$(basename "$url")
    echo "⬇️ Downloading $filename..."
    wget -nc --show-progress -q -P "$dir" "$url"
}

echo "🧠 [1/5] Downloading Wan 14B Base Model..."
download_model "https://huggingface.co/Kijai/WanVideo_comfy_fp8_scaled/resolve/main/Wan22Animate/Wan2_2-Animate-14B_fp8_e4m3fn_scaled_KJ.safetensors" "models/diffusion_models/"

echo "🎨 [2/5] Downloading VAE & CLIP Vision..."
download_model "https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/Wan2_1_VAE_bf16.safetensors" "models/vae/"
download_model "https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/clip_vision/clip_vision_h.safetensors" "models/clip_vision/"

echo "📝 [3/5] Downloading Text Encoder (BF16)..."
download_model "https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/umt5-xxl-enc-bf16.safetensors" "models/text_encoders/"

echo "✨ [4/5] Downloading LoRAs (BF16)..."
download_model "https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/loras/lightx2v_I2V_14B_480p_cfg_step_distill_rank64_bf16.safetensors" "models/loras/"
download_model "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/loras/wan2.2_animate_14B_relight_lora_bf16.safetensors" "models/loras/"

echo "👁️ [5/5] Downloading ONNX Detection Models..."
download_model "https://huggingface.co/Wan-AI/Wan2.2-Animate-14B/resolve/main/process_checkpoint/det/yolov10m.onnx" "models/detection/"
download_model "https://huggingface.co/JunkyByte/easy_ViTPose/resolve/main/onnx/wholebody/vitpose-l-wholebody.onnx" "models/detection/"

echo "========================================================"
echo "🎉 ALL DONE! Your Wan 2.2 Animate server is fully loaded!"
echo "========================================================"
