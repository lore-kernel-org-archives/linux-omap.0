From: "Sonasath, Moiz" <m-sonasath-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 3/3] [OMAP:I2C]OMAP3430 Silicon Errata 1.153
Date: Tue, 21 Jul 2009 10:15:12 -0500
Message-ID: <CD8CC2B65FEE304DA95744A5472698F202958D2F89@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

When an XRDY/XDR is hit, wait for XUDF before writing data to DATA_REG.
Otherwise some data bytes can be lost while transferring them from the
memory to the I2C interface.

Do a Busy-wait for XUDF, before writing data to DATA_REG. While waiting
if there is NACK | AL, set the appropriate error flags, ack the pending
interrupts and return from the ISR.

Signed-off-by: Moiz Sonasath<m-sonasath-l0cyMroinI0@public.gmane.org>
Signed-off-by: Vikram pandita<vikram.pandita-l0cyMroinI0@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |   24 +++++++++++++++++++++++-
 1 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 05b5e4c..8deaf87 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -672,9 +672,10 @@ omap_i2c_isr(int this_irq, void *dev_id)
 			break;
 		}
 
+		err = 0;
+complete:
 		omap_i2c_write_reg(dev, OMAP_I2C_STAT_REG, stat);
 
-		err = 0;
 		if (stat & OMAP_I2C_STAT_NACK) {
 			err |= OMAP_I2C_STAT_NACK;
 			omap_i2c_write_reg(dev, OMAP_I2C_CON_REG,
@@ -764,6 +765,27 @@ omap_i2c_isr(int this_irq, void *dev_id)
 							"data to send\n");
 					break;
 				}
+
+				/*
+				 * OMAP3430 Errata 1.153: When an XRDY/XDR
+				 * is hit, wait for XUDF before writing data
+				 * to DATA_REG. Otherwise some data bytes can
+				 * be lost while transferring them from the
+				 * memory to the I2C interface.
+				 */
+
+				if (cpu_is_omap34xx()) {
+						while (!(stat & OMAP_I2C_STAT_XUDF)) {
+							if (stat & (OMAP_I2C_STAT_NACK | OMAP_I2C_STAT_AL)) {
+								omap_i2c_ack_stat(dev, stat & (OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR));
+								err |= OMAP_I2C_STAT_XUDF;
+								goto complete;
+							}
+							cpu_relax();
+							stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
+						}
+				}
+
 				omap_i2c_write_reg(dev, OMAP_I2C_DATA_REG, w);
 			}
 			omap_i2c_ack_stat(dev,
-- 
1.5.6.3
