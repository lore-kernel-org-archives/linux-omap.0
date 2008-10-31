From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [OMAP tree][RFC 2.6.28-rc2-omap 5/9] [Bluetooth] Switch brf6150 and hci_h4p to use gpio_request/free calls
Date: Fri, 31 Oct 2008 14:18:53 +0200
Message-ID: <1225455537-14017-6-git-send-email-jarkko.nikula@nokia.com>
References: <1225455537-14017-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:62539 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751262AbYJaMUL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 Oct 2008 08:20:11 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9VCJpla002330
	for <linux-omap@vger.kernel.org>; Fri, 31 Oct 2008 14:20:08 +0200
In-Reply-To: <1225455537-14017-1-git-send-email-jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 drivers/bluetooth/brf6150.c      |   26 +++++++++++++-------------
 drivers/bluetooth/hci_h4p/core.c |   26 +++++++++++++-------------
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/bluetooth/brf6150.c b/drivers/bluetooth/brf6150.c
index 256ecde..2d22aec 100644
--- a/drivers/bluetooth/brf6150.c
+++ b/drivers/bluetooth/brf6150.c
@@ -33,9 +33,9 @@
 #include <linux/timer.h>
 #include <linux/clk.h>
 #include <linux/platform_device.h>
+#include <linux/gpio.h>
 
 #include <mach/hardware.h>
-#include <mach/gpio.h>
 #include <mach/board.h>
 #include <mach/irqs.h>
 
@@ -913,7 +913,7 @@ static int __init brf6150_init(void)
 	NBT_DBG("Uart: %d\n", info->btinfo->bt_uart);
 	NBT_DBG("sysclk: %d\n", info->btinfo->bt_sysclk);
 
-	err = omap_request_gpio(info->btinfo->reset_gpio);
+	err = gpio_request(info->btinfo->reset_gpio, "BT reset");
 	if (err < 0)
 	{
 		printk(KERN_WARNING "Cannot get GPIO line %d", 
@@ -922,23 +922,23 @@ static int __init brf6150_init(void)
 		return err;
 	}
 
-	err = omap_request_gpio(info->btinfo->bt_wakeup_gpio);
+	err = gpio_request(info->btinfo->bt_wakeup_gpio, "BT wakeup");
 	if (err < 0)
 	{
 		printk(KERN_WARNING "Cannot get GPIO line 0x%d",
 		       info->btinfo->bt_wakeup_gpio);
-		omap_free_gpio(info->btinfo->reset_gpio);
+		gpio_free(info->btinfo->reset_gpio);
 		kfree(info);
 		return err;
 	}
 
-	err = omap_request_gpio(info->btinfo->host_wakeup_gpio);
+	err = gpio_request(info->btinfo->host_wakeup_gpio, "BT host wakeup");
 	if (err < 0)
 	{
 		printk(KERN_WARNING "Cannot get GPIO line %d",
 		       info->btinfo->host_wakeup_gpio);
-		omap_free_gpio(info->btinfo->reset_gpio);
-		omap_free_gpio(info->btinfo->bt_wakeup_gpio);
+		gpio_free(info->btinfo->reset_gpio);
+		gpio_free(info->btinfo->bt_wakeup_gpio);
 		kfree(info);
 		return err;
 	}
@@ -1022,9 +1022,9 @@ cleanup_irq:
 	free_irq(irq, (void *)info);
 	free_irq(gpio_to_irq(info->btinfo->host_wakeup_gpio), (void *)info);
 cleanup:
-	omap_free_gpio(info->btinfo->reset_gpio);
-	omap_free_gpio(info->btinfo->bt_wakeup_gpio);
-	omap_free_gpio(info->btinfo->host_wakeup_gpio);
+	gpio_free(info->btinfo->reset_gpio);
+	gpio_free(info->btinfo->bt_wakeup_gpio);
+	gpio_free(info->btinfo->host_wakeup_gpio);
 	kfree(info);
 
 	return err;
@@ -1034,9 +1034,9 @@ static void __exit brf6150_exit(void)
 {
 	brf6150_hci_close(exit_info->hdev);
 	hci_free_dev(exit_info->hdev);
-	omap_free_gpio(exit_info->btinfo->reset_gpio);
-	omap_free_gpio(exit_info->btinfo->bt_wakeup_gpio);
-	omap_free_gpio(exit_info->btinfo->host_wakeup_gpio);
+	gpio_free(exit_info->btinfo->reset_gpio);
+	gpio_free(exit_info->btinfo->bt_wakeup_gpio);
+	gpio_free(exit_info->btinfo->host_wakeup_gpio);
 	free_irq(exit_info->irq, (void *)exit_info);
 	free_irq(gpio_to_irq(exit_info->btinfo->host_wakeup_gpio), (void *)exit_info);
 	kfree(exit_info);
diff --git a/drivers/bluetooth/hci_h4p/core.c b/drivers/bluetooth/hci_h4p/core.c
index 9964a0c..a5b76ad 100644
--- a/drivers/bluetooth/hci_h4p/core.c
+++ b/drivers/bluetooth/hci_h4p/core.c
@@ -34,9 +34,9 @@
 #include <linux/device.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
+#include <linux/gpio.h>
 
 #include <mach/hardware.h>
-#include <mach/gpio.h>
 #include <mach/board.h>
 #include <mach/irqs.h>
 #include <mach/pm.h>
@@ -823,7 +823,7 @@ static int hci_h4p_probe(struct platform_device *pdev)
 	NBT_DBG("Uart: %d\n", bt_config->bt_uart);
 	NBT_DBG("sysclk: %d\n", info->bt_sysclk);
 
-	err = omap_request_gpio(info->reset_gpio);
+	err = gpio_request(info->reset_gpio, "BT reset");
 	if (err < 0) {
 		dev_err(&pdev->dev, "Cannot get GPIO line %d\n",
 			info->reset_gpio);
@@ -831,23 +831,23 @@ static int hci_h4p_probe(struct platform_device *pdev)
 		goto cleanup;
 	}
 
-	err = omap_request_gpio(info->bt_wakeup_gpio);
+	err = gpio_request(info->bt_wakeup_gpio, "BT wakeup");
 	if (err < 0)
 	{
 		dev_err(info->dev, "Cannot get GPIO line 0x%d",
 			info->bt_wakeup_gpio);
-		omap_free_gpio(info->reset_gpio);
+		gpio_free(info->reset_gpio);
 		kfree(info);
 		goto cleanup;
 	}
 
-	err = omap_request_gpio(info->host_wakeup_gpio);
+	err = gpio_request(info->host_wakeup_gpio, "BT host wakeup");
 	if (err < 0)
 	{
 		dev_err(info->dev, "Cannot get GPIO line %d",
 		       info->host_wakeup_gpio);
-		omap_free_gpio(info->reset_gpio);
-		omap_free_gpio(info->bt_wakeup_gpio);
+		gpio_free(info->reset_gpio);
+		gpio_free(info->bt_wakeup_gpio);
 		kfree(info);
 		goto cleanup;
 	}
@@ -953,9 +953,9 @@ cleanup_irq:
 	free_irq(gpio_to_irq(info->host_wakeup_gpio), (void *)info);
 cleanup:
 	gpio_set_value(info->reset_gpio, 0);
-	omap_free_gpio(info->reset_gpio);
-	omap_free_gpio(info->bt_wakeup_gpio);
-	omap_free_gpio(info->host_wakeup_gpio);
+	gpio_free(info->reset_gpio);
+	gpio_free(info->bt_wakeup_gpio);
+	gpio_free(info->host_wakeup_gpio);
 	kfree(info);
 
 	return err;
@@ -971,9 +971,9 @@ static int hci_h4p_remove(struct platform_device *dev)
 	hci_h4p_hci_close(info->hdev);
 	free_irq(gpio_to_irq(info->host_wakeup_gpio), (void *) info);
 	hci_free_dev(info->hdev);
-	omap_free_gpio(info->reset_gpio);
-	omap_free_gpio(info->bt_wakeup_gpio);
-	omap_free_gpio(info->host_wakeup_gpio);
+	gpio_free(info->reset_gpio);
+	gpio_free(info->bt_wakeup_gpio);
+	gpio_free(info->host_wakeup_gpio);
 	free_irq(info->irq, (void *) info);
 	kfree(info);
 
-- 
1.5.6.5

