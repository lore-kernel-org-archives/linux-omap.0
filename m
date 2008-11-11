From: ext-eero.nurkkala@nokia.com
Subject: [PATCH] i2c: i2c-omap: Fix BUFSTAT_REG reading
Date: Tue, 11 Nov 2008 08:51:55 +0200
Message-ID: <1226386315303-git-send-email-ext-eero.nurkkala@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:39748 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754565AbYKKGzK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2008 01:55:10 -0500
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mAB6rWCP030764
	for <linux-omap@vger.kernel.org>; Tue, 11 Nov 2008 08:53:34 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

The amount of bytes to receive is read from wrong
place. It is the 6 bits starting from the bit 8 from
BUFSTAT_REG that indicate this amount. Not the 8 LSB:s.
6 LSB:s are used for the TX buffer.

Signed-off-by: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
---
 drivers/i2c/busses/i2c-omap.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index a999606..f15668d 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -621,8 +621,9 @@ omap_i2c_isr(int this_irq, void *dev_id)
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
-- 
1.6.0

