From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 4/7] omap custom atag removal for v3.7 merge window
Date: Thu, 13 Sep 2012 19:18:44 -0700
Message-ID: <E1TCLV3-0003AA-KH@merlin.infradead.org>
References: <pull-1347589125-283636>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1347589125-283636>
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

The following changes since commit 55d512e245bc7699a8800e23df1a24195dd08217:

  Linux 3.6-rc5 (2012-09-08 16:43:45 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/cleanup-omap-tags-for-v3.7

for you to fetch changes up to cf3a6ec2c0a499ef019d25d4dbc79df66e7d3f0c:

  ARM: OMAP: remove plat/board.h file (2012-09-10 16:39:21 -0700)

----------------------------------------------------------------
Remove the ancient omap specific atags that are no longer needed.

At some point we were planning to pass the bootloader information
with custom atags that did not work out too well.

There's no need for these any longer as the kernel has been booting
fine without them for quite some time. And Now we have device tree
support that can be used instead.

----------------------------------------------------------------
Igor Grinberg (9):
      ARM: OMAP: cleanup struct omap_board_config_kernel
      ARM: OMAP: omap3evm: cleanup revision bits
      ARM: OMAP: remove the sti console workaround
      ARM: OMAP1: remove the crystal type tag parsing
      ARM: OMAP: remove the omap custom tags
      ARM: OMAP1: move omap1_bl pdata out of arch/arm/*
      ARM: OMAP1: move lcd pdata out of arch/arm/*
      ARM: OMAP: move debug_card_init() function
      ARM: OMAP: remove plat/board.h file

 arch/arm/mach-omap1/board-ams-delta.c           |    1 -
 arch/arm/mach-omap1/board-fsample.c             |    1 -
 arch/arm/mach-omap1/board-generic.c             |    6 -
 arch/arm/mach-omap1/board-htcherald.c           |    1 -
 arch/arm/mach-omap1/board-nokia770.c            |    1 -
 arch/arm/mach-omap1/board-osk.c                 |    1 +
 arch/arm/mach-omap1/board-palmte.c              |    2 +-
 arch/arm/mach-omap1/board-palmtt.c              |    2 +-
 arch/arm/mach-omap1/board-palmz71.c             |    2 +-
 arch/arm/mach-omap1/board-perseus2.c            |    1 -
 arch/arm/mach-omap1/board-sx1.c                 |    1 -
 arch/arm/mach-omap1/board-voiceblue.c           |    6 -
 arch/arm/mach-omap1/clock_data.c                |    8 --
 arch/arm/mach-omap1/devices.c                   |    1 -
 arch/arm/mach-omap1/serial.c                    |    1 -
 arch/arm/mach-omap2/board-2430sdp.c             |    1 -
 arch/arm/mach-omap2/board-3430sdp.c             |    6 -
 arch/arm/mach-omap2/board-3630sdp.c             |    6 -
 arch/arm/mach-omap2/board-4430sdp.c             |    1 -
 arch/arm/mach-omap2/board-am3517crane.c         |    9 --
 arch/arm/mach-omap2/board-am3517evm.c           |    6 -
 arch/arm/mach-omap2/board-apollon.c             |    1 -
 arch/arm/mach-omap2/board-cm-t35.c              |    6 -
 arch/arm/mach-omap2/board-cm-t3517.c            |    6 -
 arch/arm/mach-omap2/board-devkit8000.c          |    1 -
 arch/arm/mach-omap2/board-generic.c             |    1 -
 arch/arm/mach-omap2/board-h4.c                  |    2 +-
 arch/arm/mach-omap2/board-igep0020.c            |    1 -
 arch/arm/mach-omap2/board-ldp.c                 |    1 -
 arch/arm/mach-omap2/board-n8x0.c                |    1 -
 arch/arm/mach-omap2/board-omap3beagle.c         |    1 -
 arch/arm/mach-omap2/board-omap3evm.c            |   19 ++--
 arch/arm/mach-omap2/board-omap3logic.c          |    1 -
 arch/arm/mach-omap2/board-omap3pandora.c        |    1 -
 arch/arm/mach-omap2/board-omap3stalker.c        |    6 -
 arch/arm/mach-omap2/board-omap3touchbook.c      |    1 -
 arch/arm/mach-omap2/board-omap4panda.c          |    1 -
 arch/arm/mach-omap2/board-overo.c               |    1 -
 arch/arm/mach-omap2/board-rx51-peripherals.c    |    1 -
 arch/arm/mach-omap2/board-rx51.c                |    1 -
 arch/arm/mach-omap2/board-ti8168evm.c           |    6 -
 arch/arm/mach-omap2/board-zoom.c                |    1 -
 arch/arm/mach-omap2/common.c                    |    1 -
 arch/arm/mach-omap2/devices.c                   |    1 -
 arch/arm/mach-omap2/gpmc-nand.c                 |    1 -
 arch/arm/mach-omap2/gpmc-onenand.c              |    1 -
 arch/arm/mach-omap2/gpmc-smc91x.c               |    1 -
 arch/arm/mach-omap2/gpmc-smsc911x.c             |    1 -
 arch/arm/mach-omap2/pm-debug.c                  |    1 -
 arch/arm/mach-omap2/pm24xx.c                    |   11 --
 arch/arm/mach-omap2/serial.c                    |    1 -
 arch/arm/plat-omap/common.c                     |   40 -------
 arch/arm/plat-omap/counter_32k.c                |    1 -
 arch/arm/plat-omap/debug-devices.c              |    3 -
 arch/arm/plat-omap/devices.c                    |    1 -
 arch/arm/plat-omap/fb.c                         |    2 -
 arch/arm/plat-omap/include/plat/board.h         |  138 -----------------------
 arch/arm/plat-omap/include/plat/debug-devices.h |    9 ++
 arch/arm/plat-omap/include/plat/mmc.h           |    1 -
 arch/arm/plat-omap/include/plat/usb.h           |    1 -
 arch/arm/plat-omap/sram.c                       |    1 -
 drivers/mmc/host/omap.c                         |    1 -
 drivers/mmc/host/omap_hsmmc.c                   |    1 -
 drivers/mtd/onenand/omap2.c                     |    2 -
 drivers/video/backlight/omap1_bl.c              |    2 +-
 include/linux/omapfb.h                          |    7 +-
 include/linux/platform_data/omap1_bl.h          |   11 ++
 67 files changed, 44 insertions(+), 320 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/plat/board.h
 create mode 100644 arch/arm/plat-omap/include/plat/debug-devices.h
 create mode 100644 include/linux/platform_data/omap1_bl.h
