From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH RFC] MFD: OMAP: USB: Make the runtime functions depend on CONFIG_PM_RUNTIME
Date: Tue, 3 Jan 2012 12:12:59 +0530
Message-ID: <1325572979-6090-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45570 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751019Ab2ACGnL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 3 Jan 2012 01:43:11 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Shubhrajyoti D <shubhrajyoti@ti.com>

Currently the runtime functions are compiled regardless
of CONFIG_PM_RUNTIME flag. This patch intends to fix the same by
using SET_RUNTIME_PM_OPS.

Cc : Keshava Munegowda <keshava_mgowda@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
applies on Tony's ehci branch.
Compile tested only.

 drivers/mfd/omap-usb-host.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 3f565ef..ef72ebe 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -887,8 +887,8 @@ static int __devexit usbhs_omap_remove(struct platform_device *pdev)
 }
 
 static const struct dev_pm_ops usbhsomap_dev_pm_ops = {
-	.runtime_suspend	= usbhs_runtime_suspend,
-	.runtime_resume		= usbhs_runtime_resume,
+	SET_RUNTIME_PM_OPS(usbhs_runtime_suspend,
+				usbhs_runtime_resume, NULL)
 };
 
 static struct platform_driver usbhs_omap_driver = {
-- 
1.7.1

