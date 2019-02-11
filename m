From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH v2] dt-bindings: input: ti-tsc-adc: Add new compatible for
 AM654 SoCs
Date: Mon, 11 Feb 2019 11:10:59 +0530
Message-ID: <3623af02-063d-9077-1e59-99d8cfe93ddd@ti.com>
References: <20190108052631.4169-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190108052631.4169-1-vigneshr@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Dmitry,

On 08/01/19 10:56 AM, Vignesh R wrote:
> AM654 SoCs has ADC IP which is similar to AM335x, but without the
> touchscreen part. Add new compatible to handle AM654 SoCs. Also, it
> seems that existing compatible strings used in the kernel DTs were never
> documented. So, document them now.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---

If there are no comments, could you queue this bindings patch? This will
help me in getting ADC DT nodes to be merged into ARM SoC tree.

Regards
Vignesh

> v2:
> Fix subject line to include subsystem name
> Rebase onto v5.0-rc1
> v1: https://lkml.org/lkml/2018/11/19/313
> 
>  .../devicetree/bindings/input/touchscreen/ti-tsc-adc.txt  | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt b/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
> index b1163bf97146..aad5e34965eb 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
> @@ -2,7 +2,12 @@
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
>  Required properties:
> +- mfd
> +	compatible: Should be
> +		"ti,am3359-tscadc" for AM335x/AM437x SoCs
> +		"ti,am654-tscadc", "ti,am3359-tscadc" for AM654 SoCs
>  - child "tsc"
> +	compatible: Should be "ti,am3359-tsc".
>  	ti,wires: Wires refer to application modes i.e. 4/5/8 wire touchscreen
>  		  support on the platform.
>  	ti,x-plate-resistance: X plate resistance
> @@ -25,6 +30,9 @@ Required properties:
>  			AIN0 = 0, AIN1 = 1 and so on till AIN7 = 7.
>  			XP  = 0, XN = 1, YP = 2, YN = 3.
>  - child "adc"
> +	compatible: Should be
> +		    "ti,am3359-adc" for AM335x/AM437x SoCs
> +		    "ti,am654-adc", "ti,am3359-adc" for AM654 SoCs
>  	ti,adc-channels: List of analog inputs available for ADC.
>  			 AIN0 = 0, AIN1 = 1 and so on till AIN7 = 7.
>  
> 

-- 
Regards
Vignesh
