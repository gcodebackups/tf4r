Shader "Unlit/Texture/BlendOne" {
Properties {
	_MainTex ("Texture", 2D) = "white" {}
	_Color ("Color", Color) = (1,1,1,1)
}

Category {
	Tags {"Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"}
	ZWrite Off
	Blend SrcAlpha One

    SubShader {
    	LOD 200
    	
    	Pass {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"
            
            float4 _Color;
            sampler2D _MainTex;
            
            struct v2f {
                float4  pos : SV_POSITION;
                float2  uv : TEXCOORD0;
            };
            
            float4 _MainTex_ST;
            
            v2f vert (appdata_base v)
            {
                v2f o;
                o.pos = mul (UNITY_MATRIX_MVP, v.vertex);
                o.uv = TRANSFORM_TEX (v.texcoord, _MainTex);
                return o;
            }
            
            half4 frag (v2f i) : COLOR
            {
                half4 texcol = tex2D (_MainTex, i.uv);
                return texcol * _Color;
            }
            ENDCG

    	}
    }
}
}
