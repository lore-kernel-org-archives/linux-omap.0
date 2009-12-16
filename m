From: Alexander Shishkin <virtuoso-0lOfPCoBze7YtjvyW6yDsg@public.gmane.org>
Subject: [PATCH 1/2] omap i2c: make errata 1.153 workaround a separate function
Date: Wed, 16 Dec 2009 16:02:23 +0200
Message-ID: <1260972144-31593-2-git-send-email-virtuoso@slind.org>
References: <1260972144-31593-1-git-send-email-virtuoso@slind.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1260972144-31593-1-git-send-email-virtuoso-0lOfPCoBze7YtjvyW6yDsg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexander Shishkin <virtuoso-0lOfPCoBze7YtjvyW6yDsg@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This is to avoid insanely long lines and levels of indentation.

Signed-off-by: Alexander Shishkin <virtuoso-0lOfPCoBze7YtjvyW6yDsg@public.gmane.org>
CC: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
CC: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
---
 drivers/i2c/busses/i2c-omap.c |   43 ++++++++++++++++++++++------------------
 1 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 75bf3ad..ad8242a 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -671,6 +671,27 @@ omap_i2c_rev1_isr(int this_irq, void *dev_id)
 #define omap_i2c_rev1_isr		NULL
 #endif
 
+/*
+ * OMAP3430 Errata 1.153: When an XRDY/XDR is hit, wait for XUDF before writing
+ * data to DATA_REG. Otherwise some data bytes can be lost while transferring
+ * them from the memory to the I2C interface.
+ */
+static int omap3430_workaround(struct omap_i2c_dev *dev, u16 *stat, int *err)
+{
+	while (!(*stat & OMAP_I2C_STAT_XUDF)) {
+		if (*stat & (OMAP_I2C_STAT_NACK | OMAP_I2C_STAT_AL)) {
+			omap_i2c_ack_stat(dev, *stat & (OMAP_I2C_STAT_XRDY |
+							OMAP_I2C_STAT_XDR));
+			*err |= OMAP_I2C_STAT_XUDF;
+			return -1;
+		}
+		cpu_relax();
+		*stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
+	}
+
+	return 0;
+}
+
 static irqreturn_t
 omap_i2c_isr(int this_irq, void *dev_id)
 {
@@ -794,25 +815,9 @@ complete:
 					break;
 				}
 
-				/*
-				 * OMAP3430 Errata 1.153: When an XRDY/XDR
-				 * is hit, wait for XUDF before writing data
-				 * to DATA_REG. Otherwise some data bytes can
-				 * be lost while transferring them from the
-				 * memory to the I2C interface.
-				 */
-
-				if (dev->rev <= OMAP_I2C_REV_ON_3430) {
-						while (!(stat & OMAP_I2C_STAT_XUDF)) {
-							if (stat & (OMAP_I2C_STAT_NACK | OMAP_I2C_STAT_AL)) {
-								omap_i2c_ack_stat(dev, stat & (OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR));
-								err |= OMAP_I2C_STAT_XUDF;
-								goto complete;
-							}
-							cpu_relax();
-							stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
-						}
-				}
+				if (dev->rev <= OMAP_I2C_REV_ON_3430 &&
+				    omap3430_workaround(dev, &stat, &err))
+					goto complete;
 
 				omap_i2c_write_reg(dev, OMAP_I2C_DATA_REG, w);
 			}
-- 
1.6.3.3
