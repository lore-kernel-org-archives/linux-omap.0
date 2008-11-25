From: ext-eero.nurkkala@nokia.com
Subject: [PATCH] i2c: i2c-omap: Fix BUFSTAT_REG reading
Date: Tue, 25 Nov 2008 13:03:46 +0200
Message-ID: <12276110261037-git-send-email-ext-eero.nurkkala@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:51056 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752762AbYKYLEA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Nov 2008 06:04:00 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mAPB3hJP026652
	for <linux-omap@vger.kernel.org>; Tue, 25 Nov 2008 05:03:59 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

The number of bytes to be received is read from wrong
place with all OMAPs with highspeed I2C support,
which involves a FIFO and BUFSTAT_REG. It is the 6
bits starting from the bit 8 in the BUFSTAT_REG
that indicate this amount of bytes to be read.
Moreover, only the 6 LSB:s are relevant for the 
TXSTAT field. 

Signed-off-by: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
---
 drivers/i2c/busses/i2c-omap.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 96f3bed..71b37ed 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -675,8 +675,9 @@ omap_i2c_isr(int this_irq, void *dev_id)
 				if (stat & OMAP_I2C_STAT_RRDY)
 					num_bytes = dev->fifo_size;
 				else
-					num_bytes = omap_i2c_read_reg(dev,
-							OMAP_I2C_BUFSTAT_REG);
+					num_bytes = (omap_i2c_read_reg(dev,
+							OMAP_I2C_BUFSTAT_REG)
+							>> 8) & 0x3F;
 			}
 			while (num_bytes) {
 				num_bytes--;
@@ -714,8 +715,9 @@ omap_i2c_isr(int this_irq, void *dev_id)
 				if (stat & OMAP_I2C_STAT_XRDY)
 					num_bytes = dev->fifo_size;
 				else
-					num_bytes = omap_i2c_read_reg(dev,
-							OMAP_I2C_BUFSTAT_REG);
+					num_bytes = (omap_i2c_read_reg(dev,
+							OMAP_I2C_BUFSTAT_REG))
+							& 0x3F;
 			}
 			while (num_bytes) {
 				num_bytes--;
-- 
1.6.0

