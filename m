From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 0/4] OMAPDSS: misc minor fixes
Date: Mon, 22 Aug 2011 11:27:12 +0300
Message-ID: <1314001636-18036-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:52211 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755573Ab1HVI13 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Aug 2011 04:27:29 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Some minor fixes for DSS. 

 Tomi

Tomi Valkeinen (4):
  OMAP: OMAPFB: make omapfb start even when a display is missing a
    driver
  OMAP: DSS2: fix clock sources on error and uninit
  OMAP: DSS2: Handle manager change in apply
  OMAP: DSS2: Remove "EXPERIMENTAL" from Kconfig

 drivers/video/omap2/dss/Kconfig          |    2 +-
 drivers/video/omap2/dss/dispc.c          |    4 +++-
 drivers/video/omap2/dss/dpi.c            |    4 +++-
 drivers/video/omap2/dss/dsi.c            |    3 +++
 drivers/video/omap2/dss/dss.h            |    2 --
 drivers/video/omap2/dss/manager.c        |    5 +++++
 drivers/video/omap2/dss/overlay.c        |    9 ++-------
 drivers/video/omap2/omapfb/Kconfig       |    2 +-
 drivers/video/omap2/omapfb/omapfb-main.c |    5 +++--
 include/video/omapdss.h                  |    1 +
 10 files changed, 22 insertions(+), 15 deletions(-)

-- 
1.7.4.1

