From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 13/26] ARM: omap3.dtsi: add omapdss information
Date: Thu, 5 Dec 2013 09:05:15 -0800
Message-ID: <20131205170514.GY26766@atomide.com>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com>
 <1386160133-24026-14-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:11309 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403Ab3LERFS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Dec 2013 12:05:18 -0500
Content-Disposition: inline
In-Reply-To: <1386160133-24026-14-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>

* Tomi Valkeinen <tomi.valkeinen@ti.com> [131204 04:31]:

Description missing.. But other than that can you please check that
the latest patch I posted in thread "[PATCH] ARM: OMAP2+: Fix populating
the hwmod data from device" works with this?

The test to do is to remove the related reg, interrupt and dma entries
from omap_hwmod_*_data.c, and make sure the related hwmod data is initialized
from DT properly.

I don't know if it makes sense to have them as children of dss_core, they
really all seem to be completely independent devices?

BTW, for v3.15, I'm hoping to do patches where we deprecate ti,hwmods
property and do the lookup based on the compatible property instead ;)
So from that point of view we need to get the device mapping right in
the .dtsi files, and don't want to start mixing up separate devices into
single .dtsi entry.

Regards,

Tony

> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  arch/arm/boot/dts/omap3.dtsi | 43 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
> index f3a0c26ed0c2..6fc163201cbd 100644
> --- a/arch/arm/boot/dts/omap3.dtsi
> +++ b/arch/arm/boot/dts/omap3.dtsi
> @@ -588,5 +588,48 @@
>  			num-eps = <16>;
>  			ram-bits = <12>;
>  		};
> +
> +		dss@48050000 {
> +			compatible = "ti,omap3-dss", "simple-bus";
> +			reg = <0x48050000 0x200>;
> +			ti,hwmods = "dss_core";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			dispc@48050400 {
> +				compatible = "ti,omap3-dispc";
> +				reg = <0x48050400 0x400>;
> +				interrupts = <25>;
> +				ti,hwmods = "dss_dispc";
> +			};
> +
> +			dpi: encoder@0 {
> +				compatible = "ti,omap3-dpi";
> +			};
> +
> +			sdi: encoder@1 {
> +				compatible = "ti,omap3-sdi";
> +			};
> +
> +			dsi: encoder@4804fc00 {
> +				compatible = "ti,omap3-dsi";
> +				reg = <0x4804fc00 0x400>;
> +				interrupts = <25>;
> +				ti,hwmods = "dss_dsi1";
> +			};
> +
> +			rfbi: encoder@48050800 {
> +				compatible = "ti,omap3-rfbi";
> +				reg = <0x48050800 0x100>;
> +				ti,hwmods = "dss_rfbi";
> +			};
> +
> +			venc: encoder@48050c00 {
> +				compatible = "ti,omap3-venc";
> +				reg = <0x48050c00 0x100>;
> +				ti,hwmods = "dss_venc";
> +			};
> +		};
>  	};
>  };
> -- 
> 1.8.3.2
> 
