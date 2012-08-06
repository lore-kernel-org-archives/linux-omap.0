From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 1/4] i2c: omap: always return IRQ_HANDLED
Date: Mon,  6 Aug 2012 17:18:54 +0300
Message-ID: <1344262737-6662-2-git-send-email-balbi@ti.com>
References: <1344262737-6662-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:57816 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756474Ab2HFOWh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Aug 2012 10:22:37 -0400
Received: by lahj13 with SMTP id j13so1222088lah.25
        for <linux-omap@vger.kernel.org>; Mon, 06 Aug 2012 07:22:35 -0700 (PDT)
In-Reply-To: <1344262737-6662-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti Datta <shubhrajyoti@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, w.sang@pengutronix.de, Felipe Balbi <balbi@ti.com>

even if our clocks are disabled, we still
handled the IRQ, so we should return IRQ_HANDLED.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/i2c/busses/i2c-omap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 2dd2301..f5eafb7 100644
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
1.7.12.rc0

