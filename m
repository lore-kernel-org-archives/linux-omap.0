From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH 4/5] ARM: OMAP4: Add L2 Cache Controller in Device Tree
Date: Mon, 20 Aug 2012 15:51:43 +0200
Message-ID: <503240EF.4050805@ti.com>
References: <1344855623-14879-1-git-send-email-santosh.shilimkar@ti.com> <1344855623-14879-5-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36514 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754817Ab2HTNvs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Aug 2012 09:51:48 -0400
In-Reply-To: <1344855623-14879-5-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.or, tony@atomide.com

Hi Santosh,

On 08/13/2012 01:00 PM, Santosh Shilimkar wrote:
> This provides PL310 Level 2 Cache Controller Device Tree
> support for OMAP4 based devices.
> 
> Cc: Benoit Cousson <b-cousson@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/boot/dts/omap4.dtsi       |    7 +++++++
>  arch/arm/mach-omap2/omap4-common.c |    6 +++++-
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> index 6717c71..cf1efb6 100644
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -36,6 +36,13 @@
>  		};
>  	};
>  

> +	L2: l2-cache-controller {

The reg offset is missing: l2-cache-controller@48242000

> +		compatible = "arm,pl310-cache";
> +		reg = <0x48242000 0x1000>;
> +		cache-unified;
> +		cache-level = <2>;
> +	};
> +

In theory, the L2 cache should be referenced from the CPUs.

Here is the way it is done for mpc8541cdc.dts for example:

	cpus {
		#address-cells = <1>;
		#size-cells = <0>;

		PowerPC,8541@0 {
			device_type = "cpu";
			reg = <0x0>;
			d-cache-line-size = <32>;	// 32 bytes
			i-cache-line-size = <32>;	// 32 bytes
			d-cache-size = <0x8000>;		// L1, 32K
			i-cache-size = <0x8000>;		// L1, 32K
			timebase-frequency = <0>;	//  33 MHz, from uboot
			bus-frequency = <0>;	// 166 MHz
			clock-frequency = <0>;	// 825 MHz, from uboot
			next-level-cache = <&L2>;
		};
	};

...

		L2: l2-cache-controller@20000 {
			compatible = "fsl,mpc8541-l2-cache-controller";
			reg = <0x20000 0x1000>;
			cache-line-size = <32>;	// 32 bytes
			cache-size = <0x40000>;	// L2, 256K
			interrupt-parent = <&mpic>;
			interrupts = <16 2>;
		};


Regards,
Benoit

>  	/*
>  	 * The soc node represents the soc top level view. It is uses for IPs
>  	 * that are not memory mapped in the MPU view or for the MPU itself.
> diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
> index c29dee9..6f95992 100644
> --- a/arch/arm/mach-omap2/omap4-common.c
> +++ b/arch/arm/mach-omap2/omap4-common.c
> @@ -16,6 +16,7 @@
>  #include <linux/io.h>
>  #include <linux/platform_device.h>
>  #include <linux/memblock.h>
> +#include <linux/of.h>
>  
>  #include <asm/hardware/gic.h>
>  #include <asm/hardware/cache-l2x0.h>
> @@ -171,7 +172,10 @@ static int __init omap_l2_cache_init(void)
>  	/* Enable PL310 L2 Cache controller */
>  	omap_smc1(0x102, 0x1);
>  
> -	l2x0_init(l2cache_base, aux_ctrl, L2X0_AUX_CTRL_MASK);
> +	if (of_have_populated_dt())
> +		l2x0_of_init(aux_ctrl, L2X0_AUX_CTRL_MASK);
> +	else
> +		l2x0_init(l2cache_base, aux_ctrl, L2X0_AUX_CTRL_MASK);
>  
>  	/*
>  	 * Override default outer_cache.disable with a OMAP4
> 

