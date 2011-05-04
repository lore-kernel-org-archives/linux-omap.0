From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 0/7] OMAP: DSS: porting old drivers to DSS2
Date: Wed,  4 May 2011 15:27:32 +0300
Message-ID: <1304512059-10372-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:47487 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752138Ab1EDM15 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 May 2011 08:27:57 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

This patch set ports all the OMAP2/3 boards, except N8x0, that use the old
omapfb to use the newer DSS2 driver.

Some board files contained old omapfb code, but there wasn't a matching LCD
driver. That board file code is also removed.

Porting N800 driver is more complicated, as the blizzard chip driver is quite
big and includes features that cannot be supported in DSS2 currently. I will
post patches for that later.

I don't have any of the boards touched by these patches, so testing is
appreciated.

 Tomi

Tomi Valkeinen (7):
  OMAP: OMAPFB: Remove unused lcd drivers
  OMAP: RX51: Remove unused old omapfb stuff
  OMAP: omap3touchbook: Remove unused lcd stuff
  OMAP: 2420SDP: Port the display driver to new DSS2
  OMAP: LDP: Port the display driver to new DSS2
  OMAP: H4: Port the display driver to new DSS2
  OMAP: Apollon: Port the display driver to new DSS2

 arch/arm/mach-omap2/board-2430sdp.c              |   84 ++++++++--
 arch/arm/mach-omap2/board-apollon.c              |   34 +++--
 arch/arm/mach-omap2/board-h4.c                   |   41 +++--
 arch/arm/mach-omap2/board-ldp.c                  |   73 +++++++-
 arch/arm/mach-omap2/board-omap3touchbook.c       |   18 --
 arch/arm/mach-omap2/board-rx51.c                 |   25 ---
 drivers/video/omap/Makefile                      |    9 -
 drivers/video/omap/lcd_2430sdp.c                 |  203 ----------------------
 drivers/video/omap/lcd_apollon.c                 |  136 ---------------
 drivers/video/omap/lcd_h4.c                      |  117 -------------
 drivers/video/omap/lcd_ldp.c                     |  201 ---------------------
 drivers/video/omap/lcd_omap2evm.c                |  192 --------------------
 drivers/video/omap/lcd_omap3beagle.c             |  130 --------------
 drivers/video/omap/lcd_omap3evm.c                |  193 --------------------
 drivers/video/omap/lcd_overo.c                   |  180 -------------------
 drivers/video/omap2/displays/panel-generic-dpi.c |   64 +++++++
 16 files changed, 244 insertions(+), 1456 deletions(-)
 delete mode 100644 drivers/video/omap/lcd_2430sdp.c
 delete mode 100644 drivers/video/omap/lcd_apollon.c
 delete mode 100644 drivers/video/omap/lcd_h4.c
 delete mode 100644 drivers/video/omap/lcd_ldp.c
 delete mode 100644 drivers/video/omap/lcd_omap2evm.c
 delete mode 100644 drivers/video/omap/lcd_omap3beagle.c
 delete mode 100644 drivers/video/omap/lcd_omap3evm.c
 delete mode 100644 drivers/video/omap/lcd_overo.c

-- 
1.7.4.1

