From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/5] ARM: dts: OMAP3: fix incorrect notation for
 musb-hdrc interrupt
Date: Wed, 22 May 2013 08:35:53 -0700
Message-ID: <20130522153552.GA10378@atomide.com>
References: <1369232864-14460-1-git-send-email-florian.vaussard@epfl.ch>
 <1369232864-14460-5-git-send-email-florian.vaussard@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:27524 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756444Ab3EVPfz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 May 2013 11:35:55 -0400
Content-Disposition: inline
In-Reply-To: <1369232864-14460-5-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Vaussard <florian.vaussard@epfl.ch>
Cc: Benoit Cousson <b-cousson@ti.com>, Stephen Warren <swarren@wwwdotorg.org>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

* Florian Vaussard <florian.vaussard@epfl.ch> [130522 07:33]:
> On OMAP3, the INTC interrupt controller has only 1 cell.
> 
> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>

Thanks a similar fix is already queued up and on it's way to mainline
tree.

Regards,

Tony

> ---
>  arch/arm/boot/dts/omap3.dtsi |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
> index 15049b8..0f3be20 100644
> --- a/arch/arm/boot/dts/omap3.dtsi
> +++ b/arch/arm/boot/dts/omap3.dtsi
> @@ -518,7 +518,7 @@
>  		usb_otg_hs: usb_otg_hs@480ab000 {
>  			compatible = "ti,omap3-musb";
>  			reg = <0x480ab000 0x1000>;
> -			interrupts = <0 92 0x4>, <0 93 0x4>;
> +			interrupts = <92>, <93>;
>  			interrupt-names = "mc", "dma";
>  			ti,hwmods = "usb_otg_hs";
>  			multipoint = <1>;
> -- 
> 1.7.5.4
> 
