From: Moiz Sonasath <m-sonasath@ti.com>
Subject: [PATCH 2/3] i2c-omap: ACK pending [R/X]DR and [R/X]RDY interrupts
Date: Thu, 20 Aug 2009 11:21:15 -0500
Message-ID: <1250785276-31713-3-git-send-email-m-sonasath@ti.com>
References: <1250785276-31713-1-git-send-email-m-sonasath@ti.com>
 <1250785276-31713-2-git-send-email-m-sonasath@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53366 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754863AbZHTQQd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 Aug 2009 12:16:33 -0400
In-Reply-To: <1250785276-31713-2-git-send-email-m-sonasath@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-omap@vger.kernel.org, ben-linux@fluff.org, Moiz Sonasath <m-sonasath@ti.com>, Vikram Pandita <vikram.pandita@ti.com>

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

