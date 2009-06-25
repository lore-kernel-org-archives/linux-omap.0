From: Nishanth Menon <nm@ti.com>
Subject: [PATCH] I2C:OMAP: fix status ack
Date: Thu, 25 Jun 2009 02:40:01 -0500
Message-ID: <1245915601-6575-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47727 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753722AbZFYHkH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Jun 2009 03:40:07 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n5P7e5lY004134
	for <linux-omap@vger.kernel.org>; Thu, 25 Jun 2009 02:40:10 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: L-o <linux-omap@vger.kernel.org>
Cc: Jagadeesh <j-pakaravoor@ti.com>, Ulrik <ubh@ti.com>, Nishanth Menon <nm@ti.com>

I2C status ack for [RX]RDR and [RX]RDY could
cause race conditions of clearing the event
twice and a violation of the programing
sequence as defined in TRM This patch fixes
the same.

Issue identified by Jagadeesh Pakaravoor
and Ulrik Bech Hald.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index ece0125..0db0051 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -651,7 +651,14 @@ omap_i2c_isr(int this_irq, void *dev_id)
 			break;
 		}
 
-		omap_i2c_write_reg(dev, OMAP_I2C_STAT_REG, stat);
+		/*
+		 * Ack the stat in one go, but [rx]dr and [rx]rdy should be
+		 * acked after the data operation is complete.
+		 * Ref: TRM SWPU114Q Figure 18-31
+		 */
+		omap_i2c_write_reg(dev, OMAP_I2C_STAT_REG, stat &
+				~(OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR |
+				OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR));
 
 		err = 0;
 		if (stat & OMAP_I2C_STAT_NACK) {
-- 
1.5.4.3

