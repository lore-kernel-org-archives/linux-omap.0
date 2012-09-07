From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v7 1/3] arm/dts: AM33XX: Add basic pinctrl device tree
 data
Date: Fri, 7 Sep 2012 09:58:38 -0700
Message-ID: <20120907165838.GW1303@atomide.com>
References: <1346924304-27425-1-git-send-email-anilkumar@ti.com>
 <1346924304-27425-2-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:58492 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751402Ab2IGQ6x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Sep 2012 12:58:53 -0400
Content-Disposition: inline
In-Reply-To: <1346924304-27425-2-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: AnilKumar Ch <anilkumar@ti.com>
Cc: wg@grandegger.com, mkl@pengutronix.de, bryan.wu@canonical.com, rpurdie@rpsys.net, linux-leds@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca

* AnilKumar Ch <anilkumar@ti.com> [120906 02:39]:
> Adds basic pinctrl device tree data for AM33XX family of devices.
> This patch is based on the pinctrl-single driver.
> 
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>

Assuming Benoit will queue this series:

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  arch/arm/boot/dts/am33xx.dtsi |    9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index be43511..58cffb7 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -40,6 +40,15 @@
>  		};
>  	};
>  
> +	am33xx_pinmux: pinmux@44e10800 {
> +		compatible = "pinctrl-single";
> +		reg = <0x44e10800 0x0238>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		pinctrl-single,register-width = <32>;
> +		pinctrl-single,function-mask = <0x7f>;
> +	};
> +
>  	/*
>  	 * XXX: Use a flat representation of the AM33XX interconnect.
>  	 * The real AM33XX interconnect network is quite complex.Since
> -- 
> 1.7.9.5
> 
