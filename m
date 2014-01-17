From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v4 2/2] usb: musb: dsps, use devm_kzalloc
Date: Fri, 17 Jan 2014 10:22:36 +0100
Message-ID: <1389950556-6453-3-git-send-email-mpa@pengutronix.de>
References: <1389950556-6453-1-git-send-email-mpa@pengutronix.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55663 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752349AbaAQJWt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Jan 2014 04:22:49 -0500
In-Reply-To: <1389950556-6453-1-git-send-email-mpa@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Bin Liu <binmlist@gmail.com>, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, kernel@pengutronix.de, Markus Pargmann <mpa@pengutronix.de>

Replace kzalloc by devm_kzalloc and remove the kfree() calls.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/usb/musb/musb_dsps.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index d0a97d6..6cae0c8 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -668,7 +668,7 @@ static int dsps_probe(struct platform_device *pdev)
 	wrp = match->data;
 
 	/* allocate glue */
-	glue = kzalloc(sizeof(*glue), GFP_KERNEL);
+	glue = devm_kzalloc(&pdev->dev, sizeof(*glue), GFP_KERNEL);
 	if (!glue) {
 		dev_err(&pdev->dev, "unable to allocate glue memory\n");
 		return -ENOMEM;
@@ -696,7 +696,6 @@ err3:
 	pm_runtime_put(&pdev->dev);
 err2:
 	pm_runtime_disable(&pdev->dev);
-	kfree(glue);
 	return ret;
 }
 
@@ -709,7 +708,6 @@ static int dsps_remove(struct platform_device *pdev)
 	/* disable usbss clocks */
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-	kfree(glue);
 
 	debugfs_remove_recursive(glue->dbgfs_root);
 
-- 
1.8.5.2

