From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2/3] i2c: omap: abolish variable name confusion
Date: Thu, 25 Jun 2015 14:34:49 -0500
Message-ID: <1435260890-32335-2-git-send-email-balbi@ti.com>
References: <1435260890-32335-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1435260890-32335-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

struct device pointers are usually called
dev. Calling our struct omap_i2c_dev pointers
also dev has caused enough confusion.

This is the result of a few simple sed rules
to convert all struct omap_i2c_dev pointers
to be called omap instead.

Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c | 598 +++++++++++++++++++++---------------------
 1 file changed, 299 insertions(+), 299 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 00712c1cf3c0..828d5caccfcb 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -269,35 +269,35 @@ static const u8 reg_map_ip_v2[] = {
 	[OMAP_I2C_IP_V2_IRQENABLE_CLR] = 0x30,
 };
 
-static inline void omap_i2c_write_reg(struct omap_i2c_dev *i2c_dev,
+static inline void omap_i2c_write_reg(struct omap_i2c_dev *omap,
 				      int reg, u16 val)
 {
-	writew_relaxed(val, i2c_dev->base +
-			(i2c_dev->regs[reg] << i2c_dev->reg_shift));
+	writew_relaxed(val, omap->base +
+			(omap->regs[reg] << omap->reg_shift));
 }
 
-static inline u16 omap_i2c_read_reg(struct omap_i2c_dev *i2c_dev, int reg)
+static inline u16 omap_i2c_read_reg(struct omap_i2c_dev *omap, int reg)
 {
-	return readw_relaxed(i2c_dev->base +
-				(i2c_dev->regs[reg] << i2c_dev->reg_shift));
+	return readw_relaxed(omap->base +
+				(omap->regs[reg] << omap->reg_shift));
 }
 
-static void __omap_i2c_init(struct omap_i2c_dev *dev)
+static void __omap_i2c_init(struct omap_i2c_dev *omap)
 {
 
-	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
+	omap_i2c_write_reg(omap, OMAP_I2C_CON_REG, 0);
 
 	/* Setup clock prescaler to obtain approx 12MHz I2C module clock: */
-	omap_i2c_write_reg(dev, OMAP_I2C_PSC_REG, dev->pscstate);
+	omap_i2c_write_reg(omap, OMAP_I2C_PSC_REG, omap->pscstate);
 
 	/* SCL low and high time values */
-	omap_i2c_write_reg(dev, OMAP_I2C_SCLL_REG, dev->scllstate);
-	omap_i2c_write_reg(dev, OMAP_I2C_SCLH_REG, dev->sclhstate);
-	if (dev->rev >= OMAP_I2C_REV_ON_3430_3530)
-		omap_i2c_write_reg(dev, OMAP_I2C_WE_REG, dev->westate);
+	omap_i2c_write_reg(omap, OMAP_I2C_SCLL_REG, omap->scllstate);
+	omap_i2c_write_reg(omap, OMAP_I2C_SCLH_REG, omap->sclhstate);
+	if (omap->rev >= OMAP_I2C_REV_ON_3430_3530)
+		omap_i2c_write_reg(omap, OMAP_I2C_WE_REG, omap->westate);
 
 	/* Take the I2C module out of reset: */
-	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
+	omap_i2c_write_reg(omap, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
 
 	/*
 	 * NOTE: right after setting CON_EN, STAT_BB could be 0 while the
@@ -309,32 +309,32 @@ static void __omap_i2c_init(struct omap_i2c_dev *dev)
 	 * Don't write to this register if the IE state is 0 as it can
 	 * cause deadlock.
 	 */
-	if (dev->iestate)
-		omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, dev->iestate);
+	if (omap->iestate)
+		omap_i2c_write_reg(omap, OMAP_I2C_IE_REG, omap->iestate);
 }
 
-static int omap_i2c_reset(struct omap_i2c_dev *dev)
+static int omap_i2c_reset(struct omap_i2c_dev *omap)
 {
 	unsigned long timeout;
 	u16 sysc;
 
-	if (dev->rev >= OMAP_I2C_OMAP1_REV_2) {
-		sysc = omap_i2c_read_reg(dev, OMAP_I2C_SYSC_REG);
+	if (omap->rev >= OMAP_I2C_OMAP1_REV_2) {
+		sysc = omap_i2c_read_reg(omap, OMAP_I2C_SYSC_REG);
 
 		/* Disable I2C controller before soft reset */
-		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG,
-			omap_i2c_read_reg(dev, OMAP_I2C_CON_REG) &
+		omap_i2c_write_reg(omap, OMAP_I2C_CON_REG,
+			omap_i2c_read_reg(omap, OMAP_I2C_CON_REG) &
 				~(OMAP_I2C_CON_EN));
 
-		omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG, SYSC_SOFTRESET_MASK);
+		omap_i2c_write_reg(omap, OMAP_I2C_SYSC_REG, SYSC_SOFTRESET_MASK);
 		/* For some reason we need to set the EN bit before the
 		 * reset done bit gets set. */
 		timeout = jiffies + OMAP_I2C_TIMEOUT;
-		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
-		while (!(omap_i2c_read_reg(dev, OMAP_I2C_SYSS_REG) &
+		omap_i2c_write_reg(omap, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
+		while (!(omap_i2c_read_reg(omap, OMAP_I2C_SYSS_REG) &
 			 SYSS_RESETDONE_MASK)) {
 			if (time_after(jiffies, timeout)) {
-				dev_warn(dev->dev, "timeout waiting "
+				dev_warn(omap->dev, "timeout waiting "
 						"for controller reset\n");
 				return -ETIMEDOUT;
 			}
@@ -342,18 +342,18 @@ static int omap_i2c_reset(struct omap_i2c_dev *dev)
 		}
 
 		/* SYSC register is cleared by the reset; rewrite it */
-		omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG, sysc);
+		omap_i2c_write_reg(omap, OMAP_I2C_SYSC_REG, sysc);
 
-		if (dev->rev > OMAP_I2C_REV_ON_3430_3530) {
+		if (omap->rev > OMAP_I2C_REV_ON_3430_3530) {
 			/* Schedule I2C-bus monitoring on the next transfer */
-			dev->bb_valid = 0;
+			omap->bb_valid = 0;
 		}
 	}
 
 	return 0;
 }
 
-static int omap_i2c_init(struct omap_i2c_dev *dev)
+static int omap_i2c_init(struct omap_i2c_dev *omap)
 {
 	u16 psc = 0, scll = 0, sclh = 0;
 	u16 fsscll = 0, fssclh = 0, hsscll = 0, hssclh = 0;
@@ -361,23 +361,23 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 	unsigned long internal_clk = 0;
 	struct clk *fclk;
 
-	if (dev->rev >= OMAP_I2C_REV_ON_3430_3530) {
+	if (omap->rev >= OMAP_I2C_REV_ON_3430_3530) {
 		/*
 		 * Enabling all wakup sources to stop I2C freezing on
 		 * WFI instruction.
 		 * REVISIT: Some wkup sources might not be needed.
 		 */
-		dev->westate = OMAP_I2C_WE_ALL;
+		omap->westate = OMAP_I2C_WE_ALL;
 	}
 
-	if (dev->flags & OMAP_I2C_FLAG_ALWAYS_ARMXOR_CLK) {
+	if (omap->flags & OMAP_I2C_FLAG_ALWAYS_ARMXOR_CLK) {
 		/*
 		 * The I2C functional clock is the armxor_ck, so there's
 		 * no need to get "armxor_ck" separately.  Now, if OMAP2420
 		 * always returns 12MHz for the functional clock, we can
 		 * do this bit unconditionally.
 		 */
-		fclk = clk_get(dev->dev, "fck");
+		fclk = clk_get(omap->dev, "fck");
 		fclk_rate = clk_get_rate(fclk);
 		clk_put(fclk);
 
@@ -394,7 +394,7 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 			psc = fclk_rate / 12000000;
 	}
 
-	if (!(dev->flags & OMAP_I2C_FLAG_SIMPLE_CLOCK)) {
+	if (!(omap->flags & OMAP_I2C_FLAG_SIMPLE_CLOCK)) {
 
 		/*
 		 * HSI2C controller internal clk rate should be 19.2 Mhz for
@@ -402,14 +402,14 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 		 * to get longer filter period for better noise suppression.
 		 * The filter is iclk (fclk for HS) period.
 		 */
-		if (dev->speed > 400 ||
-			       dev->flags & OMAP_I2C_FLAG_FORCE_19200_INT_CLK)
+		if (omap->speed > 400 ||
+			       omap->flags & OMAP_I2C_FLAG_FORCE_19200_INT_CLK)
 			internal_clk = 19200;
-		else if (dev->speed > 100)
+		else if (omap->speed > 100)
 			internal_clk = 9600;
 		else
 			internal_clk = 4000;
-		fclk = clk_get(dev->dev, "fck");
+		fclk = clk_get(omap->dev, "fck");
 		fclk_rate = clk_get_rate(fclk) / 1000;
 		clk_put(fclk);
 
@@ -418,7 +418,7 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 		psc = psc - 1;
 
 		/* If configured for High Speed */
-		if (dev->speed > 400) {
+		if (omap->speed > 400) {
 			unsigned long scl;
 
 			/* For first phase of HS mode */
@@ -427,20 +427,20 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 			fssclh = (scl / 3) - 5;
 
 			/* For second phase of HS mode */
-			scl = fclk_rate / dev->speed;
+			scl = fclk_rate / omap->speed;
 			hsscll = scl - (scl / 3) - 7;
 			hssclh = (scl / 3) - 5;
-		} else if (dev->speed > 100) {
+		} else if (omap->speed > 100) {
 			unsigned long scl;
 
 			/* Fast mode */
-			scl = internal_clk / dev->speed;
+			scl = internal_clk / omap->speed;
 			fsscll = scl - (scl / 3) - 7;
 			fssclh = (scl / 3) - 5;
 		} else {
 			/* Standard mode */
-			fsscll = internal_clk / (dev->speed * 2) - 7;
-			fssclh = internal_clk / (dev->speed * 2) - 5;
+			fsscll = internal_clk / (omap->speed * 2) - 7;
+			fssclh = internal_clk / (omap->speed * 2) - 5;
 		}
 		scll = (hsscll << OMAP_I2C_SCLL_HSSCLL) | fsscll;
 		sclh = (hssclh << OMAP_I2C_SCLH_HSSCLH) | fssclh;
@@ -449,25 +449,25 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 		fclk_rate /= (psc + 1) * 1000;
 		if (psc > 2)
 			psc = 2;
-		scll = fclk_rate / (dev->speed * 2) - 7 + psc;
-		sclh = fclk_rate / (dev->speed * 2) - 7 + psc;
+		scll = fclk_rate / (omap->speed * 2) - 7 + psc;
+		sclh = fclk_rate / (omap->speed * 2) - 7 + psc;
 	}
 
-	dev->iestate = (OMAP_I2C_IE_XRDY | OMAP_I2C_IE_RRDY |
+	omap->iestate = (OMAP_I2C_IE_XRDY | OMAP_I2C_IE_RRDY |
 			OMAP_I2C_IE_ARDY | OMAP_I2C_IE_NACK |
-			OMAP_I2C_IE_AL)  | ((dev->fifo_size) ?
+			OMAP_I2C_IE_AL)  | ((omap->fifo_size) ?
 				(OMAP_I2C_IE_RDR | OMAP_I2C_IE_XDR) : 0);
 
-	dev->pscstate = psc;
-	dev->scllstate = scll;
-	dev->sclhstate = sclh;
+	omap->pscstate = psc;
+	omap->scllstate = scll;
+	omap->sclhstate = sclh;
 
-	if (dev->rev <= OMAP_I2C_REV_ON_3430_3530) {
+	if (omap->rev <= OMAP_I2C_REV_ON_3430_3530) {
 		/* Not implemented */
-		dev->bb_valid = 1;
+		omap->bb_valid = 1;
 	}
 
-	__omap_i2c_init(dev);
+	__omap_i2c_init(omap);
 
 	return 0;
 }
@@ -475,14 +475,14 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 /*
  * Waiting on Bus Busy
  */
-static int omap_i2c_wait_for_bb(struct omap_i2c_dev *dev)
+static int omap_i2c_wait_for_bb(struct omap_i2c_dev *omap)
 {
 	unsigned long timeout;
 
 	timeout = jiffies + OMAP_I2C_TIMEOUT;
-	while (omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG) & OMAP_I2C_STAT_BB) {
+	while (omap_i2c_read_reg(omap, OMAP_I2C_STAT_REG) & OMAP_I2C_STAT_BB) {
 		if (time_after(jiffies, timeout)) {
-			dev_warn(dev->dev, "timeout waiting for bus ready\n");
+			dev_warn(omap->dev, "timeout waiting for bus ready\n");
 			return -ETIMEDOUT;
 		}
 		msleep(1);
@@ -519,19 +519,19 @@ static int omap_i2c_wait_for_bb(struct omap_i2c_dev *dev)
  * 3. Any transfer started in the middle of another master's transfer
  *    results in unpredictable results and data corruption
  */
-static int omap_i2c_wait_for_bb_valid(struct omap_i2c_dev *dev)
+static int omap_i2c_wait_for_bb_valid(struct omap_i2c_dev *omap)
 {
 	unsigned long bus_free_timeout = 0;
 	unsigned long timeout;
 	int bus_free = 0;
 	u16 stat, systest;
 
-	if (dev->bb_valid)
+	if (omap->bb_valid)
 		return 0;
 
 	timeout = jiffies + OMAP_I2C_TIMEOUT;
 	while (1) {
-		stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
+		stat = omap_i2c_read_reg(omap, OMAP_I2C_STAT_REG);
 		/*
 		 * We will see BB or BF event in a case IP had detected any
 		 * activity on the I2C bus. Now IP correctly tracks the bus
@@ -544,7 +544,7 @@ static int omap_i2c_wait_for_bb_valid(struct omap_i2c_dev *dev)
 		 * Otherwise, we must look signals on the bus to make
 		 * the right decision.
 		 */
-		systest = omap_i2c_read_reg(dev, OMAP_I2C_SYSTEST_REG);
+		systest = omap_i2c_read_reg(omap, OMAP_I2C_SYSTEST_REG);
 		if ((systest & OMAP_I2C_SYSTEST_SCL_I_FUNC) &&
 		    (systest & OMAP_I2C_SYSTEST_SDA_I_FUNC)) {
 			if (!bus_free) {
@@ -565,22 +565,22 @@ static int omap_i2c_wait_for_bb_valid(struct omap_i2c_dev *dev)
 		}
 
 		if (time_after(jiffies, timeout)) {
-			dev_warn(dev->dev, "timeout waiting for bus ready\n");
+			dev_warn(omap->dev, "timeout waiting for bus ready\n");
 			return -ETIMEDOUT;
 		}
 
 		msleep(1);
 	}
 
-	dev->bb_valid = 1;
+	omap->bb_valid = 1;
 	return 0;
 }
 
-static void omap_i2c_resize_fifo(struct omap_i2c_dev *dev, u8 size, bool is_rx)
+static void omap_i2c_resize_fifo(struct omap_i2c_dev *omap, u8 size, bool is_rx)
 {
 	u16		buf;
 
-	if (dev->flags & OMAP_I2C_FLAG_NO_FIFO)
+	if (omap->flags & OMAP_I2C_FLAG_NO_FIFO)
 		return;
 
 	/*
@@ -590,29 +590,29 @@ static void omap_i2c_resize_fifo(struct omap_i2c_dev *dev, u8 size, bool is_rx)
 	 * then we might use draining feature to transfer the remaining bytes.
 	 */
 
-	dev->threshold = clamp(size, (u8) 1, dev->fifo_size);
+	omap->threshold = clamp(size, (u8) 1, omap->fifo_size);
 
-	buf = omap_i2c_read_reg(dev, OMAP_I2C_BUF_REG);
+	buf = omap_i2c_read_reg(omap, OMAP_I2C_BUF_REG);
 
 	if (is_rx) {
 		/* Clear RX Threshold */
 		buf &= ~(0x3f << 8);
-		buf |= ((dev->threshold - 1) << 8) | OMAP_I2C_BUF_RXFIF_CLR;
+		buf |= ((omap->threshold - 1) << 8) | OMAP_I2C_BUF_RXFIF_CLR;
 	} else {
 		/* Clear TX Threshold */
 		buf &= ~0x3f;
-		buf |= (dev->threshold - 1) | OMAP_I2C_BUF_TXFIF_CLR;
+		buf |= (omap->threshold - 1) | OMAP_I2C_BUF_TXFIF_CLR;
 	}
 
-	omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG, buf);
+	omap_i2c_write_reg(omap, OMAP_I2C_BUF_REG, buf);
 
-	if (dev->rev < OMAP_I2C_REV_ON_3630)
-		dev->b_hw = 1; /* Enable hardware fixes */
+	if (omap->rev < OMAP_I2C_REV_ON_3630)
+		omap->b_hw = 1; /* Enable hardware fixes */
 
 	/* calculate wakeup latency constraint for MPU */
-	if (dev->set_mpu_wkup_lat != NULL)
-		dev->latency = (1000000 * dev->threshold) /
-			(1000 * dev->speed / 8);
+	if (omap->set_mpu_wkup_lat != NULL)
+		omap->latency = (1000000 * omap->threshold) /
+			(1000 * omap->speed / 8);
 }
 
 /*
@@ -621,42 +621,42 @@ static void omap_i2c_resize_fifo(struct omap_i2c_dev *dev, u8 size, bool is_rx)
 static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 			     struct i2c_msg *msg, int stop)
 {
-	struct omap_i2c_dev *dev = i2c_get_adapdata(adap);
+	struct omap_i2c_dev *omap = i2c_get_adapdata(adap);
 	unsigned long timeout;
 	u16 w;
 
-	dev_dbg(dev->dev, "addr: 0x%04x, len: %d, flags: 0x%x, stop: %d\n",
+	dev_dbg(omap->dev, "addr: 0x%04x, len: %d, flags: 0x%x, stop: %d\n",
 		msg->addr, msg->len, msg->flags, stop);
 
 	if (msg->len == 0)
 		return -EINVAL;
 
-	dev->receiver = !!(msg->flags & I2C_M_RD);
-	omap_i2c_resize_fifo(dev, msg->len, dev->receiver);
+	omap->receiver = !!(msg->flags & I2C_M_RD);
+	omap_i2c_resize_fifo(omap, msg->len, omap->receiver);
 
-	omap_i2c_write_reg(dev, OMAP_I2C_SA_REG, msg->addr);
+	omap_i2c_write_reg(omap, OMAP_I2C_SA_REG, msg->addr);
 
 	/* REVISIT: Could the STB bit of I2C_CON be used with probing? */
-	dev->buf = msg->buf;
-	dev->buf_len = msg->len;
+	omap->buf = msg->buf;
+	omap->buf_len = msg->len;
 
-	/* make sure writes to dev->buf_len are ordered */
+	/* make sure writes to omap->buf_len are ordered */
 	barrier();
 
-	omap_i2c_write_reg(dev, OMAP_I2C_CNT_REG, dev->buf_len);
+	omap_i2c_write_reg(omap, OMAP_I2C_CNT_REG, omap->buf_len);
 
 	/* Clear the FIFO Buffers */
-	w = omap_i2c_read_reg(dev, OMAP_I2C_BUF_REG);
+	w = omap_i2c_read_reg(omap, OMAP_I2C_BUF_REG);
 	w |= OMAP_I2C_BUF_RXFIF_CLR | OMAP_I2C_BUF_TXFIF_CLR;
-	omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG, w);
+	omap_i2c_write_reg(omap, OMAP_I2C_BUF_REG, w);
 
-	reinit_completion(&dev->cmd_complete);
-	dev->cmd_err = 0;
+	reinit_completion(&omap->cmd_complete);
+	omap->cmd_err = 0;
 
 	w = OMAP_I2C_CON_EN | OMAP_I2C_CON_MST | OMAP_I2C_CON_STT;
 
 	/* High speed configuration */
-	if (dev->speed > 400)
+	if (omap->speed > 400)
 		w |= OMAP_I2C_CON_OPMODE_HS;
 
 	if (msg->flags & I2C_M_STOP)
@@ -666,27 +666,27 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 	if (!(msg->flags & I2C_M_RD))
 		w |= OMAP_I2C_CON_TRX;
 
-	if (!dev->b_hw && stop)
+	if (!omap->b_hw && stop)
 		w |= OMAP_I2C_CON_STP;
 	/*
 	 * NOTE: STAT_BB bit could became 1 here if another master occupy
 	 * the bus. IP successfully complete transfer when the bus will be
 	 * free again (BB reset to 0).
 	 */
-	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, w);
+	omap_i2c_write_reg(omap, OMAP_I2C_CON_REG, w);
 
 	/*
 	 * Don't write stt and stp together on some hardware.
 	 */
-	if (dev->b_hw && stop) {
+	if (omap->b_hw && stop) {
 		unsigned long delay = jiffies + OMAP_I2C_TIMEOUT;
-		u16 con = omap_i2c_read_reg(dev, OMAP_I2C_CON_REG);
+		u16 con = omap_i2c_read_reg(omap, OMAP_I2C_CON_REG);
 		while (con & OMAP_I2C_CON_STT) {
-			con = omap_i2c_read_reg(dev, OMAP_I2C_CON_REG);
+			con = omap_i2c_read_reg(omap, OMAP_I2C_CON_REG);
 
 			/* Let the user know if i2c is in a bad state */
 			if (time_after(jiffies, delay)) {
-				dev_err(dev->dev, "controller timed out "
+				dev_err(omap->dev, "controller timed out "
 				"waiting for start condition to finish\n");
 				return -ETIMEDOUT;
 			}
@@ -695,42 +695,42 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 
 		w |= OMAP_I2C_CON_STP;
 		w &= ~OMAP_I2C_CON_STT;
-		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, w);
+		omap_i2c_write_reg(omap, OMAP_I2C_CON_REG, w);
 	}
 
 	/*
 	 * REVISIT: We should abort the transfer on signals, but the bus goes
 	 * into arbitration and we're currently unable to recover from it.
 	 */
-	timeout = wait_for_completion_timeout(&dev->cmd_complete,
+	timeout = wait_for_completion_timeout(&omap->cmd_complete,
 						OMAP_I2C_TIMEOUT);
 	if (timeout == 0) {
-		dev_err(dev->dev, "controller timed out\n");
-		omap_i2c_reset(dev);
-		__omap_i2c_init(dev);
+		dev_err(omap->dev, "controller timed out\n");
+		omap_i2c_reset(omap);
+		__omap_i2c_init(omap);
 		return -ETIMEDOUT;
 	}
 
-	if (likely(!dev->cmd_err))
+	if (likely(!omap->cmd_err))
 		return 0;
 
 	/* We have an error */
-	if (dev->cmd_err & (OMAP_I2C_STAT_ROVR | OMAP_I2C_STAT_XUDF)) {
-		omap_i2c_reset(dev);
-		__omap_i2c_init(dev);
+	if (omap->cmd_err & (OMAP_I2C_STAT_ROVR | OMAP_I2C_STAT_XUDF)) {
+		omap_i2c_reset(omap);
+		__omap_i2c_init(omap);
 		return -EIO;
 	}
 
-	if (dev->cmd_err & OMAP_I2C_STAT_AL)
+	if (omap->cmd_err & OMAP_I2C_STAT_AL)
 		return -EAGAIN;
 
-	if (dev->cmd_err & OMAP_I2C_STAT_NACK) {
+	if (omap->cmd_err & OMAP_I2C_STAT_NACK) {
 		if (msg->flags & I2C_M_IGNORE_NAK)
 			return 0;
 
-		w = omap_i2c_read_reg(dev, OMAP_I2C_CON_REG);
+		w = omap_i2c_read_reg(omap, OMAP_I2C_CON_REG);
 		w |= OMAP_I2C_CON_STP;
-		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, w);
+		omap_i2c_write_reg(omap, OMAP_I2C_CON_REG, w);
 		return -EREMOTEIO;
 	}
 	return -EIO;
@@ -744,24 +744,24 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 static int
 omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 {
-	struct omap_i2c_dev *dev = i2c_get_adapdata(adap);
+	struct omap_i2c_dev *omap = i2c_get_adapdata(adap);
 	int i;
 	int r;
 
-	r = pm_runtime_get_sync(dev->dev);
+	r = pm_runtime_get_sync(omap->dev);
 	if (r < 0)
 		goto out;
 
-	r = omap_i2c_wait_for_bb_valid(dev);
+	r = omap_i2c_wait_for_bb_valid(omap);
 	if (r < 0)
 		goto out;
 
-	r = omap_i2c_wait_for_bb(dev);
+	r = omap_i2c_wait_for_bb(omap);
 	if (r < 0)
 		goto out;
 
-	if (dev->set_mpu_wkup_lat != NULL)
-		dev->set_mpu_wkup_lat(dev->dev, dev->latency);
+	if (omap->set_mpu_wkup_lat != NULL)
+		omap->set_mpu_wkup_lat(omap->dev, omap->latency);
 
 	for (i = 0; i < num; i++) {
 		r = omap_i2c_xfer_msg(adap, &msgs[i], (i == (num - 1)));
@@ -772,14 +772,14 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	if (r == 0)
 		r = num;
 
-	omap_i2c_wait_for_bb(dev);
+	omap_i2c_wait_for_bb(omap);
 
-	if (dev->set_mpu_wkup_lat != NULL)
-		dev->set_mpu_wkup_lat(dev->dev, -1);
+	if (omap->set_mpu_wkup_lat != NULL)
+		omap->set_mpu_wkup_lat(omap->dev, -1);
 
 out:
-	pm_runtime_mark_last_busy(dev->dev);
-	pm_runtime_put_autosuspend(dev->dev);
+	pm_runtime_mark_last_busy(omap->dev);
+	pm_runtime_put_autosuspend(omap->dev);
 	return r;
 }
 
@@ -791,19 +791,19 @@ omap_i2c_func(struct i2c_adapter *adap)
 }
 
 static inline void
-omap_i2c_complete_cmd(struct omap_i2c_dev *dev, u16 err)
+omap_i2c_complete_cmd(struct omap_i2c_dev *omap, u16 err)
 {
-	dev->cmd_err |= err;
-	complete(&dev->cmd_complete);
+	omap->cmd_err |= err;
+	complete(&omap->cmd_complete);
 }
 
 static inline void
-omap_i2c_ack_stat(struct omap_i2c_dev *dev, u16 stat)
+omap_i2c_ack_stat(struct omap_i2c_dev *omap, u16 stat)
 {
-	omap_i2c_write_reg(dev, OMAP_I2C_STAT_REG, stat);
+	omap_i2c_write_reg(omap, OMAP_I2C_STAT_REG, stat);
 }
 
-static inline void i2c_omap_errata_i207(struct omap_i2c_dev *dev, u16 stat)
+static inline void i2c_omap_errata_i207(struct omap_i2c_dev *omap, u16 stat)
 {
 	/*
 	 * I2C Errata(Errata Nos. OMAP2: 1.67, OMAP3: 1.8)
@@ -814,17 +814,17 @@ static inline void i2c_omap_errata_i207(struct omap_i2c_dev *dev, u16 stat)
 	 */
 	if (stat & OMAP_I2C_STAT_RDR) {
 		/* Step 1: If RDR is set, clear it */
-		omap_i2c_ack_stat(dev, OMAP_I2C_STAT_RDR);
+		omap_i2c_ack_stat(omap, OMAP_I2C_STAT_RDR);
 
 		/* Step 2: */
-		if (!(omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG)
+		if (!(omap_i2c_read_reg(omap, OMAP_I2C_STAT_REG)
 						& OMAP_I2C_STAT_BB)) {
 
 			/* Step 3: */
-			if (omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG)
+			if (omap_i2c_read_reg(omap, OMAP_I2C_STAT_REG)
 						& OMAP_I2C_STAT_RDR) {
-				omap_i2c_ack_stat(dev, OMAP_I2C_STAT_RDR);
-				dev_dbg(dev->dev, "RDR when bus is busy.\n");
+				omap_i2c_ack_stat(omap, OMAP_I2C_STAT_RDR);
+				dev_dbg(omap->dev, "RDR when bus is busy.\n");
 			}
 
 		}
@@ -837,50 +837,50 @@ static inline void i2c_omap_errata_i207(struct omap_i2c_dev *dev, u16 stat)
 static irqreturn_t
 omap_i2c_omap1_isr(int this_irq, void *dev_id)
 {
-	struct omap_i2c_dev *dev = dev_id;
+	struct omap_i2c_dev *omap = dev_id;
 	u16 iv, w;
 
-	if (pm_runtime_suspended(dev->dev))
+	if (pm_runtime_suspended(omap->dev))
 		return IRQ_NONE;
 
-	iv = omap_i2c_read_reg(dev, OMAP_I2C_IV_REG);
+	iv = omap_i2c_read_reg(omap, OMAP_I2C_IV_REG);
 	switch (iv) {
 	case 0x00:	/* None */
 		break;
 	case 0x01:	/* Arbitration lost */
-		dev_err(dev->dev, "Arbitration lost\n");
-		omap_i2c_complete_cmd(dev, OMAP_I2C_STAT_AL);
+		dev_err(omap->dev, "Arbitration lost\n");
+		omap_i2c_complete_cmd(omap, OMAP_I2C_STAT_AL);
 		break;
 	case 0x02:	/* No acknowledgement */
-		omap_i2c_complete_cmd(dev, OMAP_I2C_STAT_NACK);
-		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_STP);
+		omap_i2c_complete_cmd(omap, OMAP_I2C_STAT_NACK);
+		omap_i2c_write_reg(omap, OMAP_I2C_CON_REG, OMAP_I2C_CON_STP);
 		break;
 	case 0x03:	/* Register access ready */
-		omap_i2c_complete_cmd(dev, 0);
+		omap_i2c_complete_cmd(omap, 0);
 		break;
 	case 0x04:	/* Receive data ready */
-		if (dev->buf_len) {
-			w = omap_i2c_read_reg(dev, OMAP_I2C_DATA_REG);
-			*dev->buf++ = w;
-			dev->buf_len--;
-			if (dev->buf_len) {
-				*dev->buf++ = w >> 8;
-				dev->buf_len--;
+		if (omap->buf_len) {
+			w = omap_i2c_read_reg(omap, OMAP_I2C_DATA_REG);
+			*omap->buf++ = w;
+			omap->buf_len--;
+			if (omap->buf_len) {
+				*omap->buf++ = w >> 8;
+				omap->buf_len--;
 			}
 		} else
-			dev_err(dev->dev, "RRDY IRQ while no data requested\n");
+			dev_err(omap->dev, "RRDY IRQ while no data requested\n");
 		break;
 	case 0x05:	/* Transmit data ready */
-		if (dev->buf_len) {
-			w = *dev->buf++;
-			dev->buf_len--;
-			if (dev->buf_len) {
-				w |= *dev->buf++ << 8;
-				dev->buf_len--;
+		if (omap->buf_len) {
+			w = *omap->buf++;
+			omap->buf_len--;
+			if (omap->buf_len) {
+				w |= *omap->buf++ << 8;
+				omap->buf_len--;
 			}
-			omap_i2c_write_reg(dev, OMAP_I2C_DATA_REG, w);
+			omap_i2c_write_reg(omap, OMAP_I2C_DATA_REG, w);
 		} else
-			dev_err(dev->dev, "XRDY IRQ while no data to send\n");
+			dev_err(omap->dev, "XRDY IRQ while no data to send\n");
 		break;
 	default:
 		return IRQ_NONE;
@@ -897,28 +897,28 @@ omap_i2c_omap1_isr(int this_irq, void *dev_id)
  * data to DATA_REG. Otherwise some data bytes can be lost while transferring
  * them from the memory to the I2C interface.
  */
-static int errata_omap3_i462(struct omap_i2c_dev *dev)
+static int errata_omap3_i462(struct omap_i2c_dev *omap)
 {
 	unsigned long timeout = 10000;
 	u16 stat;
 
 	do {
-		stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
+		stat = omap_i2c_read_reg(omap, OMAP_I2C_STAT_REG);
 		if (stat & OMAP_I2C_STAT_XUDF)
 			break;
 
 		if (stat & (OMAP_I2C_STAT_NACK | OMAP_I2C_STAT_AL)) {
-			omap_i2c_ack_stat(dev, (OMAP_I2C_STAT_XRDY |
+			omap_i2c_ack_stat(omap, (OMAP_I2C_STAT_XRDY |
 							OMAP_I2C_STAT_XDR));
 			if (stat & OMAP_I2C_STAT_NACK) {
-				dev->cmd_err |= OMAP_I2C_STAT_NACK;
-				omap_i2c_ack_stat(dev, OMAP_I2C_STAT_NACK);
+				omap->cmd_err |= OMAP_I2C_STAT_NACK;
+				omap_i2c_ack_stat(omap, OMAP_I2C_STAT_NACK);
 			}
 
 			if (stat & OMAP_I2C_STAT_AL) {
-				dev_err(dev->dev, "Arbitration lost\n");
-				dev->cmd_err |= OMAP_I2C_STAT_AL;
-				omap_i2c_ack_stat(dev, OMAP_I2C_STAT_AL);
+				dev_err(omap->dev, "Arbitration lost\n");
+				omap->cmd_err |= OMAP_I2C_STAT_AL;
+				omap_i2c_ack_stat(omap, OMAP_I2C_STAT_AL);
 			}
 
 			return -EIO;
@@ -928,61 +928,61 @@ static int errata_omap3_i462(struct omap_i2c_dev *dev)
 	} while (--timeout);
 
 	if (!timeout) {
-		dev_err(dev->dev, "timeout waiting on XUDF bit\n");
+		dev_err(omap->dev, "timeout waiting on XUDF bit\n");
 		return 0;
 	}
 
 	return 0;
 }
 
-static void omap_i2c_receive_data(struct omap_i2c_dev *dev, u8 num_bytes,
+static void omap_i2c_receive_data(struct omap_i2c_dev *omap, u8 num_bytes,
 		bool is_rdr)
 {
 	u16		w;
 
 	while (num_bytes--) {
-		w = omap_i2c_read_reg(dev, OMAP_I2C_DATA_REG);
-		*dev->buf++ = w;
-		dev->buf_len--;
+		w = omap_i2c_read_reg(omap, OMAP_I2C_DATA_REG);
+		*omap->buf++ = w;
+		omap->buf_len--;
 
 		/*
 		 * Data reg in 2430, omap3 and
 		 * omap4 is 8 bit wide
 		 */
-		if (dev->flags & OMAP_I2C_FLAG_16BIT_DATA_REG) {
-			*dev->buf++ = w >> 8;
-			dev->buf_len--;
+		if (omap->flags & OMAP_I2C_FLAG_16BIT_DATA_REG) {
+			*omap->buf++ = w >> 8;
+			omap->buf_len--;
 		}
 	}
 }
 
-static int omap_i2c_transmit_data(struct omap_i2c_dev *dev, u8 num_bytes,
+static int omap_i2c_transmit_data(struct omap_i2c_dev *omap, u8 num_bytes,
 		bool is_xdr)
 {
 	u16		w;
 
 	while (num_bytes--) {
-		w = *dev->buf++;
-		dev->buf_len--;
+		w = *omap->buf++;
+		omap->buf_len--;
 
 		/*
 		 * Data reg in 2430, omap3 and
 		 * omap4 is 8 bit wide
 		 */
-		if (dev->flags & OMAP_I2C_FLAG_16BIT_DATA_REG) {
-			w |= *dev->buf++ << 8;
-			dev->buf_len--;
+		if (omap->flags & OMAP_I2C_FLAG_16BIT_DATA_REG) {
+			w |= *omap->buf++ << 8;
+			omap->buf_len--;
 		}
 
-		if (dev->errata & I2C_OMAP_ERRATA_I462) {
+		if (omap->errata & I2C_OMAP_ERRATA_I462) {
 			int ret;
 
-			ret = errata_omap3_i462(dev);
+			ret = errata_omap3_i462(omap);
 			if (ret < 0)
 				return ret;
 		}
 
-		omap_i2c_write_reg(dev, OMAP_I2C_DATA_REG, w);
+		omap_i2c_write_reg(omap, OMAP_I2C_DATA_REG, w);
 	}
 
 	return 0;
@@ -991,19 +991,19 @@ static int omap_i2c_transmit_data(struct omap_i2c_dev *dev, u8 num_bytes,
 static irqreturn_t
 omap_i2c_isr(int irq, void *dev_id)
 {
-	struct omap_i2c_dev *dev = dev_id;
+	struct omap_i2c_dev *omap = dev_id;
 	irqreturn_t ret = IRQ_HANDLED;
 	u16 mask;
 	u16 stat;
 
-	spin_lock(&dev->lock);
-	mask = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
-	stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
+	spin_lock(&omap->lock);
+	mask = omap_i2c_read_reg(omap, OMAP_I2C_IE_REG);
+	stat = omap_i2c_read_reg(omap, OMAP_I2C_STAT_REG);
 
 	if (stat & mask)
 		ret = IRQ_WAKE_THREAD;
 
-	spin_unlock(&dev->lock);
+	spin_unlock(&omap->lock);
 
 	return ret;
 }
@@ -1011,20 +1011,20 @@ omap_i2c_isr(int irq, void *dev_id)
 static irqreturn_t
 omap_i2c_isr_thread(int this_irq, void *dev_id)
 {
-	struct omap_i2c_dev *dev = dev_id;
+	struct omap_i2c_dev *omap = dev_id;
 	unsigned long flags;
 	u16 bits;
 	u16 stat;
 	int err = 0, count = 0;
 
-	spin_lock_irqsave(&dev->lock, flags);
+	spin_lock_irqsave(&omap->lock, flags);
 	do {
-		bits = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
-		stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
+		bits = omap_i2c_read_reg(omap, OMAP_I2C_IE_REG);
+		stat = omap_i2c_read_reg(omap, OMAP_I2C_STAT_REG);
 		stat &= bits;
 
 		/* If we're in receiver mode, ignore XDR/XRDY */
-		if (dev->receiver)
+		if (omap->receiver)
 			stat &= ~(OMAP_I2C_STAT_XDR | OMAP_I2C_STAT_XRDY);
 		else
 			stat &= ~(OMAP_I2C_STAT_RDR | OMAP_I2C_STAT_RRDY);
@@ -1034,32 +1034,32 @@ omap_i2c_isr_thread(int this_irq, void *dev_id)
 			goto out;
 		}
 
-		dev_dbg(dev->dev, "IRQ (ISR = 0x%04x)\n", stat);
+		dev_dbg(omap->dev, "IRQ (ISR = 0x%04x)\n", stat);
 		if (count++ == 100) {
-			dev_warn(dev->dev, "Too much work in one IRQ\n");
+			dev_warn(omap->dev, "Too much work in one IRQ\n");
 			break;
 		}
 
 		if (stat & OMAP_I2C_STAT_NACK) {
 			err |= OMAP_I2C_STAT_NACK;
-			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_NACK);
+			omap_i2c_ack_stat(omap, OMAP_I2C_STAT_NACK);
 		}
 
 		if (stat & OMAP_I2C_STAT_AL) {
-			dev_err(dev->dev, "Arbitration lost\n");
+			dev_err(omap->dev, "Arbitration lost\n");
 			err |= OMAP_I2C_STAT_AL;
-			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_AL);
+			omap_i2c_ack_stat(omap, OMAP_I2C_STAT_AL);
 		}
 
 		/*
 		 * ProDB0017052: Clear ARDY bit twice
 		 */
 		if (stat & OMAP_I2C_STAT_ARDY)
-			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_ARDY);
+			omap_i2c_ack_stat(omap, OMAP_I2C_STAT_ARDY);
 
 		if (stat & (OMAP_I2C_STAT_ARDY | OMAP_I2C_STAT_NACK |
 					OMAP_I2C_STAT_AL)) {
-			omap_i2c_ack_stat(dev, (OMAP_I2C_STAT_RRDY |
+			omap_i2c_ack_stat(omap, (OMAP_I2C_STAT_RRDY |
 						OMAP_I2C_STAT_RDR |
 						OMAP_I2C_STAT_XRDY |
 						OMAP_I2C_STAT_XDR |
@@ -1070,28 +1070,28 @@ omap_i2c_isr_thread(int this_irq, void *dev_id)
 		if (stat & OMAP_I2C_STAT_RDR) {
 			u8 num_bytes = 1;
 
-			if (dev->fifo_size)
-				num_bytes = dev->buf_len;
+			if (omap->fifo_size)
+				num_bytes = omap->buf_len;
 
-			if (dev->errata & I2C_OMAP_ERRATA_I207) {
-				i2c_omap_errata_i207(dev, stat);
-				num_bytes = (omap_i2c_read_reg(dev,
+			if (omap->errata & I2C_OMAP_ERRATA_I207) {
+				i2c_omap_errata_i207(omap, stat);
+				num_bytes = (omap_i2c_read_reg(omap,
 					OMAP_I2C_BUFSTAT_REG) >> 8) & 0x3F;
 			}
 
-			omap_i2c_receive_data(dev, num_bytes, true);
-			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_RDR);
+			omap_i2c_receive_data(omap, num_bytes, true);
+			omap_i2c_ack_stat(omap, OMAP_I2C_STAT_RDR);
 			continue;
 		}
 
 		if (stat & OMAP_I2C_STAT_RRDY) {
 			u8 num_bytes = 1;
 
-			if (dev->threshold)
-				num_bytes = dev->threshold;
+			if (omap->threshold)
+				num_bytes = omap->threshold;
 
-			omap_i2c_receive_data(dev, num_bytes, false);
-			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_RRDY);
+			omap_i2c_receive_data(omap, num_bytes, false);
+			omap_i2c_ack_stat(omap, OMAP_I2C_STAT_RRDY);
 			continue;
 		}
 
@@ -1099,14 +1099,14 @@ omap_i2c_isr_thread(int this_irq, void *dev_id)
 			u8 num_bytes = 1;
 			int ret;
 
-			if (dev->fifo_size)
-				num_bytes = dev->buf_len;
+			if (omap->fifo_size)
+				num_bytes = omap->buf_len;
 
-			ret = omap_i2c_transmit_data(dev, num_bytes, true);
+			ret = omap_i2c_transmit_data(omap, num_bytes, true);
 			if (ret < 0)
 				break;
 
-			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_XDR);
+			omap_i2c_ack_stat(omap, OMAP_I2C_STAT_XDR);
 			continue;
 		}
 
@@ -1114,36 +1114,36 @@ omap_i2c_isr_thread(int this_irq, void *dev_id)
 			u8 num_bytes = 1;
 			int ret;
 
-			if (dev->threshold)
-				num_bytes = dev->threshold;
+			if (omap->threshold)
+				num_bytes = omap->threshold;
 
-			ret = omap_i2c_transmit_data(dev, num_bytes, false);
+			ret = omap_i2c_transmit_data(omap, num_bytes, false);
 			if (ret < 0)
 				break;
 
-			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_XRDY);
+			omap_i2c_ack_stat(omap, OMAP_I2C_STAT_XRDY);
 			continue;
 		}
 
 		if (stat & OMAP_I2C_STAT_ROVR) {
-			dev_err(dev->dev, "Receive overrun\n");
+			dev_err(omap->dev, "Receive overrun\n");
 			err |= OMAP_I2C_STAT_ROVR;
-			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_ROVR);
+			omap_i2c_ack_stat(omap, OMAP_I2C_STAT_ROVR);
 			break;
 		}
 
 		if (stat & OMAP_I2C_STAT_XUDF) {
-			dev_err(dev->dev, "Transmit underflow\n");
+			dev_err(omap->dev, "Transmit underflow\n");
 			err |= OMAP_I2C_STAT_XUDF;
-			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_XUDF);
+			omap_i2c_ack_stat(omap, OMAP_I2C_STAT_XUDF);
 			break;
 		}
 	} while (stat);
 
-	omap_i2c_complete_cmd(dev, err);
+	omap_i2c_complete_cmd(omap, err);
 
 out:
-	spin_unlock_irqrestore(&dev->lock, flags);
+	spin_unlock_irqrestore(&omap->lock, flags);
 
 	return IRQ_HANDLED;
 }
@@ -1212,7 +1212,7 @@ MODULE_DEVICE_TABLE(of, omap_i2c_of_match);
 static int
 omap_i2c_probe(struct platform_device *pdev)
 {
-	struct omap_i2c_dev	*dev;
+	struct omap_i2c_dev	*omap;
 	struct i2c_adapter	*adap;
 	struct resource		*mem;
 	const struct omap_i2c_bus_platform_data *pdata =
@@ -1230,47 +1230,47 @@ omap_i2c_probe(struct platform_device *pdev)
 		return irq;
 	}
 
-	dev = devm_kzalloc(&pdev->dev, sizeof(struct omap_i2c_dev), GFP_KERNEL);
-	if (!dev)
+	omap = devm_kzalloc(&pdev->dev, sizeof(struct omap_i2c_dev), GFP_KERNEL);
+	if (!omap)
 		return -ENOMEM;
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	dev->base = devm_ioremap_resource(&pdev->dev, mem);
-	if (IS_ERR(dev->base))
-		return PTR_ERR(dev->base);
+	omap->base = devm_ioremap_resource(&pdev->dev, mem);
+	if (IS_ERR(omap->base))
+		return PTR_ERR(omap->base);
 
 	match = of_match_device(of_match_ptr(omap_i2c_of_match), &pdev->dev);
 	if (match) {
 		u32 freq = 100000; /* default to 100000 Hz */
 
 		pdata = match->data;
-		dev->flags = pdata->flags;
+		omap->flags = pdata->flags;
 
 		of_property_read_u32(node, "clock-frequency", &freq);
 		/* convert DT freq value in Hz into kHz for speed */
-		dev->speed = freq / 1000;
+		omap->speed = freq / 1000;
 	} else if (pdata != NULL) {
-		dev->speed = pdata->clkrate;
-		dev->flags = pdata->flags;
-		dev->set_mpu_wkup_lat = pdata->set_mpu_wkup_lat;
+		omap->speed = pdata->clkrate;
+		omap->flags = pdata->flags;
+		omap->set_mpu_wkup_lat = pdata->set_mpu_wkup_lat;
 	}
 
-	dev->dev = &pdev->dev;
-	dev->irq = irq;
+	omap->dev = &pdev->dev;
+	omap->irq = irq;
 
-	spin_lock_init(&dev->lock);
+	spin_lock_init(&omap->lock);
 
-	platform_set_drvdata(pdev, dev);
-	init_completion(&dev->cmd_complete);
+	platform_set_drvdata(pdev, omap);
+	init_completion(&omap->cmd_complete);
 
-	dev->reg_shift = (dev->flags >> OMAP_I2C_FLAG_BUS_SHIFT__SHIFT) & 3;
+	omap->reg_shift = (omap->flags >> OMAP_I2C_FLAG_BUS_SHIFT__SHIFT) & 3;
 
-	pm_runtime_enable(dev->dev);
-	pm_runtime_set_autosuspend_delay(dev->dev, OMAP_I2C_PM_TIMEOUT);
-	pm_runtime_use_autosuspend(dev->dev);
+	pm_runtime_enable(omap->dev);
+	pm_runtime_set_autosuspend_delay(omap->dev, OMAP_I2C_PM_TIMEOUT);
+	pm_runtime_use_autosuspend(omap->dev);
 
-	r = pm_runtime_get_sync(dev->dev);
-	if (r < 0)
+	r = pm_runtime_get_sync(omap->dev);
+	if (IS_ERR_VALUE(r))
 		goto err_free_mem;
 
 	/*
@@ -1279,42 +1279,42 @@ omap_i2c_probe(struct platform_device *pdev)
 	 * Also since the omap_i2c_read_reg uses reg_map_ip_* a
 	 * readw_relaxed is done.
 	 */
-	rev = readw_relaxed(dev->base + 0x04);
+	rev = readw_relaxed(omap->base + 0x04);
 
-	dev->scheme = OMAP_I2C_SCHEME(rev);
-	switch (dev->scheme) {
+	omap->scheme = OMAP_I2C_SCHEME(rev);
+	switch (omap->scheme) {
 	case OMAP_I2C_SCHEME_0:
-		dev->regs = (u8 *)reg_map_ip_v1;
-		dev->rev = omap_i2c_read_reg(dev, OMAP_I2C_REV_REG);
-		minor = OMAP_I2C_REV_SCHEME_0_MAJOR(dev->rev);
-		major = OMAP_I2C_REV_SCHEME_0_MAJOR(dev->rev);
+		omap->regs = (u8 *)reg_map_ip_v1;
+		omap->rev = omap_i2c_read_reg(omap, OMAP_I2C_REV_REG);
+		minor = OMAP_I2C_REV_SCHEME_0_MAJOR(omap->rev);
+		major = OMAP_I2C_REV_SCHEME_0_MAJOR(omap->rev);
 		break;
 	case OMAP_I2C_SCHEME_1:
 		/* FALLTHROUGH */
 	default:
-		dev->regs = (u8 *)reg_map_ip_v2;
+		omap->regs = (u8 *)reg_map_ip_v2;
 		rev = (rev << 16) |
-			omap_i2c_read_reg(dev, OMAP_I2C_IP_V2_REVNB_LO);
+			omap_i2c_read_reg(omap, OMAP_I2C_IP_V2_REVNB_LO);
 		minor = OMAP_I2C_REV_SCHEME_1_MINOR(rev);
 		major = OMAP_I2C_REV_SCHEME_1_MAJOR(rev);
-		dev->rev = rev;
+		omap->rev = rev;
 	}
 
-	dev->errata = 0;
+	omap->errata = 0;
 
-	if (dev->rev >= OMAP_I2C_REV_ON_2430 &&
-			dev->rev < OMAP_I2C_REV_ON_4430_PLUS)
-		dev->errata |= I2C_OMAP_ERRATA_I207;
+	if (omap->rev >= OMAP_I2C_REV_ON_2430 &&
+			omap->rev < OMAP_I2C_REV_ON_4430_PLUS)
+		omap->errata |= I2C_OMAP_ERRATA_I207;
 
-	if (dev->rev <= OMAP_I2C_REV_ON_3430_3530)
-		dev->errata |= I2C_OMAP_ERRATA_I462;
+	if (omap->rev <= OMAP_I2C_REV_ON_3430_3530)
+		omap->errata |= I2C_OMAP_ERRATA_I462;
 
-	if (!(dev->flags & OMAP_I2C_FLAG_NO_FIFO)) {
+	if (!(omap->flags & OMAP_I2C_FLAG_NO_FIFO)) {
 		u16 s;
 
 		/* Set up the fifo size - Get total size */
-		s = (omap_i2c_read_reg(dev, OMAP_I2C_BUFSTAT_REG) >> 14) & 0x3;
-		dev->fifo_size = 0x8 << s;
+		s = (omap_i2c_read_reg(omap, OMAP_I2C_BUFSTAT_REG) >> 14) & 0x3;
+		omap->fifo_size = 0x8 << s;
 
 		/*
 		 * Set up notification threshold as half the total available
@@ -1322,36 +1322,36 @@ omap_i2c_probe(struct platform_device *pdev)
 		 * call back latencies.
 		 */
 
-		dev->fifo_size = (dev->fifo_size / 2);
+		omap->fifo_size = (omap->fifo_size / 2);
 
-		if (dev->rev < OMAP_I2C_REV_ON_3630)
-			dev->b_hw = 1; /* Enable hardware fixes */
+		if (omap->rev < OMAP_I2C_REV_ON_3630)
+			omap->b_hw = 1; /* Enable hardware fixes */
 
 		/* calculate wakeup latency constraint for MPU */
-		if (dev->set_mpu_wkup_lat != NULL)
-			dev->latency = (1000000 * dev->fifo_size) /
-				       (1000 * dev->speed / 8);
+		if (omap->set_mpu_wkup_lat != NULL)
+			omap->latency = (1000000 * omap->fifo_size) /
+				       (1000 * omap->speed / 8);
 	}
 
 	/* reset ASAP, clearing any IRQs */
-	omap_i2c_init(dev);
+	omap_i2c_init(omap);
 
-	if (dev->rev < OMAP_I2C_OMAP1_REV_2)
-		r = devm_request_irq(&pdev->dev, dev->irq, omap_i2c_omap1_isr,
-				IRQF_NO_SUSPEND, pdev->name, dev);
+	if (omap->rev < OMAP_I2C_OMAP1_REV_2)
+		r = devm_request_irq(&pdev->dev, omap->irq, omap_i2c_omap1_isr,
+				IRQF_NO_SUSPEND, pdev->name, omap);
 	else
-		r = devm_request_threaded_irq(&pdev->dev, dev->irq,
+		r = devm_request_threaded_irq(&pdev->dev, omap->irq,
 				omap_i2c_isr, omap_i2c_isr_thread,
 				IRQF_NO_SUSPEND | IRQF_ONESHOT,
-				pdev->name, dev);
+				pdev->name, omap);
 
 	if (r) {
-		dev_err(dev->dev, "failure requesting irq %i\n", dev->irq);
+		dev_err(omap->dev, "failure requesting irq %i\n", omap->irq);
 		goto err_unuse_clocks;
 	}
 
-	adap = &dev->adapter;
-	i2c_set_adapdata(adap, dev);
+	adap = &omap->adapter;
+	i2c_set_adapdata(adap, omap);
 	adap->owner = THIS_MODULE;
 	adap->class = I2C_CLASS_DEPRECATED;
 	strlcpy(adap->name, "OMAP I2C adapter", sizeof(adap->name));
@@ -1363,21 +1363,21 @@ omap_i2c_probe(struct platform_device *pdev)
 	adap->nr = pdev->id;
 	r = i2c_add_numbered_adapter(adap);
 	if (r) {
-		dev_err(dev->dev, "failure adding adapter\n");
+		dev_err(omap->dev, "failure adding adapter\n");
 		goto err_unuse_clocks;
 	}
 
-	dev_info(dev->dev, "bus %d rev%d.%d at %d kHz\n", adap->nr,
-		 major, minor, dev->speed);
+	dev_info(omap->dev, "bus %d rev%d.%d at %d kHz\n", adap->nr,
+		 major, minor, omap->speed);
 
-	pm_runtime_mark_last_busy(dev->dev);
-	pm_runtime_put_autosuspend(dev->dev);
+	pm_runtime_mark_last_busy(omap->dev);
+	pm_runtime_put_autosuspend(omap->dev);
 
 	return 0;
 
 err_unuse_clocks:
-	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
-	pm_runtime_put(dev->dev);
+	omap_i2c_write_reg(omap, OMAP_I2C_CON_REG, 0);
+	pm_runtime_put(omap->dev);
 	pm_runtime_disable(&pdev->dev);
 err_free_mem:
 
@@ -1386,15 +1386,15 @@ err_free_mem:
 
 static int omap_i2c_remove(struct platform_device *pdev)
 {
-	struct omap_i2c_dev	*dev = platform_get_drvdata(pdev);
+	struct omap_i2c_dev	*omap = platform_get_drvdata(pdev);
 	int ret;
 
-	i2c_del_adapter(&dev->adapter);
+	i2c_del_adapter(&omap->adapter);
 	ret = pm_runtime_get_sync(&pdev->dev);
 	if (ret < 0)
 		return ret;
 
-	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
+	omap_i2c_write_reg(omap, OMAP_I2C_CON_REG, 0);
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	return 0;
@@ -1403,23 +1403,23 @@ static int omap_i2c_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM
 static int omap_i2c_runtime_suspend(struct device *dev)
 {
-	struct omap_i2c_dev *_dev = dev_get_drvdata(dev);
+	struct omap_i2c_dev *omap = dev_get_drvdata(dev);
 
-	_dev->iestate = omap_i2c_read_reg(_dev, OMAP_I2C_IE_REG);
+	omap->iestate = omap_i2c_read_reg(omap, OMAP_I2C_IE_REG);
 
-	if (_dev->scheme == OMAP_I2C_SCHEME_0)
-		omap_i2c_write_reg(_dev, OMAP_I2C_IE_REG, 0);
+	if (omap->scheme == OMAP_I2C_SCHEME_0)
+		omap_i2c_write_reg(omap, OMAP_I2C_IE_REG, 0);
 	else
-		omap_i2c_write_reg(_dev, OMAP_I2C_IP_V2_IRQENABLE_CLR,
+		omap_i2c_write_reg(omap, OMAP_I2C_IP_V2_IRQENABLE_CLR,
 				   OMAP_I2C_IP_V2_INTERRUPTS_MASK);
 
-	if (_dev->rev < OMAP_I2C_OMAP1_REV_2) {
-		omap_i2c_read_reg(_dev, OMAP_I2C_IV_REG); /* Read clears */
+	if (omap->rev < OMAP_I2C_OMAP1_REV_2) {
+		omap_i2c_read_reg(omap, OMAP_I2C_IV_REG); /* Read clears */
 	} else {
-		omap_i2c_write_reg(_dev, OMAP_I2C_STAT_REG, _dev->iestate);
+		omap_i2c_write_reg(omap, OMAP_I2C_STAT_REG, omap->iestate);
 
 		/* Flush posted write */
-		omap_i2c_read_reg(_dev, OMAP_I2C_STAT_REG);
+		omap_i2c_read_reg(omap, OMAP_I2C_STAT_REG);
 	}
 
 	return 0;
@@ -1427,12 +1427,12 @@ static int omap_i2c_runtime_suspend(struct device *dev)
 
 static int omap_i2c_runtime_resume(struct device *dev)
 {
-	struct omap_i2c_dev *_dev = dev_get_drvdata(dev);
+	struct omap_i2c_dev *omap = dev_get_drvdata(dev);
 
-	if (!_dev->regs)
+	if (!omap->regs)
 		return 0;
 
-	__omap_i2c_init(_dev);
+	__omap_i2c_init(omap);
 
 	return 0;
 }
-- 
2.4.4
