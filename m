From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [RFC] am33xx: create child nodes for the two musb controllers
Date: Thu, 27 Jun 2013 13:23:59 +0200
Message-ID: <51CC20CF.2080103@ti.com>
References: <20130626153325.GA24075@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33112 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752176Ab3F0LYR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Jun 2013 07:24:17 -0400
In-Reply-To: <20130626153325.GA24075@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Felipe Balbi <balbi@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

Hi Sebastian,

On 06/26/2013 05:33 PM, Sebastian Andrzej Siewior wrote:
> I've been thinkig about creating two child nodes for the independent musb
> controllers on the am33. I've been thinking about the following:
> 
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index 8e1248f..6aa9506 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -326,21 +326,78 @@
>  			status = "disabled";
>  		};
>  
>  		usb@47400000 {
>  			compatible = "ti,musb-am33xx";
> -			reg = <0x47400000 0x1000	/* usbss */
> -			       0x47401000 0x800		/* musb instance 0 */
> -			       0x47401800 0x800>;	/* musb instance 1 */
> -			interrupts = <17		/* usbss */
> -				      18		/* musb instance 0 */
> -				      19>;		/* musb instance 1 */
> -			multipoint = <1>;
> -			num-eps = <16>;
> -			ram-bits = <12>;
> -			port0-mode = <3>;
> -			port1-mode = <3>;
> -			power = <250>;
> +			reg = <0x47400000 0x1000>;	/* usbss */
> +			interrupts = <17>;		
BTW, why do have so many DMA compared to the previous version?
/* usbss */
>  			ti,hwmods = "usb_otg_hs";
> +
> +			usb0@0x47401000 {
> +				reg = <0x47401000 0x800>;	/* musb instance 0 */
> +				interrupts = <18>;		/* musb instance 0 */
> +				multipoint = <1>;
> +				num-eps = <16>;
> +				ram-bits = <12>;
> +				port-mode = <3>;
> +				power = <250>;
> +
> +				phys = <&nopphy0>;
> +				dmas = <&cppi41dma 0
> +					&cppi41dma 1
> +					&cppi41dma 2
> +					&cppi41dma 3
> +					&cppi41dma 4
> +					&cppi41dma 32
> +					&cppi41dma 34
> +					&cppi41dma 36
> +					&cppi41dma 38
> +					&cppi41dma 40>;
> +				dma-names = "rx1", "rx2", "rx3", "rx4", "rx5",
> +					    "tx1", "tx2", "tx3", "tx4", "tx5";
> +			};
> +
> +			usb0@0x47401800 {
> +				reg = <0x47401800 0x800>;	/* musb instance 1 */
> +				interrupts = <19>;		/* musb instance 1 */
> +				multipoint = <1>;
> +				num-eps = <16>;
> +				ram-bits = <12>;
> +				port-mode = <3>;
> +				power = <250>;
> +
> +				phys = <&nopphy1>;
> +				dmas = <&cppi41dma 0
> +					&cppi41dma 1
> +					&cppi41dma 2
> +					&cppi41dma 3
> +					&cppi41dma 4
> +					&cppi41dma 62
> +					&cppi41dma 64
> +					&cppi41dma 66
> +					&cppi41dma 68
> +					&cppi41dma 70>;
> +				dma-names = "rx1", "rx2", "rx3", "rx4", "rx5",
> +					    "tx1", "tx2", "tx3", "tx4", "tx5";
> +			};
> +		};
> 
> Please keep in mind that his is not a proper patch it should point out
> what I have in mind.
> This would easy the for instance the dma channel assignment. Also, it will
> move back to the port-mode property instead of portX-mode one which it has
> now. This is kind of confusing since it is not a root hub or anything like
> that it is a complete musb controller. Plus for the phys property could
> easily take the one avaible and would not require which instance it
> really it is.

I don't know the HW in detail, but that looks indeed much better and
seems to reflect the partitioning with multiple instances accurately.

If Felipe is OK with that partitioning, I'll take it.

Thanks,
Benoit


