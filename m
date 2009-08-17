From: Unknown <unknown@unknown.invalid>
Subject: [PATCH 2/3] i2c-omap: ACK pending [R/X]DR and [R/X]RDY interrupts
Date: Mon, 17 Aug 2009 17:42:10 -0500
Message-ID: <30989.2262601808$1250548667@news.gmane.org>
References: <1250548931-18279-1-git-send-email-n>
 <1250548931-18279-2-git-send-email-n>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45277 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758259AbZHQWhY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Aug 2009 18:37:24 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n7HMbLRd002850
	for <linux-omap@vger.kernel.org>; Mon, 17 Aug 2009 17:37:26 -0500
From: n@lina0132712
In-Reply-To: <1250548931-18279-2-git-send-email-n>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Moiz Sonasath <m-sonasath@ti.com>, Vikram Pandita <vikram.pandita@ti.com>

From: Moiz Sonasath <m-sonasath@ti.com>

ACK any pending read/write interrupts before exiting the ISR either after 
completing the operation [ARDY interrupt] or in case of an error 
[NACK|AL interrupt]

Signed-off-by: Moiz Sonasath <m-sonasath@ti.com>
Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 94639d0..16b39f4 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -694,6 +694,9 @@ complete:
 		}
 		if (stat & (OMAP_I2C_STAT_ARDY | OMAP_I2C_STAT_NACK |
 					OMAP_I2C_STAT_AL)) {
+			omap_i2c_ack_stat(dev, stat &
+				(OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR |
+				OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR));
 			omap_i2c_complete_cmd(dev, err);
 			return IRQ_HANDLED;
 		}
-- 
1.5.6.3

