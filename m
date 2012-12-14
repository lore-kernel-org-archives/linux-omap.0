From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH REBASE 4/6] i2c: omap: in case of VERSION_2 read IRQSTATUS_RAW but write to IRQSTATUS
Date: Fri, 14 Dec 2012 18:34:07 +0200
Message-ID: <1355502849-9289-5-git-send-email-balbi@ti.com>
References: <1355502849-9289-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1355502849-9289-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

on OMAP4+ we want to read IRQSTATUS_RAW register,
instead of IRQSTATUS. The reason being that IRQSTATUS
will only contain the bits which were enabled on
IRQENABLE_SET and that will break when we need to
poll for a certain bit which wasn't enabled as an
IRQ source.

One such case is after we finish converting to
deferred stop bit, we will have to poll for ARDY
bit before returning control for the client driver
in order to prevent us from trying to start a
transfer on a bus which is already busy.

Note, however, that i2c-omap.c needs a big rework
on register definition and register access. Such
work will be done in a separate series of patches.

Cc: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c | 50 +++++++++++++++++++++++++++++++++----------
 1 file changed, 39 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index c93eb17..039edc2 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -288,6 +288,36 @@ static inline u16 omap_i2c_read_reg(struct omap_i2c_dev *i2c_dev, int reg)
 				(i2c_dev->regs[reg] << i2c_dev->reg_shift));
 }
 
+static inline void omap_i2c_write_irqstatus(struct omap_i2c_dev *i2c_dev,
+		u16 val)
+{
+	omap_i2c_write_reg(i2c_dev, OMAP_I2C_STAT_REG, val);
+}
+
+static inline u16 omap_i2c_read_irqstatus(struct omap_i2c_dev *i2c_dev)
+{
+	u16 scheme;
+
+	/*
+	 * if we are OMAP_I2C_IP_VERSION_2, we need to read from
+	 * IRQSTATUS_RAW, but write to IRQSTATUS
+	 */
+	scheme = OMAP_I2C_SCHEME(i2c_dev->rev);
+	switch (scheme) {
+	case OMAP_I2C_SCHEME_0:
+		return __raw_readw(i2c_dev->base +
+				(i2c_dev->regs[OMAP_I2C_STAT_REG] <<
+				 i2c_dev->reg_shift));
+		break;
+	case OMAP_I2C_SCHEME_1:
+		/* FALLTHROUGH */
+	default:
+		return __raw_readw(i2c_dev->base +
+				((i2c_dev->regs[OMAP_I2C_STAT_REG] - 0x04)
+				 << i2c_dev->reg_shift));
+	}
+}
+
 static void __omap_i2c_init(struct omap_i2c_dev *dev)
 {
 
@@ -470,7 +500,7 @@ static int omap_i2c_wait_for_bb(struct omap_i2c_dev *dev)
 	unsigned long timeout;
 
 	timeout = jiffies + OMAP_I2C_TIMEOUT;
-	while (omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG) & OMAP_I2C_STAT_BB) {
+	while (omap_i2c_read_irqstatus(dev) & OMAP_I2C_STAT_BB) {
 		if (time_after(jiffies, timeout)) {
 			dev_warn(dev->dev, "timeout waiting for bus ready\n");
 			return -ETIMEDOUT;
@@ -696,7 +726,7 @@ omap_i2c_complete_cmd(struct omap_i2c_dev *dev, u16 err)
 static inline void
 omap_i2c_ack_stat(struct omap_i2c_dev *dev, u16 stat)
 {
-	omap_i2c_write_reg(dev, OMAP_I2C_STAT_REG, stat);
+	omap_i2c_write_irqstatus(dev, stat);
 }
 
 static inline void i2c_omap_errata_i207(struct omap_i2c_dev *dev, u16 stat)
@@ -713,12 +743,10 @@ static inline void i2c_omap_errata_i207(struct omap_i2c_dev *dev, u16 stat)
 		omap_i2c_ack_stat(dev, OMAP_I2C_STAT_RDR);
 
 		/* Step 2: */
-		if (!(omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG)
-						& OMAP_I2C_STAT_BB)) {
+		if (!(omap_i2c_read_irqstatus(dev) & OMAP_I2C_STAT_BB)) {
 
 			/* Step 3: */
-			if (omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG)
-						& OMAP_I2C_STAT_RDR) {
+			if (omap_i2c_read_irqstatus(dev) & OMAP_I2C_STAT_RDR) {
 				omap_i2c_ack_stat(dev, OMAP_I2C_STAT_RDR);
 				dev_dbg(dev->dev, "RDR when bus is busy.\n");
 			}
@@ -799,7 +827,7 @@ static int errata_omap3_i462(struct omap_i2c_dev *dev)
 	u16 stat;
 
 	do {
-		stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
+		stat = omap_i2c_read_irqstatus(dev);
 		if (stat & OMAP_I2C_STAT_XUDF)
 			break;
 
@@ -894,7 +922,7 @@ omap_i2c_isr(int irq, void *dev_id)
 
 	spin_lock(&dev->lock);
 	mask = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
-	stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
+	stat = omap_i2c_read_irqstatus(dev);
 
 	if (stat & mask)
 		ret = IRQ_WAKE_THREAD;
@@ -916,7 +944,7 @@ omap_i2c_isr_thread(int this_irq, void *dev_id)
 	spin_lock_irqsave(&dev->lock, flags);
 	do {
 		bits = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
-		stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
+		stat = omap_i2c_read_irqstatus(dev);
 		stat &= bits;
 
 		/* If we're in receiver mode, ignore XDR/XRDY */
@@ -1297,10 +1325,10 @@ static int omap_i2c_runtime_suspend(struct device *dev)
 	if (_dev->rev < OMAP_I2C_OMAP1_REV_2) {
 		omap_i2c_read_reg(_dev, OMAP_I2C_IV_REG); /* Read clears */
 	} else {
-		omap_i2c_write_reg(_dev, OMAP_I2C_STAT_REG, _dev->iestate);
+		omap_i2c_write_irqstatus(_dev, _dev->iestate);
 
 		/* Flush posted write */
-		omap_i2c_read_reg(_dev, OMAP_I2C_STAT_REG);
+		omap_i2c_read_irqstatus(_dev);
 	}
 
 	return 0;
-- 
1.8.1.rc1.5.g7e0651a
