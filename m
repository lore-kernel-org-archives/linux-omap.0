From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHv8 09/10] I2C: OMAP: Do not set the XUDF if the underflow is not reached
Date: Thu, 19 Apr 2012 18:58:20 +0530
Message-ID: <1334842101-20670-10-git-send-email-shubhrajyoti@ti.com>
References: <1334842101-20670-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43479 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752084Ab2DSN3A (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Apr 2012 09:29:00 -0400
In-Reply-To: <1334842101-20670-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de, Shubhrajyoti D <shubhrajyoti@ti.com>, Alexander Shishkin <virtuoso@slind.org>

Currently in the 1.153 errata handling while waiting for transmitter
underflow if NACK is got the XUDF flag is also set.
The flag is set after wait for the condition is over.

Cc: Alexander Shishkin <virtuoso@slind.org>
Acked-by: Moiz Sonasath <m-sonasath@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 9323201..d12b319 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -732,7 +732,6 @@ static int errata_omap3_1p153(struct omap_i2c_dev *dev, u16 *stat, int *err)
 		if (*stat & (OMAP_I2C_STAT_NACK | OMAP_I2C_STAT_AL)) {
 			omap_i2c_ack_stat(dev, *stat & (OMAP_I2C_STAT_XRDY |
 							OMAP_I2C_STAT_XDR));
-			*err |= OMAP_I2C_STAT_XUDF;
 			return -ETIMEDOUT;
 		}
 
@@ -745,6 +744,7 @@ static int errata_omap3_1p153(struct omap_i2c_dev *dev, u16 *stat, int *err)
 		return 0;
 	}
 
+	*err |= OMAP_I2C_STAT_XUDF;
 	return 0;
 }
 
-- 
1.7.5.4

