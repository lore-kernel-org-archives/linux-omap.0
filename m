From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 4/4] I2C: OMAP3: PM: (re)init for every transfer to support off-mode
Date: Thu, 25 Jun 2009 14:34:06 -0700
Message-ID: <1245965646-20070-5-git-send-email-khilman@deeprootsystems.com>
References: <1245965646-20070-1-git-send-email-khilman@deeprootsystems.com>
 <1245965646-20070-2-git-send-email-khilman@deeprootsystems.com>
 <1245965646-20070-3-git-send-email-khilman@deeprootsystems.com>
 <1245965646-20070-4-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f210.google.com ([209.85.219.210]:58244 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754455AbZFYVe2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Jun 2009 17:34:28 -0400
Received: by mail-ew0-f210.google.com with SMTP id 6so2748369ewy.37
        for <linux-omap@vger.kernel.org>; Thu, 25 Jun 2009 14:34:31 -0700 (PDT)
In-Reply-To: <1245965646-20070-4-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>, Jouni Hogander <jouni.hogander@nokia.com>, Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>, Aaro Koskinen <aaro.koskinen@nokia.com>

From: Rajendra Nayak <rnayak@ti.com>

Because of OMAP off-mode, powerdomain can go off when I2C is idle.
Save enough state, and do a re-init for each transfer.

Additional save/restore state added by Jagadeesh Bhaskar Pakaravoor
(SYSC_REG) and Aaro Koskinen (wakeup sources.)

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 drivers/i2c/busses/i2c-omap.c |   59 +++++++++++++++++++++++++++--------------
 1 files changed, 39 insertions(+), 20 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index ad8d201..0a5d871 100644
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
@@ -230,9 +236,16 @@ static void omap_i2c_unidle(struct omap_i2c_dev *dev)
 
 	clk_enable(dev->iclk);
 	clk_enable(dev->fclk);
+	if (cpu_is_omap34xx()) {
+		omap_i2c_write_reg(dev, OMAP_I2C_PSC_REG, dev->pscstate);
+		omap_i2c_write_reg(dev, OMAP_I2C_SCLL_REG, dev->scllstate);
+		omap_i2c_write_reg(dev, OMAP_I2C_SCLH_REG, dev->sclhstate);
+		omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG, dev->bufstate);
+		omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG, dev->syscstate);
+		omap_i2c_write_reg(dev, OMAP_I2C_WE_REG, dev->westate);
+	}
 	dev->idle = 0;
-	if (dev->iestate)
-		omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, dev->iestate);
+	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, dev->iestate);
 }
 
 static void omap_i2c_idle(struct omap_i2c_dev *dev)
@@ -258,7 +271,7 @@ static void omap_i2c_idle(struct omap_i2c_dev *dev)
 
 static int omap_i2c_init(struct omap_i2c_dev *dev)
 {
-	u16 psc = 0, scll = 0, sclh = 0;
+	u16 psc = 0, scll = 0, sclh = 0, buf = 0;
 	u16 fsscll = 0, fssclh = 0, hsscll = 0, hssclh = 0;
 	unsigned long fclk_rate = 12000000;
 	unsigned long timeout;
@@ -289,21 +302,22 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 		} else if (dev->rev >= OMAP_I2C_REV_ON_3430) {
 			u32 v;
 
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
+			dev->westate = OMAP_I2C_WE_ALL;
+			omap_i2c_write_reg(dev, OMAP_I2C_WE_REG, dev->westate);
 
 		}
 	}
@@ -394,23 +408,28 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
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
1.6.3.2

