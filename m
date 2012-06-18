From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHv8 12/13] I2C: OMAP: add blank lines
Date: Mon, 18 Jun 2012 20:00:27 +0530
Message-ID: <1340029828-20751-13-git-send-email-shubhrajyoti@ti.com>
References: <1340029828-20751-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43181 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752022Ab2FROb0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Jun 2012 10:31:26 -0400
In-Reply-To: <1340029828-20751-1-git-send-email-shubhrajyoti@ti.com>
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
index 0e0ab8f..6a79089 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -818,6 +818,7 @@ complete:
 			dev_err(dev->dev, "Arbitration lost\n");
 			err |= OMAP_I2C_STAT_AL;
 		}
+
 		/*
 		 * ProDB0017052: Clear ARDY bit twice
 		 */
@@ -830,6 +831,7 @@ complete:
 			omap_i2c_complete_cmd(dev, err);
 			return IRQ_HANDLED;
 		}
+
 		if (stat & (OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR)) {
 			u8 num_bytes = 1;
 
@@ -876,6 +878,7 @@ complete:
 				stat & (OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR));
 			continue;
 		}
+
 		if (stat & (OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR)) {
 			u8 num_bytes = 1;
 			if (dev->fifo_size) {
@@ -923,10 +926,12 @@ complete:
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

