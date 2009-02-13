From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] I2C_OMAP configuration and Makefile fixes.
Date: Fri, 13 Feb 2009 14:18:23 -0800
Message-ID: <20090213221823.GI7562@atomide.com>
References: <1234428790-6263-1-git-send-email-ext-atal.shargorodsky@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="v9Ux+11Zm5mwPlX6"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56701 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751452AbZBMWS0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Feb 2009 17:18:26 -0500
Content-Disposition: inline
In-Reply-To: <1234428790-6263-1-git-send-email-ext-atal.shargorodsky@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Atal Shargorodsky <ext-atal.shargorodsky@nokia.com>
Cc: core-sw@ok.research.nokia.com, linux-omap@vger.kernel.org


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

* Atal Shargorodsky <ext-atal.shargorodsky@nokia.com> [090212 00:54]:
> Allow I2C_OMAP to be compiled as a module,
> introduce selection of I2C_OMAP by TWL4030_CORE
> and remove doubled 'obj-$(CONFIG_I2C_OMAP)' line from makefile.
> 
> Signed-off-by: Atal Shargorodsky <ext-atal.shargorodsky@nokia.com>
> ---
>  arch/arm/plat-omap/Kconfig  |    3 +++
>  arch/arm/plat-omap/Makefile |    2 +-
>  drivers/i2c/busses/Kconfig  |    1 +
>  drivers/i2c/busses/Makefile |    1 -
>  drivers/mfd/Kconfig         |    1 +
>  5 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> index 5bc8e3b..4d19d6b 100644
> --- a/arch/arm/plat-omap/Kconfig
> +++ b/arch/arm/plat-omap/Kconfig
> @@ -99,6 +99,9 @@ config OMAP_RESET_CLOCKS
>  	  probably do not want this option enabled until your
>  	  device drivers work properly.
>  
> +config I2C_OMAP_ENABLE
> +	bool
> +
>  config OMAP_BOOT_TAG
>  	bool "OMAP bootloader information passing"
>          depends on ARCH_OMAP
> diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
> index 175bfd6..e610bc9 100644
> --- a/arch/arm/plat-omap/Makefile
> +++ b/arch/arm/plat-omap/Makefile
> @@ -21,7 +21,7 @@ obj-$(CONFIG_OMAP_COMPONENT_VERSION) += component-version.o
>  obj-$(CONFIG_OMAP_GPIO_SWITCH) += gpio-switch.o
>  obj-$(CONFIG_OMAP_DEBUG_DEVICES) += debug-devices.o
>  obj-$(CONFIG_OMAP_DEBUG_LEDS) += debug-leds.o
> -obj-$(CONFIG_I2C_OMAP) += i2c.o
> +obj-$(CONFIG_I2C_OMAP_ENABLE) += i2c.o
>  
>  # OMAP MMU framework
>  obj-$(CONFIG_OMAP_MMU_FWK) += mmu.o
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index eb94378..176e053 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -400,6 +400,7 @@ config I2C_OCORES
>  config I2C_OMAP
>  	tristate "OMAP I2C adapter"
>  	depends on ARCH_OMAP
> +	select I2C_OMAP_ENABLE
>  	default y if MACH_OMAP_H3 || MACH_OMAP_OSK
>  	help
>  	  If you say yes to this option, support will be included for the
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index d4dc22d..97dbfa2 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -66,7 +66,6 @@ obj-$(CONFIG_I2C_SIBYTE)	+= i2c-sibyte.o
>  obj-$(CONFIG_I2C_STUB)		+= i2c-stub.o
>  obj-$(CONFIG_SCx200_ACB)	+= scx200_acb.o
>  obj-$(CONFIG_SCx200_I2C)	+= scx200_i2c.o
> -obj-$(CONFIG_I2C_OMAP)          += i2c-omap.o
>
>  ifeq ($(CONFIG_I2C_DEBUG_BUS),y)
>  EXTRA_CFLAGS += -DDEBUG
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 91c0417..1bc03bd 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -53,6 +53,7 @@ config HTC_PASIC3
>  config TWL4030_CORE
>  	bool "Texas Instruments TWL4030/TPS659x0 Support"
>  	depends on I2C=y && GENERIC_HARDIRQS && (ARCH_OMAP2 || ARCH_OMAP3)
> +	select I2C_OMAP
>  	help
>  	  Say yes here if you have TWL4030 family chip on your board.
>  	  This core driver provides register access and IRQ handling

To avoid adding tons of extra Kconfig options, can you check if the
following patch works for you both for built-in and module i2c-omap?

Regards,

Tony

--v9Ux+11Zm5mwPlX6
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="i2c-omap-module.patch"

--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -21,7 +21,10 @@ obj-$(CONFIG_OMAP_COMPONENT_VERSION) += component-version.o
 obj-$(CONFIG_OMAP_GPIO_SWITCH) += gpio-switch.o
 obj-$(CONFIG_OMAP_DEBUG_DEVICES) += debug-devices.o
 obj-$(CONFIG_OMAP_DEBUG_LEDS) += debug-leds.o
-obj-$(CONFIG_I2C_OMAP) += i2c.o
+
+ifneq ($(CONFIG_I2C_OMAP),)
+	obj-$(CONFIG_I2C_OMAP)		+= i2c.o
+endif
 
 # OMAP mailbox framework
 obj-$(CONFIG_OMAP_MBOX_FWK) += mailbox.o

--v9Ux+11Zm5mwPlX6--
