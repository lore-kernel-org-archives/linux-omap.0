From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 16/20] OMAPDSS: omapdss.h: remove channel field from omap_dss_device (LATER)
Date: Fri, 8 Mar 2013 13:51:51 +0200
Message-ID: <1362743515-10152-17-git-send-email-tomi.valkeinen@ti.com>
References: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57877 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933492Ab3CHLw2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Mar 2013 06:52:28 -0500
In-Reply-To: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 include/video/omapdss.h |    2 --
 1 file changed, 2 deletions(-)

diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 8647646..cd028c8 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -567,8 +567,6 @@ struct omap_dss_device {
 
 	enum omap_display_type type;
 
-	enum omap_channel channel;
-
 	union {
 		struct {
 			u8 data_lines;
-- 
1.7.10.4

