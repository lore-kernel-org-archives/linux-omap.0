From: Guruswamy Senthilvadivu <svadivu@ti.com>
Subject: [PATCH v1 07/16] OMAP3: hwmod DSS: Create platform_driver for each DSS HW IP
Date: Wed,  6 Oct 2010 16:44:50 +0530
Message-ID: <1286363699-9614-8-git-send-email-svadivu@ti.com>
References: <1286363699-9614-1-git-send-email-svadivu@ti.com>
 <1286363699-9614-2-git-send-email-svadivu@ti.com>
 <1286363699-9614-3-git-send-email-svadivu@ti.com>
 <1286363699-9614-4-git-send-email-svadivu@ti.com>
 <1286363699-9614-5-git-send-email-svadivu@ti.com>
 <1286363699-9614-6-git-send-email-svadivu@ti.com>
 <1286363699-9614-7-git-send-email-svadivu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40972 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758876Ab0JFLPW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 Oct 2010 07:15:22 -0400
In-Reply-To: <1286363699-9614-7-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com, tomi.valkeinen@nokia.com, paul@pwsan.com, hvaibhav@ti.com, linux-omap@vger.kernel.org
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>

From: Senthilvadivu Guruswamy <svadivu@ti.com>

Platform driver of dsshw has to be registered before of dispc,
rfbi, dsi1, venc and omapdisplay driver should be after all
the hw IPs. Sequence it with arch_initcall and device_initcall_sync.
---
 drivers/video/omap2/dss/core.c  |    2 +-
 drivers/video/omap2/dss/dispc.c |   28 ++++++++++++++++++++++++++++
 drivers/video/omap2/dss/dsi.c   |   28 ++++++++++++++++++++++++++++
 drivers/video/omap2/dss/dss.c   |   30 ++++++++++++++++++++++++++++++
 drivers/video/omap2/dss/rfbi.c  |   29 +++++++++++++++++++++++++++++
 drivers/video/omap2/dss/venc.c  |   28 ++++++++++++++++++++++++++++
 6 files changed, 144 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 0f267e6..7810a40 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -986,7 +986,7 @@ static int __init omap_dss_init2(void)
 }
 
 core_initcall(omap_dss_init);
-device_initcall(omap_dss_init2);
+device_initcall_sync(omap_dss_init2);
 #endif
 
 MODULE_AUTHOR("Tomi Valkeinen <tomi.valkeinen@nokia.com>");
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 5ecdc00..e48c6fa 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -186,6 +186,26 @@ static inline u32 dispc_read_reg(const struct dispc_reg idx)
 	return __raw_readl(dispc.base + idx.idx);
 }
 
+/* DISPC HW IP initialisation */
+static int omap_dispchw_probe(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static int omap_dispchw_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static struct platform_driver omap_dispchw_driver = {
+	.probe          = omap_dispchw_probe,
+	.remove         = omap_dispchw_remove,
+	.driver         = {
+		.name   = "dss_dispc",
+		.owner  = THIS_MODULE,
+	},
+};
+
 #define SR(reg) \
 	dispc.ctx[(DISPC_##reg).idx / sizeof(u32)] = dispc_read_reg(DISPC_##reg)
 #define RR(reg) \
@@ -3187,3 +3207,11 @@ int dispc_setup_plane(enum omap_plane plane,
 
 	return r;
 }
+
+static int __init omap_dispc_init(void)
+{
+	return platform_driver_register(&omap_dispchw_driver);
+}
+
+device_initcall(omap_dispc_init);
+
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index b3fa3a7..fd49663 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -292,6 +292,26 @@ static inline u32 dsi_read_reg(const struct dsi_reg idx)
 	return __raw_readl(dsi.base + idx.idx);
 }
 
+/* DSI1 HW IP initialisation */
+static int omap_dsi1hw_probe(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static int omap_dsi1hw_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static struct platform_driver omap_dsi1hw_driver = {
+	.probe          = omap_dsi1hw_probe,
+	.remove         = omap_dsi1hw_remove,
+	.driver         = {
+		.name   = "dss_dsi1",
+		.owner  = THIS_MODULE,
+	},
+};
+
 
 void dsi_save_context(void)
 {
@@ -3305,3 +3325,11 @@ void dsi_exit(void)
 	DSSDBG("omap_dsi_exit\n");
 }
 
+static int __init omap_dsi1_init(void)
+{
+	return platform_driver_register(&omap_dsi1hw_driver);
+}
+
+device_initcall(omap_dsi1_init);
+
+
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 77c3621..66ef804 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -86,6 +86,29 @@ static inline u32 dss_read_reg(const struct dss_reg idx)
 	return __raw_readl(dss.base + idx.idx);
 }
 
+/* DSS HW IP initialisation */
+static int omap_dsshw_probe(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static int omap_dsshw_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static struct platform_driver omap_dsshw_driver = {
+	.probe          = omap_dsshw_probe,
+	.remove         = omap_dsshw_remove,
+	.shutdown	= NULL,
+	.suspend	= NULL,
+	.resume		= NULL,
+	.driver         = {
+		.name   = "dss",
+		.owner  = THIS_MODULE,
+	},
+};
+
 #define SR(reg) \
 	dss.ctx[(DSS_##reg).idx / sizeof(u32)] = dss_read_reg(DSS_##reg)
 #define RR(reg) \
@@ -639,3 +662,10 @@ void dss_exit(void)
 	iounmap(dss.base);
 }
 
+static int __init omap_dss_init1(void)
+{
+	return platform_driver_register(&omap_dsshw_driver);
+}
+
+arch_initcall(omap_dss_init1);
+
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index bbe6246..23598ea 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -139,6 +139,27 @@ static inline u32 rfbi_read_reg(const struct rfbi_reg idx)
 	return __raw_readl(rfbi.base + idx.idx);
 }
 
+/* RFBI HW IP initialisation */
+static int omap_rfbihw_probe(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static int omap_rfbihw_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static struct platform_driver omap_rfbihw_driver = {
+	.probe          = omap_rfbihw_probe,
+	.remove         = omap_rfbihw_remove,
+	.driver         = {
+		.name   = "dss_rfbi",
+		.owner  = THIS_MODULE,
+	},
+};
+
+
 static void rfbi_enable_clocks(bool enable)
 {
 	if (enable)
@@ -1054,3 +1075,11 @@ int rfbi_init_display(struct omap_dss_device *dssdev)
 	dssdev->caps = OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE;
 	return 0;
 }
+
+static int __init omap_rfbi_init(void)
+{
+	return platform_driver_register(&omap_rfbihw_driver);
+}
+
+device_initcall(omap_rfbi_init);
+
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index eff3505..ec17b28 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -87,6 +87,26 @@
 #define VENC_OUTPUT_TEST			0xC8
 #define VENC_DAC_B__DAC_C			0xC8
 
+/* VENC HW IP initialisation */
+static int omap_venchw_probe(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static int omap_venchw_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static struct platform_driver omap_venchw_driver = {
+	.probe          = omap_venchw_probe,
+	.remove         = omap_venchw_remove,
+	.driver         = {
+		.name   = "dss_venc",
+		.owner  = THIS_MODULE,
+	},
+};
+
 struct venc_config {
 	u32 f_control;
 	u32 vidout_ctrl;
@@ -740,3 +760,11 @@ void venc_dump_regs(struct seq_file *s)
 
 #undef DUMPREG
 }
+
+static int __init omap_venc_init(void)
+{
+	return platform_driver_register(&omap_venchw_driver);
+}
+
+device_initcall(omap_venc_init);
+
-- 
1.6.3.3

