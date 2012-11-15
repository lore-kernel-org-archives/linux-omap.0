From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 03/32] OMAPDSS: don't WARN if there's no DSI device
Date: Thu, 15 Nov 2012 17:58:11 +0200
Message-ID: <1352995120-3288-4-git-send-email-tomi.valkeinen@ti.com>
References: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52158 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1768125Ab2KOP7N (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Nov 2012 10:59:13 -0500
In-Reply-To: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, Rob Clark <rob@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

dsi_get_dsidev_from_id() gives a WARN if DSI support is not compiled in.
This warning is not right, as it's valid to call
dsi_get_dsidev_from_id() to see if there is DSI support or not.

Remove the WARN().

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dss.h |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 8adf8be..09d0651 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -382,8 +382,6 @@ static inline void dsi_wait_pll_hsdiv_dsi_active(struct platform_device *dsidev)
 }
 static inline struct platform_device *dsi_get_dsidev_from_id(int module)
 {
-	WARN("%s: DSI not compiled in, returning platform device as NULL\n",
-			__func__);
 	return NULL;
 }
 #endif
-- 
1.7.10.4

