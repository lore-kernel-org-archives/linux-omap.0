From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/3] omap plat header removal for v3.8 merge window, part3
Date: Fri, 26 Oct 2012 14:23:40 -0700
Message-ID: <E1TRrNm-00084U-TE@merlin.infradead.org>
References: <pull-1351286620-406688>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1351286620-406688>
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

The following changes since commit 3d82cbbb3aadb4f8a30e3f614e51be96574a0855:

  ARM: OMAP: Split plat/serial.h for omap1 and omap2+ (2012-10-24 13:34:31 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.8/cleanup-headers-part3-signed

for you to fetch changes up to a0212796b58061a9716178d261f318925c246643:

  Merge tag 'omap-cleanup-fixes-a-for-3.8' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into omap-for-v3.8/cleanup-headers (2012-10-26 13:18:19 -0700)

----------------------------------------------------------------

Here is the third set of plat header removal for omap2+.

This is based on the following minimal topic branches
coordinated with the related driver maintainers:

omap-for-v3.8/cleanup-headers-usb
omap-for-v3.8/cleanup-headers-menelaus

In addition to that, there are few fixes to the previously
merged patches that can show up with customized configs.

----------------------------------------------------------------
Felipe Balbi (1):
      ARM: OMAP: move OMAP USB platform data to <linux/platform_data/omap-usb.h>

Paul Walmsley (3):
      ARM: OMAP2+: fix build breakage introduced by commit b7754452b3e27716347a528b47b0a1083af32520
      ARM: OMAP1: fix build breakage introduced by commit 25c7d49ed48b4843da7dea56a81ae7f620211ee0
      ARM: OMAP1: fix sparse warning added by commit 4c98dc6b8ef2f73bdbfa78186db9a76507ba9ea3

Tony Lindgren (5):
      ARM: OMAP2: Move plat/menelaus.h to linux/mfd/menelaus.h
      ARM: OMAP2+: Introduce local usb.h
      Merge branch 'omap-for-v3.8/cleanup-headers-usb' into omap-for-v3.8/cleanup-headers
      Merge branch 'omap-for-v3.8/cleanup-headers-menelaus' into omap-for-v3.8/cleanup-headers
      Merge tag 'omap-cleanup-fixes-a-for-3.8' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v3.8/cleanup-headers

 arch/arm/mach-omap1/clock.c                        |    4 +-
 arch/arm/mach-omap1/fpga.c                         |    1 +
 arch/arm/mach-omap1/pm_bus.c                       |    2 +
 arch/arm/mach-omap2/board-2430sdp.c                |    1 -
 arch/arm/mach-omap2/board-3430sdp.c                |    1 -
 arch/arm/mach-omap2/board-3630sdp.c                |    1 -
 arch/arm/mach-omap2/board-4430sdp.c                |    2 +-
 arch/arm/mach-omap2/board-am3517crane.c            |    1 -
 arch/arm/mach-omap2/board-am3517evm.c              |    2 +-
 arch/arm/mach-omap2/board-cm-t35.c                 |    5 +-
 arch/arm/mach-omap2/board-cm-t3517.c               |    1 -
 arch/arm/mach-omap2/board-devkit8000.c             |    1 -
 arch/arm/mach-omap2/board-h4.c                     |    2 +-
 arch/arm/mach-omap2/board-igep0020.c               |    6 +-
 arch/arm/mach-omap2/board-ldp.c                    |    3 +-
 arch/arm/mach-omap2/board-n8x0.c                   |    2 +-
 arch/arm/mach-omap2/board-omap3beagle.c            |    7 +-
 arch/arm/mach-omap2/board-omap3evm.c               |    2 +-
 arch/arm/mach-omap2/board-omap3logic.c             |    2 -
 arch/arm/mach-omap2/board-omap3pandora.c           |    1 -
 arch/arm/mach-omap2/board-omap3stalker.c           |    1 -
 arch/arm/mach-omap2/board-omap3touchbook.c         |    1 -
 arch/arm/mach-omap2/board-omap4panda.c             |    4 +-
 arch/arm/mach-omap2/board-overo.c                  |    4 +-
 arch/arm/mach-omap2/board-rm680.c                  |    4 +-
 arch/arm/mach-omap2/board-rx51.c                   |    2 +-
 arch/arm/mach-omap2/board-ti8168evm.c              |    3 +-
 arch/arm/mach-omap2/board-zoom-peripherals.c       |    1 -
 arch/arm/mach-omap2/board-zoom.c                   |    1 -
 arch/arm/mach-omap2/common.h                       |    2 +
 arch/arm/mach-omap2/omap_phy_internal.c            |    4 +-
 arch/arm/mach-omap2/twl-common.c                   |    2 -
 arch/arm/mach-omap2/usb-host.c                     |    3 +-
 arch/arm/mach-omap2/usb-musb.c                     |    3 +-
 arch/arm/mach-omap2/usb-tusb6010.c                 |    1 +
 arch/arm/mach-omap2/usb.h                          |   82 +++++++++
 arch/arm/plat-omap/include/plat/usb.h              |  179 --------------------
 drivers/mfd/menelaus.c                             |    2 +-
 drivers/mfd/omap-usb-host.c                        |    5 +-
 drivers/mfd/omap-usb-tll.c                         |    2 +-
 drivers/mfd/omap-usb.h                             |    2 +
 drivers/mtd/onenand/omap2.c                        |   36 ++--
 drivers/usb/host/ehci-omap.c                       |    3 +-
 drivers/usb/host/ohci-omap3.c                      |    1 -
 drivers/usb/musb/am35x.c                           |    3 +-
 drivers/usb/musb/musb_dsps.c                       |    3 +-
 drivers/usb/musb/omap2430.h                        |    2 +-
 .../include/plat => include/linux/mfd}/menelaus.h  |    2 -
 include/linux/platform_data/usb-omap.h             |   80 +++++++++
 49 files changed, 231 insertions(+), 254 deletions(-)
 create mode 100644 arch/arm/mach-omap2/usb.h
 delete mode 100644 arch/arm/plat-omap/include/plat/usb.h
 create mode 100644 drivers/mfd/omap-usb.h
 rename {arch/arm/plat-omap/include/plat => include/linux/mfd}/menelaus.h (96%)
 create mode 100644 include/linux/platform_data/usb-omap.h
