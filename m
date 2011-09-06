From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH] mfd: twl6030: Setup irq_wake infrastructure.
Date: Tue, 6 Sep 2011 21:29:30 +0530
Message-ID: <1315324770-14530-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35665 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754598Ab1IFP7k (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Sep 2011 11:59:40 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

TWL6030 devices have an interrupt line which is connected to
application processor like OMAP. These devices support multiple features
such as MMC card detect, USB cable detect, RTC interrupt, etc. that must
wake up the application processor.

With this change, TWL6030 client drivers can make use of
irq_wake() if the wakeup is desirable on it's irq events.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
cc: Samuel Ortiz <sameo@linux.intel.com>
---
 drivers/mfd/twl6030-irq.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/twl6030-irq.c b/drivers/mfd/twl6030-irq.c
index eb3b5f8..4477134 100644
--- a/drivers/mfd/twl6030-irq.c
+++ b/drivers/mfd/twl6030-irq.c
@@ -187,6 +187,13 @@ static inline void activate_irq(int irq)
 #endif
 }
 
+int twl6030_irq_set_wake(struct irq_data *d, unsigned int on)
+{
+	int twl_irq = (int)irq_get_chip_data(d->irq);
+
+	return irq_set_irq_wake(twl_irq, on);
+}
+
 /*----------------------------------------------------------------------*/
 
 static unsigned twl6030_irq_next;
@@ -318,10 +325,12 @@ int twl6030_init_irq(int irq_num, unsigned irq_base, unsigned irq_end)
 	twl6030_irq_chip = dummy_irq_chip;
 	twl6030_irq_chip.name = "twl6030";
 	twl6030_irq_chip.irq_set_type = NULL;
+	twl6030_irq_chip.irq_set_wake = twl6030_irq_set_wake;
 
 	for (i = irq_base; i < irq_end; i++) {
 		irq_set_chip_and_handler(i, &twl6030_irq_chip,
 					 handle_simple_irq);
+		irq_set_chip_data(i, (void *)irq_num);
 		activate_irq(i);
 	}
 
-- 
1.7.4.1

