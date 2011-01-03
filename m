From: Guruswamy Senthilvadivu <svadivu@ti.com>
Subject: [PATCH v3 16/17] OMAP2,3: DSS2: Use platform device to get baseaddr
Date: Mon,  3 Jan 2011 18:21:08 +0530
Message-ID: <1294059069-26737-17-git-send-email-svadivu@ti.com>
References: <1294059069-26737-1-git-send-email-svadivu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53180 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754791Ab1ACMv3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Jan 2011 07:51:29 -0500
In-Reply-To: <1294059069-26737-1-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com, paul@pwsan.com, khilman@deeprootsystems.com, v-hiremath@ti.com, a0919096@ti.com, linux-omap@vger.kernel.org
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>

From: Senthilvadivu Guruswamy <svadivu@ti.com>

DSS, DISPC, DSI, RFBI, VENC baseaddr can be obtained from platform_get_resource().
This API in turn picks the right silicon baseaddr from the hwmod database.
So hardcoding of base addr could be removed.

Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   11 ++++++++---
 drivers/video/omap2/dss/dsi.c   |   12 +++++++++---
 drivers/video/omap2/dss/dss.c   |   11 ++++++++---
 drivers/video/omap2/dss/rfbi.c  |   10 +++++++---
 drivers/video/omap2/dss/venc.c  |   11 ++++++++---
 5 files changed, 40 insertions(+), 15 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 57de1c9..7ce65c6 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -42,8 +42,6 @@
 #include "dss_features.h"
 
 /* DISPC */
-#define DISPC_BASE			0x48050400
-
 #define DISPC_SZ_REGS			SZ_1K
 
 struct dispc_reg { u16 idx; };
@@ -3132,6 +3130,8 @@ int dispc_setup_plane(enum omap_plane plane,
 static int omap_dispchw_probe(struct platform_device *pdev)
 {
 	u32 rev;
+	struct resource *dispc_mem;
+
 	dispc.pdev = pdev;
 
 	spin_lock_init(&dispc.irq_lock);
@@ -3143,7 +3143,12 @@ static int omap_dispchw_probe(struct platform_device *pdev)
 
 	INIT_WORK(&dispc.error_work, dispc_error_worker);
 
-	dispc.base = ioremap(DISPC_BASE, DISPC_SZ_REGS);
+	dispc_mem = platform_get_resource(dispc.pdev, IORESOURCE_MEM, 0);
+	if (!dispc_mem) {
+		DSSERR("can't get IORESOURCE_MEM DISPC\n");
+		return -EINVAL;
+	}
+	dispc.base = ioremap(dispc_mem->start, resource_size(dispc_mem));
 	if (!dispc.base) {
 		DSSERR("can't ioremap DISPC\n");
 		return -ENOMEM;
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index b592075..40e112b 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -42,8 +42,6 @@
 /*#define VERBOSE_IRQ*/
 #define DSI_CATCH_MISSING_TE
 
-#define DSI_BASE		0x4804FC00
-
 struct dsi_reg { u16 idx; };
 
 #define DSI_REG(idx)		((const struct dsi_reg) { idx })
@@ -3253,6 +3251,7 @@ int dsi_init(struct platform_device *pdev)
 {
 	u32 rev;
 	int r;
+	struct resource *dsi_mem;
 
 	spin_lock_init(&dsi.errors_lock);
 	dsi.errors = 0;
@@ -3279,7 +3278,13 @@ int dsi_init(struct platform_device *pdev)
 	dsi.te_timer.function = dsi_te_timeout;
 	dsi.te_timer.data = 0;
 #endif
-	dsi.base = ioremap(DSI_BASE, DSI_SZ_REGS);
+	dsi_mem = platform_get_resource(dsi.pdev, IORESOURCE_MEM, 0);
+	if (!dsi_mem) {
+		DSSERR("can't get IORESOURCE_MEM DSI\n");
+		r = -EINVAL;
+		goto err0;
+	}
+	dsi.base = ioremap(dsi_mem->start, resource_size(dsi_mem));
 	if (!dsi.base) {
 		DSSERR("can't ioremap DSI\n");
 		r = -ENOMEM;
@@ -3306,6 +3311,7 @@ err2:
 	iounmap(dsi.base);
 err1:
 	destroy_workqueue(dsi.workqueue);
+err0:
 	return r;
 }
 
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index b622d04..f544160 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -35,8 +35,6 @@
 #include "dss.h"
 #include "dss_features.h"
 
-#define DSS_BASE			0x48050000
-
 #define DSS_SZ_REGS			SZ_512
 
 struct dss_reg {
@@ -569,8 +567,15 @@ int dss_init(bool skip_init)
 {
 	int r;
 	u32 rev;
+	struct resource *dss_mem;
 
-	dss.base = ioremap(DSS_BASE, DSS_SZ_REGS);
+	dss_mem = platform_get_resource(dss.pdev, IORESOURCE_MEM, 0);
+	if (!dss_mem) {
+		DSSERR("can't get IORESOURCE_MEM DSS\n");
+		r = -EINVAL;
+		goto fail0;
+	}
+	dss.base = ioremap(dss_mem->start, resource_size(dss_mem));
 	if (!dss.base) {
 		DSSERR("can't ioremap DSS\n");
 		r = -ENOMEM;
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index 14a5262..33afbe8 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -36,8 +36,6 @@
 #include <plat/display.h>
 #include "dss.h"
 
-#define RFBI_BASE               0x48050800
-
 struct rfbi_reg { u16 idx; };
 
 #define RFBI_REG(idx)		((const struct rfbi_reg) { idx })
@@ -1017,6 +1015,7 @@ static int omap_rfbihw_probe(struct platform_device *pdev)
 {
 	u32 rev;
 	u32 l;
+	struct resource *rfbi_mem;
 
 	rfbi.pdev = pdev;
 
@@ -1026,7 +1025,12 @@ static int omap_rfbihw_probe(struct platform_device *pdev)
 	atomic_set(&rfbi.cmd_fifo_full, 0);
 	atomic_set(&rfbi.cmd_pending, 0);
 
-	rfbi.base = ioremap(RFBI_BASE, SZ_256);
+	rfbi_mem = platform_get_resource(rfbi.pdev, IORESOURCE_MEM, 0);
+	if (!rfbi_mem) {
+		DSSERR("can't get IORESOURCE_MEM RFBI\n");
+		return -EINVAL;
+	}
+	rfbi.base = ioremap(rfbi_mem->start, resource_size(rfbi_mem));
 	if (!rfbi.base) {
 		DSSERR("can't ioremap RFBI\n");
 		return -ENOMEM;
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 4e84e71..86ccb21 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -39,8 +39,6 @@
 
 #include "dss.h"
 
-#define VENC_BASE	0x48050C00
-
 /* Venc registers */
 #define VENC_REV_ID				0x00
 #define VENC_STATUS				0x04
@@ -717,13 +715,20 @@ void venc_dump_regs(struct seq_file *s)
 static int omap_venchw_probe(struct platform_device *pdev)
 {
 	u8 rev_id;
+	struct resource *venc_mem;
+
 	venc.pdev = pdev;
 
 	mutex_init(&venc.venc_lock);
 
 	venc.wss_data = 0;
 
-	venc.base = ioremap(VENC_BASE, SZ_1K);
+	venc_mem = platform_get_resource(venc.pdev, IORESOURCE_MEM, 0);
+	if (!venc_mem) {
+		DSSERR("can't get IORESOURCE_MEM VENC\n");
+		return -EINVAL;
+	}
+	venc.base = ioremap(venc_mem->start, resource_size(venc_mem));
 	if (!venc.base) {
 		DSSERR("can't ioremap VENC\n");
 		return -ENOMEM;
-- 
1.6.3.3

