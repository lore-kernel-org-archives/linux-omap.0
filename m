From: Guruswamy Senthilvadivu <svadivu@ti.com>
Subject: [PATCH v1 15/16] OMAP3: hwmod DSS: Use platform device to get baseaddr
Date: Wed,  6 Oct 2010 16:44:58 +0530
Message-ID: <1286363699-9614-16-git-send-email-svadivu@ti.com>
References: <1286363699-9614-1-git-send-email-svadivu@ti.com>
 <1286363699-9614-2-git-send-email-svadivu@ti.com>
 <1286363699-9614-3-git-send-email-svadivu@ti.com>
 <1286363699-9614-4-git-send-email-svadivu@ti.com>
 <1286363699-9614-5-git-send-email-svadivu@ti.com>
 <1286363699-9614-6-git-send-email-svadivu@ti.com>
 <1286363699-9614-7-git-send-email-svadivu@ti.com>
 <1286363699-9614-8-git-send-email-svadivu@ti.com>
 <1286363699-9614-9-git-send-email-svadivu@ti.com>
 <1286363699-9614-10-git-send-email-svadivu@ti.com>
 <1286363699-9614-11-git-send-email-svadivu@ti.com>
 <1286363699-9614-12-git-send-email-svadivu@ti.com>
 <1286363699-9614-13-git-send-email-svadivu@ti.com>
 <1286363699-9614-14-git-send-email-svadivu@ti.com>
 <1286363699-9614-15-git-send-email-svadivu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:32930 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758890Ab0JFLP3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 Oct 2010 07:15:29 -0400
In-Reply-To: <1286363699-9614-15-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com, tomi.valkeinen@nokia.com, paul@pwsan.com, hvaibhav@ti.com, linux-omap@vger.kernel.org
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>

From: Senthilvadivu Guruswamy <svadivu@ti.com>

DSS, DISPC, DSI, RFBI, VENC baseaddr got from platform_device.
Hardcoding of base addr could be removed.

Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   10 +++++++---
 drivers/video/omap2/dss/dsi.c   |   12 +++++++++---
 drivers/video/omap2/dss/dss.c   |   11 ++++++++---
 drivers/video/omap2/dss/rfbi.c  |   10 +++++++---
 drivers/video/omap2/dss/venc.c  |   10 +++++++---
 5 files changed, 38 insertions(+), 15 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index e35cc87..4642bf1 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -41,8 +41,6 @@
 #include "dss.h"
 
 /* DISPC */
-#define DISPC_BASE			0x48050400
-
 #define DISPC_SZ_REGS			SZ_1K
 
 struct dispc_reg { u16 idx; };
@@ -3134,6 +3132,7 @@ static void _omap_dispc_initial_config(void)
 int dispc_init(void)
 {
 	u32 rev;
+	struct resource *dispc_mem;
 
 	spin_lock_init(&dispc.irq_lock);
 
@@ -3144,7 +3143,12 @@ int dispc_init(void)
 
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
index 092d7fe..f54f967 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -42,8 +42,6 @@
 /*#define VERBOSE_IRQ*/
 #define DSI_CATCH_MISSING_TE
 
-#define DSI_BASE		0x4804FC00
-
 struct dsi_reg { u16 idx; };
 
 #define DSI_REG(idx)		((const struct dsi_reg) { idx })
@@ -3283,6 +3281,7 @@ int dsi_init(struct platform_device *pdev)
 {
 	u32 rev;
 	int r;
+	struct resource *dsi_mem;
 
 	spin_lock_init(&dsi.errors_lock);
 	dsi.errors = 0;
@@ -3309,7 +3308,13 @@ int dsi_init(struct platform_device *pdev)
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
@@ -3337,6 +3342,7 @@ err2:
 	iounmap(dsi.base);
 err1:
 	destroy_workqueue(dsi.workqueue);
+err0:
 	return r;
 }
 
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index b93b118..9a95ab8 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -34,8 +34,6 @@
 #include <plat/clock.h>
 #include "dss.h"
 
-#define DSS_BASE			0x48050000
-
 #define DSS_SZ_REGS			SZ_512
 
 struct dss_reg {
@@ -970,8 +968,15 @@ int dss_init(bool skip_init)
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
index 9bee39d..0566eec 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -36,8 +36,6 @@
 #include <plat/display.h>
 #include "dss.h"
 
-#define RFBI_BASE               0x48050800
-
 struct rfbi_reg { u16 idx; };
 
 #define RFBI_REG(idx)		((const struct rfbi_reg) { idx })
@@ -994,6 +992,7 @@ int rfbi_init(void)
 {
 	u32 rev;
 	u32 l;
+	struct resource *rfbi_mem;
 
 	spin_lock_init(&rfbi.cmd_lock);
 
@@ -1001,7 +1000,12 @@ int rfbi_init(void)
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
index 3a121cb..eccb3c7 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -39,8 +39,6 @@
 
 #include "dss.h"
 
-#define VENC_BASE	0x48050C00
-
 /* Venc registers */
 #define VENC_REV_ID				0x00
 #define VENC_STATUS				0x04
@@ -690,12 +688,18 @@ struct regulator *dss_get_vdda_dac(void)
 int venc_init(struct platform_device *pdev)
 {
 	u8 rev_id;
+	struct resource *venc_mem;
 
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

