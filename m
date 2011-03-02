From: Nishanth Menon <nm@ti.com>
Subject: [PATCH v2 07/18] omap3+: sr: make notify independent of class
Date: Wed,  2 Mar 2011 16:25:20 +0530
Message-ID: <1299063331-27968-8-git-send-email-nm@ti.com>
References: <1299063331-27968-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:45030 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757128Ab1CBK4o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 05:56:44 -0500
Received: by mail-yw0-f47.google.com with SMTP id 8so2308478ywg.20
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 02:56:43 -0800 (PST)
In-Reply-To: <1299063331-27968-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Kevin H <khilman@ti.com>, Tony L <tony@atomide.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>

Interrupt notification mechanism of SmartReflex can be used by the
choice of implementation of the class driver. For example, Class 2 and
Class 1.5 of SmartReflex can both use the interrupt notification to
identify the transition of voltage or other events.

Hence, the actual class does not matter for notifier. Let the class
driver's handling decide how it should be used. smartreflex driver
should provide just the primitives.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index a1f532e..08e1ee4 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -142,7 +142,7 @@ static irqreturn_t sr_interrupt(int irq, void *data)
 		sr_write_reg(sr_info, IRQSTATUS, status);
 	}
 
-	if (sr_class->class_type == SR_CLASS2 && sr_class->notify)
+	if (sr_class->notify)
 		sr_class->notify(sr_info->voltdm, status);
 
 	return IRQ_HANDLED;
@@ -257,9 +257,7 @@ static int sr_late_init(struct omap_sr *sr_info)
 	struct resource *mem;
 	int ret = 0;
 
-	if (sr_class->class_type == SR_CLASS2 &&
-		sr_class->notify_flags && sr_info->irq) {
-
+	if (sr_class->notify && sr_class->notify_flags && sr_info->irq) {
 		name = kasprintf(GFP_KERNEL, "sr_%s", sr_info->voltdm->name);
 		if (name == NULL) {
 			ret = -ENOMEM;
-- 
1.7.1

