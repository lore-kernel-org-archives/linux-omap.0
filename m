From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] ARM: dts: add core2 padconf region for am3517
Date: Sun, 10 May 2015 19:15:04 -0500
Message-ID: <554FF488.5090805@ti.com>
References: <1431293273-19321-1-git-send-email-andrej.skvortzov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41386 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751734AbbEKAQF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 10 May 2015 20:16:05 -0400
In-Reply-To: <1431293273-19321-1-git-send-email-andrej.skvortzov@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>, =?windows-1252?Q?Beno=EE?= =?windows-1252?Q?t_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>

On 05/10/2015 04:27 PM, Andrey Skvortsov wrote:
> According to the technical reference manual for AM35xx system
> controller module (SCM) PADCONFS core registers are divided in two
> regions: 0x48002030..0x48002268 and 0x480025d8..0x480025FC.
> First region is the same for all omap3 SoC and is described in omap3.dtsi.
> The second region is the same as in omap34xx (see omap34xx.dtsi)
> and omap35xx. The patch adds missing description for the second region.
> This patch was tested on AM3517.
> 
> Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> ---
> 
> Commit 3d495383648a ("ARM: dts: Split omap3 pinmux core device") notes that
> Nishanth Menon <nm@ti.com> said that 3517 does not have padconf2 region.
> Unfortunately I couldn't find reference to his post on mailing list.
> This patch was tested on AM3517 SoC and original vendor code contains
> pinmuxing for this second region as well.


http://www.ti.com/lit/ug/sprugr0c/sprugr0c.pdf
CONTROL_PADCONF_ETK_CLK is indeed at 0x480025D8
Apologies on missing it :(

> 
>  arch/arm/boot/dts/am3517.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am3517.dtsi b/arch/arm/boot/dts/am3517.dtsi
> index c90724b..2534500 100644
> --- a/arch/arm/boot/dts/am3517.dtsi
> +++ b/arch/arm/boot/dts/am3517.dtsi
> @@ -60,5 +60,16 @@
>  			dma-names = "tx", "rx";
>  			clock-frequency = <48000000>;
>  		};
> +
> +		omap3_pmx_core2: pinmux@480025D8 {
> +			compatible = "ti,omap3-padconf", "pinctrl-single";
> +			reg = <0x480025D8 0x24>;

b8845074cfbbd1d1b46720a1b563d7b4240dac21 ("ARM: dts: omap3: add minimal
l4 bus layout with control module support") moves omap3_pmx_core under
scm -> should'nt we do the same here?

> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			#interrupt-cells = <1>;
> +			interrupt-controller;
> +			pinctrl-single,register-width = <16>;
> +			pinctrl-single,function-mask = <0xff1f>;
> +		};
>  	};
>  };
> 


-- 
Regards,
Nishanth Menon
