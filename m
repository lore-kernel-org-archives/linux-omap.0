From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 3/3] omap late multiplatform cleanup for v3.8 merge window
Date: Mon, 26 Nov 2012 17:06:12 -0800
Message-ID: <E1Td9dT-0007vn-Cu@merlin.infradead.org>
References: <pull-1353978372-642963>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1353978372-642963>
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

The following changes since commit 0f9cb211ba5db93d488fe6b154138231fdd0e22d:

  Merge tag 'v3.7-rc7' into next/cleanup (2012-11-25 21:34:34 -0800)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.8/cleanup-multiplatform-v2-signed

for you to fetch changes up to 5ebb428d045ea9b908864547819786d5bcebad05:

  ARM: OMAP: Move plat-omap/dma-omap.h to include/linux/omap-dma.h (2012-11-26 13:19:23 -0800)

----------------------------------------------------------------
Remaining patches to allow omap2+ to build with multiplatform
enabled. Unfortunately the DMA header patch had to be redone
to avoid adding new multiplatform specific include paths, the
other patches are just trivial compile fixes.

Note that this does not yet contain the necessary Kconfig
changes as we are still waiting for some drivers to get
fixed up first.

----------------------------------------------------------------
Tony Lindgren (3):
      watchdog: OMAP: fixup for ARM multiplatform support
      ASoC: OMAP: mcbsp fixes for enabling ARM multiplatform support
      ARM: OMAP: Move plat-omap/dma-omap.h to include/linux/omap-dma.h

 arch/arm/mach-omap1/board-h2.c                     |   2 +-
 arch/arm/mach-omap1/board-h3.c                     |   2 +-
 arch/arm/mach-omap1/board-palmte.c                 |   2 +-
 arch/arm/mach-omap1/board-palmtt.c                 |   2 +-
 arch/arm/mach-omap1/board-palmz71.c                |   2 +-
 arch/arm/mach-omap1/board-sx1.c                    |   2 +-
 arch/arm/mach-omap1/dma.c                          |   2 +-
 arch/arm/mach-omap1/io.c                           |   2 +-
 arch/arm/mach-omap1/lcd_dma.c                      |   2 +-
 arch/arm/mach-omap1/mcbsp.c                        |   2 +-
 arch/arm/mach-omap1/pm.c                           |   2 +-
 arch/arm/mach-omap2/board-3430sdp.c                |   2 +-
 arch/arm/mach-omap2/board-h4.c                     |   2 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c       |   2 +-
 arch/arm/mach-omap2/board-rx51.c                   |   2 +-
 arch/arm/mach-omap2/devices.c                      |   2 +-
 arch/arm/mach-omap2/dma.c                          |   2 +-
 arch/arm/mach-omap2/io.c                           |   2 +-
 arch/arm/mach-omap2/mcbsp.c                        |   2 +-
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |   2 +-
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |   2 +-
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |   3 +-
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |   2 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   2 +-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |   2 +-
 arch/arm/mach-omap2/pm24xx.c                       |   2 +-
 arch/arm/mach-omap2/pm34xx.c                       |   3 +-
 arch/arm/mach-omap2/serial.c                       |   2 +-
 arch/arm/plat-omap/dma.c                           |   2 +-
 arch/arm/plat-omap/include/plat-omap/dma-omap.h    | 377 ---------------------
 drivers/crypto/omap-aes.c                          |   2 +-
 drivers/crypto/omap-sham.c                         |   2 +-
 drivers/dma/omap-dma.c                             |   2 -
 drivers/media/platform/omap/omap_vout.c            |   2 +-
 drivers/media/platform/omap/omap_vout_vrfb.c       |   2 +-
 drivers/media/platform/omap3isp/ispstat.h          |   2 +-
 drivers/media/platform/soc_camera/omap1_camera.c   |   2 +-
 drivers/mtd/nand/omap2.c                           |   1 -
 drivers/mtd/onenand/omap2.c                        |   2 +-
 drivers/usb/gadget/omap_udc.c                      |   2 +-
 drivers/usb/musb/tusb6010_omap.c                   |   2 +-
 drivers/video/omap/lcdc.c                          |   2 +-
 drivers/video/omap/omapfb_main.c                   |   2 +-
 drivers/video/omap/sossi.c                         |   2 +-
 drivers/watchdog/omap_wdt.c                        |   2 -
 include/linux/omap-dma.h                           | 366 ++++++++++++++++++++
 sound/soc/omap/mcbsp.c                             |   4 +-
 sound/soc/omap/mcbsp.h                             |   6 +
 sound/soc/omap/omap-mcbsp.c                        |   5 +-
 49 files changed, 417 insertions(+), 430 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/plat-omap/dma-omap.h
