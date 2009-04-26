From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/2] I2C: OMAP: overhaul the rev2+ interrupt service routine
	and omap_i2c_xfer_msg()
Date: Sat, 25 Apr 2009 22:28:18 -0600
Message-ID: <20090426042810.31316.77958.stgit@localhost.localdomain>
References: <20090426042504.31316.68357.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:59246 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462AbZDZEns (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 26 Apr 2009 00:43:48 -0400
In-Reply-To: <20090426042504.31316.68357.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Ari Kauppi <ext-ari.kauppi@nokia.com>, Eero Nurkkala <ext-eero.nurkkala@nokia.com>

High I2C transmit activity can cause spurious IRQs.  This patch
restructures the i2c-omap.c interrupt service routine to reduce these
and to clean up the driver.

Correctness:

- Move the test for receive FIFO overflows and transmit FIFO underflows
  up to the top of the ISR.  This ensures that they will be caught
  even if RRDY, RDR, XRDY, XDR interrupts occur.

- Ignore the transmit FIFO underflow flag if it occurs before we've
  written any data into the FIFO, since we expect it to occur then.
  (OMAP_I2C_XUDF_EXPECTED flag)

- Remove double-clears of the interrupt status register via
  omap_i2c_ack_stat().

- When starting I2C activity, flush posted writes to clear the I2C
  FIFOs and to start/stop the I2C bus

- Clear the interrupt status register _after_ all of the interrupt
  events have been processed, not before.

Clean up:

- Remove an unnecessary device register read in the ISR by using the
  dev->iestate cached register.

With this patch applied, I was unable to trigger any I2C spurious IRQs
after a couple of hours of continuous transmission on I2C1.  It's hard =
to
say with complete certainty that all the spurious interrupts are gone.
Without RTL access, it's hard to be sure of the correct state machine
sequence.  The IP block may be so bugged that we may have to add a
readback after each __raw_writew().

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Ari Kauppi <ext-ari.kauppi@nokia.com>
Cc: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
---
 drivers/i2c/busses/i2c-omap.c |  101 ++++++++++++++++++++++++++-------=
--------
 1 files changed, 63 insertions(+), 38 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-oma=
p.c
index 387a2d3..9f14040 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -2,7 +2,7 @@
  * TI OMAP I2C master mode driver
  *
  * Copyright (C) 2003 MontaVista Software, Inc.
- * Copyright (C) 2005 Nokia Corporation
+ * Copyright (C) 2005, 2009 Nokia Corporation
  * Copyright (C) 2004 - 2007 Texas Instruments.
  *
  * Originally written by MontaVista Software, Inc.
@@ -12,6 +12,7 @@
  *	Juha Yrj=C3=B6l=C3=A4 <juha.yrjola@solidboot.com>
  *	Syed Khasim <x0khasim@ti.com>
  *	Nishant Menon <nm@ti.com>
+ *	Paul Walmsley <paul@pwsan.com>
  *
  * This program is free software; you can redistribute it and/or modif=
y
  * it under the terms of the GNU General Public License as published b=
y
@@ -159,10 +160,10 @@
 #define SYSC_IDLEMODE_SMART		0x2
 #define SYSC_CLOCKACTIVITY_FCLK		0x2
=20
-
 /* omap_i2c_dev.flags */
 #define OMAP_I2C_BAD_HW			(1 << 0)  /* bad hardware */
 #define OMAP_I2C_IDLE			(1 << 1)  /* device clocks off */
+#define OMAP_I2C_XUDF_EXPECTED		(1 << 2)  /* no data xmitted yet */
=20
 struct omap_i2c_dev {
 	struct device		*dev;
@@ -197,6 +198,18 @@ static inline u16 omap_i2c_read_reg(struct omap_i2=
c_dev *i2c_dev, int reg)
 	return __raw_readw(i2c_dev->base + reg);
 }
=20
+static inline void omap_i2c_posted_write_barrier(struct omap_i2c_dev *=
i2c_dev)
+{
+	omap_i2c_read_reg(i2c_dev, OMAP_I2C_SYSC_REG);
+}
+
+static inline void omap_i2c_write_nonposted_reg(struct omap_i2c_dev *i=
2c_dev,
+						int reg, u16 val)
+{
+	omap_i2c_write_reg(i2c_dev, reg, val);
+	omap_i2c_posted_write_barrier(i2c_dev);
+}
+
 static inline void omap_i2c_set_flag(struct omap_i2c_dev *i2c_dev, u8 =
flag_mask)
 {
 	i2c_dev->flags |=3D flag_mask;
@@ -261,10 +274,9 @@ static void omap_i2c_idle(struct omap_i2c_dev *dev=
)
 	if (dev->rev < OMAP_I2C_REV_2) {
 		omap_i2c_read_reg(dev, OMAP_I2C_IV_REG); /* Read clears */
 	} else {
-		omap_i2c_write_reg(dev, OMAP_I2C_STAT_REG, dev->iestate);
-
 		/* Flush posted write before setting the idle flag */
-		omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
+		omap_i2c_write_nonposted_reg(dev, OMAP_I2C_STAT_REG,
+					     dev->iestate);
 	}
 	omap_i2c_set_flag(dev, OMAP_I2C_IDLE);
 	clk_disable(dev->fclk);
@@ -400,11 +412,12 @@ static int omap_i2c_init(struct omap_i2c_dev *dev=
)
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
=20
 	/* Enable interrupts */
-	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG,
-			(OMAP_I2C_IE_XRDY | OMAP_I2C_IE_RRDY |
+	dev->iestate =3D (OMAP_I2C_IE_XRDY | OMAP_I2C_IE_RRDY |
 			OMAP_I2C_IE_ARDY | OMAP_I2C_IE_NACK |
 			OMAP_I2C_IE_AL)  | ((dev->fifo_size) ?
-				(OMAP_I2C_IE_RDR | OMAP_I2C_IE_XDR) : 0));
+					    (OMAP_I2C_IE_RDR | OMAP_I2C_IE_XDR) : 0);
+	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, dev->iestate);
+
 	return 0;
 }
=20
@@ -454,11 +467,13 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *=
adap,
 	/* Clear the FIFO Buffers */
 	w =3D omap_i2c_read_reg(dev, OMAP_I2C_BUF_REG);
 	w |=3D OMAP_I2C_BUF_RXFIF_CLR | OMAP_I2C_BUF_TXFIF_CLR;
-	omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG, w);
+	omap_i2c_write_nonposted_reg(dev, OMAP_I2C_BUF_REG, w);
=20
 	init_completion(&dev->cmd_complete);
 	dev->cmd_err =3D 0;
=20
+	omap_i2c_set_flag(dev, OMAP_I2C_XUDF_EXPECTED);
+
 	w =3D OMAP_I2C_CON_EN | OMAP_I2C_CON_MST | OMAP_I2C_CON_STT;
=20
 	/* High speed configuration */
@@ -480,6 +495,7 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *ad=
ap,
 	 */
 	if ((dev->flags & OMAP_I2C_BAD_HW) && stop) {
 		unsigned long delay =3D jiffies + OMAP_I2C_TIMEOUT;
+		/* The following also acts as a posted write barrier */
 		u16 con =3D omap_i2c_read_reg(dev, OMAP_I2C_CON_REG);
 		while (con & OMAP_I2C_CON_STT) {
 			con =3D omap_i2c_read_reg(dev, OMAP_I2C_CON_REG);
@@ -498,6 +514,8 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *ad=
ap,
 		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, w);
 	}
=20
+	omap_i2c_posted_write_barrier(dev);
+
 	/*
 	 * REVISIT: We should abort the transfer on signals, but the bus goes
 	 * into arbitration and we're currently unable to recover from it.
@@ -529,7 +547,7 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *ad=
ap,
 		if (stop) {
 			w =3D omap_i2c_read_reg(dev, OMAP_I2C_CON_REG);
 			w |=3D OMAP_I2C_CON_STP;
-			omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, w);
+			omap_i2c_write_nonposted_reg(dev, OMAP_I2C_CON_REG, w);
 		}
 		return -EREMOTEIO;
 	}
@@ -580,12 +598,6 @@ omap_i2c_complete_cmd(struct omap_i2c_dev *dev, u1=
6 err)
 	complete(&dev->cmd_complete);
 }
=20
-static inline void
-omap_i2c_ack_stat(struct omap_i2c_dev *dev, u16 stat)
-{
-	omap_i2c_write_reg(dev, OMAP_I2C_STAT_REG, stat);
-}
-
 /* rev1 devices are apparently only on some 15xx */
 #ifdef CONFIG_ARCH_OMAP15XX
=20
@@ -651,26 +663,36 @@ static irqreturn_t
 omap_i2c_isr(int this_irq, void *dev_id)
 {
 	struct omap_i2c_dev *dev =3D dev_id;
-	u16 bits;
 	u16 stat, w;
 	int err, count =3D 0;
=20
 	if (dev->flags & OMAP_I2C_IDLE)
 		return IRQ_NONE;
=20
-	bits =3D omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
-	while ((stat =3D (omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG))) & bits)=
 {
+	/* This also acts as a posted write barrier as the ISR loops */
+	while ((stat =3D (omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG))) & dev->=
iestate) {
+
 		dev_dbg(dev->dev, "IRQ (ISR =3D 0x%04x)\n", stat);
 		if (count++ =3D=3D 100) {
 			dev_warn(dev->dev, "Too much work in one IRQ\n");
 			break;
 		}
=20
-		omap_i2c_write_reg(dev, OMAP_I2C_STAT_REG, stat);
-
 		err =3D 0;
+
+		if (stat & OMAP_I2C_STAT_ROVR) {
+			dev_err(dev->dev, "Receive overrun\n");
+			dev->cmd_err |=3D OMAP_I2C_STAT_ROVR;
+		}
+		if (stat & OMAP_I2C_STAT_XUDF &&
+		    !(dev->flags & OMAP_I2C_XUDF_EXPECTED)) {
+			dev_err(dev->dev, "Transmit underflow\n");
+			dev->cmd_err |=3D OMAP_I2C_STAT_XUDF;
+		}
+
 		if (stat & OMAP_I2C_STAT_NACK) {
 			err |=3D OMAP_I2C_STAT_NACK;
+			/* XXX should not be necessary per TRM */
 			omap_i2c_write_reg(dev, OMAP_I2C_CON_REG,
 					   OMAP_I2C_CON_STP);
 		}
@@ -678,9 +700,7 @@ omap_i2c_isr(int this_irq, void *dev_id)
 			dev_err(dev->dev, "Arbitration lost\n");
 			err |=3D OMAP_I2C_STAT_AL;
 		}
-		if (stat & (OMAP_I2C_STAT_ARDY | OMAP_I2C_STAT_NACK |
-					OMAP_I2C_STAT_AL))
-			omap_i2c_complete_cmd(dev, err);
+
 		if (stat & (OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR)) {
 			u8 num_bytes =3D 1;
 			if (dev->fifo_size) {
@@ -717,9 +737,6 @@ omap_i2c_isr(int this_irq, void *dev_id)
 					break;
 				}
 			}
-			omap_i2c_ack_stat(dev,
-				stat & (OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR));
-			continue;
 		}
 		if (stat & (OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR)) {
 			u8 num_bytes =3D 1;
@@ -758,18 +775,26 @@ omap_i2c_isr(int this_irq, void *dev_id)
 				}
 				omap_i2c_write_reg(dev, OMAP_I2C_DATA_REG, w);
 			}
-			omap_i2c_ack_stat(dev,
-				stat & (OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR));
-			continue;
-		}
-		if (stat & OMAP_I2C_STAT_ROVR) {
-			dev_err(dev->dev, "Receive overrun\n");
-			dev->cmd_err |=3D OMAP_I2C_STAT_ROVR;
-		}
-		if (stat & OMAP_I2C_STAT_XUDF) {
-			dev_err(dev->dev, "Transmit underflow\n");
-			dev->cmd_err |=3D OMAP_I2C_STAT_XUDF;
+			omap_i2c_clear_flag(dev, OMAP_I2C_XUDF_EXPECTED);
+
+			/*
+			 * It seems that there must be some delay between
+			 * writing to the FIFO and clearing the interrupt
+			 * status register
+			 */
+			omap_i2c_posted_write_barrier(dev);
 		}
+
+		/*
+		 * Ensure the device interrupt clears before the
+		 * MPUINTC unmasks the IRQ line - avoiding spurious
+		 * IRQs
+		 */
+		omap_i2c_write_reg(dev, OMAP_I2C_STAT_REG, stat);
+
+		if (stat & (OMAP_I2C_STAT_ARDY | OMAP_I2C_STAT_NACK |
+			    OMAP_I2C_STAT_AL))
+			omap_i2c_complete_cmd(dev, err);
 	}
=20
 	return count ? IRQ_HANDLED : IRQ_NONE;


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
