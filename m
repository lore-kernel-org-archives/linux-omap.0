From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 2/2] mfd: twl-core: convert to module_i2c_driver()
Date: Tue, 23 Apr 2013 16:19:10 +0300
Message-ID: <1366723151-23209-3-git-send-email-grygorii.strashko@ti.com>
References: <1366723151-23209-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1366723151-23209-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Samuel Ortiz <sameo@linux.intel.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Shift TWL initialization to module/device init layer, because I2C now is
not initialized on subsys init layer and shifted to module/device init
layer instead.

The I2C <--> TWL dependency should be resolved in drivers/Makefile now.

Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/mfd/twl-core.c |   12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 4f3baad..f01340d 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -1347,17 +1347,7 @@ static struct i2c_driver twl_driver = {
 	.remove		= twl_remove,
 };
 
-static int __init twl_init(void)
-{
-	return i2c_add_driver(&twl_driver);
-}
-subsys_initcall(twl_init);
-
-static void __exit twl_exit(void)
-{
-	i2c_del_driver(&twl_driver);
-}
-module_exit(twl_exit);
+module_i2c_driver(twl_driver);
 
 MODULE_AUTHOR("Texas Instruments, Inc.");
 MODULE_DESCRIPTION("I2C Core interface for TWL");
-- 
1.7.9.5
