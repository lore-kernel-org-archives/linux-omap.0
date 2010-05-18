From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 00/23] OMAP DSS patches for 2.6.35 merge window
Date: Tue, 18 May 2010 15:34:51 +0300
Message-ID: <1274186114-26951-1-git-send-email-tomi.valkeinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:57871 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757465Ab0ERMfz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 08:35:55 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>

Here are OMAP DSS patches for 2.6.35 merge window. They have been previ=
ously
reviewed on linux-omap and fbdev lists.

 Tomi

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

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
