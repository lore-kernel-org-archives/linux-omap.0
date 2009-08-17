From: Moiz Sonasath <m-sonasath@ti.com>
Subject: [PATCH 1/3] i2c-omap: Fix I2C status ACK
Date: Mon, 17 Aug 2009 17:45:44 -0500
Message-ID: <1250549146-18362-2-git-send-email-m-sonasath@ti.com>
References: <1250549146-18362-1-git-send-email-m-sonasath@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35724 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758265AbZHQWk5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Aug 2009 18:40:57 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n7HMerv4017220
	for <linux-omap@vger.kernel.org>; Mon, 17 Aug 2009 17:40:58 -0500
In-Reply-To: <1250549146-18362-1-git-send-email-m-sonasath@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Moiz Sonasath <m-sonasath@ti.com>

From: Nishanth Menon <nm@ti.com>

I2C status ack for [RX]RDR and [RX]RDY could
cause race conditions of clearing the event
twice and a violation of the programing
sequence as defined in TRM This patch fixes
the same.

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Moiz Sonasath <m-sonasath@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index d258b02..94639d0 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -674,7 +674,14 @@ omap_i2c_isr(int this_irq, void *dev_id)
 
 		err = 0;
 complete:
-		omap_i2c_write_reg(dev, OMAP_I2C_STAT_REG, stat);
+		/*
+		 * Ack the stat in one go, but [R/X]DR and [R/X]RDY should be
+		 * acked after the data operation is complete.
+		 * Ref: TRM SWPU114Q Figure 18-31
+		 */
+		omap_i2c_write_reg(dev, OMAP_I2C_STAT_REG, stat &
+				~(OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR |
+				OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR));
 
 		if (stat & OMAP_I2C_STAT_NACK) {
 			err |= OMAP_I2C_STAT_NACK;
-- 
1.5.6.3

