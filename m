From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] arm: n950: Add missing regulator definitions
Date: Mon, 5 May 2014 12:51:12 -0700
Message-ID: <20140505195112.GF25949@atomide.com>
References: <1399162988-4946-1-git-send-email-sakari.ailus@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:65301 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752630AbaEETvQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 May 2014 15:51:16 -0400
Content-Disposition: inline
In-Reply-To: <1399162988-4946-1-git-send-email-sakari.ailus@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: linux-omap@vger.kernel.org, aaro.koskinen@iki.fi

* Sakari Ailus <sakari.ailus@iki.fi> [140503 17:20]:
> The N950/N9 uses two additional regulators from the twl 4030 for CSI-2
> receiver (vaux2) and cameras (vaux3).
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@iki.fi>

Thanks applying into omap-for-v3.16/dt.

Tony

> ---
>  arch/arm/boot/dts/omap3-n950-n9.dtsi |   14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap3-n950-n9.dtsi b/arch/arm/boot/dts/omap3-n950-n9.dtsi
> index 5c26c18..7d64f30 100644
> --- a/arch/arm/boot/dts/omap3-n950-n9.dtsi
> +++ b/arch/arm/boot/dts/omap3-n950-n9.dtsi
> @@ -67,6 +67,20 @@
>  	ti,pulldowns	= <0x008106>; /* BIT(1) | BIT(2) | BIT(8) | BIT(15) */
>  };
>  
> +/* CSI-2 receiver */
> +&vaux2 {
> +	regulator-name = "vaux2"; 
> +	regulator-min-microvolt = <1800000>;
> +	regulator-max-microvolt = <1800000>;
> +};
> +
> +/* Cameras */
> +&vaux3 {
> +	regulator-name = "vaux3"; 
> +	regulator-min-microvolt = <2800000>;
> +	regulator-max-microvolt = <2800000>;
> +};
> +
>  &i2c2 {
>  	clock-frequency = <400000>;
>  };
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
