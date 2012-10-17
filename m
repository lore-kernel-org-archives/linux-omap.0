From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv3 0/5] OMAP: VRFB: convert to platform device
Date: Wed, 17 Oct 2012 13:18:17 +0300
Message-ID: <1350469102-24888-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56007 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756022Ab2JQKSe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Oct 2012 06:18:34 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, tony@atomide.com
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

This is the third version of the series. Changes to v2 are:
* rebased on 3.7-rc1 to resolve conflicts
* add omap_vrfb_supported() so that cpu_is_* check can be removed from omapfb

As Kevin Hilman pointed out, the context restore is not functional. I didn't
touch that, as it's not functional with the current kernel either (and nobody
has complained, so it can't be that critical).

 Tomi

Tomi Valkeinen (5):
  OMAP: VRFB: convert vrfb to platform device
  OMAP: move arch/arm/plat-omap/include/plat/vrfb.h
  OMAP: SDRC: remove VRFB code
  OMAPDSS: VRFB: add omap_vrfb_supported()
  OMAPFB: use omap_vrfb_supported()

 arch/arm/mach-omap2/sdrc.c                   |   16 ---
 arch/arm/plat-omap/fb.c                      |   61 +++++++++++
 arch/arm/plat-omap/include/plat/sdrc.h       |    7 --
 arch/arm/plat-omap/include/plat/vrfb.h       |   66 ------------
 drivers/media/platform/omap/omap_vout.c      |    2 +-
 drivers/media/platform/omap/omap_vout_vrfb.c |    2 +-
 drivers/media/platform/omap/omap_voutdef.h   |    2 +-
 drivers/video/omap2/omapfb/omapfb-ioctl.c    |    2 +-
 drivers/video/omap2/omapfb/omapfb-main.c     |    8 +-
 drivers/video/omap2/omapfb/omapfb-sysfs.c    |    2 +-
 drivers/video/omap2/vrfb.c                   |  142 ++++++++++++++++++++++----
 include/video/omapvrfb.h                     |   68 ++++++++++++
 12 files changed, 257 insertions(+), 121 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/plat/vrfb.h
 create mode 100644 include/video/omapvrfb.h

-- 
1.7.9.5

