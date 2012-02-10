From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH 07/10] OMAP: I2C: add devexit to the remove code
Date: Fri, 10 Feb 2012 19:30:02 +0530
Message-ID: <1328882405-15284-8-git-send-email-shubhrajyoti@ti.com>
References: <1328882405-15284-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60958 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758749Ab2BJOAu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Feb 2012 09:00:50 -0500
In-Reply-To: <1328882405-15284-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khali@linux-fr.org, Shubhrajyoti D <shubhrajyoti@ti.com>, Ben Dooks <ben-linux@fluff.org>, Kevin Hilman <khilman@ti.com>

The omap_i2c_remove function may not be needed after
device exit so the memory could be freed.

Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Kevin Hilman <khilman@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
Previous discurssion 
http://www.mail-archive.com/linux-i2c@vger.kernel.org/msg06976.html

 drivers/i2c/busses/i2c-omap.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index cb9d4f8..fd77cd2 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1132,8 +1132,7 @@ err_release_region:
 	return r;
 }
 
-static int
-omap_i2c_remove(struct platform_device *pdev)
+static int __devexit omap_i2c_remove(struct platform_device *pdev)
 {
 	struct omap_i2c_dev	*dev = platform_get_drvdata(pdev);
 	struct resource		*mem;
@@ -1222,7 +1221,7 @@ static struct dev_pm_ops omap_i2c_pm_ops = {
 
 static struct platform_driver omap_i2c_driver = {
 	.probe		= omap_i2c_probe,
-	.remove		= omap_i2c_remove,
+	.remove		= __devexit_p(omap_i2c_remove),
 	.driver		= {
 		.name	= "omap_i2c",
 		.owner	= THIS_MODULE,
-- 
1.7.1

