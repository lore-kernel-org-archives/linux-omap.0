From: <ext-atal.shargorodsky@nokia.com>
Subject: RE: [PATCH] I2C_OMAP configuration and Makefile fixes.
Date: Mon, 16 Feb 2009 10:38:13 +0100
Message-ID: <6F45DEE63C5BB542B6A7B0C4E41467D00764C1DA1F@NOK-EUMSG-03.mgdnok.nokia.com>
References: <1234428790-6263-1-git-send-email-ext-atal.shargorodsky@nokia.com>,<20090213221823.GI7562@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:17516 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754143AbZBPJjP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Feb 2009 04:39:15 -0500
In-Reply-To: <20090213221823.GI7562@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org

Hi, Tony,

I received a feedback from Jarkko Nikula and this produced another proposed fix and this thread:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg09618.html
So this patch is not valid anymore.

Best regards,

Atal

________________________________________
From: ext Tony Lindgren [tony@atomide.com]
Sent: Saturday, February 14, 2009 12:18 AM
To: Shargorodsky Atal (EXT-Teleca/Helsinki)
Cc: core-sw@ok.research.nokia.com; linux-omap@vger.kernel.org
Subject: Re: [PATCH] I2C_OMAP configuration and Makefile fixes.

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
>         probably do not want this option enabled until your
>         device drivers work properly.
>
> +config I2C_OMAP_ENABLE
> +     bool
> +
>  config OMAP_BOOT_TAG
>       bool "OMAP bootloader information passing"
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
>       tristate "OMAP I2C adapter"
>       depends on ARCH_OMAP
> +     select I2C_OMAP_ENABLE
>       default y if MACH_OMAP_H3 || MACH_OMAP_OSK
>       help
>         If you say yes to this option, support will be included for the
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index d4dc22d..97dbfa2 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -66,7 +66,6 @@ obj-$(CONFIG_I2C_SIBYTE)    += i2c-sibyte.o
>  obj-$(CONFIG_I2C_STUB)               += i2c-stub.o
>  obj-$(CONFIG_SCx200_ACB)     += scx200_acb.o
>  obj-$(CONFIG_SCx200_I2C)     += scx200_i2c.o
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
>       bool "Texas Instruments TWL4030/TPS659x0 Support"
>       depends on I2C=y && GENERIC_HARDIRQS && (ARCH_OMAP2 || ARCH_OMAP3)
> +     select I2C_OMAP
>       help
>         Say yes here if you have TWL4030 family chip on your board.
>         This core driver provides register access and IRQ handling

To avoid adding tons of extra Kconfig options, can you check if the
following patch works for you both for built-in and module i2c-omap?

Regards,

Tony
