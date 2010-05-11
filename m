From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 3/6] omap: i2c: make errata 1.153 workaround a separate
	function
Date: Tue, 11 May 2010 11:35:14 -0700
Message-ID: <20100511183514.15596.77080.stgit@baageli.muru.com>
References: <20100511182854.15596.56293.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100511182854.15596.56293.stgit-XB442sTQ5VIxQTnqJstS8Q@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
Cc: Nishant Menon <nm-l0cyMroinI0@public.gmane.org>, Alexander Shishkin <virtuoso-0lOfPCoBze7YtjvyW6yDsg@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

From: Alexander Shishkin <virtuoso-0lOfPCoBze7YtjvyW6yDsg@public.gmane.org>

This is to avoid insanely long lines and levels of indentation.

Signed-off-by: Alexander Shishkin <virtuoso-0lOfPCoBze7YtjvyW6yDsg@public.gmane.org>
Cc: Nishant Menon <nm-l0cyMroinI0@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |   43 +++++++++++++++++++++++------------------
 1 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 42c0b91..ef73483 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -756,6 +756,27 @@ omap_i2c_rev1_isr(int this_irq, void *dev_id)
 #define omap_i2c_rev1_isr		NULL
 #endif
 
+/*
+ * OMAP3430 Errata 1.153: When an XRDY/XDR is hit, wait for XUDF before writing
+ * data to DATA_REG. Otherwise some data bytes can be lost while transferring
+ * them from the memory to the I2C interface.
+ */
+static int errata_omap3_1p153(struct omap_i2c_dev *dev, u16 *stat, int *err)
+{
+	while (!(*stat & OMAP_I2C_STAT_XUDF)) {
+		if (*stat & (OMAP_I2C_STAT_NACK | OMAP_I2C_STAT_AL)) {
+			omap_i2c_ack_stat(dev, *stat & (OMAP_I2C_STAT_XRDY |
+							OMAP_I2C_STAT_XDR));
+			*err |= OMAP_I2C_STAT_XUDF;
+			return -ETIMEDOUT;
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
@@ -885,25 +906,9 @@ complete:
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
+				if ((dev->rev <= OMAP_I2C_REV_ON_3430) &&
+				    errata_omap3_1p153(dev, &stat, &err))
+					goto complete;
 
 				omap_i2c_write_reg(dev, OMAP_I2C_DATA_REG, w);
 			}
