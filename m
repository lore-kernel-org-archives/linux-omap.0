From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHv8 04/22] i2c: omap: add blank lines
Date: Wed, 12 Sep 2012 16:27:58 +0530
Message-ID: <1347447496-16793-5-git-send-email-shubhrajyoti@ti.com>
References: <1347447496-16793-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40572 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757221Ab2ILK7E (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Sep 2012 06:59:04 -0400
In-Reply-To: <1347447496-16793-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de, Felipe Balbi <balbi@ti.com>, Shubhrajyoti D <shubhrajyoti@ti.com>

From: Felipe Balbi <balbi@ti.com>

trivial patch to aid readability. No functional
changes.

Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 0dd647a..30ea63c 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -786,6 +786,7 @@ complete:
 			dev_err(dev->dev, "Arbitration lost\n");
 			err |= OMAP_I2C_STAT_AL;
 		}
+
 		/*
 		 * ProDB0017052: Clear ARDY bit twice
 		 */
@@ -798,6 +799,7 @@ complete:
 			omap_i2c_complete_cmd(dev, err);
 			return IRQ_HANDLED;
 		}
+
 		if (stat & (OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR)) {
 			u8 num_bytes = 1;
 
@@ -844,6 +846,7 @@ complete:
 				stat & (OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR));
 			continue;
 		}
+
 		if (stat & (OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR)) {
 			u8 num_bytes = 1;
 			if (dev->fifo_size) {
@@ -891,10 +894,12 @@ complete:
 				stat & (OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR));
 			continue;
 		}
+
 		if (stat & OMAP_I2C_STAT_ROVR) {
 			dev_err(dev->dev, "Receive overrun\n");
 			dev->cmd_err |= OMAP_I2C_STAT_ROVR;
 		}
+
 		if (stat & OMAP_I2C_STAT_XUDF) {
 			dev_err(dev->dev, "Transmit underflow\n");
 			dev->cmd_err |= OMAP_I2C_STAT_XUDF;
-- 
1.7.5.4

