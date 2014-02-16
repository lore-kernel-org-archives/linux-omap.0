From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v2] ARM: dts: tps65910 backup battery regulator
Date: Sun, 16 Feb 2014 23:01:42 +0100
Message-ID: <20140216220142.GA31006@pengutronix.de>
References: <1387539808-24910-3-git-send-email-mpa@pengutronix.de>
 <1389888503-32013-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47664 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752540AbaBPWBp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 Feb 2014 17:01:45 -0500
Content-Disposition: inline
In-Reply-To: <1389888503-32013-1-git-send-email-mpa@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de

Hi,

On Thu, Jan 16, 2014 at 05:08:23PM +0100, Markus Pargmann wrote:
> This patch adds a devicetree node for the backup battery regulator.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
> Hi,
> 
> Mark Brown applied [1] the other part of the series which adds 'vbb' as
> regulator-compatible. I forgot to add you in Cc.

Any comments on this?

Regards,

Markus

> 
> Regards,
> 
> Markus
> 
> [1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/289815/focus=290089
> 
>  arch/arm/boot/dts/tps65910.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/tps65910.dtsi b/arch/arm/boot/dts/tps65910.dtsi
> index 92693a8..b0ac665 100644
> --- a/arch/arm/boot/dts/tps65910.dtsi
> +++ b/arch/arm/boot/dts/tps65910.dtsi
> @@ -82,5 +82,10 @@
>  			reg = <12>;
>  			regulator-compatible = "vmmc";
>  		};
> +
> +		vbb_reg: regulator@13 {
> +			reg = <13>;
> +			regulator-compatible = "vbb";
> +		};
>  	};
>  };
> -- 
> 1.8.5.2
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
