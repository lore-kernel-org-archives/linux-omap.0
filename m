From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 3/4] i2c: omap: remove unnecessary pm_runtime_suspended check
Date: Mon,  6 Aug 2012 17:18:56 +0300
Message-ID: <1344262737-6662-4-git-send-email-balbi@ti.com>
References: <1344262737-6662-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:51984 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756474Ab2HFOWm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Aug 2012 10:22:42 -0400
Received: by lbol12 with SMTP id l12so3120076lbo.30
        for <linux-omap@vger.kernel.org>; Mon, 06 Aug 2012 07:22:40 -0700 (PDT)
In-Reply-To: <1344262737-6662-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti Datta <shubhrajyoti@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, w.sang@pengutronix.de, Felipe Balbi <balbi@ti.com>

before starting any messages we call pm_runtime_get_sync()
which will make sure that by the time we program a transfer
and our IRQ handler gets called, we're not suspended
anymore.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/i2c/busses/i2c-omap.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index a3db053..60928f2 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -883,9 +883,6 @@ omap_i2c_isr_thread(int this_irq, void *dev_id)
 	u16 stat;
 	int err = 0, count = 0;
 
-	if (pm_runtime_suspended(dev->dev))
-		return IRQ_HANDLED;
-
 	spin_lock_irqsave(&dev->lock, flags);
 	do {
 		bits = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
-- 
1.7.12.rc0

