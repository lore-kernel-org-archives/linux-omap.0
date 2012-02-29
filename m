From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/5] non-critical fixes for v3.4 merge window
Date: Wed, 29 Feb 2012 12:15:06 -0800
Message-ID: <12008.5396025845$1330546554@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Arnd & Olof,

This contains fixes for MMC platform init to allow marking
functions that should be __init as __init. Also included are
some randconfig fixes.

Regards,

Tony


The following changes since commit 6b21d18ed50c7d145220b0724ea7f2613abf0f95:
  Linus Torvalds (1):
        Linux 3.3-rc5

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fixes-non-critical

Kevin Hilman (1):
      ARM: OMAP: convert omap_device_build() and callers to __init

Ohad Ben-Cohen (1):
      ARM: OMAP: omap_device: Expose omap_device_{alloc, delete, register}

Paul Walmsley (1):
      ARM: OMAP2+: I2C: always compile I2C reset code, even if I2C driver is not built

Peter Ujfalusi (1):
      OMAP4: dma: Correct CPU version check for dma_common_ch_end

Santosh Shilimkar (2):
      ARM: OMAP: fix section mismatch warning for omap4_hotplug_cpu()
      ARM: OMAP: Fix section mismatch warning for platform_cpu_die()

Tony Lindgren (13):
      ARM: OMAP: Fix kernel panic with HSMMC when twl4030_gpio is a module
      ARM: OMAP: Fix build error when mmc_omap is built as module
      ARM: OMAP2+: Split omap2_hsmmc_init() to properly support I2C GPIO pins
      ARM: OMAP2+: Fix Kconfig dependencies for USB_ARCH_HAS_EHCI
      ARM: OMAP2+: Fix OMAP_HDQ_BASE build error
      ARM: OMAP2+: Fix board_mux section type conflict when OMAP_MUX is not set
      ARM: OMAP2+: Fix zoom LCD backlight if TWL_CORE is not selected
      ARM: OMAP2+: Fix devexit for smartreflex when CONFIG_HOTPLUG is not set
      ARM: OMAP: Fix devexit for dma when CONFIG_HOTPLUG is not set
      ARM: OMAP2+: Fix multiple randconfig errors with SOC_OMAP and SOC_OMAP_NOOP
      ARM: OMAP2+: Mark omap_hsmmc_init and omap_mux related functions as __init
      Merge branch 'randconfig' into fixes-non-critical
      Merge branch 'hsmmc' into fixes-non-critical

 arch/arm/Makefile                             |    4 +-
 arch/arm/mach-omap2/Kconfig                   |   55 +++++++----
 arch/arm/mach-omap2/Makefile                  |    5 +-
 arch/arm/mach-omap2/board-2430sdp.c           |    2 +-
 arch/arm/mach-omap2/board-3430sdp.c           |    5 +-
 arch/arm/mach-omap2/board-4430sdp.c           |    4 +-
 arch/arm/mach-omap2/board-am3517evm.c         |    2 +-
 arch/arm/mach-omap2/board-cm-t35.c            |    5 +-
 arch/arm/mach-omap2/board-devkit8000.c        |    4 +-
 arch/arm/mach-omap2/board-flash.c             |    2 +-
 arch/arm/mach-omap2/board-igep0020.c          |    6 +-
 arch/arm/mach-omap2/board-ldp.c               |    2 +-
 arch/arm/mach-omap2/board-n8x0.c              |    4 +
 arch/arm/mach-omap2/board-omap3beagle.c       |   10 ++-
 arch/arm/mach-omap2/board-omap3evm.c          |    7 +-
 arch/arm/mach-omap2/board-omap3logic.c        |    2 +-
 arch/arm/mach-omap2/board-omap3pandora.c      |    5 +-
 arch/arm/mach-omap2/board-omap3stalker.c      |   15 ++-
 arch/arm/mach-omap2/board-omap3touchbook.c    |   17 ++--
 arch/arm/mach-omap2/board-omap4panda.c        |    6 +-
 arch/arm/mach-omap2/board-overo.c             |    3 +-
 arch/arm/mach-omap2/board-rm680.c             |    2 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c  |    2 +-
 arch/arm/mach-omap2/board-zoom-display.c      |    4 +
 arch/arm/mach-omap2/board-zoom-peripherals.c  |    4 +-
 arch/arm/mach-omap2/devices.c                 |   15 ++--
 arch/arm/mach-omap2/display.c                 |    8 +-
 arch/arm/mach-omap2/dma.c                     |    2 +-
 arch/arm/mach-omap2/gpio.c                    |    2 +-
 arch/arm/mach-omap2/hsmmc.c                   |  129 +++++++++++++++++++------
 arch/arm/mach-omap2/hsmmc.h                   |   12 ++-
 arch/arm/mach-omap2/mcbsp.c                   |    2 +-
 arch/arm/mach-omap2/mux.c                     |   14 ++--
 arch/arm/mach-omap2/mux.h                     |    2 +-
 arch/arm/mach-omap2/omap-hotplug.c            |    2 +-
 arch/arm/mach-omap2/omap-mpuss-lowpower.c     |    2 +-
 arch/arm/mach-omap2/pm.c                      |    2 +-
 arch/arm/mach-omap2/smartreflex.c             |    2 +-
 arch/arm/mach-omap2/sr_device.c               |    2 +-
 arch/arm/plat-omap/dma.c                      |    2 +-
 arch/arm/plat-omap/include/plat/omap_device.h |    7 ++
 arch/arm/plat-omap/omap_device.c              |   20 ++---
 42 files changed, 264 insertions(+), 138 deletions(-)
