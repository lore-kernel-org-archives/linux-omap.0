From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [GIT PULL] OMAP DSS updates for 2.6.35
Date: Fri, 21 May 2010 11:24:58 +0300
Message-ID: <1274430298.4246.81.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds <torvalds@linux-foundation.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, ext Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

Hi Linus,

Here are latest updates for OMAP display subsystem. Small fixes, suppor=
t
for new boards and panels.

 Tomi

The following changes since commit e40152ee1e1c7a63f4777791863215e3faa3=
7a86:
  Linus Torvalds (1):
        Linus 2.6.34

are available in the git repository at:

  git://gitorious.org/linux-omap-dss2/linux.git for-linus

Carlos Lopez (1):
      OMAP2: DSS: Add missing line for update bg color

Grazvydas Ignotas (1):
      OMAP: DSS2: TPO-TD03MTEA1: fix Kconfig dependency

Jani Nikula (6):
      OMAP: DSS2: fix lock_fb_info() and omapfb_lock() locking order
      OMAP: DSS2: check lock_fb_info() return value
      OMAP: DSS2: VENC: don't call platform_enable/disable() twice
      OMAP: DSS2: Fix device disable when driver is not loaded
      OMAP: DSS2: omap_dss_probe() conditional compilation cleanup
      OMAP: DSS2: Fix omap_dss_probe() error path

Kishore Y (1):
      OMAP3630: DSS2: Updating MAX divider value

Koen Kooi (1):
      board-omap3-beagle: add DSS2 support

Roger Quadros (7):
      OMAP: DSS2: Add Kconfig option for DPI display type
      OMAP: DSS2: Remove redundant enable/disable calls from SDI
      OMAP: DSS2: Use vdds_sdi regulator supply in SDI
      OMAP: RX51: Add LCD Panel support
      OMAP: RX51: Add Touch Controller in SPI board info
      OMAP: DSS2: Add ACX565AKM Panel Driver
      OMAP: RX51: Update board defconfig

Tomi Valkeinen (2):
      OMAP: DSS2: Make partial update width even
      OMAP: DSS2: Taal: add mutex to protect panel data

Vaibhav Hiremath (3):
      OMAP: Enable DSS2 in OMAP3EVM defconfig
      OMAP: AM3517: Enable DSS2 in AM3517EVM defconfig
      OMAP: LCD LS037V7DW01: Add Backlight driver support

Ville Syrj=C3=A4l=C3=A4 (1):
      OMAP: DSS2: Taal: Fix DSI bus locking problem

 arch/arm/configs/am3517_evm_defconfig              |   52 ++-
 arch/arm/configs/omap3_evm_defconfig               |   51 ++-
 arch/arm/configs/rx51_defconfig                    |   39 +-
 arch/arm/mach-omap2/Makefile                       |    1 +
 arch/arm/mach-omap2/board-omap3beagle.c            |  101 ++-
 arch/arm/mach-omap2/board-rx51-peripherals.c       |   28 +
 arch/arm/mach-omap2/board-rx51-video.c             |  109 +++
 arch/arm/mach-omap2/board-rx51.c                   |    2 +
 drivers/video/omap2/displays/Kconfig               |    9 +-
 drivers/video/omap2/displays/Makefile              |    1 +
 drivers/video/omap2/displays/panel-acx565akm.c     |  819 ++++++++++++=
++++++++
 .../video/omap2/displays/panel-sharp-ls037v7dw01.c |   78 ++
 drivers/video/omap2/displays/panel-taal.c          |  143 +++-
 drivers/video/omap2/dss/Kconfig                    |    6 +
 drivers/video/omap2/dss/Makefile                   |    3 +-
 drivers/video/omap2/dss/core.c                     |   85 ++-
 drivers/video/omap2/dss/display.c                  |    9 +-
 drivers/video/omap2/dss/dss.c                      |   24 +-
 drivers/video/omap2/dss/dss.h                      |   50 ++
 drivers/video/omap2/dss/manager.c                  |   21 +
 drivers/video/omap2/dss/sdi.c                      |   26 +-
 drivers/video/omap2/dss/venc.c                     |   15 +-
 drivers/video/omap2/omapfb/omapfb-ioctl.c          |    5 +-
 drivers/video/omap2/omapfb/omapfb-sysfs.c          |   25 +-
 24 files changed, 1573 insertions(+), 129 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-rx51-video.c
 create mode 100644 drivers/video/omap2/displays/panel-acx565akm.c
