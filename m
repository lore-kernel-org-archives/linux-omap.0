From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: [PATCH] I2C: OMAP3: PM: (re)init for every transfer to support off-mode
Date: Mon, 23 Nov 2009 08:59:18 -0800
Message-ID: <1258995558-18048-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, Jouni Hogander <jouni.hogander-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Jagadeesh Bhaskar Pakaravoor <j-pakaravoor-l0cyMroinI0@public.gmane.org>, Aaro Koskinen <aaro.koskinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>, Hu Tao <taohu-3WKxDLwmzFNWk0Htik3J/w@public.gmane.org>, Xiaolong Chen <A21785-3WKxDLwmzFNWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>

Because of OMAP off-mode, powerdomain can go off when I2C is idle.
Save enough state, and do a re-init for each transfer.

Additional save/restore state added by Jagadeesh Bhaskar Pakaravoor
(SYSC_REG) and Aaro Koskinen (wakeup sources.)

Also, The OMAP3430 TRM states:

"During active mode (I2Ci.I2C_CON[15] I2C_EN bit is set to 1), make no
changes to the I2Ci.I2C_SCLL and I2Ci.I2C_SCLH registers.  Changes may
result in unpredictable behavior."

Hence, the I2C_EN bit should be clearer when modifying these
registers. Please note that clearing the entire I2C_CON register to
disable the I2C module is safe, because the I2C_CON register is
re-configured for each transfer.

Signed-off-by: Jouni Hogander <jouni.hogander-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
Cc: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor-l0cyMroinI0@public.gmane.org>
Cc: Aaro Koskinen <aaro.koskinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
Cc: Hu Tao <taohu-3WKxDLwmzFNWk0Htik3J/w@public.gmane.org>
Cc: Xiaolong Chen <A21785-3WKxDLwmzFNWk0Htik3J/w@public.gmane.org>
Signed-off-by: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
---
Originally posted on 21-july-2009 for the 2.6.32 merge window:

  http://marc.info/?l=linux-i2c&m=124821776627177&w=2

Please queue for 2.6.32-rc if still possible, or at least for 2.6.33.

 drivers/i2c/busses/i2c-omap.c |   64 ++++++++++++++++++++++++++--------------
 1 files changed, 41 insertions(+), 23 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 827da08..75bf3ad 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -178,6 +178,12 @@ struct omap_i2c_dev {
 	unsigned		b_hw:1;		/* bad h/w fixes */
 	unsigned		idle:1;
 	u16			iestate;	/* Saved interrupt register */
+	u16			pscstate;
+	u16			scllstate;
+	u16			sclhstate;
+	u16			bufstate;
+	u16			syscstate;
+	u16			westate;
 };
 
 static inline void omap_i2c_write_reg(struct omap_i2c_dev *i2c_dev,
@@ -230,9 +236,18 @@ static void omap_i2c_unidle(struct omap_i2c_dev *dev)
 
 	clk_enable(dev->iclk);
 	clk_enable(dev->fclk);
+	if (cpu_is_omap34xx()) {
+		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
+		omap_i2c_write_reg(dev, OMAP_I2C_PSC_REG, dev->pscstate);
+		omap_i2c_write_reg(dev, OMAP_I2C_SCLL_REG, dev->scllstate);
+		omap_i2c_write_reg(dev, OMAP_I2C_SCLH_REG, dev->sclhstate);
+		omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG, dev->bufstate);
+		omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG, dev->syscstate);
+		omap_i2c_write_reg(dev, OMAP_I2C_WE_REG, dev->westate);
+		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
+	}
 	dev->idle = 0;
-	if (dev->iestate)
-		omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, dev->iestate);
+	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, dev->iestate);
 }
 
 static void omap_i2c_idle(struct omap_i2c_dev *dev)
@@ -258,7 +273,7 @@ static void omap_i2c_idle(struct omap_i2c_dev *dev)
 
 static int omap_i2c_init(struct omap_i2c_dev *dev)
 {
-	u16 psc = 0, scll = 0, sclh = 0;
+	u16 psc = 0, scll = 0, sclh = 0, buf = 0;
 	u16 fsscll = 0, fssclh = 0, hsscll = 0, hssclh = 0;
 	unsigned long fclk_rate = 12000000;
 	unsigned long timeout;
@@ -287,24 +302,22 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 					   SYSC_AUTOIDLE_MASK);
 
 		} else if (dev->rev >= OMAP_I2C_REV_ON_3430) {
-			u32 v;
-
-			v = SYSC_AUTOIDLE_MASK;
-			v |= SYSC_ENAWAKEUP_MASK;
-			v |= (SYSC_IDLEMODE_SMART <<
+			dev->syscstate = SYSC_AUTOIDLE_MASK;
+			dev->syscstate |= SYSC_ENAWAKEUP_MASK;
+			dev->syscstate |= (SYSC_IDLEMODE_SMART <<
 			      __ffs(SYSC_SIDLEMODE_MASK));
-			v |= (SYSC_CLOCKACTIVITY_FCLK <<
+			dev->syscstate |= (SYSC_CLOCKACTIVITY_FCLK <<
 			      __ffs(SYSC_CLOCKACTIVITY_MASK));
 
-			omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG, v);
+			omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG,
+							dev->syscstate);
 			/*
 			 * Enabling all wakup sources to stop I2C freezing on
 			 * WFI instruction.
 			 * REVISIT: Some wkup sources might not be needed.
 			 */
-			omap_i2c_write_reg(dev, OMAP_I2C_WE_REG,
-							OMAP_I2C_WE_ALL);
-
+			dev->westate = OMAP_I2C_WE_ALL;
+			omap_i2c_write_reg(dev, OMAP_I2C_WE_REG, dev->westate);
 		}
 	}
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
@@ -394,23 +407,28 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 	omap_i2c_write_reg(dev, OMAP_I2C_SCLL_REG, scll);
 	omap_i2c_write_reg(dev, OMAP_I2C_SCLH_REG, sclh);
 
-	if (dev->fifo_size)
-		/* Note: setup required fifo size - 1 */
-		omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG,
-					(dev->fifo_size - 1) << 8 | /* RTRSH */
-					OMAP_I2C_BUF_RXFIF_CLR |
-					(dev->fifo_size - 1) | /* XTRSH */
-					OMAP_I2C_BUF_TXFIF_CLR);
+	if (dev->fifo_size) {
+		/* Note: setup required fifo size - 1. RTRSH and XTRSH */
+		buf = (dev->fifo_size - 1) << 8 | OMAP_I2C_BUF_RXFIF_CLR |
+			(dev->fifo_size - 1) | OMAP_I2C_BUF_TXFIF_CLR;
+		omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG, buf);
+	}
 
 	/* Take the I2C module out of reset: */
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
 
 	/* Enable interrupts */
-	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG,
-			(OMAP_I2C_IE_XRDY | OMAP_I2C_IE_RRDY |
+	dev->iestate = (OMAP_I2C_IE_XRDY | OMAP_I2C_IE_RRDY |
 			OMAP_I2C_IE_ARDY | OMAP_I2C_IE_NACK |
 			OMAP_I2C_IE_AL)  | ((dev->fifo_size) ?
-				(OMAP_I2C_IE_RDR | OMAP_I2C_IE_XDR) : 0));
+				(OMAP_I2C_IE_RDR | OMAP_I2C_IE_XDR) : 0);
+	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, dev->iestate);
+	if (cpu_is_omap34xx()) {
+		dev->pscstate = psc;
+		dev->scllstate = scll;
+		dev->sclhstate = sclh;
+		dev->bufstate = buf;
+	}
 	return 0;
 }
 
-- 
1.6.5.1
