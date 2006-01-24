From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH 2/2] i2c-omap: Fix support for OMAP15xx
Date: Tue, 24 Jan 2006 14:15:19 +0100
Message-ID: <20060124131518.GB21123@orphique>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Current implementation of omap_i2c_isr doesn't work on OMAP5910 (Too
much work in one IRQ). Interrupt service routine is broken in these
aspects:
* it tries to ack interrupt by writing to read-only status register.
* it doesn't ackowledge interrupt properly by reading interrupt vector
  register.
I'm assuming that driver works correctly on other OMAPs (right? ;-)), so
proposed patch adds interrupt service routine for 15xx cpus and deletes 
rev1 stuff from omap_i2c_isr. Tested on OMAP5910 with DS1339 clock on
I2C bus.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index fb41255..b021073 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -429,6 +429,60 @@ omap_i2c_ack_stat(struct omap_i2c_dev *d
 	omap_i2c_write_reg(dev, OMAP_I2C_STAT_REG, stat);
 }
 
+#ifdef CONFIG_ARCH_OMAP15XX
+static irqreturn_t
+omap_i2c_rev1_isr(int this_irq, void *dev_id, struct pt_regs *regs)
+{
+	struct omap_i2c_dev *dev = dev_id;
+	u16 iv, w;
+
+	iv = omap_i2c_read_reg(dev, OMAP_I2C_IV_REG);
+	switch (iv) {
+	case 0x00:	/* None */
+		break;
+	case 0x01:	/* Arbitration lost */
+		dev_err(dev->dev, "Arbitration lost\n");
+		omap_i2c_complete_cmd(dev, OMAP_I2C_STAT_AL);
+		break;
+	case 0x02:	/* No acknowledgement */
+		omap_i2c_complete_cmd(dev, OMAP_I2C_STAT_NACK);
+		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_STP);
+		break;
+	case 0x03:	/* Register access ready */
+		omap_i2c_complete_cmd(dev, 0);
+		break;
+	case 0x04:	/* Receive data ready */
+		if (dev->buf_len) {
+			w = omap_i2c_read_reg(dev, OMAP_I2C_DATA_REG);
+			*dev->buf++ = w;
+			dev->buf_len--;
+			if (dev->buf_len) {
+				*dev->buf++ = w >> 8;
+				dev->buf_len--;
+			}
+		} else
+			dev_err(dev->dev, "RRDY IRQ while no data requested\n");
+		break;
+	case 0x05:	/* Transmit data ready */
+		if (dev->buf_len) {
+			w = *dev->buf++;
+			dev->buf_len--;
+			if (dev->buf_len) {
+				w |= *dev->buf++ << 8;
+				dev->buf_len--;
+			}
+			omap_i2c_write_reg(dev, OMAP_I2C_DATA_REG, w);
+		} else
+			dev_err(dev->dev, "XRDY IRQ while no data to send\n");
+		break;
+	default:
+		return IRQ_NONE;
+	}
+
+	return IRQ_HANDLED;
+}
+#endif
+
 static irqreturn_t
 omap_i2c_isr(int this_irq, void *dev_id, struct pt_regs *regs)
 {
@@ -436,7 +490,6 @@ omap_i2c_isr(int this_irq, void *dev_id,
 	u16 bits;
 	u16 stat, w;
 	int count = 0;
-	u16 iv_read;
 
 	bits = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
 	while ((stat = (omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG))) & bits) {
@@ -450,8 +503,6 @@ omap_i2c_isr(int this_irq, void *dev_id,
 
 		if (stat & OMAP_I2C_STAT_ARDY) {
 			omap_i2c_complete_cmd(dev, 0);
-			if (dev->rev1)
-				iv_read = omap_i2c_read_reg(dev, OMAP_I2C_IV_REG);
 			continue;
 		}
 		if (stat & OMAP_I2C_STAT_RRDY) {
@@ -463,13 +514,9 @@ omap_i2c_isr(int this_irq, void *dev_id,
 					*dev->buf++ = w >> 8;
 					dev->buf_len--;
 				}
-				if (dev->rev1 && !dev->buf_len)
-					omap_i2c_complete_cmd(dev, 0);
 			} else
 				dev_err(dev->dev, "RRDY IRQ while no data requested\n");
 			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_RRDY);
-			if (dev->rev1)
-				iv_read = omap_i2c_read_reg(dev, OMAP_I2C_IV_REG);
 			continue;
 		}
 		if (stat & OMAP_I2C_STAT_XRDY) {
@@ -493,11 +540,6 @@ omap_i2c_isr(int this_irq, void *dev_id,
 #endif
 			omap_i2c_write_reg(dev, OMAP_I2C_DATA_REG, w);
 			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_XRDY);
-			if (dev->rev1) {
-				iv_read = omap_i2c_read_reg(dev, OMAP_I2C_IV_REG);
-				if (!dev->buf_len)
-					omap_i2c_complete_cmd(dev, 0);
-			}
 			if (bail_out)
 				omap_i2c_complete_cmd(dev, 1 << 15);
 			continue;
@@ -518,8 +560,6 @@ omap_i2c_isr(int this_irq, void *dev_id,
 			dev_err(dev->dev, "Arbitration lost\n");
 			omap_i2c_complete_cmd(dev, OMAP_I2C_STAT_AL);
 		}
-		if (dev->rev1)
-			iv_read = omap_i2c_read_reg(dev, OMAP_I2C_IV_REG);
 	}
 
 	return count ? IRQ_HANDLED : IRQ_NONE;
@@ -591,8 +631,12 @@ omap_i2c_probe(struct platform_device *p
 	/* reset ASAP, clearing any IRQs */
 	omap_i2c_reset(dev);
 
-	r = request_irq(dev->irq, omap_i2c_isr, 0,
-			driver_name, dev);
+#ifdef CONFIG_ARCH_OMAP15XX
+	r = request_irq(dev->irq, dev->rev1 ? omap_i2c_rev1_isr : omap_i2c_isr,
+			0, driver_name, dev);
+#else
+	r = request_irq(dev->irq, omap_i2c_isr, 0, driver_name, dev);
+#endif
 	if (r) {
 		dev_err(dev->dev, "failure requesting irq %i\n", dev->irq);
 		goto do_unuse_clocks;
