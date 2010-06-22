From: Archit Taneja <archit@ti.com>
Subject: [PATCH] OMAP: DSS2: Remove extra return statement
Date: Tue, 22 Jun 2010 13:44:01 +0530
Message-ID: <1277194441-31508-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39988 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757165Ab0FVIOJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Jun 2010 04:14:09 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Remove extra return statement in omapdss_default_get_recommended_bpp
from overlay.c

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/display.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
index 480aeaa..22dd7a4
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -346,7 +346,6 @@ int omapdss_default_get_recommended_bpp(struct omap_dss_device *dssdev)
 	case OMAP_DISPLAY_TYPE_VENC:
 	case OMAP_DISPLAY_TYPE_SDI:
 		return 24;
-		return 24;
 	default:
 		BUG();
 	}
-- 
1.6.3.3

