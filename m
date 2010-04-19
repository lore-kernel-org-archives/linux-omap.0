From: Manjunatha GK <manjugk@ti.com>
Subject: [PATCH v4] OMAP2/3: I2C: Errata ID i207: Clear wrong RDR interrupt
Date: Mon, 19 Apr 2010 12:44:22 +0530
Message-ID: <1271661262-10538-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57999 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751282Ab0DSGxi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Apr 2010 02:53:38 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Manjunatha GK <manjugk@ti.com>, linux-i2c@vger.kernel.org, ben-linux@fluff.org, "Kalliguddi, Hema" <hemahk@ti.com>, Nishanth Menon <nm@ti.com>, Aaro Koskinen <Aaro.Koskinen@nokia.com>

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

Signed-off-by: Manjunatha GK <manjugk@ti.com>
Cc: linux-i2c@vger.kernel.org
Cc: ben-linux@fluff.org
Cc: Kalliguddi, Hema <hemahk@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Aaro Koskinen <Aaro.Koskinen@nokia.com>

---
 drivers/i2c/busses/i2c-omap.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index f2019d2..8309eac 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -796,6 +796,34 @@ complete:
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
+				omap_i2c_ack_stat(dev, OMAP_I2C_STAT_RDR);
+
+				/* Step 2: */
+				if(!(omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG)
+							& OMAP_I2C_STAT_BB)) {
+					/* Step 3: */
+					if(omap_i2c_read_reg(dev,
+						OMAP_I2C_STAT_REG)
+							& OMAP_I2C_STAT_RDR) {
+						omap_i2c_ack_stat(dev,
+							OMAP_I2C_STAT_RDR);
+						dev_err(dev->dev,
+						"RDR when the bus is busy.\n");
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

