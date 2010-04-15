From: Manjunatha GK <manjugk-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3] OMAP2/3: I2C: Errata ID i207: Clear wrong RDR interrupt
Date: Thu, 15 Apr 2010 16:44:47 +0530
Message-ID: <1271330087-26084-1-git-send-email-manjugk@ti.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Manjunatha GK <manjugk-l0cyMroinI0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, "Kalliguddi, Hema" <hemahk-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

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

Note : This errata is applicable for OMAP2 and OMAP3 platforms only.
It is not applicable for OMAP4.

Signed-off-by: Manjunatha GK <manjugk-l0cyMroinI0@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
Cc: Kalliguddi, Hema <hemahk-l0cyMroinI0@public.gmane.org>
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>

---
 drivers/i2c/busses/i2c-omap.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index ae6f5c1..d1648da 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -733,6 +733,34 @@ complete:
 		}
 		if (stat & (OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR)) {
 			u8 num_bytes = 1;
+
+			/*
+			 * I2C Errata(Errata Nos. OMAP2: 1.67, OMAP3: 1.8)
+			 * Not applicable for OMAP4.
+			 * Under certain rare conditions, RDR could be set again
+			 * when the bus is busy, then ignore the interrupt and
+			 * clear the interrupt.
+			 */
+			if ((stat & OMAP_I2C_STAT_RDR) && !cpu_is_omap44xx()) {
+				/* Step 1: If RDR is set, clear it */
+				omap_i2c_ack_stat(dev, stat & OMAP_I2C_STAT_RDR);
+
+				/* Step 2: */
+				if(!(omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG)
+							& OMAP_I2C_STAT_BB)) {
+					/* Step 3: */
+					if(omap_i2c_read_reg(dev,
+						OMAP_I2C_STAT_REG)
+							& OMAP_I2C_STAT_RDR) {
+						omap_i2c_ack_stat(dev, stat
+							& OMAP_I2C_STAT_RDR);
+						dev_err(dev->dev,
+						"I2C : RDR when the bus is busy.\n");
+						continue;
+					}
+
+				}
+			}
 			if (dev->fifo_size) {
 				if (stat & OMAP_I2C_STAT_RRDY)
 					num_bytes = dev->fifo_size;
-- 
1.6.0.4
