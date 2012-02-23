From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 4/4] arm/dts: OMAP3: Add mmc controller nodes and
 board data
Date: Thu, 23 Feb 2012 10:57:18 -0800
Message-ID: <20120223185718.GZ18185@atomide.com>
References: <1329998490-27555-1-git-send-email-rnayak@ti.com>
 <1329998490-27555-5-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:59391 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524Ab2BWS5W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Feb 2012 13:57:22 -0500
Content-Disposition: inline
In-Reply-To: <1329998490-27555-5-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balajitk@ti.com, svenkatr@ti.com, linaro-dev@lists.linaro.org

> --- a/arch/arm/boot/dts/omap3.dtsi
> +++ b/arch/arm/boot/dts/omap3.dtsi
> @@ -113,5 +113,31 @@
>  			#size-cells = <0>;
>  			ti,hwmods = "i2c3";
>  		};
> +
> +		mmc1: mmc@1 {
> +			compatible = "ti,omap2-hsmmc";
> +			ti,hwmods = "mmc1";
> +			ti,dual-volt;
> +		};
> +
> +		mmc2: mmc@2 {
> +			compatible = "ti,omap2-hsmmc";
> +			ti,hwmods = "mmc2";
> +		};
> +
> +		mmc3: mmc@3 {
> +			compatible = "ti,omap2-hsmmc";
> +			ti,hwmods = "mmc3";
> +		};
> +
> +		mmc4: mmc@4 {
> +			compatible = "ti,omap2-hsmmc";
> +			ti,hwmods = "mmc4";
> +		};
> +
> +		mmc5: mmc@5 {
> +			compatible = "ti,omap2-hsmmc";
> +			ti,hwmods = "mmc5";
> +		};
>  	};
>  };

These all should all be "ti,omap3-hsmmc" I guess?

Tony
