From: Felipe Balbi <balbi@ti.com>
Subject: [RFC/PATCH 1/3] i2c/omap: drop the lock hard irq context
Date: Thu, 1 Aug 2013 15:12:43 +0300
Message-ID: <1375359165-8411-2-git-send-email-balbi@ti.com>
References: <1375359165-8411-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36497 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753815Ab3HAMOF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Aug 2013 08:14:05 -0400
In-Reply-To: <1375359165-8411-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Felipe Balbi <balbi@ti.com>

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The lock is taken while reading two registers. On RT the first lock is
taken in hard irq where it might sleep and in the threaded irq.
The threaded irq runs in oneshot mode so the hard irq does not run until
the thread the completes so there is no reason to grab the lock.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/i2c/busses/i2c-omap.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 142b694d..8ceb98a 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -884,15 +884,12 @@ omap_i2c_isr(int irq, void *dev_id)
 	u16 mask;
 	u16 stat;
 
-	spin_lock(&dev->lock);
-	mask = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
 	stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
+	mask = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
 
 	if (stat & mask)
 		ret = IRQ_WAKE_THREAD;
 
-	spin_unlock(&dev->lock);
-
 	return ret;
 }
 
-- 
1.8.3.4.840.g6a90778

