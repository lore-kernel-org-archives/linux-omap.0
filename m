From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 02/15] OMAPDSS: remove omap_dss_device->channel field
Date: Thu, 29 Aug 2013 16:31:47 +0300
Message-ID: <1377783120-14001-3-git-send-email-tomi.valkeinen@ti.com>
References: <1377783120-14001-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49957 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754535Ab3H2NcL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Aug 2013 09:32:11 -0400
In-Reply-To: <1377783120-14001-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

The 'channel' field in struct omap_dss_device is no longer used, and can
be removed.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 include/video/omapdss.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index b394635..3b68dc2 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -765,9 +765,6 @@ struct omap_dss_device {
 	enum omap_display_type type;
 	enum omap_display_type output_type;
 
-	/* obsolete, to be removed */
-	enum omap_channel channel;
-
 	union {
 		struct {
 			u8 data_lines;
-- 
1.8.1.2

