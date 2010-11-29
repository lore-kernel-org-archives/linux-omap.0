From: Guruswamy Senthilvadivu <svadivu@ti.com>
Subject: [PATCH v2 08/17] OMAP2,3: DSS: Create platform_driver for each DSS HW IP
Date: Mon, 29 Nov 2010 17:21:34 +0530
Message-ID: <1291031503-21036-9-git-send-email-svadivu@ti.com>
References: <1291031503-21036-1-git-send-email-svadivu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48972 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753526Ab0K2Lv5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Nov 2010 06:51:57 -0500
In-Reply-To: <1291031503-21036-1-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com, tomi.valkeinen@nokia.com, paul@pwsan.com, hvaibhav@ti.com, linux-omap@vger.kernel.org
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>

From: Senthilvadivu Guruswamy <svadivu@ti.com>

Platform driver of dsshw has to be registered before of dispc,
rfbi, dsi1, venc and omapdisplay driver should be after all
the hw IPs. Sequence it with arch_initcall and device_initcall_sync

Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
---
 drivers/video/omap2/dss/core.c  |    2 +-
 drivers/video/omap2/dss/dispc.c |   28 ++++++++++++++++++++++++++++
 drivers/video/omap2/dss/dsi.c   |   29 ++++++++++++++++++++++++++++-
 drivers/video/omap2/dss/dss.c   |   27 +++++++++++++++++++++++++++
 drivers/video/omap2/dss/rfbi.c  |   28 ++++++++++++++++++++++++++++
 drivers/video/omap2/dss/venc.c  |   28 ++++++++++++++++++++++++++++
 6 files changed, 140 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 48d20d8..d165434 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -989,7 +989,7 @@ static int __init omap_dss_init2(void)
 }
 
 core_initcall(omap_dss_init);
-device_initcall(omap_dss_init2);
+device_initcall_sync(omap_dss_init2);
 #endif
 
 MODULE_AUTHOR("Tomi Valkeinen <tomi.valkeinen@nokia.com>");
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index fa40fa5..942dea5 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -3167,3 +3167,31 @@ int dispc_setup_plane(enum omap_plane plane,
 
 	return r;
 }
+
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
+		.name   = "omap_dispc",
+		.owner  = THIS_MODULE,
+	},
+};
+
+static int __init omap_dispc_init(void)
+{
+	return platform_driver_register(&omap_dispchw_driver);
+}
+
+device_initcall(omap_dispc_init);
+
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index aa4f7a5..037d366 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -292,7 +292,6 @@ static inline u32 dsi_read_reg(const struct dsi_reg idx)
 	return __raw_readl(dsi.base + idx.idx);
 }
 
-
 void dsi_save_context(void)
 {
 }
@@ -3304,3 +3303,31 @@ void dsi_exit(void)
 	DSSDBG("omap_dsi_exit\n");
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
+		.name   = "omap_dsi1",
+		.owner  = THIS_MODULE,
+	},
+};
+
+static int __init omap_dsi1_init(void)
+{
+	return platform_driver_register(&omap_dsi1hw_driver);
+}
+
+device_initcall(omap_dsi1_init);
+
+
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 77c3621..6d0bd89 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -639,3 +639,30 @@ void dss_exit(void)
 	iounmap(dss.base);
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
+	.driver         = {
+		.name   = "omap_dss",
+		.owner  = THIS_MODULE,
+	},
+};
+
+static int __init omap_dss_init1(void)
+{
+	return platform_driver_register(&omap_dsshw_driver);
+}
+
+arch_initcall(omap_dss_init1);
+
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index bbe6246..a086233 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -1054,3 +1054,31 @@ int rfbi_init_display(struct omap_dss_device *dssdev)
 	dssdev->caps = OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE;
 	return 0;
 }
+
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
+		.name   = "omap_rfbi",
+		.owner  = THIS_MODULE,
+	},
+};
+
+static int __init omap_rfbi_init(void)
+{
+	return platform_driver_register(&omap_rfbihw_driver);
+}
+
+device_initcall(omap_rfbi_init);
+
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index eff3505..ac63cee 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -740,3 +740,31 @@ void venc_dump_regs(struct seq_file *s)
 
 #undef DUMPREG
 }
+
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
+		.name   = "omap_venc",
+		.owner  = THIS_MODULE,
+	},
+};
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

