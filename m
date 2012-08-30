From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 3/3] arm/dts: AM33XX: Add D_CAN device tree data
Date: Thu, 30 Aug 2012 13:35:59 -0700
Message-ID: <20120830203558.GC1303@atomide.com>
References: <1346141454-18786-1-git-send-email-anilkumar@ti.com>
 <1346141454-18786-4-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:35256 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223Ab2H3UgF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Aug 2012 16:36:05 -0400
Content-Disposition: inline
In-Reply-To: <1346141454-18786-4-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: AnilKumar Ch <anilkumar@ti.com>
Cc: wg@grandegger.com, mkl@pengutronix.de, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca

* AnilKumar Ch <anilkumar@ti.com> [120828 01:11]:
> Add Bosch D_CAN controller device tree data to AM33XX dtsi
> file by adding d_can device nodes with all the necessary
> parameters.
> 
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> ---
>  arch/arm/boot/dts/am33xx.dtsi |   18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index dfe9c559..d965137 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -177,5 +177,23 @@
>  			compatible = "ti,omap3-wdt";
>  			ti,hwmods = "wd_timer2";
>  		};
> +
> +		dcan0: d_can@481CC000 {
> +			compatible = "bosch,d_can";
> +			ti,hwmods = "d_can0";
> +			reg = <0x481CC000 0x2000>;
> +			interrupts = <52>;
> +			interrupt-parent = <&intc>;
> +			status = "disabled";
> +		};
> +
> +		dcan1: d_can@481D0000 {
> +			compatible = "bosch,d_can";
> +			ti,hwmods = "d_can1";
> +			reg = <0x481D0000 0x2000>;
> +			interrupts = <55>;
> +			interrupt-parent = <&intc>;
> +			status = "disabled";
> +		};
>  	};
>  };

Use lower case for hex numbers here too and add support to claim the pins
in the dcan driver.

Tony
