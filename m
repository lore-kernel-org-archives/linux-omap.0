From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH] ARM: dts: add AM33XX EDMA support
Date: Mon, 26 Aug 2013 10:33:33 +0200
Message-ID: <521B12DD.8010505@baylibre.com>
References: <1377284808-32412-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:50862 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756052Ab3HZIdh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Aug 2013 04:33:37 -0400
Received: by mail-ea0-f174.google.com with SMTP id z15so1438909ead.19
        for <linux-omap@vger.kernel.org>; Mon, 26 Aug 2013 01:33:36 -0700 (PDT)
In-Reply-To: <1377284808-32412-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: tony@atomide.com, Joel Fernandes <joelf@ti.com>, santosh.shilimkar@ti.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Matt Porter <mdp@ti.com>, Matt Porter <mporter@ti.com>, Joel A Fernandes <joelagnel@ti.com>

Hi Sebastian,

Is this patch different from that one:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg92176.html

Lokesh just pointed me this patch because it was missing for the 
SHAM/AES series from Mark Greer.

Bottom-line, I've just applied the original one along with a second one 
that was adding EDMA in SPI.

Regards,
Benoit


On 23/08/2013 21:06, Sebastian Andrzej Siewior wrote:
> From: Matt Porter <mdp@ti.com>
>
> Adds AM33XX EDMA support to the am33xx.dtsi as documented in
> Documentation/devicetree/bindings/dma/ti-edma.txt
>
> Joel: Drop DT entries that are non-hardware-description for now as discussed in [1]
>
> [1] https://patchwork.kernel.org/patch/2226761/
>
> Signed-off-by: Matt Porter <mporter@ti.com>
> Signed-off-by: Joel A Fernandes <joelagnel@ti.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> Could someone please pick this up?
>
>   arch/arm/boot/dts/am33xx.dtsi | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index 38b446b..784f774 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -96,6 +96,18 @@
>   			reg = <0x48200000 0x1000>;
>   		};
>
> +		edma: edma@49000000 {
> +			compatible = "ti,edma3";
> +			ti,hwmods = "tpcc", "tptc0", "tptc1", "tptc2";
> +			reg =	<0x49000000 0x10000>,
> +				<0x44e10f90 0x10>;
> +			interrupts = <12 13 14>;
> +			#dma-cells = <1>;
> +			dma-channels = <64>;
> +			ti,edma-regions = <4>;
> +			ti,edma-slots = <256>;
> +		};
> +
>   		gpio0: gpio@44e07000 {
>   			compatible = "ti,omap4-gpio";
>   			ti,hwmods = "gpio1";
>

