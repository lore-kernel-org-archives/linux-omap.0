From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v7 5/7] ARM: dts: add pbias dt node
Date: Mon, 6 Jan 2014 18:19:28 +0000
Message-ID: <20140106181928.GK24664@e106331-lin.cambridge.arm.com>
References: <1387560955-6547-1-git-send-email-balajitk@ti.com>
 <1387560955-6547-6-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:34719 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755717AbaAFSTz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Jan 2014 13:19:55 -0500
Content-Disposition: inline
In-Reply-To: <1387560955-6547-6-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "broonie@kernel.org" <broonie@kernel.org>, "tony@atomide.com" <tony@atomide.com>

On Fri, Dec 20, 2013 at 05:35:53PM +0000, Balaji T K wrote:
> Add pbias regulator node as a child of system control
> module - syscon.
> 
> Signed-off-by: Balaji T K <balajitk@ti.com>
> ---
>  arch/arm/boot/dts/dra7.dtsi     |   18 ++++++++++++++++++
>  arch/arm/boot/dts/omap2430.dtsi |   18 ++++++++++++++++++
>  arch/arm/boot/dts/omap3.dtsi    |   18 ++++++++++++++++++
>  arch/arm/boot/dts/omap4.dtsi    |   18 ++++++++++++++++++
>  arch/arm/boot/dts/omap5.dtsi    |   18 ++++++++++++++++++
>  5 files changed, 90 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index d0df4c4..4e68df1 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -110,6 +110,23 @@
>  			ti,hwmods = "counter_32k";
>  		};
>  
> +		dra7_ctrl_general: tisyscon@4a002e00 {
> +			compatible = "ti,control-syscon", "syscon", "simple-bus";

Please, don't use simple-bus like that. The components below this node
depend on it. It is _NOT_ a simple bus. Make the ti,control-syscon
driver probe it's children.

> +			reg = <0x4a002e00 0x7c>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +			pbias_regulator: pbias_regulator {
> +				compatible = "ti,pbias-omap";
> +				reg = <0 0x4>;
> +				pbias_mmc_reg: pbias_mmc_omap5 {
> +					regulator-name = "pbias_mmc_omap5";
> +					regulator-min-microvolt = <1800000>;
> +					regulator-max-microvolt = <3000000>;
> +				};
> +			};
> +		};
> +

Thanks,
Mark.
