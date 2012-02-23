From: Nishanth Menon <nm@ti.com>
Subject: [PATCH] MFD: TWL 6030: make twl6030_irq_set_wake static
Date: Wed, 22 Feb 2012 20:03:59 -0600
Message-ID: <1329962639-29800-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:60156 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754851Ab2BWCDw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Feb 2012 21:03:52 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>

twl6030_irq_set_wake is not used anywhere else in the kernel
except as irq_chip.irq_set_wake. No reason for it to be exported.

Also fixes build warning:
drivers/mfd/twl6030-irq.c:230:5: warning: symbol 'twl6030_irq_set_wake' was not declared. Should it be static?

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/mfd/twl6030-irq.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mfd/twl6030-irq.c b/drivers/mfd/twl6030-irq.c
index aa367a2..3c2cc00 100644
--- a/drivers/mfd/twl6030-irq.c
+++ b/drivers/mfd/twl6030-irq.c
@@ -236,7 +236,7 @@ static inline void activate_irq(int irq)
 #endif
 }
 
-int twl6030_irq_set_wake(struct irq_data *d, unsigned int on)
+static int twl6030_irq_set_wake(struct irq_data *d, unsigned int on)
 {
 	if (on)
 		atomic_inc(&twl6030_wakeirqs);
-- 
1.7.5.4

