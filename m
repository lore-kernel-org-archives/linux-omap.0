From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 5/6] OMAP2/3: I2C: Errata ID i207: Clear wrong RDR interrupt
Date: Tue, 11 May 2010 11:35:20 -0700
Message-ID: <20100511183520.15596.58730.stgit@baageli.muru.com>
References: <20100511182854.15596.56293.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100511182854.15596.56293.stgit-XB442sTQ5VIxQTnqJstS8Q@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Manjunatha GK <manjugk-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Aaro Koskinen <Aaro.Koskinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Hema Kalliguddi <hemahk-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: manjugk manjugk <manjugk-l0cyMroinI0@public.gmane.org>

Under certain rare conditions, I2C_STAT[13].RDR bit may be set
and the corresponding interrupt fire, even there is no data in
the receive FIFO, or the I2C data transfer is still ongoing.
These spurious RDR events must be ignored by the software.

This patch handles and ignores RDR spurious interrupts.

The below sequence is required in interrupt handler for
handling this errata:
1. If RDR is set to 1, clear RDR
2. Read I2C status register and check for BusBusy bit. If BusBusy
bit is set, skip remaining steps.
3. If BusBusy bit is not set, perform read operation on I2C status
register.
4. If RDR is set, clear the same. Check RDR again and clear if it sets
RDR bit again.
5. Perform I2C Data Read operation N number of times(where N is value
read from the register BUFSTAT-RXSTAT bit fields).

Note:
This errata is not applicable for omap2420 and omap4.
It is applicable for:
1. omap2430
2. omap34xx(including omap3630).

Signed-off-by: Manjunatha GK <manjugk-l0cyMroinI0@public.gmane.org>
Cc: Hema Kalliguddi <hemahk-l0cyMroinI0@public.gmane.org>
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Aaro Koskinen <Aaro.Koskinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |   40 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 00fd02e..fdba131 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -166,6 +166,8 @@ enum {
 #define SYSC_IDLEMODE_SMART		0x2
 #define SYSC_CLOCKACTIVITY_FCLK		0x2
 
+/* Errata definitions */
+#define I2C_OMAP_ERRATA_I207		(1 << 0)
 
 struct omap_i2c_dev {
 	struct device		*dev;
@@ -199,6 +201,7 @@ struct omap_i2c_dev {
 	u16			bufstate;
 	u16			syscstate;
 	u16			westate;
+	u16			errata;
 };
 
 const static u8 reg_map[] = {
@@ -498,6 +501,11 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 	/* Take the I2C module out of reset: */
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
 
+	dev->errata = 0;
+
+	if (cpu_is_omap2430() || cpu_is_omap34xx())
+		dev->errata |= I2C_OMAP_ERRATA_I207;
+
 	/* Enable interrupts */
 	dev->iestate = (OMAP_I2C_IE_XRDY | OMAP_I2C_IE_RRDY |
 			OMAP_I2C_IE_ARDY | OMAP_I2C_IE_NACK |
@@ -695,6 +703,34 @@ omap_i2c_ack_stat(struct omap_i2c_dev *dev, u16 stat)
 	omap_i2c_write_reg(dev, OMAP_I2C_STAT_REG, stat);
 }
 
+static inline void i2c_omap_errata_i207(struct omap_i2c_dev *dev, u16 stat)
+{
+	/*
+	 * I2C Errata(Errata Nos. OMAP2: 1.67, OMAP3: 1.8)
+	 * Not applicable for OMAP4.
+	 * Under certain rare conditions, RDR could be set again
+	 * when the bus is busy, then ignore the interrupt and
+	 * clear the interrupt.
+	 */
+	if (stat & OMAP_I2C_STAT_RDR) {
+		/* Step 1: If RDR is set, clear it */
+		omap_i2c_ack_stat(dev, OMAP_I2C_STAT_RDR);
+
+		/* Step 2: */
+		if (!(omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG)
+						& OMAP_I2C_STAT_BB)) {
+
+			/* Step 3: */
+			if (omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG)
+						& OMAP_I2C_STAT_RDR) {
+				omap_i2c_ack_stat(dev, OMAP_I2C_STAT_RDR);
+				dev_dbg(dev->dev, "RDR when bus is busy.\n");
+			}
+
+		}
+	}
+}
+
 /* rev1 devices are apparently only on some 15xx */
 #ifdef CONFIG_ARCH_OMAP15XX
 
@@ -834,6 +870,10 @@ complete:
 		}
 		if (stat & (OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR)) {
 			u8 num_bytes = 1;
+
+			if (dev->errata & I2C_OMAP_ERRATA_I207)
+				i2c_omap_errata_i207(dev, stat);
+
 			if (dev->fifo_size) {
 				if (stat & OMAP_I2C_STAT_RRDY)
 					num_bytes = dev->fifo_size;
