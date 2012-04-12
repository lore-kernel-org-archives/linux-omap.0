From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHv8 07/18] I2C: OMAP: Optimise the remove code
Date: Thu, 12 Apr 2012 18:36:24 +0530
Message-ID: <1334235995-6727-8-git-send-email-shubhrajyoti@ti.com>
References: <1334235995-6727-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52819 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932080Ab2DLNHQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Apr 2012 09:07:16 -0400
In-Reply-To: <1334235995-6727-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de, Shubhrajyoti D <shubhrajyoti@ti.com>

The omap_i2c_remove function may not be needed after
device exit so the memory could be freed.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 3670088..2096726 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1134,8 +1134,7 @@ err_release_region:
 	return r;
 }
 
-static int
-omap_i2c_remove(struct platform_device *pdev)
+static int __devexit omap_i2c_remove(struct platform_device *pdev)
 {
 	struct omap_i2c_dev	*dev = platform_get_drvdata(pdev);
 	struct resource		*mem;
@@ -1228,7 +1227,7 @@ static struct dev_pm_ops omap_i2c_pm_ops = {
 
 static struct platform_driver omap_i2c_driver = {
 	.probe		= omap_i2c_probe,
-	.remove		= omap_i2c_remove,
+	.remove		= __devexit_p(omap_i2c_remove),
 	.driver		= {
 		.name	= "omap_i2c",
 		.owner	= THIS_MODULE,
-- 
1.7.4.1

