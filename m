From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 3/3] memory: gpmc: Move omap gpmc code to live under drivers
Date: Mon, 24 Nov 2014 12:00:11 +0200
Message-ID: <547301AB.9040905@ti.com>
References: <1416594856-15201-1-git-send-email-tony@atomide.com> <1416594856-15201-4-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54353 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753089AbaKXKAm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Nov 2014 05:00:42 -0500
In-Reply-To: <1416594856-15201-4-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>

Tony,

On 11/21/2014 08:34 PM, Tony Lindgren wrote:
> Just move to drivers as further clean-up can now happen there
> finally.
> 
> Let's also add Roger and me to the MAINTAINERS so we get
> notified for any patches related to GPMC.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  MAINTAINERS                                              | 8 ++++++++
>  arch/arm/mach-omap2/Kconfig                              | 2 ++
>  arch/arm/mach-omap2/Makefile                             | 2 +-
>  drivers/memory/Kconfig                                   | 8 ++++++++
>  drivers/memory/Makefile                                  | 1 +
>  arch/arm/mach-omap2/gpmc.c => drivers/memory/omap-gpmc.c | 0
>  6 files changed, 20 insertions(+), 1 deletion(-)
>  rename arch/arm/mach-omap2/gpmc.c => drivers/memory/omap-gpmc.c (100%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dab92a7..78cc059 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6629,6 +6629,14 @@ L:	linux-omap@vger.kernel.org
>  S:	Maintained
>  F:	sound/soc/omap/
>  
> +OMAP GENERAL PURPOSE MEMORY CONTROLLER SUPPORT
> +M:	Roger Quadros <rogerq@ti.com>
> +M:	Tony Lindgren <tony@atomide.com>
> +L:	linux-omap@vger.kernel.org
> +S:	Maintained
> +F:	drivers/memory/omap-gpmc.c
> +F:	arch/arm/mach-omap2/*gpmc*
> +
>  OMAP FRAMEBUFFER SUPPORT
>  M:	Tomi Valkeinen <tomi.valkeinen@ti.com>
>  L:	linux-fbdev@vger.kernel.org
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index f4d06ae..0ea218e 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -79,7 +79,9 @@ config ARCH_OMAP2PLUS
>  	select CLKSRC_MMIO
>  	select GENERIC_IRQ_CHIP
>  	select MACH_OMAP_GENERIC
> +	select MEMORY
>  	select OMAP_DM_TIMER
> +	select OMAP_GPMC
>  	select PINCTRL
>  	select SOC_BUS
>  	select TI_PRIV_EDMA
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 3e824f8..bd85741 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -6,7 +6,7 @@ ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include \
>  	-I$(srctree)/arch/arm/plat-omap/include
>  
>  # Common support
> -obj-y := id.o io.o control.o mux.o devices.o fb.o serial.o gpmc.o timer.o pm.o \
> +obj-y := id.o io.o control.o mux.o devices.o fb.o serial.o timer.o pm.o \
>  	 common.o gpio.o dma.o wd_timer.o display.o i2c.o hdq1w.o omap_hwmod.o \
>  	 omap_device.o sram.o drm.o
>  
> diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
> index 6d91c27..6759de7 100644
> --- a/drivers/memory/Kconfig
> +++ b/drivers/memory/Kconfig
> @@ -41,6 +41,14 @@ config TI_EMIF
>  	  parameters and other settings during frequency, voltage and
>  	  temperature changes
>  
> +config OMAP_GPMC
> +	bool

We should depend on ARCH_OMAP2PLUS. Other platforms won't benefit
anything from this driver.

> +	help
> +	  This driver is for the General Purpose Memory Controller (GPMC)
> +	  present on Texas Instruments SoCs (e.g. OMAP2+). GPMC allows
> +	  interfacing to a variety of asynchronous as well as synchronous
> +	  memory drives like NOR, NAND, OneNAND, SRAM.
> +
>  config MVEBU_DEVBUS
>  	bool "Marvell EBU Device Bus Controller"
>  	default y
> diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
> index c32d319..a7d410f 100644
> --- a/drivers/memory/Makefile
> +++ b/drivers/memory/Makefile
> @@ -8,6 +8,7 @@ endif
>  obj-$(CONFIG_ATMEL_SDRAMC)	+= atmel-sdramc.o
>  obj-$(CONFIG_TI_AEMIF)		+= ti-aemif.o
>  obj-$(CONFIG_TI_EMIF)		+= emif.o
> +obj-$(CONFIG_OMAP_GPMC)		+= omap-gpmc.o
>  obj-$(CONFIG_FSL_CORENET_CF)	+= fsl-corenet-cf.o
>  obj-$(CONFIG_FSL_IFC)		+= fsl_ifc.o
>  obj-$(CONFIG_MVEBU_DEVBUS)	+= mvebu-devbus.o
> diff --git a/arch/arm/mach-omap2/gpmc.c b/drivers/memory/omap-gpmc.c
> similarity index 100%
> rename from arch/arm/mach-omap2/gpmc.c
> rename to drivers/memory/omap-gpmc.c
> 

cheers,
-roger
