From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH 1/5] arm/dts: Add omap36xx.dtsi file and rename omap3-beagle
 to omap3-beagle-xm
Date: Fri, 7 Sep 2012 17:49:09 +0200
Message-ID: <504A1775.1060300@ti.com>
References: <20120906185615.1172.23588.stgit@muffinssi.local> <20120906185821.1172.18455.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53948 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703Ab2IGPt0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Sep 2012 11:49:26 -0400
In-Reply-To: <20120906185821.1172.18455.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org

Hi Tony,

On 09/06/2012 08:58 PM, Tony Lindgren wrote:
> The extra serial port is not available on 34xx. And the current
> omap3-beagle.dts file is for omap3-beagle-xm.dts as it lists 512MB
> of memory.

Indeed, my Beagle is in fact a xM :-)

It is too bad that we do have to duplicate the DTS file for all the board variants. Peter already did that for pandaES and at that time I was wondering if this was needed or not.

That being said, I'm not sure we have any good way to handle two boards using the same DTS. It means that will we will have to rely on the bootloader now to select the proper DTB.

Please not that's I'm queuing a bunch of OMAP2/3/4/5/AM33XX for you, so you might have to rebase that one on top.

The branch is there. 

git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.7/dts

I'm still waiting for a couple of AM33xx pinmux patches from Anil that should re acked by some folks who know that (like you :-)).

I'll send you the pull request next week.

Regards,
Benoit

> Please somebody submit a new omap3-beagle.dts for the original 34xx
> BeagleBoard after testing it properly.
> 
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: devicetree-discuss@lists.ozlabs.org
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/boot/dts/omap3-beagle-xm.dts |    6 +++---
>  arch/arm/boot/dts/omap3.dtsi          |    7 -------
>  arch/arm/boot/dts/omap36xx.dtsi       |   25 +++++++++++++++++++++++++
>  arch/arm/mach-omap2/Makefile.boot     |    2 +-
>  4 files changed, 29 insertions(+), 11 deletions(-)
>  rename arch/arm/boot/dts/{omap3-beagle.dts => omap3-beagle-xm.dts} (89%)
>  create mode 100644 arch/arm/boot/dts/omap36xx.dtsi
> 
> diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
> similarity index 89%
> rename from arch/arm/boot/dts/omap3-beagle.dts
> rename to arch/arm/boot/dts/omap3-beagle-xm.dts
> index e60cba0..df6d485 100644
> --- a/arch/arm/boot/dts/omap3-beagle.dts
> +++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
> @@ -7,11 +7,11 @@
>   */
>  /dts-v1/;
>  
> -/include/ "omap3.dtsi"
> +/include/ "omap36xx.dtsi"
>  
>  / {
> -	model = "TI OMAP3 BeagleBoard";
> -	compatible = "ti,omap3-beagle", "ti,omap3";
> +	model = "TI OMAP3 BeagleBoard xM";
> +	compatible = "ti,omap3-beagle-xm, ti,omap3-beagle", "ti,omap3";
>  
>  	memory {
>  		device_type = "memory";
> diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
> index 8109471..9965ed6 100644
> --- a/arch/arm/boot/dts/omap3.dtsi
> +++ b/arch/arm/boot/dts/omap3.dtsi
> @@ -17,7 +17,6 @@
>  		serial0 = &uart1;
>  		serial1 = &uart2;
>  		serial2 = &uart3;
> -		serial3 = &uart4;
>  	};
>  
>  	cpus {
> @@ -141,12 +140,6 @@
>  			clock-frequency = <48000000>;
>  		};
>  
> -		uart4: serial@49042000 {
> -			compatible = "ti,omap3-uart";
> -			ti,hwmods = "uart4";
> -			clock-frequency = <48000000>;
> -		};
> -
>  		i2c1: i2c@48070000 {
>  			compatible = "ti,omap3-i2c";
>  			#address-cells = <1>;
> diff --git a/arch/arm/boot/dts/omap36xx.dtsi b/arch/arm/boot/dts/omap36xx.dtsi
> new file mode 100644
> index 0000000..96bf028
> --- /dev/null
> +++ b/arch/arm/boot/dts/omap36xx.dtsi
> @@ -0,0 +1,25 @@
> +/*
> + * Device Tree Source for OMAP3 SoC
> + *
> + * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2.  This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + */
> +
> +/include/ "omap3.dtsi"
> +
> +/ {
> +	aliases {
> +		serial3 = &uart4;
> +	};
> +
> +	ocp {
> +		uart4: serial@49042000 {
> +			compatible = "ti,omap3-uart";
> +			ti,hwmods = "uart4";
> +			clock-frequency = <48000000>;
> +		};
> +	};
> +};
> diff --git a/arch/arm/mach-omap2/Makefile.boot b/arch/arm/mach-omap2/Makefile.boot
> index 6cf1c2d..0e602b7 100644
> --- a/arch/arm/mach-omap2/Makefile.boot
> +++ b/arch/arm/mach-omap2/Makefile.boot
> @@ -3,7 +3,7 @@ params_phys-y		:= 0x80000100
>  initrd_phys-y		:= 0x80800000
>  
>  dtb-$(CONFIG_SOC_OMAP2420)	+= omap2420-h4.dtb
> -dtb-$(CONFIG_ARCH_OMAP3)	+= omap3-beagle.dtb omap3-evm.dtb
> +dtb-$(CONFIG_ARCH_OMAP3)	+= omap3-beagle-xm.dtb omap3-evm.dtb
>  dtb-$(CONFIG_ARCH_OMAP4)	+= omap4-panda.dtb omap4-pandaES.dtb
>  dtb-$(CONFIG_ARCH_OMAP4)	+= omap4-var_som.dtb omap4-sdp.dtb
>  dtb-$(CONFIG_SOC_OMAP5)		+= omap5-evm.dtb
> 

