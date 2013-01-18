From: Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
Subject: Re: [PATCH 2/3] ARM: dts: AM33XX: Add GPMC node
Date: Fri, 18 Jan 2013 14:17:43 +0100
Message-ID: <1358515063.3873.31.camel@coredoba.hi.pengutronix.de>
References: <1358491295-4022-1-git-send-email-avinashphilip@ti.com>
	 <1358491295-4022-3-git-send-email-avinashphilip@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37347 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187Ab3ARNRz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Jan 2013 08:17:55 -0500
In-Reply-To: <1358491295-4022-3-git-send-email-avinashphilip@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Philip Avinash <avinashphilip@ti.com>
Cc: b-cousson@ti.com, tony@atomide.com, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, gururaja.hebbar@ti.com, zonque@gmail.com

On Fri, 2013-01-18 at 12:11 +0530, Philip Avinash wrote:
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index eaef5e7..f4209d8 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -393,5 +393,17 @@
>  			ti,hwmods = "elm";
>  			status = "disabled";
>  		};
> +
> +		gpmc: gpmc@50000000 {
> +			compatible = "ti,am3352-gpmc";
> +			ti,hwmods = "gpmc";
> +			reg = <0x50000000 0x2000>;
> +			interrupts = <100>;
> +			num-cs = <8>;

According to the AM335x TRM (SPRUH73G) page 254 we have GPMC_CSn[6:0],
so num-cs should probably be <7>.

> +			num-waitpins = <2>;
> +			#address-cells = <2>;
> +			#size-cells = <1>;
> +			status = "disabled";
> +		};
>  	};
>  };

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

