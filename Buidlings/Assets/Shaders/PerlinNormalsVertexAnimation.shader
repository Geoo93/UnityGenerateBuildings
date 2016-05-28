﻿
Shader ".ShaderExample/PerlinNormalsVertexAnimation" {

	Properties {

		_Frequency ("Frequency", Range(-2.0,2.0)) = 0.5
		_Noise ("Noise", Range(-10.0,10.0)) = 0.0
		_Speed ("Speed", Range(0.0,20.0)) = 2.5

    
    }

  SubShader {

    Pass {
      CGPROGRAM
      #pragma vertex vert
      #pragma fragment frag
      #include "UnityCG.cginc"


      float _Frequency, _Noise, _Speed;

      struct v2f {
          float4 pos : SV_POSITION;
          fixed4 color : COLOR;
      };
      
      v2f vert (appdata_base IN)
      {
	        v2f OUT;

	         ////smooth wave on the x and z axis
	        IN.vertex.xyz += IN.normal * ( sin((IN.vertex.x + _Time * _Speed) * _Noise ) + cos((IN.vertex.z + _Time * _Speed) * _Noise )) * _Frequency;

         	//Color
         	OUT.color = float4(IN.normal,1) * 0.5 + 0.5;

         	//this line must be after the vertex manipulation
          	OUT.pos = mul (UNITY_MATRIX_MVP, IN.vertex);

         	return OUT;
      }

      fixed4 frag (v2f i) : SV_Target 
      { 
      	return i.color;
      }
      ENDCG
    }


  } 



}
