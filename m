From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 1/2] DSPRBIDGE: split probe from bridge initializations
Date: Tue,  8 Jun 2010 19:48:12 -0500
Message-ID: <1276044493-23003-2-git-send-email-omar.ramirez@ti.com>
References: <1276044493-23003-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50768 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756497Ab0FIAza (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Jun 2010 20:55:30 -0400
In-Reply-To: <1276044493-23003-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

A function containing driver low lever initializations has been
created. Now device entry should be available only if the startup
call has completed successfully, in case of error rollback any
of the changes that apply.

Now, device entry is created after bridge initializations
have been completed.

Reported-by: Ameya Palande <ameya.palande@nokia.com>
Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/rmgr/drv_interface.c |  178 ++++++++++++++++++-------------
 1 files changed, 105 insertions(+), 73 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index c29de2c..f80b15b 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -233,23 +233,125 @@ static struct notifier_block iva_clk_notifier = {
 };
 #endif
 
+/**
+ * omap3_bridge_startup() - perform low lever initializations
+ * @pdev:      pointer to platform device
+ *
+ * Initializes recovery, PM and DVFS required data, before calling
+ * clk and memory init routines.
+ */
+static int omap3_bridge_startup(struct platform_device *pdev)
+{
+	struct dspbridge_platform_data *pdata = pdev->dev.platform_data;
+	struct drv_data *drv_datap = NULL;
+	u32 phys_membase, phys_memsize;
+	int err;
+
+#ifdef CONFIG_BRIDGE_RECOVERY
+	bridge_rec_queue = create_workqueue("bridge_rec_queue");
+	INIT_WORK(&bridge_recovery_work, bridge_recover);
+	INIT_COMPLETION(bridge_comp);
+#endif
+
+#ifdef CONFIG_PM
+	/* Initialize the wait queue */
+	bridge_suspend_data.suspended = 0;
+	init_waitqueue_head(&bridge_suspend_data.suspend_wq);
+
+#ifdef CONFIG_BRIDGE_DVFS
+	for (i = 0; i < 6; i++)
+		pdata->mpu_speed[i] = vdd1_rate_table_bridge[i].rate;
+
+	err = cpufreq_register_notifier(&iva_clk_notifier,
+					CPUFREQ_TRANSITION_NOTIFIER);
+	if (err)
+		pr_err("%s: clk_notifier_register failed for iva2_ck\n",
+								__func__);
+#endif
+#endif
+
+	dsp_clk_init();
+	services_init();
+
+	drv_datap = kzalloc(sizeof(struct drv_data), GFP_KERNEL);
+	if (!drv_datap) {
+		err = -ENOMEM;
+		goto err1;
+	}
+
+	drv_datap->shm_size = shm_size;
+	drv_datap->tc_wordswapon = tc_wordswapon;
+
+	if (base_img) {
+		drv_datap->base_img = kmalloc(strlen(base_img) + 1, GFP_KERNEL);
+		if (!drv_datap->base_img) {
+			err = -ENOMEM;
+			goto err2;
+		}
+		strncpy(drv_datap->base_img, base_img, strlen(base_img) + 1);
+	}
+
+	dev_set_drvdata(bridge, drv_datap);
+
+	if (shm_size < 0x10000) {	/* 64 KB */
+		err = -EINVAL;
+		pr_err("%s: shm size must be at least 64 KB\n", __func__);
+		goto err3;
+	}
+	dev_dbg(bridge, "%s: requested shm_size = 0x%x\n", __func__, shm_size);
+
+	phys_membase = pdata->phys_mempool_base;
+	phys_memsize = pdata->phys_mempool_size;
+	if (phys_membase > 0 && phys_memsize > 0)
+		mem_ext_phys_pool_init(phys_membase, phys_memsize);
+
+	if (tc_wordswapon)
+		dev_dbg(bridge, "%s: TC Word Swap is enabled\n", __func__);
+
+	driver_context = dsp_init(&err);
+	if (err) {
+		pr_err("DSP Bridge driver initialization failed\n");
+		goto err4;
+	}
+
+	return 0;
+
+err4:
+	mem_ext_phys_pool_release();
+err3:
+	kfree(drv_datap->base_img);
+err2:
+	kfree(drv_datap);
+err1:
+#ifdef CONFIG_BRIDGE_DVFS
+	cpufreq_unregister_notifier(&iva_clk_notifier,
+					CPUFREQ_TRANSITION_NOTIFIER);
+#endif
+	dsp_clk_exit();
+	services_exit();
+
+	return err;
+}
+
 static int __devinit omap34_xx_bridge_probe(struct platform_device *pdev)
 {
 	int status;
-	u32 init_status = 0;
 	dev_t dev = 0;
 	int result;
 #ifdef CONFIG_BRIDGE_DVFS
 	int i = 0;
 #endif
-	struct dspbridge_platform_data *pdata = pdev->dev.platform_data;
-	struct drv_data *drv_datap = NULL;
 
 	omap_dspbridge_dev = pdev;
 
 	/* Global bridge device */
 	bridge = &omap_dspbridge_dev->dev;
 
+	/* Bridge low level initializations */
+	status = omap3_bridge_startup(pdev);
+	if (status)
+		goto err1;
+
 	/* use 2.6 device model */
 	result = alloc_chrdev_region(&dev, 0, 1, driver_name);
 	if (result < 0) {
@@ -277,76 +379,6 @@ static int __devinit omap34_xx_bridge_probe(struct platform_device *pdev)
 	device_create(bridge_class, NULL, MKDEV(driver_major, 0),
 		      NULL, "DspBridge");
 
-#ifdef CONFIG_PM
-	/* Initialize the wait queue */
-	if (!status) {
-		bridge_suspend_data.suspended = 0;
-		init_waitqueue_head(&bridge_suspend_data.suspend_wq);
-	}
-#endif
-
-	dsp_clk_init();
-	services_init();
-
-	/*  Autostart flag.  This should be set to true if the DSP image should
-	 *  be loaded and run during bridge module initialization */
-	drv_datap = kzalloc(sizeof(struct drv_data), GFP_KERNEL);
-	if (drv_datap) {
-		drv_datap->shm_size = shm_size;
-		drv_datap->tc_wordswapon = tc_wordswapon;
-		if (base_img) {
-			drv_datap->base_img = kmalloc(strlen(base_img) + 1,
-								GFP_KERNEL);
-			if (drv_datap->base_img)
-				strncpy(drv_datap->base_img, base_img,
-							strlen(base_img) + 1);
-			else
-				status = -ENOMEM;
-		}
-	} else {
-		init_status = -ENOMEM;
-	}
-	if (shm_size < 0x10000) {	/* 64 KB */
-		init_status = -EINVAL;
-		status = -1;
-		pr_err("%s: shm size must be at least 64 KB\n", __func__);
-	}
-	dev_dbg(bridge, "%s: requested shm_size = 0x%x\n", __func__, shm_size);
-
-	if ((pdata->phys_mempool_base > 0) && (pdata->phys_mempool_size > 0))
-		mem_ext_phys_pool_init(pdata->phys_mempool_base,
-						pdata->phys_mempool_size);
-	if (tc_wordswapon)
-		dev_dbg(bridge, "%s: TC Word Swap is enabled\n", __func__);
-
-	if (DSP_SUCCEEDED(init_status)) {
-#ifdef CONFIG_BRIDGE_DVFS
-		for (i = 0; i < 6; i++)
-			pdata->mpu_speed[i] = vdd1_rate_table_bridge[i].rate;
-
-		if (!cpufreq_register_notifier(&iva_clk_notifier,
-						CPUFREQ_TRANSITION_NOTIFIER))
-			pr_err("%s: clk_notifier_register failed for iva2_ck\n",
-			       __func__);
-#endif
-		dev_set_drvdata(bridge, drv_datap);
-		driver_context = dsp_init(&init_status);
-		if (DSP_FAILED(init_status)) {
-			status = -1;
-			pr_err("DSP Bridge driver initialization failed\n");
-		} else {
-			pr_info("DSP Bridge driver loaded\n");
-		}
-	}
-
-#ifdef CONFIG_BRIDGE_RECOVERY
-	bridge_rec_queue = create_workqueue("bridge_rec_queue");
-	INIT_WORK(&bridge_recovery_work, bridge_recover);
-	INIT_COMPLETION(bridge_comp);
-#endif
-	DBC_ASSERT(status == 0);
-	DBC_ASSERT(DSP_SUCCEEDED(init_status));
-
 	return 0;
 
 err2:
-- 
1.7.1

