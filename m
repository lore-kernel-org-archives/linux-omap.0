From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] i2c: busses: constify dev_pm_ops structures
Date: Sun, 15 Jan 2017 15:29:41 +0530
Message-ID: <1484474381-1064-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Sender: linux-i2c-owner@vger.kernel.org
To: julia.lawall@lip6.fr, tony@atomide.com, wsa@the-dreams.de, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: linux-omap@vger.kernel.org

Declare dev_pm_ops structures as const as they are only stored in the pm
field of a device_driver structure. This field is of type const, so
dev_pm_ops structures having similar properties can be declared const
too.

File size before: drivers/i2c/busses/i2c-omap.o
   text	   data	    bss	    dec	    hex	filename
   6814	    584	      0	   7398	   1ce6	drivers/i2c/busses/i2c-omap.o

File size after: drivers/i2c/busses/i2c-omap.o
   text	   data	    bss	    dec	    hex	filename
   7006	    392	      0	   7398	   1ce6	drivers/i2c/busses/i2c-omap.o

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/i2c/busses/i2c-omap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index c7da0c4..1ebb5e9 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1504,7 +1504,7 @@ static int omap_i2c_runtime_resume(struct device *dev)
 	return 0;
 }
 
-static struct dev_pm_ops omap_i2c_pm_ops = {
+static const struct dev_pm_ops omap_i2c_pm_ops = {
 	SET_RUNTIME_PM_OPS(omap_i2c_runtime_suspend,
 			   omap_i2c_runtime_resume, NULL)
 };
-- 
1.9.1
