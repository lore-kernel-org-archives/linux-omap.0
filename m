From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 28/32] OMAPDSS: omapdss.h: add owner field to omap_dss_device
Date: Thu, 30 May 2013 12:34:49 +0300
Message-ID: <1369906493-27538-29-git-send-email-tomi.valkeinen@ti.com>
References: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41394 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030355Ab3E3Jf7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 May 2013 05:35:59 -0400
In-Reply-To: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Add struct module *owner field to omap_dss_device, which points to the
module containing the ops for this omap_dss_device. This will be used to
manage the ref count for the module.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 include/video/omapdss.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 5046264..c32d90e 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -579,6 +579,8 @@ struct omap_dss_device {
 	/* new device, pointer to panel device */
 	struct device *dev;
 
+	struct module *owner;
+
 	struct list_head panel_list;
 
 	/* alias in the form of "display%d" */
-- 
1.8.1.2

