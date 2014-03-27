From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] i2c: omap: fix usage of IS_ERR_VALUE with pm_runtime_get_sync
Date: Thu, 27 Mar 2014 11:18:33 -0500
Message-ID: <1395937113-10222-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

we use IS_ERR_VALUE to check for error values of pm_runtime_get_sync,
when the value can only be < 0 in the case of err. Replace the
check with a simpler < 0 check.

This fixes the coccicheck warnings:
linux-2.6/drivers/i2c/busses/i2c-omap.c:1157:5-24:
pm_runtime_get_sync returns < 0 as error. Unecessary IS_ERR_VALUE at
line 1158
linux-2.6/drivers/i2c/busses/i2c-omap.c:1278:7-26:
pm_runtime_get_sync returns < 0 as error. Unecessary IS_ERR_VALUE at
line 1279
drivers/i2c/busses/i2c-omap.c:638:5-24:
pm_runtime_get_sync returns < 0 as error. Unecessary IS_ERR_VALUE at
line 639

Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
---
Patch based on: v3.14-rc8
coccicheck report based on next-20140326 tag

 drivers/i2c/busses/i2c-omap.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 90dcc2e..078a3de 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -636,7 +636,7 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	int r;
 
 	r = pm_runtime_get_sync(dev->dev);
-	if (IS_ERR_VALUE(r))
+	if (r < 0)
 		goto out;
 
 	r = omap_i2c_wait_for_bb(dev);
@@ -1155,7 +1155,7 @@ omap_i2c_probe(struct platform_device *pdev)
 	pm_runtime_use_autosuspend(dev->dev);
 
 	r = pm_runtime_get_sync(dev->dev);
-	if (IS_ERR_VALUE(r))
+	if (r < 0)
 		goto err_free_mem;
 
 	/*
@@ -1276,7 +1276,7 @@ static int omap_i2c_remove(struct platform_device *pdev)
 
 	i2c_del_adapter(&dev->adapter);
 	ret = pm_runtime_get_sync(&pdev->dev);
-	if (IS_ERR_VALUE(ret))
+	if (ret < 0)
 		return ret;
 
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
-- 
1.7.9.5
