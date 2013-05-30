From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 08/27] OMAPDSS: add OMAP_DISPLAY_TYPE_DVI
Date: Thu, 30 May 2013 12:36:01 +0300
Message-ID: <1369906580-27585-9-git-send-email-tomi.valkeinen@ti.com>
References: <1369906580-27585-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41437 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030416Ab3E3Jg7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 May 2013 05:36:59 -0400
In-Reply-To: <1369906580-27585-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Add new display bus type for DVI. This is not used by omapdss driver
itself, but is used by external encoder chips that output DVI.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/display.c | 1 +
 include/video/omapdss.h           | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
index 0daf3e3..fafe7c9 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -61,6 +61,7 @@ int omapdss_default_get_recommended_bpp(struct omap_dss_device *dssdev)
 	case OMAP_DISPLAY_TYPE_VENC:
 	case OMAP_DISPLAY_TYPE_SDI:
 	case OMAP_DISPLAY_TYPE_HDMI:
+	case OMAP_DISPLAY_TYPE_DVI:
 		return 24;
 	default:
 		BUG();
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 3582edf..6796b0d 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -70,6 +70,7 @@ enum omap_display_type {
 	OMAP_DISPLAY_TYPE_DSI		= 1 << 3,
 	OMAP_DISPLAY_TYPE_VENC		= 1 << 4,
 	OMAP_DISPLAY_TYPE_HDMI		= 1 << 5,
+	OMAP_DISPLAY_TYPE_DVI		= 1 << 6,
 };
 
 enum omap_plane {
-- 
1.8.1.2

