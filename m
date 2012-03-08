From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 2/2] OMAPDSS: Ensure OPP100 when DSS is operational
Date: Thu,  8 Mar 2012 13:13:37 +0200
Message-ID: <1331205217-19927-2-git-send-email-tomi.valkeinen@ti.com>
References: <1331205217-19927-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog136.obsmtp.com ([74.125.149.85]:49008 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755945Ab2CHLOO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Mar 2012 06:14:14 -0500
Received: by mail-lpp01m010-f47.google.com with SMTP id w12so454938lag.34
        for <linux-omap@vger.kernel.org>; Thu, 08 Mar 2012 03:14:12 -0800 (PST)
In-Reply-To: <1331205217-19927-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>

Most of the DSS clocks have restrictions on their frequency based on the
OPP in use. For example, maximum frequency for a clock may be 180MHz in
OPP100, but 90MHz in OPP50. This means that when a high enough pixel
clock or function clock is required, we need to use OPP100.

However, there's currently no way in the PM framework to make that kind
of request. The closest we get is to ask for very high bus throughput
from the PM framework, which should effectively force OPP100.

This patch is a simple version for handling the problem. Instead of
asking for OPP100 only when needed, this patch asks for OPP100 whenever
DSS is active. This obviously is not an optimal solution for cases with
small displays where OPP50 would work just fine. However, a proper
solution is a complex one, and this patch is a short term solution for
the problem.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 drivers/video/omap2/dss/core.c |   10 ++++++++++
 drivers/video/omap2/dss/dss.c  |   13 +++++++++++++
 drivers/video/omap2/dss/dss.h  |    1 +
 3 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 8613f86..999bcbc 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -87,6 +87,16 @@ struct regulator *dss_get_vdds_sdi(void)
 	return reg;
 }
 
+int dss_set_min_bus_tput(struct device *dev, unsigned long tput)
+{
+	struct omap_dss_board_info *pdata = core.pdev->dev.platform_data;
+
+	if (pdata->set_min_bus_tput)
+		return pdata->set_min_bus_tput(dev, tput);
+	else
+		return 0;
+}
+
 #if defined(CONFIG_DEBUG_FS) && defined(CONFIG_OMAP2_DSS_DEBUG_SUPPORT)
 static int dss_debug_show(struct seq_file *s, void *unused)
 {
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 4a6b5ee..4a3eb22 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -826,11 +826,24 @@ static int omap_dsshw_remove(struct platform_device *pdev)
 static int dss_runtime_suspend(struct device *dev)
 {
 	dss_save_context();
+	dss_set_min_bus_tput(dev, 0);
 	return 0;
 }
 
 static int dss_runtime_resume(struct device *dev)
 {
+	int r;
+	/*
+	 * Set an arbitrarily high tput request to ensure OPP100.
+	 * What we should really do is to make a request to stay in OPP100,
+	 * without any tput requirements, but that is not currently possible
+	 * via the PM layer.
+	 */
+
+	r = dss_set_min_bus_tput(dev, 1000000000);
+	if (r)
+		return r;
+
 	dss_restore_context();
 	return 0;
 }
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index d4b3dff..42f8f62 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -162,6 +162,7 @@ struct platform_device;
 struct bus_type *dss_get_bus(void);
 struct regulator *dss_get_vdds_dsi(void);
 struct regulator *dss_get_vdds_sdi(void);
+int dss_set_min_bus_tput(struct device *dev, unsigned long tput);
 
 /* apply */
 void dss_apply_init(void);
-- 
1.7.4.1

