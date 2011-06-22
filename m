From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 0/4] OMAP: DSS2: misc patches
Date: Wed, 22 Jun 2011 11:45:22 +0300
Message-ID: <1308732326-17278-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:48654 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751007Ab1FVIpp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Jun 2011 04:45:45 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Here are few miscellaneous patches for DSS. A pure cleanup patch from Nishant,
patch adding Color Phase Rotation support, and two minor fixes.

 Tomi

Nishant Kamat (1):
  OMAP: DSS: Minor cleanup in ovl and mgr cache structs

Tomi Valkeinen (3):
  OMAP: DSS2: Add Color Phase Rotation support
  OMAP: DSS2: DSI: sync when disabling a display
  OMAP: DSS2: Fix FIFO threshold and burst size for OMAP4

 drivers/video/omap2/displays/panel-taal.c |    5 +-
 drivers/video/omap2/dss/dispc.c           |   84 ++++++++-
 drivers/video/omap2/dss/display.c         |   12 +-
 drivers/video/omap2/dss/dsi.c             |   16 +-
 drivers/video/omap2/dss/dss.h             |   18 +-
 drivers/video/omap2/dss/dss_features.c    |   23 +++
 drivers/video/omap2/dss/dss_features.h    |    3 +
 drivers/video/omap2/dss/manager.c         |  284 ++++++++++++++++++----------
 include/video/omapdss.h                   |    9 +
 9 files changed, 314 insertions(+), 140 deletions(-)

-- 
1.7.4.1

