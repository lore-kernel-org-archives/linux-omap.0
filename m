From: Balaji T K <balajitk@ti.com>
Subject: [PATCH] i2c-omap: fix build for !CONFIG_SUSPEND
Date: Tue, 22 Feb 2011 12:25:39 +0530
Message-ID: <1298357739-5132-1-git-send-email-balajitk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34745 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751578Ab1BVGxL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Feb 2011 01:53:11 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-i2c@vger.kernel.org, ben-linux@fluff.org
Cc: linux-omap@vger.kernel.org, khilman@ti.com, Balaji T K <balajitk@ti.com>

fix the build break when !CONFIG_SUSPEND

drivers/i2c/busses/i2c-omap.c:1173: error: lvalue required as unary '&' operand
make[3]: *** [drivers/i2c/busses/i2c-omap.o] Error 1
make[2]: *** [drivers/i2c/busses] Error 2
make[1]: *** [drivers/i2c] Error 2
make: *** [drivers] Error 2

Signed-off-by: Balaji T K <balajitk@ti.com>
---
introduced by commit f6f98d72575031b0c03416a28a0d580128114b74
applies on i2c-fixes branch

 drivers/i2c/busses/i2c-omap.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 0541df9..adc1ee5 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1160,8 +1160,9 @@ static struct dev_pm_ops omap_i2c_pm_ops = {
 	.suspend = omap_i2c_suspend,
 	.resume = omap_i2c_resume,
 };
+#define OMAP_I2C_PM_OPS (&omap_i2c_pm_ops)
 #else
-#define omap_i2c_pm_ops NULL
+#define OMAP_I2C_PM_OPS NULL
 #endif
 
 static struct platform_driver omap_i2c_driver = {
@@ -1170,7 +1171,7 @@ static struct platform_driver omap_i2c_driver = {
 	.driver		= {
 		.name	= "omap_i2c",
 		.owner	= THIS_MODULE,
-		.pm     = &omap_i2c_pm_ops,
+		.pm	= OMAP_I2C_PM_OPS,
 	},
 };
 
-- 
1.7.0.4

