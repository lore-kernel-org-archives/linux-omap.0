From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 01/12] OMAP: DSS2: add read_edid() to omap_dss_driver struct
Date: Wed, 31 Aug 2011 16:23:12 +0300
Message-ID: <1314797003-17638-2-git-send-email-tomi.valkeinen@ti.com>
References: <1314797003-17638-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:44202 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755392Ab1HaNXk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Aug 2011 09:23:40 -0400
In-Reply-To: <1314797003-17638-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, mythripk@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

read_edid() can be used to get the EDID information from the display.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 include/video/omapdss.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index f8385ae..8ed5a6c 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -558,6 +558,8 @@ struct omap_dss_driver {
 
 	int (*set_wss)(struct omap_dss_device *dssdev, u32 wss);
 	u32 (*get_wss)(struct omap_dss_device *dssdev);
+
+	int (*read_edid)(struct omap_dss_device *dssdev, u8 *buf, int len);
 };
 
 int omap_dss_register_driver(struct omap_dss_driver *);
-- 
1.7.4.1

