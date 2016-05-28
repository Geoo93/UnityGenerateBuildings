﻿
Shader ".ShaderExample/GradientThreeColor" {

     Properties {
        _ColorTop ("Top Color", Color) = (1,1,1,1)
        _ColorMid ("Mid Color", Color) = (1,1,1,1)
        _ColorBot ("Bot Color", Color) = (1,1,1,1)
        _Middle ("Middle", Range(0.001, 0.999)) = 1
     }
 
     SubShader {
         Tags {"Queue"="Background"  "IgnoreProjector"="True"}
         LOD 100
 
         ZWrite On
 
         Pass {
         CGPROGRAM
         #pragma vertex vert  
         #pragma fragment frag
         #include "UnityCG.cginc"

         fixed4 _ColorTop;
         fixed4 _ColorMid;
         fixed4 _ColorBot;
         float  _Middle;
 
         struct v2f {
             float4 pos : SV_POSITION;
             float4 texcoord : TEXCOORD0;
         };
 
         v2f vert (appdata_full IN) {
             v2f OUT;
             OUT.pos = mul (UNITY_MATRIX_MVP, IN.vertex);
             OUT.texcoord = IN.texcoord;
             return OUT;
         }
 
         fixed4 frag (v2f IN) : COLOR {
             fixed4 c = lerp(_ColorBot, _ColorMid, IN.texcoord.y / _Middle) * step(IN.texcoord.y, _Middle);
             c += lerp(_ColorMid, _ColorTop, (IN.texcoord.y - _Middle) / (1 - _Middle)) * step(_Middle, IN.texcoord.y);
             c.a = 1;

             return c;
         }
         ENDCG
         }
     }
 }