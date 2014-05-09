From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 3/5] OMAPDSS: remove unused macros
Date: Fri, 9 May 2014 15:32:05 +0300
Message-ID: <1399638727-23254-3-git-send-email-tomi.valkeinen@ti.com>
References: <1399638727-23254-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52007 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753422AbaEIMca (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 May 2014 08:32:30 -0400
In-Reply-To: <1399638727-23254-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Macros to_dss_driver() and to_dss_device() are no longer used, and the
latter doesn't even work. Remove them.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 include/video/omapdss.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 6adb44534606..def9f0b739c4 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -964,9 +964,6 @@ int dispc_ovl_setup(enum omap_plane plane, const struct omap_overlay_info *oi,
 		bool replication, const struct omap_video_timings *mgr_timings,
 		bool mem_to_mem);
 
-#define to_dss_driver(x) container_of((x), struct omap_dss_driver, driver)
-#define to_dss_device(x) container_of((x), struct omap_dss_device, old_dev)
-
 int omapdss_compat_init(void);
 void omapdss_compat_uninit(void);
 
-- 
1.9.1

