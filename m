From: George Cherian <george.cherian@ti.com>
Subject: Re: [PATCH v2] ARM: dts: am33xx: Move the cppi41dma node so it's
 probed early
Date: Mon, 12 May 2014 10:29:52 +0530
Message-ID: <53705548.7020400@ti.com>
References: <1398373881-23369-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54359 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751120AbaELFAa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 May 2014 01:00:30 -0400
In-Reply-To: <1398373881-23369-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Benoit Cousson <bcousson@baylibre.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>

On 4/25/2014 2:41 AM, Ezequiel Garcia wrote:
> The DMA controller is needed for the USB controller to be correctly
> registered. Therefore, if the DMA node is located at the end an unecessary
> probe deferral is produced systematically.
>
> This is easily fixed by moving the node at the beggining of the child list,
> so it's probed first.
>
> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Acked-by: George Cherian <george.cherian@ti.com>
> --
> v1->v2:
>    * Added a comment to prevent a future clean-up based on the memory offset.
>
>   arch/arm/boot/dts/am33xx.dtsi | 34 ++++++++++++++++++++--------------
>   1 file changed, 20 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index 9770e35..02e1eb6 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -453,6 +453,26 @@
>   			ti,hwmods = "usb_otg_hs";
>   			status = "disabled";
>   
> +			/*
> +			 * The probe order matches the child ordering so the
> +			 * dma-controller node must be the first one to prevent
> +			 * spurious probe deferrals.
> +			 */
> +			cppi41dma: dma-controller@47402000 {
> +				compatible = "ti,am3359-cppi41";
> +				reg =  <0x47400000 0x1000
> +					0x47402000 0x1000
> +					0x47403000 0x1000
> +					0x47404000 0x4000>;
> +				reg-names = "glue", "controller", "scheduler", "queuemgr";
> +				interrupts = <17>;
> +				interrupt-names = "glue";
> +				#dma-cells = <2>;
> +				#dma-channels = <30>;
> +				#dma-requests = <256>;
> +				status = "disabled";
> +			};
> +
>   			usb_ctrl_mod: control@44e10620 {
>   				compatible = "ti,am335x-usb-ctrl-module";
>   				reg = <0x44e10620 0x10
> @@ -556,20 +576,6 @@
>   					"tx14", "tx15";
>   			};
>   
> -			cppi41dma: dma-controller@47402000 {
> -				compatible = "ti,am3359-cppi41";
> -				reg =  <0x47400000 0x1000
> -					0x47402000 0x1000
> -					0x47403000 0x1000
> -					0x47404000 0x4000>;
> -				reg-names = "glue", "controller", "scheduler", "queuemgr";
> -				interrupts = <17>;
> -				interrupt-names = "glue";
> -				#dma-cells = <2>;
> -				#dma-channels = <30>;
> -				#dma-requests = <256>;
> -				status = "disabled";
> -			};
>   		};
>   
>   		epwmss0: epwmss@48300000 {


-- 
-George

