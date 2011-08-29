From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] mfd: Combine MFD_SUPPORT and MFD_CORE
Date: Mon, 29 Aug 2011 12:54:30 -0600
Message-ID: <CACxGe6vKTzb7bKQ07NZm1E_ZWUHoOj93NBsYrCU7HxrKYTAp+g@mail.gmail.com>
References: <20110829102732.03f0f05d.rdunlap@xenotime.net> <1314643307-17780-1-git-send-email-coelho@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:61503 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753219Ab1H2Syv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Aug 2011 14:54:51 -0400
In-Reply-To: <1314643307-17780-1-git-send-email-coelho@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Luciano Coelho <coelho@ti.com>
Cc: Randy Dunlap <rdunlap@xenotime.net>, matti.j.aaltonen@nokia.com, johannes@sipsolutions.net, linux-kernel@vger.kernel.org, sameo@linux.intel.com, mchehab@infradead.org, linux-media@vger.kernel.org, linux-omap@vger.kernel.org, Jean Delvare <khali@linux-fr.org>, Tony Lindgren <tony@atomide.com>

On Mon, Aug 29, 2011 at 12:41 PM, Luciano Coelho <coelho@ti.com> wrote:
> From: Randy Dunlap <rdunlap@xenotime.net>
>
> Combine MFD_SUPPORT (which only enabled the remainder of the MFD
> menu) and MFD_CORE. =A0This allows other drivers to select MFD_CORE
> without needing to also select MFD_SUPPORT, which fixes some
> kconfig unmet dependency warnings. =A0Modeled after I2C kconfig.
>
> [Forward-ported to 3.1-rc4. =A0This fixes a warning when some drivers=
,
> such as RADIO_WL1273, are selected, but MFD_SUPPORT is not. -- Luca]
>
> Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
> Reported-by: Johannes Berg <johannes@sipsolutions.net>
> Cc: Jean Delvare <khali@linux-fr.org>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Luciano Coelho <coelho@ti.com>

okay by me.

g.

> ---
>
> I guess this should fix the problem. =A0I've simple forward-ported
> Randy's patch to the latest mainline kernel. =A0I don't know via whic=
h
> tree this should go in, though.
>
> NOTE: I have *not* tested this very thoroughly. =A0But at least
> omap2plus stuff seems to work okay with this change. =A0MFD_SUPPORT i=
s
> also selected by a couple of "tile" platforms defconfigs, but I guess
> the Kconfig system should take care of it.
>
> =A0arch/arm/mach-omap2/Kconfig | =A0 =A02 +-
> =A0drivers/gpio/Kconfig =A0 =A0 =A0 =A0| =A0 =A03 +-
> =A0drivers/mfd/Kconfig =A0 =A0 =A0 =A0 | =A0 54 +++------------------=
---------------------
> =A03 files changed, 6 insertions(+), 53 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfi=
g
> index 57b66d5..1046923 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -14,7 +14,7 @@ config ARCH_OMAP2PLUS_TYPICAL
> =A0 =A0 =A0 =A0select SERIAL_OMAP_CONSOLE
> =A0 =A0 =A0 =A0select I2C
> =A0 =A0 =A0 =A0select I2C_OMAP
> - =A0 =A0 =A0 select MFD_SUPPORT
> + =A0 =A0 =A0 select MFD_CORE
> =A0 =A0 =A0 =A0select MENELAUS if ARCH_OMAP2
> =A0 =A0 =A0 =A0select TWL4030_CORE if ARCH_OMAP3 || ARCH_OMAP4
> =A0 =A0 =A0 =A0select TWL4030_POWER if ARCH_OMAP3 || ARCH_OMAP4
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index d539efd..fbc5fd4 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -180,7 +180,7 @@ config GPIO_SCH
>
> =A0config GPIO_VX855
> =A0 =A0 =A0 =A0tristate "VIA VX855/VX875 GPIO"
> - =A0 =A0 =A0 depends on MFD_SUPPORT && PCI
> + =A0 =A0 =A0 depends on PCI
> =A0 =A0 =A0 =A0select MFD_CORE
> =A0 =A0 =A0 =A0select MFD_VX855
> =A0 =A0 =A0 =A0help
> @@ -417,7 +417,6 @@ config GPIO_TIMBERDALE
> =A0config GPIO_RDC321X
> =A0 =A0 =A0 =A0tristate "RDC R-321x GPIO support"
> =A0 =A0 =A0 =A0depends on PCI
> - =A0 =A0 =A0 select MFD_SUPPORT
> =A0 =A0 =A0 =A0select MFD_CORE
> =A0 =A0 =A0 =A0select MFD_RDC321X
> =A0 =A0 =A0 =A0help
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 21574bd..1836cdf 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -2,10 +2,9 @@
> =A0# Multifunction miscellaneous devices
> =A0#
>
> -menuconfig MFD_SUPPORT
> - =A0 =A0 =A0 bool "Multifunction device drivers"
> +menuconfig MFD_CORE
> + =A0 =A0 =A0 tristate "Multifunction device drivers"
> =A0 =A0 =A0 =A0depends on HAS_IOMEM
> - =A0 =A0 =A0 default y
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0Multifunction devices embed several functions (e.g=
=2E GPIOs,
> =A0 =A0 =A0 =A0 =A0touchscreens, keyboards, current regulators, power=
 management chips,
> @@ -18,16 +17,11 @@ menuconfig MFD_SUPPORT
>
> =A0 =A0 =A0 =A0 =A0This option alone does not add any kernel code.
>
> -if MFD_SUPPORT
> -
> -config MFD_CORE
> - =A0 =A0 =A0 tristate
> - =A0 =A0 =A0 default n
> +if MFD_CORE
>
> =A0config MFD_88PM860X
> =A0 =A0 =A0 =A0bool "Support Marvell 88PM8606/88PM8607"
> =A0 =A0 =A0 =A0depends on I2C=3Dy && GENERIC_HARDIRQS
> - =A0 =A0 =A0 select MFD_CORE
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0This supports for Marvell 88PM8606/88PM8607 Power =
Management IC.
> =A0 =A0 =A0 =A0 =A0This includes the I2C driver and the core APIs _on=
ly_, you have to
> @@ -55,14 +49,12 @@ config MFD_SM501_GPIO
> =A0config MFD_ASIC3
> =A0 =A0 =A0 =A0bool "Support for Compaq ASIC3"
> =A0 =A0 =A0 =A0depends on GENERIC_HARDIRQS && GPIOLIB && ARM
> - =A0 =A0 =A0 select MFD_CORE
> =A0 =A0 =A0 =A0 ---help---
> =A0 =A0 =A0 =A0 =A0This driver supports the ASIC3 multifunction chip =
found on many
> =A0 =A0 =A0 =A0 =A0PDAs (mainly iPAQ and HTC based ones)
>
> =A0config MFD_DAVINCI_VOICECODEC
> =A0 =A0 =A0 =A0tristate
> - =A0 =A0 =A0 select MFD_CORE
>
> =A0config MFD_DM355EVM_MSP
> =A0 =A0 =A0 =A0bool "DaVinci DM355 EVM microcontroller"
> @@ -75,7 +67,6 @@ config MFD_DM355EVM_MSP
> =A0config MFD_TI_SSP
> =A0 =A0 =A0 =A0tristate "TI Sequencer Serial Port support"
> =A0 =A0 =A0 =A0depends on ARCH_DAVINCI_TNETV107X
> - =A0 =A0 =A0 select MFD_CORE
> =A0 =A0 =A0 =A0---help---
> =A0 =A0 =A0 =A0 =A0Say Y here if you want support for the Sequencer S=
erial Port
> =A0 =A0 =A0 =A0 =A0in a Texas Instruments TNETV107X SoC.
> @@ -93,7 +84,6 @@ config HTC_EGPIO
>
> =A0config HTC_PASIC3
> =A0 =A0 =A0 =A0tristate "HTC PASIC3 LED/DS1WM chip support"
> - =A0 =A0 =A0 select MFD_CORE
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0This core driver provides register access for the =
LED/DS1WM
> =A0 =A0 =A0 =A0 =A0chips labeled "AIC2" and "AIC3", found on HTC Blue=
angel and
> @@ -124,7 +114,6 @@ config TPS6105X
> =A0 =A0 =A0 =A0tristate "TPS61050/61052 Boost Converters"
> =A0 =A0 =A0 =A0depends on I2C
> =A0 =A0 =A0 =A0select REGULATOR
> - =A0 =A0 =A0 select MFD_CORE
> =A0 =A0 =A0 =A0select REGULATOR_FIXED_VOLTAGE
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0This option enables a driver for the TP61050/TPS61=
052
> @@ -147,7 +136,6 @@ config TPS65010
>
> =A0config TPS6507X
> =A0 =A0 =A0 =A0tristate "TPS6507x Power Management / Touch Screen chi=
ps"
> - =A0 =A0 =A0 select MFD_CORE
> =A0 =A0 =A0 =A0depends on I2C
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0If you say yes here you get support for the TPS650=
7x series of
> @@ -160,7 +148,6 @@ config TPS6507X
> =A0config MFD_TPS6586X
> =A0 =A0 =A0 =A0bool "TPS6586x Power Management chips"
> =A0 =A0 =A0 =A0depends on I2C=3Dy && GPIOLIB && GENERIC_HARDIRQS
> - =A0 =A0 =A0 select MFD_CORE
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0If you say yes here you get support for the TPS658=
6X series of
> =A0 =A0 =A0 =A0 =A0Power Management chips.
> @@ -174,7 +161,6 @@ config MFD_TPS6586X
> =A0config MFD_TPS65910
> =A0 =A0 =A0 =A0bool "TPS65910 Power Management chip"
> =A0 =A0 =A0 =A0depends on I2C=3Dy && GPIOLIB
> - =A0 =A0 =A0 select MFD_CORE
> =A0 =A0 =A0 =A0select GPIO_TPS65910
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0if you say yes here you get support for the TPS659=
10 series of
> @@ -186,7 +172,6 @@ config MFD_TPS65912
>
> =A0config MFD_TPS65912_I2C
> =A0 =A0 =A0 =A0bool "TPS95612 Power Management chip with I2C"
> - =A0 =A0 =A0 select MFD_CORE
> =A0 =A0 =A0 =A0select MFD_TPS65912
> =A0 =A0 =A0 =A0depends on I2C=3Dy && GPIOLIB
> =A0 =A0 =A0 =A0help
> @@ -195,7 +180,6 @@ config MFD_TPS65912_I2C
>
> =A0config MFD_TPS65912_SPI
> =A0 =A0 =A0 =A0bool "TPS65912 Power Management chip with SPI"
> - =A0 =A0 =A0 select MFD_CORE
> =A0 =A0 =A0 =A0select MFD_TPS65912
> =A0 =A0 =A0 =A0depends on SPI_MASTER && GPIOLIB
> =A0 =A0 =A0 =A0help
> @@ -252,7 +236,6 @@ config TWL4030_POWER
> =A0config MFD_TWL4030_AUDIO
> =A0 =A0 =A0 =A0bool
> =A0 =A0 =A0 =A0depends on TWL4030_CORE
> - =A0 =A0 =A0 select MFD_CORE
> =A0 =A0 =A0 =A0default n
>
> =A0config TWL6030_PWM
> @@ -267,13 +250,11 @@ config TWL6030_PWM
> =A0config TWL6040_CORE
> =A0 =A0 =A0 =A0bool
> =A0 =A0 =A0 =A0depends on TWL4030_CORE && GENERIC_HARDIRQS
> - =A0 =A0 =A0 select MFD_CORE
> =A0 =A0 =A0 =A0default n
>
> =A0config MFD_STMPE
> =A0 =A0 =A0 =A0bool "Support STMicroelectronics STMPE"
> =A0 =A0 =A0 =A0depends on I2C=3Dy && GENERIC_HARDIRQS
> - =A0 =A0 =A0 select MFD_CORE
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0Support for the STMPE family of I/O Expanders from
> =A0 =A0 =A0 =A0 =A0STMicroelectronics.
> @@ -296,7 +277,6 @@ config MFD_STMPE
> =A0config MFD_TC3589X
> =A0 =A0 =A0 =A0bool "Support Toshiba TC35892 and variants"
> =A0 =A0 =A0 =A0depends on I2C=3Dy && GENERIC_HARDIRQS
> - =A0 =A0 =A0 select MFD_CORE
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0Support for the Toshiba TC35892 and variants I/O E=
xpander.
>
> @@ -311,7 +291,6 @@ config MFD_TMIO
> =A0config MFD_T7L66XB
> =A0 =A0 =A0 =A0bool "Support Toshiba T7L66XB"
> =A0 =A0 =A0 =A0depends on ARM && HAVE_CLK
> - =A0 =A0 =A0 select MFD_CORE
> =A0 =A0 =A0 =A0select MFD_TMIO
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0Support for Toshiba Mobile IO Controller T7L66XB
> @@ -319,7 +298,6 @@ config MFD_T7L66XB
> =A0config MFD_TC6387XB
> =A0 =A0 =A0 =A0bool "Support Toshiba TC6387XB"
> =A0 =A0 =A0 =A0depends on ARM && HAVE_CLK
> - =A0 =A0 =A0 select MFD_CORE
> =A0 =A0 =A0 =A0select MFD_TMIO
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0Support for Toshiba Mobile IO Controller TC6387XB
> @@ -327,7 +305,6 @@ config MFD_TC6387XB
> =A0config MFD_TC6393XB
> =A0 =A0 =A0 =A0bool "Support Toshiba TC6393XB"
> =A0 =A0 =A0 =A0depends on GPIOLIB && ARM
> - =A0 =A0 =A0 select MFD_CORE
> =A0 =A0 =A0 =A0select MFD_TMIO
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0Support for Toshiba Mobile IO Controller TC6393XB
> @@ -356,7 +333,6 @@ config PMIC_ADP5520
> =A0config MFD_MAX8925
> =A0 =A0 =A0 =A0bool "Maxim Semiconductor MAX8925 PMIC Support"
> =A0 =A0 =A0 =A0depends on I2C=3Dy && GENERIC_HARDIRQS
> - =A0 =A0 =A0 select MFD_CORE
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0Say yes here to support for Maxim Semiconductor MA=
X8925. This is
> =A0 =A0 =A0 =A0 =A0a Power Management IC. This driver provies common =
support for
> @@ -366,7 +342,6 @@ config MFD_MAX8925
> =A0config MFD_MAX8997
> =A0 =A0 =A0 =A0bool "Maxim Semiconductor MAX8997/8966 PMIC Support"
> =A0 =A0 =A0 =A0depends on I2C=3Dy && GENERIC_HARDIRQS
> - =A0 =A0 =A0 select MFD_CORE
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0Say yes here to support for Maxim Semiconductor MA=
X8998/8966.
> =A0 =A0 =A0 =A0 =A0This is a Power Management IC with RTC, Flash, Fue=
l Gauge, Haptic,
> @@ -378,7 +353,6 @@ config MFD_MAX8997
> =A0config MFD_MAX8998
> =A0 =A0 =A0 =A0bool "Maxim Semiconductor MAX8998/National LP3974 PMIC=
 Support"
> =A0 =A0 =A0 =A0depends on I2C=3Dy && GENERIC_HARDIRQS
> - =A0 =A0 =A0 select MFD_CORE
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0Say yes here to support for Maxim Semiconductor MA=
X8998 and
> =A0 =A0 =A0 =A0 =A0National Semiconductor LP3974. This is a Power Man=
agement IC.
> @@ -388,7 +362,6 @@ config MFD_MAX8998
>
> =A0config MFD_WM8400
> =A0 =A0 =A0 =A0tristate "Support Wolfson Microelectronics WM8400"
> - =A0 =A0 =A0 select MFD_CORE
> =A0 =A0 =A0 =A0depends on I2C
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0Support for the Wolfson Microelecronics WM8400 PMI=
C and audio
> @@ -402,7 +375,6 @@ config MFD_WM831X
>
> =A0config MFD_WM831X_I2C
> =A0 =A0 =A0 =A0bool "Support Wolfson Microelectronics WM831x/2x PMICs=
 with I2C"
> - =A0 =A0 =A0 select MFD_CORE
> =A0 =A0 =A0 =A0select MFD_WM831X
> =A0 =A0 =A0 =A0depends on I2C=3Dy && GENERIC_HARDIRQS
> =A0 =A0 =A0 =A0help
> @@ -413,7 +385,6 @@ config MFD_WM831X_I2C
>
> =A0config MFD_WM831X_SPI
> =A0 =A0 =A0 =A0bool "Support Wolfson Microelectronics WM831x/2x PMICs=
 with SPI"
> - =A0 =A0 =A0 select MFD_CORE
> =A0 =A0 =A0 =A0select MFD_WM831X
> =A0 =A0 =A0 =A0depends on SPI_MASTER && GENERIC_HARDIRQS
> =A0 =A0 =A0 =A0help
> @@ -487,7 +458,6 @@ config MFD_WM8350_I2C
>
> =A0config MFD_WM8994
> =A0 =A0 =A0 =A0bool "Support Wolfson Microelectronics WM8994"
> - =A0 =A0 =A0 select MFD_CORE
> =A0 =A0 =A0 =A0depends on I2C=3Dy && GENERIC_HARDIRQS
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0The WM8994 is a highly integrated hi-fi CODEC desi=
gned for
> @@ -526,7 +496,6 @@ config MFD_MC13783
> =A0config MFD_MC13XXX
> =A0 =A0 =A0 =A0tristate "Support Freescale MC13783 and MC13892"
> =A0 =A0 =A0 =A0depends on SPI_MASTER
> - =A0 =A0 =A0 select MFD_CORE
> =A0 =A0 =A0 =A0select MFD_MC13783
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0Support for the Freescale (Atlas) PMIC and audio C=
ODECs
> @@ -548,7 +517,6 @@ config ABX500_CORE
> =A0config AB3100_CORE
> =A0 =A0 =A0 =A0bool "ST-Ericsson AB3100 Mixed Signal Circuit core fun=
ctions"
> =A0 =A0 =A0 =A0depends on I2C=3Dy && ABX500_CORE
> - =A0 =A0 =A0 select MFD_CORE
> =A0 =A0 =A0 =A0default y if ARCH_U300
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0Select this to enable the AB3100 Mixed Signal IC c=
ore
> @@ -579,7 +547,6 @@ config EZX_PCAP
> =A0config AB8500_CORE
> =A0 =A0 =A0 =A0bool "ST-Ericsson AB8500 Mixed Signal Power Management=
 chip"
> =A0 =A0 =A0 =A0depends on GENERIC_HARDIRQS && ABX500_CORE
> - =A0 =A0 =A0 select MFD_CORE
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0Select this option to enable access to AB8500 powe=
r management
> =A0 =A0 =A0 =A0 =A0chip. This connects to U8500 either on the SSP/SPI=
 bus (deprecated
> @@ -614,7 +581,6 @@ config AB8500_GPADC
>
> =A0config AB3550_CORE
> =A0 =A0 =A0 =A0 bool "ST-Ericsson AB3550 Mixed Signal Circuit core fu=
nctions"
> - =A0 =A0 =A0 select MFD_CORE
> =A0 =A0 =A0 =A0depends on I2C=3Dy && GENERIC_HARDIRQS && ABX500_CORE
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0Select this to enable the AB3550 Mixed Signal IC c=
ore
> @@ -629,7 +595,6 @@ config AB3550_CORE
> =A0config MFD_DB8500_PRCMU
> =A0 =A0 =A0 =A0bool "ST-Ericsson DB8500 Power Reset Control Managemen=
t Unit"
> =A0 =A0 =A0 =A0depends on UX500_SOC_DB8500
> - =A0 =A0 =A0 select MFD_CORE
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0Select this option to enable support for the DB850=
0 Power Reset
> =A0 =A0 =A0 =A0 =A0and Control Management Unit. This is basically an =
autonomous
> @@ -639,7 +604,6 @@ config MFD_DB8500_PRCMU
> =A0config MFD_DB5500_PRCMU
> =A0 =A0 =A0 =A0bool "ST-Ericsson DB5500 Power Reset Control Managemen=
t Unit"
> =A0 =A0 =A0 =A0depends on UX500_SOC_DB5500
> - =A0 =A0 =A0 select MFD_CORE
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0Select this option to enable support for the DB550=
0 Power Reset
> =A0 =A0 =A0 =A0 =A0and Control Management Unit. This is basically an =
autonomous
> @@ -648,7 +612,6 @@ config MFD_DB5500_PRCMU
>
> =A0config MFD_CS5535
> =A0 =A0 =A0 =A0tristate "Support for CS5535 and CS5536 southbridge co=
re functions"
> - =A0 =A0 =A0 select MFD_CORE
> =A0 =A0 =A0 =A0depends on PCI && X86
> =A0 =A0 =A0 =A0---help---
> =A0 =A0 =A0 =A0 =A0This is the core driver for CS5535/CS5536 MFD func=
tions. =A0This is
> @@ -656,7 +619,6 @@ config MFD_CS5535
>
> =A0config MFD_TIMBERDALE
> =A0 =A0 =A0 =A0tristate "Support for the Timberdale FPGA"
> - =A0 =A0 =A0 select MFD_CORE
> =A0 =A0 =A0 =A0depends on PCI && GPIOLIB
> =A0 =A0 =A0 =A0---help---
> =A0 =A0 =A0 =A0This is the core driver for the timberdale FPGA. This =
device is a
> @@ -668,14 +630,12 @@ config MFD_TIMBERDALE
> =A0config LPC_SCH
> =A0 =A0 =A0 =A0tristate "Intel SCH LPC"
> =A0 =A0 =A0 =A0depends on PCI
> - =A0 =A0 =A0 select MFD_CORE
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0LPC bridge function of the Intel SCH provides supp=
ort for
> =A0 =A0 =A0 =A0 =A0System Management Bus and General Purpose I/O.
>
> =A0config MFD_RDC321X
> =A0 =A0 =A0 =A0tristate "Support for RDC-R321x southbridge"
> - =A0 =A0 =A0 select MFD_CORE
> =A0 =A0 =A0 =A0depends on PCI
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0Say yes here if you want to have support for the R=
DC R-321x SoC
> @@ -684,7 +644,6 @@ config MFD_RDC321X
>
> =A0config MFD_JANZ_CMODIO
> =A0 =A0 =A0 =A0tristate "Support for Janz CMOD-IO PCI MODULbus Carrie=
r Board"
> - =A0 =A0 =A0 select MFD_CORE
> =A0 =A0 =A0 =A0depends on PCI
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0This is the core driver for the Janz CMOD-IO PCI M=
ODULbus
> @@ -694,7 +653,6 @@ config MFD_JANZ_CMODIO
>
> =A0config MFD_JZ4740_ADC
> =A0 =A0 =A0 =A0bool "Support for the JZ4740 SoC ADC core"
> - =A0 =A0 =A0 select MFD_CORE
> =A0 =A0 =A0 =A0select GENERIC_IRQ_CHIP
> =A0 =A0 =A0 =A0depends on MACH_JZ4740
> =A0 =A0 =A0 =A0help
> @@ -704,7 +662,6 @@ config MFD_JZ4740_ADC
> =A0config MFD_VX855
> =A0 =A0 =A0 =A0tristate "Support for VIA VX855/VX875 integrated south=
 bridge"
> =A0 =A0 =A0 =A0depends on PCI
> - =A0 =A0 =A0 select MFD_CORE
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0Say yes here to enable support for various functio=
ns of the
> =A0 =A0 =A0 =A0 =A0VIA VX855/VX875 south bridge. You will need to ena=
ble the vx855_spi
> @@ -713,7 +670,6 @@ config MFD_VX855
> =A0config MFD_WL1273_CORE
> =A0 =A0 =A0 =A0tristate "Support for TI WL1273 FM radio."
> =A0 =A0 =A0 =A0depends on I2C
> - =A0 =A0 =A0 select MFD_CORE
> =A0 =A0 =A0 =A0default n
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0This is the core driver for the TI WL1273 FM radio=
=2E This MFD
> @@ -735,7 +691,6 @@ config MFD_PM8XXX
> =A0config MFD_PM8921_CORE
> =A0 =A0 =A0 =A0tristate "Qualcomm PM8921 PMIC chip"
> =A0 =A0 =A0 =A0depends on MSM_SSBI
> - =A0 =A0 =A0 select MFD_CORE
> =A0 =A0 =A0 =A0select MFD_PM8XXX
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0If you say yes to this option, support will be inc=
luded for the
> @@ -762,7 +717,6 @@ config TPS65911_COMPARATOR
>
> =A0config MFD_AAT2870_CORE
> =A0 =A0 =A0 =A0bool "Support for the AnalogicTech AAT2870"
> - =A0 =A0 =A0 select MFD_CORE
> =A0 =A0 =A0 =A0depends on I2C=3Dy && GPIOLIB
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0If you say yes here you get support for the AAT287=
0.
> @@ -770,7 +724,7 @@ config MFD_AAT2870_CORE
> =A0 =A0 =A0 =A0 =A0additional drivers must be enabled in order to use=
 the
> =A0 =A0 =A0 =A0 =A0functionality of the device.
>
> -endif # MFD_SUPPORT
> +endif # MFD_CORE
>
> =A0menu "Multimedia Capabilities Port drivers"
> =A0 =A0 =A0 =A0depends on ARCH_SA1100
> --
> 1.7.1
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
