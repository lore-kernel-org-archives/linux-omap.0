From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH v2] omap-serial: Fix the error handling in the omap_serial probe
Date: Wed, 21 Mar 2012 17:22:22 +0530
Message-ID: <1332330742-22375-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40872 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863Ab2CULwe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Mar 2012 07:52:34 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Shubhrajyoti D <shubhrajyoti@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Govindraj.R" <govindraj.raja@ti.com>

The patch does the following

- The pm_runtime_disable is called in the remove not in the error
  case of probe.The patch calls the pm_runtime_disable in the error
  case.
- Calls pm_runtime_put in the error case.
- The  up is not freed in the error path. Fix the memory leak by using
  devm_* so that the memory need not be freed in the driver.
- Also the iounmap is not called fix the same by calling using devm_ioremap.
- Make the name of the error tags more meaningful.

Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Govindraj.R <govindraj.raja@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
Changes from the v1:
Use devm_* functions instead of freeing in the driver.

 drivers/tty/serial/omap-serial.c |   43 +++++++++++++++++--------------------
 1 files changed, 20 insertions(+), 23 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 1e193fc..5386239 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1381,29 +1381,24 @@ static int serial_omap_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	if (!request_mem_region(mem->start, resource_size(mem),
+	if (!devm_request_mem_region(&pdev->dev, mem->start, resource_size(mem),
 				pdev->dev.driver->name)) {
 		dev_err(&pdev->dev, "memory region already claimed\n");
 		return -EBUSY;
 	}
 
 	dma_rx = platform_get_resource_byname(pdev, IORESOURCE_DMA, "rx");
-	if (!dma_rx) {
-		ret = -EINVAL;
-		goto err;
-	}
+	if (!dma_rx)
+		return -ENXIO;
 
 	dma_tx = platform_get_resource_byname(pdev, IORESOURCE_DMA, "tx");
-	if (!dma_tx) {
-		ret = -EINVAL;
-		goto err;
-	}
+	if (!dma_tx)
+		return -ENXIO;
+
+	up = devm_kzalloc(&pdev->dev, sizeof(*up), GFP_KERNEL);
+	if (!up)
+		return -ENOMEM;
 
-	up = kzalloc(sizeof(*up), GFP_KERNEL);
-	if (up == NULL) {
-		ret = -ENOMEM;
-		goto do_release_region;
-	}
 	up->pdev = pdev;
 	up->port.dev = &pdev->dev;
 	up->port.type = PORT_OMAP;
@@ -1423,16 +1418,17 @@ static int serial_omap_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "failed to get alias/pdev id, errno %d\n",
 								up->port.line);
 		ret = -ENODEV;
-		goto err;
+		goto err_port_line;
 	}
 
 	sprintf(up->name, "OMAP UART%d", up->port.line);
 	up->port.mapbase = mem->start;
-	up->port.membase = ioremap(mem->start, resource_size(mem));
+	up->port.membase = devm_ioremap(&pdev->dev, mem->start,
+						resource_size(mem));
 	if (!up->port.membase) {
 		dev_err(&pdev->dev, "can't ioremap UART\n");
 		ret = -ENOMEM;
-		goto err;
+		goto err_ioremap;
 	}
 
 	up->port.flags = omap_up_info->flags;
@@ -1478,16 +1474,19 @@ static int serial_omap_probe(struct platform_device *pdev)
 
 	ret = uart_add_one_port(&serial_omap_reg, &up->port);
 	if (ret != 0)
-		goto do_release_region;
+		goto err_add_port;
 
 	pm_runtime_put(&pdev->dev);
 	platform_set_drvdata(pdev, up);
 	return 0;
-err:
+
+err_add_port:
+	pm_runtime_put(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+err_ioremap:
+err_port_line:
 	dev_err(&pdev->dev, "[UART%d]: failure [%s]: %d\n",
 				pdev->id, __func__, ret);
-do_release_region:
-	release_mem_region(mem->start, resource_size(mem));
 	return ret;
 }
 
@@ -1499,8 +1498,6 @@ static int serial_omap_remove(struct platform_device *dev)
 		pm_runtime_disable(&up->pdev->dev);
 		uart_remove_one_port(&serial_omap_reg, &up->port);
 		pm_qos_remove_request(&up->pm_qos_request);
-
-		kfree(up);
 	}
 
 	platform_set_drvdata(dev, NULL);
-- 
1.7.1

