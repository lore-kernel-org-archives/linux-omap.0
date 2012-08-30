From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH RESEND v4 1/3] arm/dts: AM33XX: Add basic pinctrl
 device tree data
Date: Thu, 30 Aug 2012 13:32:35 -0700
Message-ID: <20120830203234.GA1303@atomide.com>
References: <1346141454-18786-1-git-send-email-anilkumar@ti.com>
 <1346141454-18786-2-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:32736 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104Ab2H3Ucl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Aug 2012 16:32:41 -0400
Content-Disposition: inline
In-Reply-To: <1346141454-18786-2-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: AnilKumar Ch <anilkumar@ti.com>
Cc: wg@grandegger.com, mkl@pengutronix.de, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca

* AnilKumar Ch <anilkumar@ti.com> [120828 01:11]:
> Adds basic pinctrl device tree data for AM33XX family of devices.
> This patch is based on the pinctrl-single driver.
> 
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> ---
>  arch/arm/boot/dts/am33xx.dtsi |    9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index dde76f7..dfe9c559 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -40,6 +40,15 @@
>  		};
>  	};
>  
> +	am3358_pinmux: pinmux@44E10800 {
> +		compatible = "pinctrl-single";
> +		reg = <0x44E10800 0x0238>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		pinctrl-single,register-width = <32>;
> +		pinctrl-single,function-mask = <0x7F>;
> +	};
> +

Nit: Please use lower case for the hex numbers as that's the
standard in Linux kernel.

Tony
