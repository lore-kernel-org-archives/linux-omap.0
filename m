From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHv10 09/10] I2C: OMAP: Do not set the XUDF(Transmit underflow) if the underflow is not reached
Date: Mon, 14 May 2012 14:19:57 +0530
Message-ID: <1336985398-3291-10-git-send-email-shubhrajyoti@ti.com>
References: <1336985398-3291-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57825 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755107Ab2ENIvN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 May 2012 04:51:13 -0400
In-Reply-To: <1336985398-3291-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de, Shubhrajyoti D <shubhrajyoti@ti.com>, Alexander Shishkin <virtuoso@slind.org>

Currently in the 1.153 errata handling while waiting for transmitter
underflow if NACK is got the XUDF(Transmit underflow) flag is also set.
The flag is set after wait for the condition is over.

Cc: Alexander Shishkin <virtuoso@slind.org>
Acked-by: Moiz Sonasath <m-sonasath@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
- XUDF is expanded to transmit underflow

 drivers/i2c/busses/i2c-omap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 43b0efb..c0aa16b 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -730,7 +730,6 @@ static int errata_omap3_1p153(struct omap_i2c_dev *dev, u16 *stat, int *err)
 		if (*stat & (OMAP_I2C_STAT_NACK | OMAP_I2C_STAT_AL)) {
 			omap_i2c_ack_stat(dev, *stat & (OMAP_I2C_STAT_XRDY |
 							OMAP_I2C_STAT_XDR));
-			*err |= OMAP_I2C_STAT_XUDF;
 			return -ETIMEDOUT;
 		}
 
@@ -743,6 +742,7 @@ static int errata_omap3_1p153(struct omap_i2c_dev *dev, u16 *stat, int *err)
 		return 0;
 	}
 
+	*err |= OMAP_I2C_STAT_XUDF;
 	return 0;
 }
 
-- 
1.7.5.4

