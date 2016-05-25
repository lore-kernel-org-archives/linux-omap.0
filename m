From: Ravikumar Kattekola <rk@ti.com>
Subject: [RFC 1/1] drivers: i2c: omap: Add slave support
Date: Wed, 25 May 2016 19:41:19 +0530
Message-ID: <20160525141119.14486-2-rk@ti.com>
References: <20160525141119.14486-1-rk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160525141119.14486-1-rk@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, wsa@the-dreams.de, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

I2C controller on most of the omap devices has both master and slave
capability but the i2c framework has been missing support for registering
a bus in slave mode for long.

Recently the i2c slave support has been added to i2c framework,
the following patch adds the required support for omap_i2c driver to
register a controller as a slave device and be deriven by
an external/internal master.

The slave interface requires us to add following mandatory events

1. I2C_SLAVE_WRITE_REQUESTED
2. I2C_SLAVE_READ_REQUESTED
3. I2C_SLAVE_WRITE_RECEIVED
4. I2C_SLAVE_READ_PROCESSED

and

5. I2C_SLAVE_STOP

The omap i2c controller (at least on dra7x devices)
doesn't have  start/stop (STT/STP) support for slave mode
so event  #5 is not implemented in the driver.

Signed-off-by: Ravikumar Kattekola <rk@ti.com>
---
 drivers/i2c/busses/i2c-omap.c | 144 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 144 insertions(+)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index ab1279b..ccfc49f 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -89,6 +89,7 @@ enum {
 /* I2C Interrupt Enable Register (OMAP_I2C_IE): */
 #define OMAP_I2C_IE_XDR		(1 << 14)	/* TX Buffer drain int enable */
 #define OMAP_I2C_IE_RDR		(1 << 13)	/* RX Buffer drain int enable */
+#define OMAP_I2C_IE_AAS		(1 << 9)	/* Addressed as Slave int enable */
 #define OMAP_I2C_IE_XRDY	(1 << 4)	/* TX data ready int enable */
 #define OMAP_I2C_IE_RRDY	(1 << 3)	/* RX data ready int enable */
 #define OMAP_I2C_IE_ARDY	(1 << 2)	/* Access ready int enable */
@@ -202,6 +203,7 @@ struct omap_i2c_dev {
 	u8			*regs;
 	size_t			buf_len;
 	struct i2c_adapter	adapter;
+	struct i2c_client	*slave;
 	u8			threshold;
 	u8			fifo_size;	/* use as flag and value
 						 * fifo_size==0 implies no fifo
@@ -1003,6 +1005,62 @@ omap_i2c_isr(int irq, void *dev_id)
 	return ret;
 }
 
+#ifdef CONFIG_I2C_SLAVE
+static int omap_i2c_slave_irq(struct omap_i2c_dev *omap)
+{
+	u16 stat_raw;
+	u16 stat;
+	u16 bits;
+	u8 value;
+
+	stat_raw = omap_i2c_read_reg(omap, OMAP_I2C_IP_V2_IRQSTATUS_RAW);
+	bits = omap_i2c_read_reg(omap, OMAP_I2C_IE_REG);
+	stat_raw &= bits;
+
+	if (stat_raw & OMAP_I2C_STAT_AAS) {
+		omap_i2c_ack_stat(omap, OMAP_I2C_STAT_AAS);
+		stat_raw &= ~OMAP_I2C_STAT_AAS;
+	}
+
+	/* Someone's just sayin Hi? okay bye..*/
+	if (!stat_raw)
+		goto out;
+
+	dev_dbg(omap->dev, "IRQ (ISR = 0x%04x)\n", stat_raw);
+
+	if (stat_raw & OMAP_I2C_STAT_RRDY)
+		i2c_slave_event(omap->slave, I2C_SLAVE_WRITE_REQUESTED, &value);
+
+	do {
+		bits = omap_i2c_read_reg(omap, OMAP_I2C_IE_REG);
+		stat = omap_i2c_read_reg(omap, OMAP_I2C_STAT_REG);
+		stat &= bits;
+
+		if (stat & OMAP_I2C_STAT_AAS)
+			omap_i2c_ack_stat(omap, OMAP_I2C_STAT_AAS);
+
+		if (stat & OMAP_I2C_STAT_RRDY) {
+			value = omap_i2c_read_reg(omap, OMAP_I2C_DATA_REG);
+			i2c_slave_event(omap->slave, I2C_SLAVE_WRITE_RECEIVED,
+					&value);
+			omap_i2c_ack_stat(omap, OMAP_I2C_STAT_RRDY);
+		}
+
+		if (stat & OMAP_I2C_STAT_XRDY) {
+			i2c_slave_event(omap->slave, I2C_SLAVE_READ_REQUESTED,
+					&value);
+			omap_i2c_write_reg(omap, OMAP_I2C_DATA_REG, value);
+			i2c_slave_event(omap->slave, I2C_SLAVE_READ_PROCESSED,
+					&value);
+			omap_i2c_ack_stat(omap, OMAP_I2C_STAT_XRDY);
+		}
+
+	} while (stat);
+out:
+	return 0;
+}
+#endif
+
 static irqreturn_t
 omap_i2c_isr_thread(int this_irq, void *dev_id)
 {
@@ -1011,6 +1069,13 @@ omap_i2c_isr_thread(int this_irq, void *dev_id)
 	u16 stat;
 	int err = 0, count = 0;
 
+#ifdef CONFIG_I2C_SLAVE
+	if (omap->slave) {
+		/* If a slave is registered pass on the interrupt */
+		err = omap_i2c_slave_irq(omap);
+		goto out;
+	}
+#endif
 	do {
 		bits = omap_i2c_read_reg(omap, OMAP_I2C_IE_REG);
 		stat = omap_i2c_read_reg(omap, OMAP_I2C_STAT_REG);
@@ -1139,9 +1204,88 @@ out:
 	return IRQ_HANDLED;
 }
 
+#ifdef CONFIG_I2C_SLAVE
+static int omap_i2c_reg_slave(struct i2c_client *slave)
+{
+	struct omap_i2c_dev *omap = i2c_get_adapdata(slave->adapter);
+	u16 reg;
+	int ret = 0;
+
+	dev_info(omap->dev, "Registering as a slave @ %x\n", slave->addr);
+
+	/* Already registered as a slave?
+	 * XXX: OMAP I2c controller supports up to four
+	 * different OA, can we register as four different
+	 * slaves?
+	 */
+	if (omap->slave)
+		return -EBUSY;
+
+	ret = pm_runtime_get_sync(omap->dev);
+	if (ret < 0)
+		return ret;
+
+	omap->slave = slave;
+
+	/* Write OA: So that master(s) can talk to us */
+	omap_i2c_write_reg(omap, OMAP_I2C_OA_REG, slave->addr);
+
+	/* Set / Switch to slave mode */
+	reg = omap_i2c_read_reg(omap, OMAP_I2C_CON_REG);
+	reg &= ~OMAP_I2C_CON_MST;
+	omap_i2c_write_reg(omap, OMAP_I2C_CON_REG, reg);
+
+	/* Clear status */
+	omap_i2c_write_reg(omap, OMAP_I2C_SYSS_REG, 0);
+
+	/* As of now, We dont need all interrupts be enabled */
+	omap->iestate = OMAP_I2C_IE_AAS | OMAP_I2C_IE_XRDY | OMAP_I2C_IE_RRDY;
+
+	/* Clear interrupt mask */
+	omap_i2c_write_reg(omap, OMAP_I2C_IP_V2_IRQENABLE_CLR, 0xffff);
+
+	dev_dbg(omap->dev, "omap->iestate 0x%04x\n", omap->iestate);
+
+	/* Enable necessary interrupts */
+	omap_i2c_write_reg(omap, OMAP_I2C_IE_REG, omap->iestate);
+
+	return 0;
+
+}
+
+static int omap_i2c_unreg_slave(struct i2c_client *slave)
+{
+	struct omap_i2c_dev *omap = i2c_get_adapdata(slave->adapter);
+	u16 reg;
+
+	WARN_ON(!omap->slave);
+	omap->slave = NULL;
+
+	/* Switch to master mode */
+	reg = omap_i2c_read_reg(omap, OMAP_I2C_CON_REG);
+	reg |= OMAP_I2C_CON_MST;
+	omap_i2c_write_reg(omap, OMAP_I2C_CON_REG, reg);
+
+	/* clear status */
+	omap_i2c_write_reg(omap, OMAP_I2C_SYSS_REG, 0);
+
+	/* Just to make sure re-init in master mode
+	 * Should we do a reset here?
+	 */
+	omap_i2c_init(omap);
+
+	pm_runtime_put(omap->dev);
+	return 0;
+}
+#endif
+
 static const struct i2c_algorithm omap_i2c_algo = {
 	.master_xfer	= omap_i2c_xfer,
 	.functionality	= omap_i2c_func,
+#ifdef CONFIG_I2C_SLAVE
+	.reg_slave	= omap_i2c_reg_slave,
+	.unreg_slave	= omap_i2c_unreg_slave,
+#endif /* CONFIG_I2C_SLAVE */
 };
 
 #ifdef CONFIG_OF
-- 
2.8.2.396.g5fe494c
