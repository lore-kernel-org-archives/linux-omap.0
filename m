From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHv11 1/6] i2c: omap: Optimise the remove code
Date: Thu, 28 Jun 2012 20:41:27 +0530
Message-ID: <1340896292-12112-2-git-send-email-shubhrajyoti@ti.com>
References: <1340896292-12112-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35299 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754381Ab2F1PMY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jun 2012 11:12:24 -0400
In-Reply-To: <1340896292-12112-1-git-send-email-shubhrajyoti@ti.com>
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
index 9895fa7..b086076 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1102,8 +1102,7 @@ err_release_region:
 	return r;
 }
 
-static int
-omap_i2c_remove(struct platform_device *pdev)
+static int __devexit omap_i2c_remove(struct platform_device *pdev)
 {
 	struct omap_i2c_dev	*dev = platform_get_drvdata(pdev);
 	struct resource		*mem;
@@ -1187,7 +1186,7 @@ static struct dev_pm_ops omap_i2c_pm_ops = {
 
 static struct platform_driver omap_i2c_driver = {
 	.probe		= omap_i2c_probe,
-	.remove		= omap_i2c_remove,
+	.remove		= __devexit_p(omap_i2c_remove),
 	.driver		= {
 		.name	= "omap_i2c",
 		.owner	= THIS_MODULE,
-- 
1.7.5.4

