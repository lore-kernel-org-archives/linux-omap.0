From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: omap3-beagle: Add NAND device
Date: Mon, 16 Mar 2015 15:11:38 -0700
Message-ID: <20150316221138.GO12397@atomide.com>
References: <1425654605-5752-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:37910 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932496AbbCPWQ1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Mar 2015 18:16:27 -0400
Content-Disposition: inline
In-Reply-To: <1425654605-5752-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [150306 07:10]:
> The beagle board contains a 16-bit NAND device connected to
> chip select 0 of the GPMC controller.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>

Applying into omap-for-v4.1/dt thanks.

Tony

> ---
>  arch/arm/boot/dts/omap3-beagle.dts | 52 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
> index c792391..bf28502 100644
> --- a/arch/arm/boot/dts/omap3-beagle.dts
> +++ b/arch/arm/boot/dts/omap3-beagle.dts
> @@ -379,3 +379,55 @@
>  		};
>  	};
>  };
> +
> +&gpmc {
> +	status = "ok";
> +	ranges = <0 0 0x30000000 0x1000000>;	/* CS0 space, 16MB */
> +
> +	/* Chip select 0 */
> +	nand@0,0 {
> +		reg = <0 0 4>;		/* NAND I/O window, 4 bytes */
> +		interrupts = <20>;
> +		ti,nand-ecc-opt = "ham1";
> +		nand-bus-width = <16>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		gpmc,device-width = <2>;
> +		gpmc,cs-on-ns = <0>;
> +		gpmc,cs-rd-off-ns = <36>;
> +		gpmc,cs-wr-off-ns = <36>;
> +		gpmc,adv-on-ns = <6>;
> +		gpmc,adv-rd-off-ns = <24>;
> +		gpmc,adv-wr-off-ns = <36>;
> +		gpmc,oe-on-ns = <6>;
> +		gpmc,oe-off-ns = <48>;
> +		gpmc,we-on-ns = <6>;
> +		gpmc,we-off-ns = <30>;
> +		gpmc,rd-cycle-ns = <72>;
> +		gpmc,wr-cycle-ns = <72>;
> +		gpmc,access-ns = <54>;
> +		gpmc,wr-access-ns = <30>;
> +
> +		partition@0 {
> +			label = "X-Loader";
> +			reg = <0 0x80000>;
> +		};
> +		partition@80000 {
> +			label = "U-Boot";
> +			reg = <0x80000 0x1e0000>;
> +		};
> +		partition@1c0000 {
> +			label = "U-Boot Env";
> +			reg = <0x260000 0x20000>;
> +		};
> +		partition@280000 {
> +			label = "Kernel";
> +			reg = <0x280000 0x400000>;
> +		};
> +		partition@780000 {
> +			label = "Filesystem";
> +			reg = <0x680000 0xf980000>;
> +		};
> +	};
> +};
> -- 
> 2.1.0
> 
