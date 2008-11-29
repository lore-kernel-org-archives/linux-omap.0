From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 04/12] i2c-omap: FIFO handling support and broken hw
	workaround for i2c-omap
Date: Fri, 28 Nov 2008 17:34:16 -0800
Message-ID: <20081129013416.13428.4500.stgit@localhost>
References: <20081129013318.13428.88465.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58425 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753231AbYK2BeP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Nov 2008 20:34:15 -0500
In-Reply-To: <20081129013318.13428.88465.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-i2c@vger.kernel.org, ben-linux@fluff.org
Cc: Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, Jason P Marini <jason.marini@gmail.com>

From: Nishanth Menon <nm@ti.com>

Based on an earlier patch from Nishant Menon:

- Transfers can use FIFO on FIFO capable devices
- Prevents errors for HSI2C if FIFO is not used
- Implemented errenous handling of STT-STP handling on SDP2430

Also merged in is a fix from Jaron Marini to fix occasional i2c
hang if OMAP_I2C_CON_STT remains asserted.

Signed-off-by: Jason P Marini <jason.marini@gmail.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/i2c/busses/i2c-omap.c |  190 ++++++++++++++++++++++++++++++++---------
 1 files changed, 150 insertions(+), 40 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index b0aa0f8..9ae4b74 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -55,8 +55,11 @@
 #define OMAP_I2C_SCLL_REG		0x34
 #define OMAP_I2C_SCLH_REG		0x38
 #define OMAP_I2C_SYSTEST_REG		0x3c
+#define OMAP_I2C_BUFSTAT_REG		0x40
 
 /* I2C Interrupt Enable Register (OMAP_I2C_IE): */
+#define OMAP_I2C_IE_XDR		(1 << 14)	/* TX Buffer drain int enable */
+#define OMAP_I2C_IE_RDR		(1 << 13)	/* RX Buffer drain int enable */
 #define OMAP_I2C_IE_XRDY	(1 << 4)	/* TX data ready int enable */
 #define OMAP_I2C_IE_RRDY	(1 << 3)	/* RX data ready int enable */
 #define OMAP_I2C_IE_ARDY	(1 << 2)	/* Access ready int enable */
@@ -64,7 +67,8 @@
 #define OMAP_I2C_IE_AL		(1 << 0)	/* Arbitration lost int ena */
 
 /* I2C Status Register (OMAP_I2C_STAT): */
-#define OMAP_I2C_STAT_SBD	(1 << 15)	/* Single byte data */
+#define OMAP_I2C_STAT_XDR	(1 << 14)	/* TX Buffer draining */
+#define OMAP_I2C_STAT_RDR	(1 << 13)	/* RX Buffer draining */
 #define OMAP_I2C_STAT_BB	(1 << 12)	/* Bus busy */
 #define OMAP_I2C_STAT_ROVR	(1 << 11)	/* Receive overrun */
 #define OMAP_I2C_STAT_XUDF	(1 << 10)	/* Transmit underflow */
@@ -78,12 +82,14 @@
 
 /* I2C Buffer Configuration Register (OMAP_I2C_BUF): */
 #define OMAP_I2C_BUF_RDMA_EN	(1 << 15)	/* RX DMA channel enable */
+#define OMAP_I2C_BUF_RXFIF_CLR	(1 << 14)	/* RX FIFO Clear */
 #define OMAP_I2C_BUF_XDMA_EN	(1 << 7)	/* TX DMA channel enable */
+#define OMAP_I2C_BUF_TXFIF_CLR	(1 << 6)	/* TX FIFO Clear */
 
 /* I2C Configuration Register (OMAP_I2C_CON): */
 #define OMAP_I2C_CON_EN		(1 << 15)	/* I2C module enable */
 #define OMAP_I2C_CON_BE		(1 << 14)	/* Big endian mode */
-#define OMAP_I2C_CON_OPMODE	(1 << 12)	/* High Speed support */
+#define OMAP_I2C_CON_OPMODE_HS	(1 << 12)	/* High Speed support */
 #define OMAP_I2C_CON_STB	(1 << 11)	/* Start byte mode (master) */
 #define OMAP_I2C_CON_MST	(1 << 10)	/* Master/slave mode */
 #define OMAP_I2C_CON_TRX	(1 << 9)	/* TX/RX mode (master only) */
@@ -127,7 +133,12 @@ struct omap_i2c_dev {
 	u8			*buf;
 	size_t			buf_len;
 	struct i2c_adapter	adapter;
+	u8			fifo_size;	/* use as flag and value
+						 * fifo_size==0 implies no fifo
+						 * if set, should be trsh+1
+						 */
 	unsigned		rev1:1;
+	unsigned		b_hw:1;		/* bad h/w fixes */
 	unsigned		idle:1;
 	u16			iestate;	/* Saved interrupt register */
 };
@@ -297,6 +308,14 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 	omap_i2c_write_reg(dev, OMAP_I2C_SCLL_REG, scll);
 	omap_i2c_write_reg(dev, OMAP_I2C_SCLH_REG, sclh);
 
+	if (dev->fifo_size)
+		/* Note: setup required fifo size - 1 */
+		omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG,
+					(dev->fifo_size - 1) << 8 | /* RTRSH */
+					OMAP_I2C_BUF_RXFIF_CLR |
+					(dev->fifo_size - 1) | /* XTRSH */
+					OMAP_I2C_BUF_TXFIF_CLR);
+
 	/* Take the I2C module out of reset: */
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
 
@@ -304,7 +323,8 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG,
 			   (OMAP_I2C_IE_XRDY | OMAP_I2C_IE_RRDY |
 			    OMAP_I2C_IE_ARDY | OMAP_I2C_IE_NACK |
-			    OMAP_I2C_IE_AL));
+			    OMAP_I2C_IE_AL)  | ((dev->fifo_size) ?
+				(OMAP_I2C_IE_RDR | OMAP_I2C_IE_XDR) : 0));
 	return 0;
 }
 
@@ -351,6 +371,11 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 
 	omap_i2c_write_reg(dev, OMAP_I2C_CNT_REG, dev->buf_len);
 
+	/* Clear the FIFO Buffers */
+	w = omap_i2c_read_reg(dev, OMAP_I2C_BUF_REG);
+	w |= OMAP_I2C_BUF_RXFIF_CLR | OMAP_I2C_BUF_TXFIF_CLR;
+	omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG, w);
+
 	init_completion(&dev->cmd_complete);
 	dev->cmd_err = 0;
 
@@ -358,17 +383,40 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 
 	/* High speed configuration */
 	if (dev->speed > 400)
-		w |= OMAP_I2C_CON_OPMODE;
+		w |= OMAP_I2C_CON_OPMODE_HS;
 
 	if (msg->flags & I2C_M_TEN)
 		w |= OMAP_I2C_CON_XA;
 	if (!(msg->flags & I2C_M_RD))
 		w |= OMAP_I2C_CON_TRX;
-	if (stop)
+	if (!dev->b_hw && stop)
 		w |= OMAP_I2C_CON_STP;
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, w);
 
 	/*
+	 * Don't write stt and stp together on some hardware.
+	 */
+	if (dev->b_hw && stop) {
+		unsigned long delay = jiffies + OMAP_I2C_TIMEOUT;
+		u16 con = omap_i2c_read_reg(dev, OMAP_I2C_CON_REG);
+		while (con & OMAP_I2C_CON_STT) {
+			con = omap_i2c_read_reg(dev, OMAP_I2C_CON_REG);
+
+			/* Let the user know if i2c is in a bad state */
+			if (time_after(jiffies, delay)) {
+				dev_err(dev->dev, "controller timed out "
+				"waiting for start condition to finish\n");
+				return -ETIMEDOUT;
+			}
+			cpu_relax();
+		}
+
+		w |= OMAP_I2C_CON_STP;
+		w &= ~OMAP_I2C_CON_STT;
+		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, w);
+	}
+
+	/*
 	 * REVISIT: We should abort the transfer on signals, but the bus goes
 	 * into arbitration and we're currently unable to recover from it.
 	 */
@@ -516,7 +564,7 @@ omap_i2c_isr(int this_irq, void *dev_id)
 	struct omap_i2c_dev *dev = dev_id;
 	u16 bits;
 	u16 stat, w;
-	int count = 0;
+	int err, count = 0;
 
 	if (dev->idle)
 		return IRQ_NONE;
@@ -531,39 +579,94 @@ omap_i2c_isr(int this_irq, void *dev_id)
 
 		omap_i2c_write_reg(dev, OMAP_I2C_STAT_REG, stat);
 
-		if (stat & OMAP_I2C_STAT_ARDY) {
-			omap_i2c_complete_cmd(dev, 0);
-			continue;
+		err = 0;
+		if (stat & OMAP_I2C_STAT_NACK) {
+			err |= OMAP_I2C_STAT_NACK;
+			omap_i2c_write_reg(dev, OMAP_I2C_CON_REG,
+					   OMAP_I2C_CON_STP);
 		}
-		if (stat & OMAP_I2C_STAT_RRDY) {
-			w = omap_i2c_read_reg(dev, OMAP_I2C_DATA_REG);
-			if (dev->buf_len) {
-				*dev->buf++ = w;
-				dev->buf_len--;
+		if (stat & OMAP_I2C_STAT_AL) {
+			dev_err(dev->dev, "Arbitration lost\n");
+			err |= OMAP_I2C_STAT_AL;
+		}
+		if (stat & (OMAP_I2C_STAT_ARDY | OMAP_I2C_STAT_NACK |
+					OMAP_I2C_STAT_AL))
+			omap_i2c_complete_cmd(dev, err);
+		if (stat & (OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR)) {
+			u8 num_bytes = 1;
+			if (dev->fifo_size) {
+				if (stat & OMAP_I2C_STAT_RRDY)
+					num_bytes = dev->fifo_size;
+				else
+					num_bytes = omap_i2c_read_reg(dev,
+							OMAP_I2C_BUFSTAT_REG);
+			}
+			while (num_bytes) {
+				num_bytes--;
+				w = omap_i2c_read_reg(dev, OMAP_I2C_DATA_REG);
 				if (dev->buf_len) {
-					*dev->buf++ = w >> 8;
+					*dev->buf++ = w;
 					dev->buf_len--;
+					/* Data reg from 2430 is 8 bit wide */
+					if (!cpu_is_omap2430()) {
+						if (dev->buf_len) {
+							*dev->buf++ = w >> 8;
+							dev->buf_len--;
+						}
+					}
+				} else {
+					if (stat & OMAP_I2C_STAT_RRDY)
+						dev_err(dev->dev,
+							"RRDY IRQ while no data"
+								" requested\n");
+					if (stat & OMAP_I2C_STAT_RDR)
+						dev_err(dev->dev,
+							"RDR IRQ while no data"
+								" requested\n");
+					break;
 				}
-			} else
-				dev_err(dev->dev, "RRDY IRQ while no data "
-						"requested\n");
-			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_RRDY);
+			}
+			omap_i2c_ack_stat(dev,
+				stat & (OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR));
 			continue;
 		}
-		if (stat & OMAP_I2C_STAT_XRDY) {
-			w = 0;
-			if (dev->buf_len) {
-				w = *dev->buf++;
-				dev->buf_len--;
+		if (stat & (OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR)) {
+			u8 num_bytes = 1;
+			if (dev->fifo_size) {
+				if (stat & OMAP_I2C_STAT_XRDY)
+					num_bytes = dev->fifo_size;
+				else
+					num_bytes = omap_i2c_read_reg(dev,
+							OMAP_I2C_BUFSTAT_REG);
+			}
+			while (num_bytes) {
+				num_bytes--;
+				w = 0;
 				if (dev->buf_len) {
-					w |= *dev->buf++ << 8;
+					w = *dev->buf++;
 					dev->buf_len--;
+					/* Data reg from  2430 is 8 bit wide */
+					if (!cpu_is_omap2430()) {
+						if (dev->buf_len) {
+							w |= *dev->buf++ << 8;
+							dev->buf_len--;
+						}
+					}
+				} else {
+					if (stat & OMAP_I2C_STAT_XRDY)
+						dev_err(dev->dev,
+							"XRDY IRQ while no "
+							"data to send\n");
+					if (stat & OMAP_I2C_STAT_XDR)
+						dev_err(dev->dev,
+							"XDR IRQ while no "
+							"data to send\n");
+					break;
 				}
-			} else
-				dev_err(dev->dev, "XRDY IRQ while no "
-					"data to send\n");
-			omap_i2c_write_reg(dev, OMAP_I2C_DATA_REG, w);
-			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_XRDY);
+				omap_i2c_write_reg(dev, OMAP_I2C_DATA_REG, w);
+			}
+			omap_i2c_ack_stat(dev,
+				stat & (OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR));
 			continue;
 		}
 		if (stat & OMAP_I2C_STAT_ROVR) {
@@ -571,18 +674,9 @@ omap_i2c_isr(int this_irq, void *dev_id)
 			dev->cmd_err |= OMAP_I2C_STAT_ROVR;
 		}
 		if (stat & OMAP_I2C_STAT_XUDF) {
-			dev_err(dev->dev, "Transmit overflow\n");
+			dev_err(dev->dev, "Transmit underflow\n");
 			dev->cmd_err |= OMAP_I2C_STAT_XUDF;
 		}
-		if (stat & OMAP_I2C_STAT_NACK) {
-			omap_i2c_complete_cmd(dev, OMAP_I2C_STAT_NACK);
-			omap_i2c_write_reg(dev, OMAP_I2C_CON_REG,
-					   OMAP_I2C_CON_STP);
-		}
-		if (stat & OMAP_I2C_STAT_AL) {
-			dev_err(dev->dev, "Arbitration lost\n");
-			omap_i2c_complete_cmd(dev, OMAP_I2C_STAT_AL);
-		}
 	}
 
 	return count ? IRQ_HANDLED : IRQ_NONE;
@@ -651,6 +745,22 @@ omap_i2c_probe(struct platform_device *pdev)
 	if (cpu_is_omap15xx())
 		dev->rev1 = omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) < 0x20;
 
+	if (cpu_is_omap2430()) {
+		u16 s;
+
+		/* Set up the fifo size - Get total size */
+		s = (omap_i2c_read_reg(dev, OMAP_I2C_BUFSTAT_REG) >> 14) & 0x3;
+		dev->fifo_size = 0x8 << s;
+
+		/*
+		 * Set up notification threshold as half the total available
+		 * size. This is to ensure that we can handle the status on int
+		 * call back latencies.
+		 */
+		dev->fifo_size = (dev->fifo_size / 2);
+		dev->b_hw = 1; /* Enable hardware fixes */
+	}
+
 	/* reset ASAP, clearing any IRQs */
 	omap_i2c_init(dev);
 

