From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/3] htcherald: Modify Makefiles and Kconfig for HTC
 Herald
Date: Mon, 16 Nov 2009 12:49:30 -0800
Message-ID: <20091116204930.GO3684@atomide.com>
References: <1258228077.16065.16.camel@runt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63785 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753965AbZKPUt2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Nov 2009 15:49:28 -0500
Content-Disposition: inline
In-Reply-To: <1258228077.16065.16.camel@runt>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cory Maccarrone <darkstar6262@gmail.com>
Cc: linux-omap@vger.kernel.org

* Cory Maccarrone <darkstar6262@gmail.com> [091114 11:47]:
> The Makefiles and Kconfig files were modified to include the new
> HTC Herald board support and LCD panel configuration code.

Ended up merging this with the board-htcherald.c patch.

Tony
 
> Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
> ---
>  arch/arm/mach-omap1/Kconfig  |    6 ++++++
>  arch/arm/mach-omap1/Makefile |    1 +
>  drivers/video/omap/Makefile  |    1 +
>  3 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/Kconfig b/arch/arm/mach-omap1/Kconfig
> index 3232726..27f4897 100644
> --- a/arch/arm/mach-omap1/Kconfig
> +++ b/arch/arm/mach-omap1/Kconfig
> @@ -57,6 +57,12 @@ config MACH_OMAP_HTCWIZARD
>  	help
>  	  HTC Wizard smartphone support (AKA QTEK 9100, ...)
>  
> +config MACH_HERALD
> +	bool "HTC Herald"
> +	depends on ARCH_OMAP850
> +	help
> +	  HTC Herald smartphone support (AKA T-Mobile Wing, ...)
> +
>  config MACH_OMAP_OSK
>  	bool "TI OSK Support"
>  	depends on ARCH_OMAP1 && ARCH_OMAP16XX
> diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
> index 6867cd3..87e539a 100644
> --- a/arch/arm/mach-omap1/Makefile
> +++ b/arch/arm/mach-omap1/Makefile
> @@ -34,6 +34,7 @@ obj-$(CONFIG_MACH_OMAP_PALMTT)		+= board-palmtt.o
>  obj-$(CONFIG_MACH_NOKIA770)		+= board-nokia770.o
>  obj-$(CONFIG_MACH_AMS_DELTA)		+= board-ams-delta.o
>  obj-$(CONFIG_MACH_SX1)			+= board-sx1.o board-sx1-mmc.o
> +obj-$(CONFIG_MACH_HERALD)		+= board-htcherald.o
>  
>  ifeq ($(CONFIG_ARCH_OMAP15XX),y)
>  # Innovator-1510 FPGA
> diff --git a/drivers/video/omap/Makefile b/drivers/video/omap/Makefile
> index b63b198..49226a1 100644
> --- a/drivers/video/omap/Makefile
> +++ b/drivers/video/omap/Makefile
> @@ -35,6 +35,7 @@ objs-y$(CONFIG_MACH_OMAP3EVM) += lcd_omap3evm.o
>  objs-y$(CONFIG_MACH_OMAP3_BEAGLE) += lcd_omap3beagle.o
>  objs-y$(CONFIG_FB_OMAP_LCD_MIPID) += lcd_mipid.o
>  objs-y$(CONFIG_MACH_OVERO) += lcd_overo.o
> +objs-y$(CONFIG_MACH_HERALD) += lcd_htcherald.o
>  
>  omapfb-objs := $(objs-yy)
>  
> -- 
> 1.6.3.3
> 
> 
