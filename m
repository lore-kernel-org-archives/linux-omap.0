From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 0/8] OMAP: DSS2: Miscellaneous patches
Date: Tue, 10 May 2011 19:24:08 +0300
Message-ID: <1305044656-31512-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:57897 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932828Ab1EJQY1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 May 2011 12:24:27 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Here are some smallish fixes and cleanups I made while porting N800's display
driver to DSS2. 

 Tomi

Tomi Valkeinen (8):
  OMAP: DSS2: Add missing dummy functions
  OMAPFB: fix wrong clock aliases and device name
  OMAP: DSS2: RFBI: add rfbi_bus_lock
  OMAP: DSS2: RFIB: clock enable/disable changes
  OMAP: DSS2: RFBI: add omap_rfbi_configure
  OMAP: DSS2: RFIB: cleanup
  OMAP: DSS2: OMAPFB: remove dead code
  OMAP: DSS2: OMAPFB: Reduce stack usage

 arch/arm/plat-omap/include/plat/display.h |    4 +
 drivers/video/omap/dispc.c                |    4 +-
 drivers/video/omap/omapfb_main.c          |    2 +-
 drivers/video/omap/rfbi.c                 |    2 +-
 drivers/video/omap2/dss/dss.h             |   28 ++++-
 drivers/video/omap2/dss/rfbi.c            |  174 +++++------------------------
 drivers/video/omap2/omapfb/omapfb-main.c  |   78 +++++--------
 7 files changed, 86 insertions(+), 206 deletions(-)

-- 
1.7.4.1

