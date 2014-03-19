From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 00/62] arm-soc randconfig fixes
Date: Wed, 19 Mar 2014 20:28:57 +0100
Message-ID: <1395257399-359545-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.13]:55977 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752226AbaCSTbc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Mar 2014 15:31:32 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, =?UTF-8?q?Uwe=20Kleine-K=F6nig?= <kernel@pengutronix.de>, Hartley Sweeten <hsweeten@visionengravers.com>, Shawn Guo <shawn.guo@freescale.com>, Krzysztof Halasa <khc@pm.waw.pl>, David Brown <davidb@codeaurora.org>, linux-omap@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Haojian Zhuang <haojian.zhuang@gmail.com>, Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Maxime Ripard <maxime.ripard@free-electrons.com>, Stephen Warren <swarren@wwwdotorg.org>

Hi everyone,

This is my much too long series of mostly trivial build for ARM platfor=
m
code. It's about a third of the total set of patches I have in a local
tree that I use for build testing randconfig kernels. Most of the other
patches are for device drivers, but there is also a significant chunk
for ARM architecture code, and a few things that are controversial or
not yet properly fixed.

I'd like to put all or most of these into a branch in arm-soc for
the coming merge window. Acks are very much appreciated, as as
Naks when I got something wrong. Everything I don't hear back
from I will assume is ok and put in.

Statistically speaking, I probably made a couple of mistakes here,
so please have a look if you find the time.

Arnd Bergmann (62):
  ARM: at91: split out at91x40 into a top-level option
  ARM: at91: don't provide dt init code for at91x40
  ARM: at91: export sam9_smc interfaces
  ARM: at91: fix broken "if () else" statement
  ARM: at91: sama5 always uses DT
  ARM: davinci: export da8xx_syscfg0_base
  ARM: davinci: make dm644x-evm phy fixup conditional
  ARM: davinci: use explicit 'select' for DA850_EVM
  ARM: efm32: allow uncompress debug output
  ARM: efm32: select AUTO_ZRELADDR
  ARM: ep93xx: export ep93xx_chip_revision
  ARM: hisi: fix building without CONFIG_HOTPLUG_CPU
  ARM: hisi: select HAVE_ARM_SCU only for SMP
  ARM: imx: imx6q_set_lpm is only defined for CONFIG_PM=3Dy
  ARM: ixp4xx/omixp: always include linux/leds.h
  ARM: ixp4xx: avoid use of PCIBIOS_MIN_MEM in io.h
  ARM: ixp4xx: fix gpio rework
  ARM: ks8695/og: make PCI setup conditional
  ARM: lpc32xx: export lpc32xx_return_iram_size
  ARM: msm: add missing include of linux/module.h
  ARM: msm: avoid calling debug_ll_addr on !MMU
  ARM: msm: export legacy DMA interfaces
  ARM: omap1: fix building without 32K_TIMER
  ARM: omap1: select I2C where needed for PMIC
  ARM: mvebu: add missing header
  ARM: mvebu: don't select CONFIG_NEON
  ARM: orion5x: make dns323 independent of PHY support
  ARM: pxa: FB_W100 must be built-in
  ARM: pxa: don't "select" SMC91X on MACH_XCEP
  ARM: pxa: enable pxafb unconditionally for some boards
  ARM: pxa: fix colibri build
  ARM: pxa: fix pxa_ssp_* declarations
  ARM: pxa: remove broken balloon3_gpio_vbus reference
  ARM: pxa: select I2C_GPIO only if I2C is on
  ARM: pxa: trizeps4 and trizeps4wl use the same file
  ARM: rpc: autoselect CPU_SA110
  ARM: sa1100/pxa: fix MTD_XIP build
  ARM: footbridge: don't build floppy code for addin mode
  ARM: footbridge: fix build with PCI disabled
  ARM: footbridge: make screen_info setup conditional
  ARM: realview: fix sparsemem build
  ARM: realview: use explicit core tile config options
  ARM: integrator: only select pl01x if TTY is enabled
  ARM: integrator: refine CPU selection
  ARM: s3c24xx: MINI2440 needs I2C for EEPROM_AT24
  ARM: s3c24xx: fix gta02 build error
  ARM: s3c64xx: MACH_SMDK6400 needs HSMMC1
  ARM: s3c64xx: select power domains only when used
  ARM: s5p64x0: fix building with only one soc type
  ARM: s5pv210: enable IDE support in MACH_TORBRECK
  ARM: samsung: allow serial driver to be disabled
  ARM: samsung: disable decompressor watchdog on exynos
  ARM: samsung: fix SAMSUNG_PM_DEBUG Kconfig logic
  ARM: samsung: select ATAGS where necessary
  ARM: samsung: select CRC32 for SAMSUNG_PM_CHECK
  ARM: samsung: select I2C where needed for PMIC
  ARM: exynos: fix l2x0 saved regs handling
  ARM: exynos: add missing include of linux/module.h
  ARM: shmobile: ak4642 needs i2c support
  ARM: shmobile: work around CONFIG_PHYLIB=3Dm
  ARM: sunxi: fix build for THUMB2_KERNEL
  ARM: tegra: make debug_ll code build for ARMv6

 arch/arm/Kconfig                             |  9 ++++-
 arch/arm/Kconfig.debug                       |  2 +-
 arch/arm/include/debug/tegra.S               | 18 ++++-----
 arch/arm/mach-at91/Kconfig                   | 23 +++++++++--
 arch/arm/mach-at91/Kconfig.non_dt            |  8 +---
 arch/arm/mach-at91/at91sam9260_devices.c     |  4 +-
 arch/arm/mach-at91/sam9_smc.c                |  3 ++
 arch/arm/mach-at91/setup.c                   |  2 +-
 arch/arm/mach-davinci/Kconfig                |  7 +---
 arch/arm/mach-davinci/board-dm644x-evm.c     | 11 +++---
 arch/arm/mach-davinci/devices-da8xx.c        |  1 +
 arch/arm/mach-ep93xx/core.c                  |  1 +
 arch/arm/mach-exynos/common.c                |  6 ++-
 arch/arm/mach-exynos/cpuidle.c               |  1 +
 arch/arm/mach-footbridge/Kconfig             |  2 +-
 arch/arm/mach-footbridge/Makefile            |  3 +-
 arch/arm/mach-footbridge/cats-hw.c           |  2 +
 arch/arm/mach-hisi/Kconfig                   |  2 +-
 arch/arm/mach-hisi/Makefile                  |  3 +-
 arch/arm/mach-hisi/hotplug.c                 |  2 +
 arch/arm/mach-imx/clk-imx6q.c                |  3 +-
 arch/arm/mach-imx/clk-imx6sl.c               |  3 +-
 arch/arm/mach-imx/cpuidle-imx6sl.c           |  3 ++
 arch/arm/mach-integrator/Kconfig             | 19 ++++++++--
 arch/arm/mach-ixp4xx/common.c                |  6 +--
 arch/arm/mach-ixp4xx/goramo_mlr.c            |  7 ++++
 arch/arm/mach-ixp4xx/include/mach/io.h       |  3 +-
 arch/arm/mach-ixp4xx/omixp-setup.c           |  2 -
 arch/arm/mach-ks8695/board-og.c              |  3 +-
 arch/arm/mach-lpc32xx/common.c               |  1 +
 arch/arm/mach-msm/dma.c                      |  3 ++
 arch/arm/mach-msm/io.c                       |  2 +
 arch/arm/mach-mvebu/Kconfig                  |  2 -
 arch/arm/mach-mvebu/board-v7.c               |  1 +
 arch/arm/mach-omap1/Kconfig                  |  4 ++
 arch/arm/mach-omap1/pm.c                     |  8 ++--
 arch/arm/mach-orion5x/Kconfig                |  1 -
 arch/arm/mach-orion5x/dns323-setup.c         |  2 +
 arch/arm/mach-pxa/Kconfig                    | 10 +++--
 arch/arm/mach-pxa/balloon3.c                 |  1 -
 arch/arm/mach-pxa/colibri-evalboard.c        |  1 +
 arch/arm/mach-pxa/include/mach/mtd-xip.h     |  7 ++--
 arch/arm/mach-pxa/irq.c                      |  8 ++++
 arch/arm/mach-realview/Kconfig               | 57 ++++++++++++++++++++=
++++++++
 arch/arm/mach-realview/include/mach/memory.h |  2 +
 arch/arm/mach-s3c24xx/Kconfig                |  3 +-
 arch/arm/mach-s3c24xx/mach-gta02.c           |  2 +-
 arch/arm/mach-s3c64xx/Kconfig                |  3 ++
 arch/arm/mach-s3c64xx/irq-pm.c               | 12 ++++--
 arch/arm/mach-s5p64x0/common.c               | 18 ++++++++-
 arch/arm/mach-s5p64x0/common.h               |  5 +--
 arch/arm/mach-s5p64x0/irq-pm.c               |  6 +++
 arch/arm/mach-s5pv210/Kconfig                |  1 +
 arch/arm/mach-sa1100/include/mach/mtd-xip.h  |  4 +-
 arch/arm/mach-shmobile/Kconfig               | 12 +++---
 arch/arm/mach-shmobile/board-koelsch.c       |  2 +-
 arch/arm/mach-shmobile/board-lager.c         |  2 +-
 arch/arm/mach-sunxi/headsmp.S                |  3 +-
 arch/arm/mm/Kconfig                          | 30 +++++++--------
 arch/arm/plat-samsung/Kconfig                |  7 ++--
 arch/arm/plat-samsung/init.c                 |  4 ++
 drivers/video/Kconfig                        |  4 +-
 include/linux/pxa2xx_ssp.h                   |  2 +-
 63 files changed, 276 insertions(+), 113 deletions(-)

--=20
1.8.3.2

Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Uwe Kleine-K=F6nig <kernel@pengutronix.de>
Cc: Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Shawn Guo <shawn.guo@freescale.com>
Cc: Krzysztof Halasa <khc@pm.waw.pl>
Cc: David Brown <davidb@codeaurora.org>
Cc: linux-omap@vger.kernel.org
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Simon Horman <horms@verge.net.au>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
