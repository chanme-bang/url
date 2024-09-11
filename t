%%writefile app.py
import streamlit as st
from PIL import Image
import io

def convert_jpg_to_png(image):
    """JPG 이미지를 PNG로 변환하는 함수"""
    with io.BytesIO() as output:
        # 이미지를 PNG 포맷으로 저장
        image.save(output, format='PNG')
        png_image = Image.open(io.BytesIO(output.getvalue()))
    return png_image

st.title('JPG to PNG Converter')

# 파일 업로드 위젯
uploaded_file = st.file_uploader("Upload a JPG file", type=["jpg", "jpeg"])

if uploaded_file is not None:
    # 업로드된 파일을 이미지로 열기
    image = Image.open(uploaded_file)
    
    if image.format not in ["JPEG", "JPG"]:
        st.error("Please upload a JPG file.")
    else:
        # JPG 이미지를 PNG로 변환
        png_image = convert_jpg_to_png(image)
        
        # 변환된 PNG 이미지를 화면에 표시
        st.image(png_image, caption='Converted PNG Image', use_column_width=True)
        
        # PNG 파일로 다운로드 링크 생성
        buffered = io.BytesIO()
        png_image.save(buffered, format='PNG')
        st.download_button(
            label="Download PNG",
            data=buffered.getvalue(),
            file_name="converted_image.png",
            mime="image/png"
        )
