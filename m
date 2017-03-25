From: Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH 3/7] usb: dwc3: core: change goto labels to meaningful names
Date: Fri, 24 Mar 2017 18:05:01 -0600
Message-ID: <f47d57e54d834cf3194d3176f14f9f2a56856233.1490387086.git.shuahkh@osg.samsung.com>
References: <cover.1490387086.git.shuahkh@osg.samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <cover.1490387086.git.shuahkh@osg.samsung.com>
In-Reply-To: <cover.1490387086.git.shuahkh@osg.samsung.com>
References: <cover.1490387086.git.shuahkh@osg.samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: balbi@kernel.org, gregkh@linuxfoundation.org, kgene@kernel.org, krzk@kernel.org, javier@osg.samsung.com
Cc: Shuah Khan <shuahkh@osg.samsung.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Change goto labels to meaningful names.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 drivers/usb/dwc3/core.c | 62 ++++++++++++++++++++++++-------------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 0fc7bef..f82786a 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -347,7 +347,7 @@ static int dwc3_setup_scratch_buffers(struct dwc3 *dwc)
 	if (dma_mapping_error(dwc->sysdev, scratch_addr)) {
 		dev_err(dwc->sysdev, "failed to map scratch buffer\n");
 		ret = -EFAULT;
-		goto err0;
+		goto return_err;
 	}
 
 	dwc->scratch_addr = scratch_addr;
@@ -357,22 +357,22 @@ static int dwc3_setup_scratch_buffers(struct dwc3 *dwc)
 	ret = dwc3_send_gadget_generic_command(dwc,
 			DWC3_DGCMD_SET_SCRATCHPAD_ADDR_LO, param);
 	if (ret < 0)
-		goto err1;
+		goto unmap_scratchbuf;
 
 	param = upper_32_bits(scratch_addr);
 
 	ret = dwc3_send_gadget_generic_command(dwc,
 			DWC3_DGCMD_SET_SCRATCHPAD_ADDR_HI, param);
 	if (ret < 0)
-		goto err1;
+		goto unmap_scratchbuf;
 
 	return 0;
 
-err1:
+unmap_scratchbuf:
 	dma_unmap_single(dwc->sysdev, dwc->scratch_addr, dwc->nr_scratch *
 			DWC3_SCRATCHBUF_SIZE, DMA_BIDIRECTIONAL);
 
-err0:
+return_err:
 	return ret;
 }
 
@@ -669,7 +669,7 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	if (!dwc3_core_is_valid(dwc)) {
 		dev_err(dwc->dev, "this is not a DesignWare USB3 DRD Core\n");
 		ret = -ENODEV;
-		goto err0;
+		goto return_err;
 	}
 
 	/*
@@ -687,18 +687,18 @@ static int dwc3_core_init(struct dwc3 *dwc)
 
 	ret = dwc3_core_soft_reset(dwc);
 	if (ret)
-		goto err0;
+		goto return_err;
 
 	ret = dwc3_phy_setup(dwc);
 	if (ret)
-		goto err0;
+		goto return_err;
 
 	dwc3_core_setup_global_control(dwc);
 	dwc3_core_num_eps(dwc);
 
 	ret = dwc3_setup_scratch_buffers(dwc);
 	if (ret)
-		goto err1;
+		goto phy_shutdown_exit;
 
 	/* Adjust Frame Length */
 	dwc3_frame_length_adjustment(dwc);
@@ -707,16 +707,16 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	usb_phy_set_suspend(dwc->usb3_phy, 0);
 	ret = phy_power_on(dwc->usb2_generic_phy);
 	if (ret < 0)
-		goto err2;
+		goto phy_suspend;
 
 	ret = phy_power_on(dwc->usb3_generic_phy);
 	if (ret < 0)
-		goto err3;
+		goto usb2_phy_poweroff;
 
 	ret = dwc3_event_buffers_setup(dwc);
 	if (ret) {
 		dev_err(dwc->dev, "failed to setup event buffers\n");
-		goto err4;
+		goto usb3_phy_poweroff;
 	}
 
 	switch (dwc->dr_mode) {
@@ -757,23 +757,23 @@ static int dwc3_core_init(struct dwc3 *dwc)
 
 	return 0;
 
-err4:
+usb3_phy_poweroff:
 	phy_power_off(dwc->usb3_generic_phy);
 
-err3:
+usb2_phy_poweroff:
 	phy_power_off(dwc->usb2_generic_phy);
 
-err2:
+phy_suspend:
 	usb_phy_set_suspend(dwc->usb2_phy, 1);
 	usb_phy_set_suspend(dwc->usb3_phy, 1);
 
-err1:
+phy_shutdown_exit:
 	usb_phy_shutdown(dwc->usb2_phy);
 	usb_phy_shutdown(dwc->usb3_phy);
 	phy_exit(dwc->usb2_generic_phy);
 	phy_exit(dwc->usb3_generic_phy);
 
-err0:
+return_err:
 	return ret;
 }
 
@@ -1091,7 +1091,7 @@ static int dwc3_probe(struct platform_device *pdev)
 	regs = devm_ioremap_resource(dev, res);
 	if (IS_ERR(regs)) {
 		ret = PTR_ERR(regs);
-		goto err0;
+		goto restore_res_start;
 	}
 
 	dwc->regs	= regs;
@@ -1104,7 +1104,7 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	ret = dwc3_core_get_phy(dwc);
 	if (ret)
-		goto err0;
+		goto restore_res_start;
 
 	spin_lock_init(&dwc->lock);
 
@@ -1114,7 +1114,7 @@ static int dwc3_probe(struct platform_device *pdev)
 	pm_runtime_enable(dev);
 	ret = pm_runtime_get_sync(dev);
 	if (ret < 0)
-		goto err1;
+		goto runtime_disable;
 
 	pm_runtime_forbid(dev);
 
@@ -1122,52 +1122,52 @@ static int dwc3_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(dwc->dev, "failed to allocate event buffers\n");
 		ret = -ENOMEM;
-		goto err2;
+		goto runtime_allow_put_sync;
 	}
 
 	ret = dwc3_get_dr_mode(dwc);
 	if (ret)
-		goto err3;
+		goto ulpi_exit;
 
 	ret = dwc3_alloc_scratch_buffers(dwc);
 	if (ret)
-		goto err3;
+		goto ulpi_exit;
 
 	ret = dwc3_core_init(dwc);
 	if (ret) {
 		dev_err(dev, "failed to initialize core\n");
-		goto err4;
+		goto free_scratchbufs;
 	}
 
 	dwc3_check_params(dwc);
 
 	ret = dwc3_core_init_mode(dwc);
 	if (ret)
-		goto err5;
+		goto event_buffers_cleanup;
 
 	dwc3_debugfs_init(dwc);
 	pm_runtime_put(dev);
 
 	return 0;
 
-err5:
+event_buffers_cleanup:
 	dwc3_event_buffers_cleanup(dwc);
 
-err4:
+free_scratchbufs:
 	dwc3_free_scratch_buffers(dwc);
 
-err3:
+ulpi_exit:
 	dwc3_free_event_buffers(dwc);
 	dwc3_ulpi_exit(dwc);
 
-err2:
+runtime_allow_put_sync:
 	pm_runtime_allow(&pdev->dev);
 	pm_runtime_put_sync(&pdev->dev);
 
-err1:
+runtime_disable:
 	pm_runtime_disable(&pdev->dev);
 
-err0:
+restore_res_start:
 	/*
 	 * restore res->start back to its original value so that, in case the
 	 * probe is deferred, we don't end up getting error in request the
-- 
2.7.4
