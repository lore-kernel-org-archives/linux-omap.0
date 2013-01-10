From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] enable multiplatform support for omap2+ for v3.9
Date: Thu, 10 Jan 2013 11:42:18 -0800
Message-ID: <20130110194217.GA14149@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:11677 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755715Ab3AJTmY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Jan 2013 14:42:24 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Russell King <rmk+kernel@arm.linux.org.uk>

Hi Arnd, Olof,

Below is a pull request to enable multiplatform support for omap2+.

Note that there's a trivial merge conflict with linux next for
drivers/crypto/omap-sham.c. The solution is to just use the version
of the file in linux next.

Russell, looks like you need to update your omap noconfig files a
bit, see below.

Regards,

Tony


The following changes since commit 5c49985c21bba4d2f899e3a97121868a5c58a876:

  Merge branch 'fixes' of git://git.linaro.org/people/rmk/linux-arm (2013-01-09 08:58:57 -0800)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.9/multiplatform-enable-signed

for you to fetch changes up to 173d2b24c8ae5d79d016f84d7fbb1c18ec23e508:

  ARM: OMAP2+: Remove now obsolete uncompress.h and debug-macro.S (2013-01-09 11:38:45 -0800)

----------------------------------------------------------------
The last dependency for enabling multiplatform support for omap2+ is now
finally gone with commit 62e4d357 (ARM: 7609/1: disable errata work-arounds
which access secure registers) that was preventing booting omap4.

Note that make uImage will no longer work properly because of unspecified
load address, so uImage needs to be created manually with:

$ mkimage -A arm -O linux -T kernel -C none -a 0x80008000 -e 0x80008000 \
	-n "Linux" -d zImage-omap2plus uImage-omap2plus

You can also boot minimal vexpress configuration using qemu with:

$ qemu-system-arm -machine vexpress-a9 -m 1024 -net nic -net user -serial stdio \
	-append "console=ttyAMA0,115200n8 rw root=/dev/mmcblk0p2 rootwait" \
	-kernel zImage-omap2plus -initrd initrd.img -sd rootfs.img

Please note that some custom defconfigs now need to be updated to include
the following options:

CONFIG_ARCH_MULTIPLATFORM=y
CONFIG_ARCH_MULTI_V7=y
CONFIG_ARCH_OMAP2PLUS=y

And possibly also:

CONFIG_ARCH_MULTI_V6=y

Updating is needed at least for RMK's minimal allnoconfig files.

And if you need DEBUG_LL for earlyprintk, you now have to select the
debug port manually with Kconfig.

----------------------------------------------------------------
Tony Lindgren (9):
      ARM: OMAP2+: Limit omap initcalls to omap only on multiplatform kernels
      ARM: OMAP2+: Use omap initcalls
      ARM: OMAP: Fix i2c cmdline initcall for multiplatform
      ARM: OMAP: Fix dmaengine init for multiplatform
      ARM: OMAP2+: Add multiplatform debug_ll support
      ARM: OMAP2+: Disable code that currently does not work with multiplaform
      ARM: OMAP2+: Enable ARCH_MULTIPLATFORM support
      ARM: OMAP2+: Add minimal support for booting vexpress
      ARM: OMAP2+: Remove now obsolete uncompress.h and debug-macro.S

 arch/arm/Kconfig                                   |  13 +-
 arch/arm/Kconfig.debug                             |  56 +++++++
 arch/arm/configs/omap2plus_defconfig               |   6 +-
 .../debug-macro.S => include/debug/omap2plus.S}    | 137 +++++++++-------
 arch/arm/mach-omap1/dma.c                          |  18 ++-
 arch/arm/mach-omap1/i2c.c                          |   6 +
 arch/arm/mach-omap2/Kconfig                        |  25 ++-
 arch/arm/mach-omap2/Makefile                       |   3 +
 arch/arm/mach-omap2/board-omap3beagle.c            |   2 +-
 arch/arm/mach-omap2/board-rx51-video.c             |   3 +-
 arch/arm/mach-omap2/clock2xxx.c                    |   2 +-
 arch/arm/mach-omap2/clock3xxx.c                    |   2 +-
 arch/arm/mach-omap2/devices.c                      |   6 +-
 arch/arm/mach-omap2/dma.c                          |  23 ++-
 arch/arm/mach-omap2/drm.c                          |   2 +-
 arch/arm/mach-omap2/emu.c                          |   2 +-
 arch/arm/mach-omap2/fb.c                           |   4 +-
 arch/arm/mach-omap2/gpio.c                         |   5 +-
 arch/arm/mach-omap2/gpmc.c                         |   4 +-
 arch/arm/mach-omap2/hdq1w.c                        |   3 +-
 arch/arm/mach-omap2/hwspinlock.c                   |   2 +-
 arch/arm/mach-omap2/i2c.c                          |   5 +
 arch/arm/mach-omap2/include/mach/serial.h          |  37 -----
 arch/arm/mach-omap2/include/mach/uncompress.h      | 176 ---------------------
 arch/arm/mach-omap2/mcbsp.c                        |   3 +-
 arch/arm/mach-omap2/omap-iommu.c                   |   2 +-
 arch/arm/mach-omap2/omap2-restart.c                |   3 +-
 arch/arm/mach-omap2/omap4-common.c                 |   4 +-
 arch/arm/mach-omap2/omap_device.c                  |   5 +-
 arch/arm/mach-omap2/omap_hwmod.c                   |   2 +-
 arch/arm/mach-omap2/omap_phy_internal.c            |   2 +-
 arch/arm/mach-omap2/opp3xxx_data.c                 |   2 +-
 arch/arm/mach-omap2/opp4xxx_data.c                 |   2 +-
 arch/arm/mach-omap2/pm-debug.c                     |   2 +-
 arch/arm/mach-omap2/pm.c                           |   2 +-
 arch/arm/mach-omap2/pmu.c                          |   2 +-
 arch/arm/mach-omap2/prm3xxx.c                      |   2 +-
 arch/arm/mach-omap2/prm44xx.c                      |   2 +-
 arch/arm/mach-omap2/serial.c                       |   2 +-
 arch/arm/mach-omap2/smartreflex-class3.c           |   2 +-
 arch/arm/mach-omap2/soc.h                          |  29 ++++
 arch/arm/mach-omap2/timer.c                        |   2 +-
 arch/arm/mach-omap2/wd_timer.c                     |   2 +-
 arch/arm/plat-omap/Kconfig                         |  32 +---
 arch/arm/plat-omap/Makefile                        |   2 +
 arch/arm/plat-omap/i2c.c                           |   3 +-
 arch/arm/plat-omap/include/plat/i2c.h              |   6 +
 drivers/crypto/omap-sham.c                         |   3 +
 drivers/dma/omap-dma.c                             |  20 +--
 drivers/media/rc/Kconfig                           |   2 +-
 drivers/staging/tidspbridge/Kconfig                |   2 +-
 51 files changed, 314 insertions(+), 370 deletions(-)
 rename arch/arm/{mach-omap2/include/mach/debug-macro.S => include/debug/omap2plus.S} (56%)
 delete mode 100644 arch/arm/mach-omap2/include/mach/uncompress.h
