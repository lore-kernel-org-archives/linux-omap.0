From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH] ARM: dts: OMAP: Add usb_otg and glue data to OMAP3+ boards
Date: Wed, 15 May 2013 11:51:33 +0530
Message-ID: <5193296D.5040001@ti.com>
References: <20130511023557.GB28602@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57330 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754676Ab3EOGWF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 May 2013 02:22:05 -0400
In-Reply-To: <20130511023557.GB28602@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb <linux-usb@vger.kernel.org>

On Saturday 11 May 2013 08:05 AM, Tony Lindgren wrote:
> Commit ad871c10 (ARM: dts: OMAP: Add usb_otg and glue data to
> OMAP3+ boards) added support for MUSB on omap3 for device tree,
> but added the interrupts the wrong way probably as they were
> copied from the omap4.dtsi file. On omap3 we have TI specific
> interrupt controller, not GIC.
>
> Fix this by specifying the interrupt following the TI INTC
> binding.
>
> Without this fix MUSB won't work as it is trying to use
> irq0 instead of irq92.
>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
Tested in beagleboard-xm

Tested-by: Kishon Vijay Abraham I <kishon@ti.com>
>
> --- a/arch/arm/boot/dts/omap3.dtsi
> +++ b/arch/arm/boot/dts/omap3.dtsi
> @@ -516,7 +516,7 @@
>   		usb_otg_hs: usb_otg_hs@480ab000 {
>   			compatible = "ti,omap3-musb";
>   			reg = <0x480ab000 0x1000>;
> -			interrupts = <0 92 0x4>, <0 93 0x4>;
> +			interrupts = <92>, <93>;
>   			interrupt-names = "mc", "dma";
>   			ti,hwmods = "usb_otg_hs";
>   			multipoint = <1>;
>

