From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 00/12] DSS: Series description
Date: Mon, 12 Jan 2009 13:47:19 +0200
Message-ID: <20090112114718.1003.23643.stgit@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:35696 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbZALLrn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Jan 2009 06:47:43 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-omap@vger.kernel.org

New Display Subsystem for OMAP2/3
---------------------------------

This patch set implements new Display Subsystem (DSS) for OMAP2/3 processors.
The DSS is still under work and these patches are for review.

This is an updated version of the patch set I sent back in november:
http://marc.info/?l=linux-fbdev-devel&m=122581504222406&w=2

The first patch is a doc file that tries to explain a bit how the drivers work.

The patch set is based on the current linux-omap tree.

You can find the patches also from a git tree at
http://www.bat.org/~tomba/git/linux-omap-dss.git/

---

Tomi Valkeinen (12):
      DSS: Hacked N810 support
      DSS: Support for OMAP3 EVM board
      DSS: Support for OMAP3 SDP board
      DSS: Sharp LS037V7DW01 LCD Panel driver
      DSS: support for Beagle Board
      DSS: Add generic DVI panel
      DSS: OMAPFB: fb driver for new display subsystem
      DSS: DSI support
      DSS: VENC support
      DSS: RFBI support
      DSS: Display subsystem for OMAP2/3
      DSS: Documentation for DSS2


 Documentation/arm/OMAP/DSS                    |  270 ++
 arch/arm/configs/dss_omap3_beagle_defconfig   | 1437 +++++++++++
 arch/arm/configs/dss_omap_3430sdp_defconfig   | 1603 +++++++++++++
 arch/arm/mach-omap2/board-3430sdp.c           |  215 ++
 arch/arm/mach-omap2/board-n800.c              |  214 +-
 arch/arm/mach-omap2/board-omap3beagle.c       |  101 +
 arch/arm/mach-omap2/board-omap3evm.c          |  203 ++
 arch/arm/plat-omap/Kconfig                    |    2 
 arch/arm/plat-omap/Makefile                   |    4 
 arch/arm/plat-omap/dss/Kconfig                |   71 +
 arch/arm/plat-omap/dss/Makefile               |    6 
 arch/arm/plat-omap/dss/dispc.c                | 2113 +++++++++++++++++
 arch/arm/plat-omap/dss/display.c              |  787 ++++++
 arch/arm/plat-omap/dss/dpi.c                  |  344 +++
 arch/arm/plat-omap/dss/dsi.c                  | 3187 +++++++++++++++++++++++++
 arch/arm/plat-omap/dss/dss.c                  |  774 ++++++
 arch/arm/plat-omap/dss/dss.h                  |  274 ++
 arch/arm/plat-omap/dss/rfbi.c                 | 1262 ++++++++++
 arch/arm/plat-omap/dss/sdi.c                  |  174 +
 arch/arm/plat-omap/dss/venc.c                 |  506 ++++
 arch/arm/plat-omap/fb-vram.c                  |  646 +++++
 arch/arm/plat-omap/fb.c                       |   22 
 arch/arm/plat-omap/include/mach/display.h     |  462 ++++
 arch/arm/plat-omap/include/mach/omapfb.h      |   14 
 drivers/video/Kconfig                         |    1 
 drivers/video/Makefile                        |    1 
 drivers/video/omap/Kconfig                    |    5 
 drivers/video/omap2/Kconfig                   |   62 
 drivers/video/omap2/Makefile                  |    8 
 drivers/video/omap2/ctrl-blizzard.c           |  279 ++
 drivers/video/omap2/omapfb-ioctl.c            |  460 ++++
 drivers/video/omap2/omapfb-main.c             | 1442 +++++++++++
 drivers/video/omap2/omapfb-sysfs.c            |  901 +++++++
 drivers/video/omap2/omapfb.h                  |  115 +
 drivers/video/omap2/panel-generic.c           |   97 +
 drivers/video/omap2/panel-n800.c              |  437 +++
 drivers/video/omap2/panel-sharp-ls037v7dw01.c |  109 +
 37 files changed, 18537 insertions(+), 71 deletions(-)
 create mode 100644 Documentation/arm/OMAP/DSS
 create mode 100644 arch/arm/configs/dss_omap3_beagle_defconfig
 create mode 100644 arch/arm/configs/dss_omap_3430sdp_defconfig
 create mode 100644 arch/arm/plat-omap/dss/Kconfig
 create mode 100644 arch/arm/plat-omap/dss/Makefile
 create mode 100644 arch/arm/plat-omap/dss/dispc.c
 create mode 100644 arch/arm/plat-omap/dss/display.c
 create mode 100644 arch/arm/plat-omap/dss/dpi.c
 create mode 100644 arch/arm/plat-omap/dss/dsi.c
 create mode 100644 arch/arm/plat-omap/dss/dss.c
 create mode 100644 arch/arm/plat-omap/dss/dss.h
 create mode 100644 arch/arm/plat-omap/dss/rfbi.c
 create mode 100644 arch/arm/plat-omap/dss/sdi.c
 create mode 100644 arch/arm/plat-omap/dss/venc.c
 create mode 100644 arch/arm/plat-omap/fb-vram.c
 create mode 100644 arch/arm/plat-omap/include/mach/display.h
 create mode 100644 drivers/video/omap2/Kconfig
 create mode 100644 drivers/video/omap2/Makefile
 create mode 100644 drivers/video/omap2/ctrl-blizzard.c
 create mode 100644 drivers/video/omap2/omapfb-ioctl.c
 create mode 100644 drivers/video/omap2/omapfb-main.c
 create mode 100644 drivers/video/omap2/omapfb-sysfs.c
 create mode 100644 drivers/video/omap2/omapfb.h
 create mode 100644 drivers/video/omap2/panel-generic.c
 create mode 100644 drivers/video/omap2/panel-n800.c
 create mode 100644 drivers/video/omap2/panel-sharp-ls037v7dw01.c

-- 
 Tomi Valkeinen

