From: Kalle Jokiniemi <kalle.jokiniemi@jollamobile.com>
Subject: [PATCH 1/1] twl4030: Fix chained irq handling on resume from suspend
Date: Tue, 16 Oct 2012 17:59:35 +0300
Message-ID: <1350399575-13240-1-git-send-email-kalle.jokiniemi@jollamobile.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp130.iad.emailsrvr.com ([207.97.245.130]:38752 "EHLO
	smtp130.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754905Ab2JPO7m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Oct 2012 10:59:42 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, sameo@linux.intel.com
Cc: khilman@deeprootsystems.com, omaplinuxkernel@gmail.com, linux-i2c@vger.kernel.org, w.sang@pengutronix.de, linux-omap@vger.kernel.org, grygorii.strashko@ti.com, shubhrajyoti@ti.com, huzefank@ti.com, nm@ti.com, Kalle Jokiniemi <kalle.jokiniemi@jollamobile.com>

The irqs are enabled one-by-one in pm core resume_noirq phase.
This leads to situation where the twl4030 primary interrupt
handler (PIH) is enabled before the chained secondary handlers
(SIH). As the PIH cannot clear the pending interrupt, and
SIHs have not been enabled yet, a flood of interrupts hangs
the device.

Fixed the issue by setting the SIH irqs with IRQF_EARLY_RESUME
flags, so they get enabled before the PIH.

Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@jollamobile.com>
---
 drivers/mfd/twl4030-irq.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mfd/twl4030-irq.c b/drivers/mfd/twl4030-irq.c
index ad733d7..cdd1173 100644
--- a/drivers/mfd/twl4030-irq.c
+++ b/drivers/mfd/twl4030-irq.c
@@ -672,7 +672,8 @@ int twl4030_sih_setup(struct device *dev, int module, int irq_base)
 	irq = sih_mod + twl4030_irq_base;
 	irq_set_handler_data(irq, agent);
 	agent->irq_name = kasprintf(GFP_KERNEL, "twl4030_%s", sih->name);
-	status = request_threaded_irq(irq, NULL, handle_twl4030_sih, 0,
+	status = request_threaded_irq(irq, NULL, handle_twl4030_sih,
+				      IRQF_EARLY_RESUME,
 				      agent->irq_name ?: sih->name, NULL);
 
 	dev_info(dev, "%s (irq %d) chaining IRQs %d..%d\n", sih->name,
-- 
1.7.4.1

