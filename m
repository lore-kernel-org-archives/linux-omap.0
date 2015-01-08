From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: DTS: N950/N9: add twl_power
Date: Wed, 7 Jan 2015 16:11:18 -0800
Message-ID: <20150108001117.GO13010@atomide.com>
References: <1419624589-10432-1-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:41747 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753628AbbAHAPD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jan 2015 19:15:03 -0500
Content-Disposition: inline
In-Reply-To: <1419624589-10432-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [141226 12:12]:
> Add twl_power for N950/N9. Start with the simplest configuration to just
> enable power off.
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Applying into omap-for-v3.20/dt thanks.

Tony

> ---
>  arch/arm/boot/dts/omap3-n950-n9.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap3-n950-n9.dtsi b/arch/arm/boot/dts/omap3-n950-n9.dtsi
> index 1e49dfe..c41db94 100644
> --- a/arch/arm/boot/dts/omap3-n950-n9.dtsi
> +++ b/arch/arm/boot/dts/omap3-n950-n9.dtsi
> @@ -60,6 +60,11 @@
>  
>  &twl {
>  	compatible = "ti,twl5031";
> +
> +	twl_power: power {
> +		compatible = "ti,twl4030-power";
> +		ti,use_poweroff;
> +	};
>  };
>  
>  &twl_gpio {
> -- 
> 2.2.0
> 
