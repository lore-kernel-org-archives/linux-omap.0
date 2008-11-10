From: ext-eero.nurkkala@nokia.com
Subject: [PATCH] i2c: i2c-omap: Fix BUFSTAT_REG reading
Date: Mon, 10 Nov 2008 12:46:49 +0200
Message-ID: <12263140092601-git-send-email-ext-eero.nurkkala@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:64703 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754370AbYKJKsL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Nov 2008 05:48:11 -0500
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mAAAm70U023971
	for <linux-omap@vger.kernel.org>; Mon, 10 Nov 2008 12:48:08 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>


Signed-off-by: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
---
 drivers/i2c/busses/i2c-omap.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index f4d1edc..9ae3ad3 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -642,8 +642,9 @@ omap_i2c_isr(int this_irq, void *dev_id)
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
1.5.2

