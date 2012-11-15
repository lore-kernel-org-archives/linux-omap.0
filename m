From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 15/32] OMAPDSS: add dss_get_core_pdev()
Date: Thu, 15 Nov 2012 17:58:23 +0200
Message-ID: <1352995120-3288-16-git-send-email-tomi.valkeinen@ti.com>
References: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56252 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1768267Ab2KOP7e (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Nov 2012 10:59:34 -0500
In-Reply-To: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, Rob Clark <rob@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add dss_get_core_pdev() which returns the platform device for dss core
device. The following patches use the core pdev to register sysfs files
in the compat code.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/core.c |    5 +++++
 drivers/video/omap2/dss/dss.h  |    1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index b1a9ce1..8c30831 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -66,6 +66,11 @@ enum omapdss_version omapdss_get_version(void)
 }
 EXPORT_SYMBOL(omapdss_get_version);
 
+struct platform_device *dss_get_core_pdev(void)
+{
+	return core.pdev;
+}
+
 /* REGULATORS */
 
 struct regulator *dss_get_vdds_dsi(void)
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 6c3cfb33..9ee3c88 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -160,6 +160,7 @@ struct seq_file;
 struct platform_device;
 
 /* core */
+struct platform_device *dss_get_core_pdev(void);
 struct bus_type *dss_get_bus(void);
 struct regulator *dss_get_vdds_dsi(void);
 struct regulator *dss_get_vdds_sdi(void);
-- 
1.7.10.4

