From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 8/8] OMAPDSS: alloc dssdevs dynamically
Date: Wed, 19 Sep 2012 11:30:38 +0300
Message-ID: <1348043438-2624-9-git-send-email-tomi.valkeinen@ti.com>
References: <1348043438-2624-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:45252 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754506Ab2ISIbS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Sep 2012 04:31:18 -0400
Received: by lagy9 with SMTP id y9so510698lag.19
        for <linux-omap@vger.kernel.org>; Wed, 19 Sep 2012 01:31:15 -0700 (PDT)
In-Reply-To: <1348043438-2624-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

We currently create omap_dss_devices statically in board files, and use
those devices directly in the omapdss driver. This model prevents us
from having the platform data (which the dssdevs in board files
practically are) as read-only, and it's also different than what we will
use with device tree.

This patch changes the model to be in line with DT model: we allocate
the dssdevs dynamically, and initialize them according to the data in
the board file's dssdev (basically we memcopy the dssdev fields).

The allocation and registration is done in the following steps in the
output drivers:

- Use dss_alloc_and_init_device to allocate and initialize the device.
  The function uses kalloc and device_initialize to accomplish this.
- Call dss_copy_device_pdata to copy the data from the board file's
  dssdev
- Use dss_add_device to register the device.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/core.c |   72 ++++++++++++++++++++--------------------
 drivers/video/omap2/dss/dpi.c  |   17 +++++++---
 drivers/video/omap2/dss/dsi.c  |   15 +++++++--
 drivers/video/omap2/dss/dss.h  |   11 +++---
 drivers/video/omap2/dss/hdmi.c |   15 +++++++--
 drivers/video/omap2/dss/rfbi.c |   17 +++++++---
 drivers/video/omap2/dss/sdi.c  |   17 +++++++---
 drivers/video/omap2/dss/venc.c |   17 +++++++---
 8 files changed, 119 insertions(+), 62 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index c4fd768..b2af72d 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -33,6 +33,7 @@
 #include <linux/device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/suspend.h>
+#include <linux/slab.h>
 
 #include <video/omapdss.h>
 
@@ -418,55 +419,44 @@ void omap_dss_unregister_driver(struct omap_dss_driver *dssdriver)
 EXPORT_SYMBOL(omap_dss_unregister_driver);
 
 /* DEVICE */
-static void reset_device(struct device *dev, int check)
-{
-	u8 *dev_p = (u8 *)dev;
-	u8 *dev_end = dev_p + sizeof(*dev);
-	void *saved_pdata;
-
-	saved_pdata = dev->platform_data;
-	if (check) {
-		/*
-		 * Check if there is any other setting than platform_data
-		 * in struct device; warn that these will be reset by our
-		 * init.
-		 */
-		dev->platform_data = NULL;
-		while (dev_p < dev_end) {
-			if (*dev_p) {
-				WARN("%s: struct device fields will be "
-						"discarded\n",
-				     __func__);
-				break;
-			}
-			dev_p++;
-		}
-	}
-	memset(dev, 0, sizeof(*dev));
-	dev->platform_data = saved_pdata;
-}
-
 
 static void omap_dss_dev_release(struct device *dev)
 {
-	reset_device(dev, 0);
+	struct omap_dss_device *dssdev = to_dss_device(dev);
+	kfree(dssdev);
 }
 
 static int disp_num_counter;
 
-int omap_dss_register_device(struct omap_dss_device *dssdev,
-		struct device *parent)
+struct omap_dss_device *dss_alloc_and_init_device(struct device *parent)
 {
-	reset_device(&dssdev->dev, 1);
+	struct omap_dss_device *dssdev;
+
+	dssdev = kzalloc(sizeof(*dssdev), GFP_KERNEL);
+	if (!dssdev)
+		return NULL;
 
 	dssdev->dev.bus = &dss_bus_type;
 	dssdev->dev.parent = parent;
 	dssdev->dev.release = omap_dss_dev_release;
 	dev_set_name(&dssdev->dev, "display%d", disp_num_counter++);
-	return device_register(&dssdev->dev);
+
+	device_initialize(&dssdev->dev);
+
+	return dssdev;
 }
 
-void omap_dss_unregister_device(struct omap_dss_device *dssdev)
+int dss_add_device(struct omap_dss_device *dssdev)
+{
+	return device_add(&dssdev->dev);
+}
+
+void dss_put_device(struct omap_dss_device *dssdev)
+{
+	put_device(&dssdev->dev);
+}
+
+void dss_unregister_device(struct omap_dss_device *dssdev)
 {
 	device_unregister(&dssdev->dev);
 }
@@ -474,15 +464,25 @@ void omap_dss_unregister_device(struct omap_dss_device *dssdev)
 static int dss_unregister_dss_dev(struct device *dev, void *data)
 {
 	struct omap_dss_device *dssdev = to_dss_device(dev);
-	omap_dss_unregister_device(dssdev);
+	dss_unregister_device(dssdev);
 	return 0;
 }
 
-void omap_dss_unregister_child_devices(struct device *parent)
+void dss_unregister_child_devices(struct device *parent)
 {
 	device_for_each_child(parent, NULL, dss_unregister_dss_dev);
 }
 
+void dss_copy_device_pdata(struct omap_dss_device *dst,
+		const struct omap_dss_device *src)
+{
+	u8 *d = (u8 *)dst;
+	u8 *s = (u8 *)src;
+	size_t dsize = sizeof(struct device);
+
+	memcpy(d + dsize, s + dsize, sizeof(struct omap_dss_device) - dsize);
+}
+
 /* BUS */
 static int __init omap_dss_bus_register(void)
 {
diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 6f9a199..fac19d3 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -399,25 +399,34 @@ static struct omap_dss_device * __init dpi_find_dssdev(struct platform_device *p
 	return def_dssdev;
 }
 
-static void __init dpi_probe_pdata(struct platform_device *pdev)
+static void __init dpi_probe_pdata(struct platform_device *dpidev)
 {
+	struct omap_dss_device *plat_dssdev;
 	struct omap_dss_device *dssdev;
 	int r;
 
-	dssdev = dpi_find_dssdev(pdev);
+	plat_dssdev = dpi_find_dssdev(dpidev);
 
+	if (!plat_dssdev)
+		return;
+
+	dssdev = dss_alloc_and_init_device(&dpidev->dev);
 	if (!dssdev)
 		return;
 
+	dss_copy_device_pdata(dssdev, plat_dssdev);
+
 	r = dpi_init_display(dssdev);
 	if (r) {
 		DSSERR("device %s init failed: %d\n", dssdev->name, r);
+		dss_put_device(dssdev);
 		return;
 	}
 
-	r = omap_dss_register_device(dssdev, &pdev->dev);
+	r = dss_add_device(dssdev);
 	if (r) {
 		DSSERR("device %s register failed: %d\n", dssdev->name, r);
+		dss_put_device(dssdev);
 		return;
 	}
 }
@@ -433,7 +442,7 @@ static int __init omap_dpi_probe(struct platform_device *pdev)
 
 static int __exit omap_dpi_remove(struct platform_device *pdev)
 {
-	omap_dss_unregister_child_devices(&pdev->dev);
+	dss_unregister_child_devices(&pdev->dev);
 
 	return 0;
 }
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index ee9ae52..1dd019c 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -5040,23 +5040,32 @@ static struct omap_dss_device * __init dsi_find_dssdev(struct platform_device *p
 
 static void __init dsi_probe_pdata(struct platform_device *dsidev)
 {
+	struct omap_dss_device *plat_dssdev;
 	struct omap_dss_device *dssdev;
 	int r;
 
-	dssdev = dsi_find_dssdev(dsidev);
+	plat_dssdev = dsi_find_dssdev(dsidev);
 
+	if (!plat_dssdev)
+		return;
+
+	dssdev = dss_alloc_and_init_device(&dsidev->dev);
 	if (!dssdev)
 		return;
 
+	dss_copy_device_pdata(dssdev, plat_dssdev);
+
 	r = dsi_init_display(dssdev);
 	if (r) {
 		DSSERR("device %s init failed: %d\n", dssdev->name, r);
+		dss_put_device(dssdev);
 		return;
 	}
 
-	r = omap_dss_register_device(dssdev, &dsidev->dev);
+	r = dss_add_device(dssdev);
 	if (r) {
 		DSSERR("device %s register failed: %d\n", dssdev->name, r);
+		dss_put_device(dssdev);
 		return;
 	}
 }
@@ -5184,7 +5193,7 @@ static int __exit omap_dsihw_remove(struct platform_device *dsidev)
 
 	WARN_ON(dsi->scp_clk_refcount > 0);
 
-	omap_dss_unregister_child_devices(&dsidev->dev);
+	dss_unregister_child_devices(&dsidev->dev);
 
 	pm_runtime_disable(&dsidev->dev);
 
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 7a3fea6..417d305 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -185,10 +185,13 @@ void dss_dsi_disable_pads(int dsi_id, unsigned lane_mask);
 int dss_set_min_bus_tput(struct device *dev, unsigned long tput);
 int dss_debugfs_create_file(const char *name, void (*write)(struct seq_file *));
 
-int omap_dss_register_device(struct omap_dss_device *dssdev,
-		struct device *parent);
-void omap_dss_unregister_device(struct omap_dss_device *dssdev);
-void omap_dss_unregister_child_devices(struct device *parent);
+struct omap_dss_device *dss_alloc_and_init_device(struct device *parent);
+int dss_add_device(struct omap_dss_device *dssdev);
+void dss_unregister_device(struct omap_dss_device *dssdev);
+void dss_unregister_child_devices(struct device *parent);
+void dss_put_device(struct omap_dss_device *dssdev);
+void dss_copy_device_pdata(struct omap_dss_device *dst,
+		const struct omap_dss_device *src);
 
 /* apply */
 void dss_apply_init(void);
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 3b10e18..23daf7d 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -931,15 +931,22 @@ static struct omap_dss_device * __init hdmi_find_dssdev(struct platform_device *
 
 static void __init hdmi_probe_pdata(struct platform_device *pdev)
 {
+	struct omap_dss_device *plat_dssdev;
 	struct omap_dss_device *dssdev;
 	struct omap_dss_hdmi_data *priv;
 	int r;
 
-	dssdev = hdmi_find_dssdev(pdev);
+	plat_dssdev = hdmi_find_dssdev(pdev);
 
+	if (!plat_dssdev)
+		return;
+
+	dssdev = dss_alloc_and_init_device(&pdev->dev);
 	if (!dssdev)
 		return;
 
+	dss_copy_device_pdata(dssdev, plat_dssdev);
+
 	priv = dssdev->data;
 
 	hdmi.ct_cp_hpd_gpio = priv->ct_cp_hpd_gpio;
@@ -951,12 +958,14 @@ static void __init hdmi_probe_pdata(struct platform_device *pdev)
 	r = hdmi_init_display(dssdev);
 	if (r) {
 		DSSERR("device %s init failed: %d\n", dssdev->name, r);
+		dss_put_device(dssdev);
 		return;
 	}
 
-	r = omap_dss_register_device(dssdev, &pdev->dev);
+	r = dss_add_device(dssdev);
 	if (r) {
 		DSSERR("device %s register failed: %d\n", dssdev->name, r);
+		dss_put_device(dssdev);
 		return;
 	}
 }
@@ -1020,7 +1029,7 @@ static int __exit omapdss_hdmihw_remove(struct platform_device *pdev)
 {
 	device_for_each_child(&pdev->dev, NULL, hdmi_remove_child);
 
-	omap_dss_unregister_child_devices(&pdev->dev);
+	dss_unregister_child_devices(&pdev->dev);
 
 	hdmi_panel_exit();
 
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index 1127037..38d9b8e 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -970,25 +970,34 @@ static struct omap_dss_device * __init rfbi_find_dssdev(struct platform_device *
 	return def_dssdev;
 }
 
-static void __init rfbi_probe_pdata(struct platform_device *pdev)
+static void __init rfbi_probe_pdata(struct platform_device *rfbidev)
 {
+	struct omap_dss_device *plat_dssdev;
 	struct omap_dss_device *dssdev;
 	int r;
 
-	dssdev = rfbi_find_dssdev(pdev);
+	plat_dssdev = rfbi_find_dssdev(rfbidev);
 
+	if (!plat_dssdev)
+		return;
+
+	dssdev = dss_alloc_and_init_device(&rfbidev->dev);
 	if (!dssdev)
 		return;
 
+	dss_copy_device_pdata(dssdev, plat_dssdev);
+
 	r = rfbi_init_display(dssdev);
 	if (r) {
 		DSSERR("device %s init failed: %d\n", dssdev->name, r);
+		dss_put_device(dssdev);
 		return;
 	}
 
-	r = omap_dss_register_device(dssdev, &pdev->dev);
+	r = dss_add_device(dssdev);
 	if (r) {
 		DSSERR("device %s register failed: %d\n", dssdev->name, r);
+		dss_put_device(dssdev);
 		return;
 	}
 }
@@ -1055,7 +1064,7 @@ err_runtime_get:
 
 static int __exit omap_rfbihw_remove(struct platform_device *pdev)
 {
-	omap_dss_unregister_child_devices(&pdev->dev);
+	dss_unregister_child_devices(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	return 0;
 }
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index 0aaa7f3..919ff72 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -223,25 +223,34 @@ static struct omap_dss_device * __init sdi_find_dssdev(struct platform_device *p
 	return def_dssdev;
 }
 
-static void __init sdi_probe_pdata(struct platform_device *pdev)
+static void __init sdi_probe_pdata(struct platform_device *sdidev)
 {
+	struct omap_dss_device *plat_dssdev;
 	struct omap_dss_device *dssdev;
 	int r;
 
-	dssdev = sdi_find_dssdev(pdev);
+	plat_dssdev = sdi_find_dssdev(sdidev);
 
+	if (!plat_dssdev)
+		return;
+
+	dssdev = dss_alloc_and_init_device(&sdidev->dev);
 	if (!dssdev)
 		return;
 
+	dss_copy_device_pdata(dssdev, plat_dssdev);
+
 	r = sdi_init_display(dssdev);
 	if (r) {
 		DSSERR("device %s init failed: %d\n", dssdev->name, r);
+		dss_put_device(dssdev);
 		return;
 	}
 
-	r = omap_dss_register_device(dssdev, &pdev->dev);
+	r = dss_add_device(dssdev);
 	if (r) {
 		DSSERR("device %s register failed: %d\n", dssdev->name, r);
+		dss_put_device(dssdev);
 		return;
 	}
 }
@@ -255,7 +264,7 @@ static int __init omap_sdi_probe(struct platform_device *pdev)
 
 static int __exit omap_sdi_remove(struct platform_device *pdev)
 {
-	omap_dss_unregister_child_devices(&pdev->dev);
+	dss_unregister_child_devices(&pdev->dev);
 
 	return 0;
 }
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 88fa6ea..996779c 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -763,27 +763,36 @@ static struct omap_dss_device * __init venc_find_dssdev(struct platform_device *
 	return def_dssdev;
 }
 
-static void __init venc_probe_pdata(struct platform_device *pdev)
+static void __init venc_probe_pdata(struct platform_device *vencdev)
 {
+	struct omap_dss_device *plat_dssdev;
 	struct omap_dss_device *dssdev;
 	int r;
 
-	dssdev = venc_find_dssdev(pdev);
+	plat_dssdev = venc_find_dssdev(vencdev);
 
+	if (!plat_dssdev)
+		return;
+
+	dssdev = dss_alloc_and_init_device(&vencdev->dev);
 	if (!dssdev)
 		return;
 
+	dss_copy_device_pdata(dssdev, plat_dssdev);
+
 	dssdev->channel = OMAP_DSS_CHANNEL_DIGIT;
 
 	r = venc_init_display(dssdev);
 	if (r) {
 		DSSERR("device %s init failed: %d\n", dssdev->name, r);
+		dss_put_device(dssdev);
 		return;
 	}
 
-	r = omap_dss_register_device(dssdev, &pdev->dev);
+	r = dss_add_device(dssdev);
 	if (r) {
 		DSSERR("device %s register failed: %d\n", dssdev->name, r);
+		dss_put_device(dssdev);
 		return;
 	}
 }
@@ -848,7 +857,7 @@ err_runtime_get:
 
 static int __exit omap_venchw_remove(struct platform_device *pdev)
 {
-	omap_dss_unregister_child_devices(&pdev->dev);
+	dss_unregister_child_devices(&pdev->dev);
 
 	if (venc.vdda_dac_reg != NULL) {
 		regulator_put(venc.vdda_dac_reg);
-- 
1.7.9.5

