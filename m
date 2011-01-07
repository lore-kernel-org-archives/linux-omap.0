From: Sumit Semwal <sumit.semwal@ti.com>
Subject: [PATCH v4 15/17] OMAP2,3: DSS2: replace printk with dev_dbg in init
Date: Fri,  7 Jan 2011 08:49:09 +0530
Message-ID: <1294370351-8654-16-git-send-email-sumit.semwal@ti.com>
References: <1294370351-8654-1-git-send-email-sumit.semwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59681 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756036Ab1AGDUs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 6 Jan 2011 22:20:48 -0500
In-Reply-To: <1294370351-8654-1-git-send-email-sumit.semwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com, paul@pwsan.com, khilman@deeprootsystems.com, hvaibhav@ti.com, linux-omap@vger.kernel.org
Cc: Sumit Semwal <sumit.semwal@ti.com>

This patch replaces printk's in the init/probe functions to dev_dbg
for boot time optimization.

Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
---
 drivers/video/omap2/dss/dispc.c |    2 +-
 drivers/video/omap2/dss/dsi.c   |    2 +-
 drivers/video/omap2/dss/rfbi.c  |    2 +-
 drivers/video/omap2/dss/venc.c  |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index e19c4cd..97dfc84 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -3158,7 +3158,7 @@ static int omap_dispchw_probe(struct platform_device *pdev)
 	dispc_save_context();
 
 	rev = dispc_read_reg(DISPC_REVISION);
-	printk(KERN_INFO "OMAP DISPC rev %d.%d\n",
+	dev_dbg(&pdev->dev, "OMAP DISPC rev %d.%d\n",
 	       FLD_GET(rev, 7, 4), FLD_GET(rev, 3, 0));
 
 	enable_clocks(0);
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 411d0c6..cf1a2ad 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -3297,7 +3297,7 @@ static int dsi_init(struct platform_device *pdev)
 	enable_clocks(1);
 
 	rev = dsi_read_reg(DSI_REVISION);
-	printk(KERN_INFO "OMAP DSI rev %d.%d\n",
+	dev_dbg(&pdev->dev, "OMAP DSI rev %d.%d\n",
 	       FLD_GET(rev, 7, 4), FLD_GET(rev, 3, 0));
 
 	enable_clocks(0);
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index 52bfb1c..24936f8 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -1044,7 +1044,7 @@ static int omap_rfbihw_probe(struct platform_device *pdev)
 	rfbi_write_reg(RFBI_SYSCONFIG, l);
 
 	rev = rfbi_read_reg(RFBI_REVISION);
-	printk(KERN_INFO "OMAP RFBI rev %d.%d\n",
+	dev_dbg(&pdev->dev, "OMAP RFBI rev %d.%d\n",
 	       FLD_GET(rev, 7, 4), FLD_GET(rev, 3, 0));
 
 	rfbi_enable_clocks(0);
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 029fbc3..edccd59 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -739,7 +739,7 @@ static int omap_venchw_probe(struct platform_device *pdev)
 	venc_enable_clocks(1);
 
 	rev_id = (u8)(venc_read_reg(VENC_REV_ID) & 0xff);
-	printk(KERN_INFO "OMAP VENC rev %d\n", rev_id);
+	dev_dbg(&pdev->dev, "OMAP VENC rev %d\n", rev_id);
 
 	venc_enable_clocks(0);
 
-- 
1.7.0.4

