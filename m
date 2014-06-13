From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 00/14] arm-soc fixes for 3.16 review
Date: Fri, 13 Jun 2014 18:01:02 +0200
Message-ID: <1402675276-538682-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:63138 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753102AbaFMQCN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Jun 2014 12:02:13 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: arm@kernel.org, Arnd Bergmann <arnd@arndb.de>, andrew@lunn.ch, ben-linux@fluff.org, dan.carpenter@oracle.com, daniel.lezcano@linaro.org, gregory.clement@free-electrons.com, jason@lakedaemon.net, khilman@linaro.org, kgene.kim@samsung.com, linus.walleij@linaro.org, lorenzo.pieralisi@arm.com, ohad@wizery.com, olof@lixom.net, pawel.moll@arm.com, robh@kernel.org, rtivy@ti.com, linux@arm.linux.org.uk, sachin.kamat@linaro.org, santosh.shilimkar@ti.com, sebastian.hesselbarth@gmail.com, shawn.guo@linaro.org, sboyd@codeaurora.org, t.figa@samsung.com, tony@atomide.com, tushar.behera@linaro.org, viresh.kumar@linaro.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org

Hi Everyone,

here are the fixes I've picked up so far as the last pull request
for the merge window. I'm sure there will be a lot more in the
future, but let us know if I missed something or if any of the
patches (in particular mine, some of which I have not posted
before) are not ok.

Arnd Bergmann (6):
  ARM: mvebu: fix randconfig builds for pmsu driver
  ARM: omap2: fix am43xx dependency on l2x0 cache
  ARM: keystone requires ARM_PATCH_PHYS_VIRT
  bus/arm-cci: add dependency on OF && CPU_V7
  remoteproc: da8xx: don't select CMA on no-MMU
  ARM: samsung: make SAMSUNG_DMADEV optional

Dan Carpenter (1):
  misc: vexpress: fix error handling vexpress_syscfg_regmap_init()

Jason Cooper (1):
  ARM: mvebu: DT: fix OpenBlocks AX3-4 RAM size

Linus Walleij (1):
  ARM: integrator: fix section mismatch problem

Olof Johansson (1):
  ARM: exynos: move sysram info to exynos.c

Rob Herring (2):
  ARM: exynos: cleanup kconfig option display
  ARM: use menuconfig for sub-arch menus

Sachin Kamat (1):
  ARM: EXYNOS: Fix compilation warning

Stephen Boyd (1):
  ARM: Remove ARCH_HAS_CPUFREQ config option

 arch/arm/Kconfig                                 | 20 +--------------
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts |  2 +-
 arch/arm/configs/omap2plus_defconfig             |  1 +
 arch/arm/mach-bcm/Kconfig                        |  7 +++---
 arch/arm/mach-berlin/Kconfig                     |  6 +----
 arch/arm/mach-cns3xxx/Kconfig                    |  7 +++---
 arch/arm/mach-davinci/Kconfig                    |  1 -
 arch/arm/mach-exynos/Kconfig                     |  7 +-----
 arch/arm/mach-exynos/common.h                    |  1 +
 arch/arm/mach-exynos/exynos.c                    | 31 +++++++++++++++++++++++-
 arch/arm/mach-exynos/platsmp.c                   | 26 ++------------------
 arch/arm/mach-highbank/Kconfig                   |  1 -
 arch/arm/mach-imx/Kconfig                        | 10 +++-----
 arch/arm/mach-integrator/Kconfig                 |  2 +-
 arch/arm/mach-integrator/impd1.c                 | 12 ++++++++-
 arch/arm/mach-keystone/Kconfig                   |  1 +
 arch/arm/mach-moxart/Kconfig                     |  2 +-
 arch/arm/mach-mvebu/Kconfig                      |  8 ++----
 arch/arm/mach-mvebu/pmsu.c                       |  9 ++++++-
 arch/arm/mach-nomadik/Kconfig                    |  4 +--
 arch/arm/mach-omap2/Kconfig                      | 11 +++++----
 arch/arm/mach-omap2/common.h                     |  7 ++++++
 arch/arm/mach-prima2/Kconfig                     |  6 ++---
 arch/arm/mach-qcom/Kconfig                       |  6 +----
 arch/arm/mach-s3c24xx/Kconfig                    |  2 +-
 arch/arm/mach-s3c64xx/Kconfig                    |  4 +--
 arch/arm/mach-s5p64x0/Kconfig                    |  6 +++--
 arch/arm/mach-s5pc100/Kconfig                    |  3 ++-
 arch/arm/mach-s5pv210/Kconfig                    |  3 ++-
 arch/arm/mach-shmobile/Kconfig                   |  6 ++---
 arch/arm/mach-spear/Kconfig                      |  1 -
 arch/arm/mach-tegra/Kconfig                      |  8 +++---
 arch/arm/mach-u300/Kconfig                       |  6 +----
 arch/arm/mach-ux500/Kconfig                      |  7 +-----
 arch/arm/mach-vexpress/Kconfig                   |  8 +++---
 arch/arm/mach-vt8500/Kconfig                     |  1 -
 arch/arm/mach-zynq/Kconfig                       |  1 -
 arch/arm/plat-samsung/Kconfig                    | 28 ++++++---------------
 drivers/bus/Kconfig                              |  2 +-
 drivers/misc/vexpress-syscfg.c                   | 12 ++++++---
 drivers/remoteproc/Kconfig                       |  2 +-
 41 files changed, 127 insertions(+), 161 deletions(-)

-- 
1.8.3.2

Cc: andrew@lunn.ch
Cc: arnd@arndb.de
Cc: ben-linux@fluff.org
Cc: dan.carpenter@oracle.com
Cc: daniel.lezcano@linaro.org
Cc: gregory.clement@free-electrons.com
Cc: jason@lakedaemon.net
Cc: khilman@linaro.org
Cc: kgene.kim@samsung.com
Cc: linus.walleij@linaro.org
Cc: lorenzo.pieralisi@arm.com
Cc: ohad@wizery.com
Cc: olof@lixom.net
Cc: pawel.moll@arm.com
Cc: robh@kernel.org
Cc: rtivy@ti.com
Cc: linux@arm.linux.org.uk
Cc: sachin.kamat@linaro.org
Cc: santosh.shilimkar@ti.com
Cc: sebastian.hesselbarth@gmail.com
Cc: shawn.guo@linaro.org
Cc: sboyd@codeaurora.org
Cc: t.figa@samsung.com
Cc: tony@atomide.com
Cc: tushar.behera@linaro.org
Cc: viresh.kumar@linaro.org
Cc:  linux-omap@vger.kernel.org
Cc:  linux-samsung-soc@vger.kernel.org
