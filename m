From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 02/12] OMAP: DSS2: add detect() to omap_dss_driver struct
Date: Wed, 31 Aug 2011 16:23:13 +0300
Message-ID: <1314797003-17638-3-git-send-email-tomi.valkeinen@ti.com>
References: <1314797003-17638-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:42739 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755745Ab1HaNXm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Aug 2011 09:23:42 -0400
In-Reply-To: <1314797003-17638-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, mythripk@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

detect() can be used to probe if the display is connected.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 include/video/omapdss.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 8ed5a6c..a62f49a 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -560,6 +560,7 @@ struct omap_dss_driver {
 	u32 (*get_wss)(struct omap_dss_device *dssdev);
 
 	int (*read_edid)(struct omap_dss_device *dssdev, u8 *buf, int len);
+	bool (*detect)(struct omap_dss_device *dssdev);
 };
 
 int omap_dss_register_driver(struct omap_dss_driver *);
-- 
1.7.4.1

