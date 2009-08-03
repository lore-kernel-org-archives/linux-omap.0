From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 0/4) OMAPFB patches
Date: Mon,  3 Aug 2009 16:15:11 +0300
Message-ID: <1249305315-25595-1-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:26078 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755068AbZHCNPt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Aug 2009 09:15:49 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-omap@vger.kernel.org

This patch set makes preparations for the new DSS2 driver. It implements VRFB
support and a VRAM manager, omapfb.h is split and moved, and a dummy DSS device
is created to make it possible for old DSS and new DSS2 to co-exist.

VRFB and VRAM are not used by the current DSS driver.

The patches are based on linux-omap, as omapfb seems to be broken in mainstream
kernel.

 Tomi Valkeinen

 arch/arm/mach-omap1/board-nokia770.c     |    2 +-
 arch/arm/mach-omap2/board-n800.c         |    2 +-
 arch/arm/mach-omap2/clock24xx.c          |    8 +-
 arch/arm/mach-omap2/clock34xx.c          |   10 +-
 arch/arm/mach-omap2/io.c                 |    4 +-
 arch/arm/plat-omap/Kconfig               |    6 +
 arch/arm/plat-omap/Makefile              |    2 +
 arch/arm/plat-omap/fb.c                  |    2 +-
 arch/arm/plat-omap/include/mach/omapfb.h |  398 ------------------
 arch/arm/plat-omap/include/mach/vram.h   |   63 +++
 arch/arm/plat-omap/include/mach/vrfb.h   |   46 ++
 arch/arm/plat-omap/sram.c                |    8 +
 arch/arm/plat-omap/vram.c                |  655 ++++++++++++++++++++++++++++++
 arch/arm/plat-omap/vrfb.c                |  281 +++++++++++++
 drivers/video/omap/blizzard.c            |    2 +-
 drivers/video/omap/dispc.c               |   21 +-
 drivers/video/omap/hwa742.c              |    2 +-
 drivers/video/omap/lcd_2430sdp.c         |    2 +-
 drivers/video/omap/lcd_ams_delta.c       |    2 +-
 drivers/video/omap/lcd_apollon.c         |    2 +-
 drivers/video/omap/lcd_h3.c              |    2 +-
 drivers/video/omap/lcd_h4.c              |    2 +-
 drivers/video/omap/lcd_inn1510.c         |    2 +-
 drivers/video/omap/lcd_inn1610.c         |    2 +-
 drivers/video/omap/lcd_ldp.c             |    2 +-
 drivers/video/omap/lcd_mipid.c           |    3 +-
 drivers/video/omap/lcd_omap2evm.c        |    2 +-
 drivers/video/omap/lcd_omap3beagle.c     |    2 +-
 drivers/video/omap/lcd_omap3evm.c        |    2 +-
 drivers/video/omap/lcd_osk.c             |    2 +-
 drivers/video/omap/lcd_overo.c           |    3 +-
 drivers/video/omap/lcd_palmte.c          |    2 +-
 drivers/video/omap/lcd_palmtt.c          |    2 +-
 drivers/video/omap/lcd_palmz71.c         |    2 +-
 drivers/video/omap/lcdc.c                |    3 +-
 drivers/video/omap/omapfb.h              |  227 +++++++++++
 drivers/video/omap/omapfb_main.c         |    2 +-
 drivers/video/omap/rfbi.c                |    3 +-
 drivers/video/omap/sossi.c               |    2 +-
 include/linux/omapfb.h                   |  197 +++++++++
 40 files changed, 1543 insertions(+), 439 deletions(-)

