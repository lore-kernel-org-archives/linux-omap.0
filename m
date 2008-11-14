From: ext-eero.nurkkala@nokia.com
Subject: [PATCH] i2c: i2c-omap: Fix BUFSTAT_REG reading
Date: Fri, 14 Nov 2008 10:41:52 +0200
Message-ID: <12266521123866-git-send-email-ext-eero.nurkkala@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:49426 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821AbYKNIni (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Nov 2008 03:43:38 -0500
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mAE8hWsm013358
	for <linux-omap@vger.kernel.org>; Fri, 14 Nov 2008 10:43:36 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

The amount of bytes to receive is read from wrong
place. It is the 6 bits starting from the bit 8 from
BUFSTAT_REG that indicate this amount. Not the 8 LSB:s.
Only 6 LSB:s are used for the TX buffer. Also, with
omap 3430, only the 6 LSB:s are relevant for XDR.

Signed-off-by: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
---
 drivers/i2c/busses/i2c-omap.c |   25 +++++++++++++++++++------
 1 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index a999606..e708ebd 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -618,11 +618,19 @@ omap_i2c_isr(int this_irq, void *dev_id)
 		if (stat & (OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR)) {
 			u8 num_bytes = 1;
 			if (dev->fifo_size) {
-				if (stat & OMAP_I2C_STAT_RRDY)
+				if (stat & OMAP_I2C_STAT_RRDY) {
 					num_bytes = dev->fifo_size;
-				else
-					num_bytes = omap_i2c_read_reg(dev,
+				} else {
+					if (cpu_is_omap34xx())
+						num_bytes =
+							(omap_i2c_read_reg(dev,
+							 OMAP_I2C_BUFSTAT_REG)
+							 >> 8) & 0x3F;
+					else
+						num_bytes =
+							omap_i2c_read_reg(dev,
 							OMAP_I2C_BUFSTAT_REG);
+				}
 			}
 			while (num_bytes) {
 				num_bytes--;
@@ -657,11 +665,16 @@ omap_i2c_isr(int this_irq, void *dev_id)
 		if (stat & (OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR)) {
 			u8 num_bytes = 1;
 			if (dev->fifo_size) {
-				if (stat & OMAP_I2C_STAT_XRDY)
+				if (stat & OMAP_I2C_STAT_XRDY) {
 					num_bytes = dev->fifo_size;
-				else
-					num_bytes = omap_i2c_read_reg(dev,
+				} else {
+					num_bytes =
+						omap_i2c_read_reg(dev,
 							OMAP_I2C_BUFSTAT_REG);
+
+					if (cpu_is_omap34xx())
+						num_bytes &= 0x3F;
+				}
 			}
 			while (num_bytes) {
 				num_bytes--;
-- 
1.6.0

