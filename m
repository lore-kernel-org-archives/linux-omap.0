From: Manjunatha GK <manjugk-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] OMAP3: I2C: Clean up Errata 1p153 handling
Date: Wed, 28 Apr 2010 20:28:59 +0530
Message-ID: <1272466739-2847-1-git-send-email-manjugk@ti.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Alexander Shishkin <virtuoso-0lOfPCoBze7YtjvyW6yDsg@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Clean up existing Errata 1p153 handling to use generic
errata handling mechanism through dev flag.

Signed-off-by: Manjunatha GK <manjugk-l0cyMroinI0@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Alexander Shishkin <virtuoso-0lOfPCoBze7YtjvyW6yDsg@public.gmane.org>
---
 PS : This patch has dependency on the patch:
 https://patchwork.kernel.org/patch/95616/

 drivers/i2c/busses/i2c-omap.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 5f5207e..0caa8fe 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -168,6 +168,7 @@ enum {
 
 /* Errata definitions */
 #define I2C_OMAP_ERRATA_I207		(1 << 0)
+#define I2C_OMAP3_1P153			(1 << 1)
 
 struct omap_i2c_dev {
 	struct device		*dev;
@@ -946,7 +947,7 @@ complete:
 					break;
 				}
 
-				if ((dev->rev <= OMAP_I2C_REV_ON_3430) &&
+				if ((dev->errata & I2C_OMAP3_1P153) &&
 				    errata_omap3_1p153(dev, &stat, &err))
 					goto complete;
 
@@ -1049,6 +1050,9 @@ omap_i2c_probe(struct platform_device *pdev)
 
 	dev->rev = omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) & 0xff;
 
+	if (dev->rev <= OMAP_I2C_REV_ON_3430)
+		dev->errata |= I2C_OMAP3_1P153;
+
 	if (!(cpu_class_is_omap1() || cpu_is_omap2420())) {
 		u16 s;
 
-- 
1.6.0.4
