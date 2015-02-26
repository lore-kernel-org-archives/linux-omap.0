From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 15/15] OMAPDSS: disable VT switch
Date: Thu, 26 Feb 2015 14:49:09 +0200
Message-ID: <1424954949-12801-15-git-send-email-tomi.valkeinen@ti.com>
References: <1424954949-12801-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37403 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932236AbbBZMtz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Feb 2015 07:49:55 -0500
In-Reply-To: <1424954949-12801-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, NeilBrown <neil@brown.name>

We don't need VT switch when suspending/resuming, so disable it. This
speeds up suspend/resume.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: NeilBrown <neil@brown.name>
---
 drivers/video/fbdev/omap2/dss/dss.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/dss.c b/drivers/video/fbdev/omap2/dss/dss.c
index a6d10d4279f3..7f978b6a34e8 100644
--- a/drivers/video/fbdev/omap2/dss/dss.c
+++ b/drivers/video/fbdev/omap2/dss/dss.c
@@ -38,6 +38,7 @@
 #include <linux/regmap.h>
 #include <linux/of.h>
 #include <linux/regulator/consumer.h>
+#include <linux/suspend.h>
 
 #include <video/omapdss.h>
 
@@ -1138,6 +1139,8 @@ static int __init omap_dsshw_probe(struct platform_device *pdev)
 
 	dss_debugfs_create_file("dss", dss_dump_regs);
 
+	pm_set_vt_switch(0);
+
 	return 0;
 
 err_pll_init:
-- 
2.3.0

