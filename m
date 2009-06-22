From: Ulrik Bech Hald <ubh@ti.com>
Subject: [PATCH 1/1] i2c:OMAP3:Errata workaround for spurious RDR event
Date: Mon, 22 Jun 2009 15:24:52 -0500
Message-ID: <1245702292-4383-1-git-send-email-ubh@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41685 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758102AbZFVUTq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Jun 2009 16:19:46 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n5MKJiQF003260
	for <linux-omap@vger.kernel.org>; Mon, 22 Jun 2009 15:19:49 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Ulrik Bech Hald <ubh@ti.com>

Under certain rare conditions, I2C_STAT[13].RDR bit may be set,
and the corresponding interrupt fire, even when there is no
data in the receive FIFO, or the I2C data transfer is still
ongoing. These spurious RDR events must be ignored by the
software.

A check for OMAP_I2C_STAT_BB is introduced in the ISR to
prevent further processing of RDR interrupt, if the bus is busy.

Signed-off-by: Ulrik Bech Hald <ubh@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index ece0125..88feea1 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -668,6 +668,15 @@ omap_i2c_isr(int this_irq, void *dev_id)
 			omap_i2c_complete_cmd(dev, err);
 		if (stat & (OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR)) {
 			u8 num_bytes = 1;
+			/* 3430 I2C Errata 1.15
+			 * RDR could be set when the bus is busy, then
+			 * ignore the interrupt, and clear the bit.
+			 */
+			u8 stat2 = 0;
+			stat2 = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
+			if (stat2 & OMAP_I2C_STAT_BB)
+				return IRQ_HANDLED;
+
 			if (dev->fifo_size) {
 				if (stat & OMAP_I2C_STAT_RRDY)
 					num_bytes = dev->fifo_size;
-- 
1.5.4.3

