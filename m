From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHv7 19/23] i2c: omap: always return IRQ_HANDLED
Date: Tue, 11 Sep 2012 15:12:14 +0530
Message-ID: <1347356538-23835-20-git-send-email-shubhrajyoti@ti.com>
References: <1347356538-23835-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60453 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758618Ab2IKJnj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Sep 2012 05:43:39 -0400
In-Reply-To: <1347356538-23835-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de, Felipe Balbi <balbi@ti.com>, Shubhrajyoti D <shubhrajyoti@ti.com>

From: Felipe Balbi <balbi@ti.com>

even if our clocks are disabled, we still
handled the IRQ, so we should return IRQ_HANDLED.

Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 498a462..4a696bd 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -862,7 +862,7 @@ omap_i2c_isr(int this_irq, void *dev_id)
 	int err = 0, count = 0;
 
 	if (pm_runtime_suspended(dev->dev))
-		return IRQ_NONE;
+		return IRQ_HANDLED;
 
 	do {
 		bits = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
-- 
1.7.5.4

