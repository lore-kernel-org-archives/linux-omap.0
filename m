From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 16/19] omap3+: sr: disable spamming interrupts
Date: Sat, 19 Feb 2011 17:31:55 +0530
Message-ID: <1298116918-30744-17-git-send-email-nm@ti.com>
References: <1298116918-30744-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:42014 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754404Ab1BSMEP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 19 Feb 2011 07:04:15 -0500
Received: by gxk5 with SMTP id 5so119160gxk.17
        for <linux-omap@vger.kernel.org>; Sat, 19 Feb 2011 04:04:13 -0800 (PST)
In-Reply-To: <1298116918-30744-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Nishanth Menon <nm@ti.com>

At times with bad SR configurations especially during silicon bringups,
we could get continuous spurious interrupts which end up hanging the
platform in the form of an ISR call for status bits that are
automatically enabled by the h/w without any s/w clearing option.

If we detect scenarios where isr was called without the corresponding
notification bit being set, instead of hanging up the system,
we will disable interrupt after noting the event in the system log
to try and keep system sanity and allow developer to debug and fix
the condition.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index ad23b8d..0301186 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -209,8 +209,16 @@ static irqreturn_t sr_interrupt(int irq, void *data)
 		value = irqstat_to_notifier_v2(status);
 	}
 
-	if (sr_class->notify)
-		sr_class->notify(sr_info->voltdm, value);
+	/* Attempt some resemblence of recovery! */
+	if (!value) {
+		dev_err(&sr_info->pdev->dev, "%s: Spurious interrupt!"
+			"status = 0x%08x. Disabling to prevent spamming!!\n",
+			__func__, status);
+		disable_irq_nosync(sr_info->irq);
+	} else {
+		if (sr_class->notify)
+			sr_class->notify(sr_info->voltdm, value);
+	}
 
 	return IRQ_HANDLED;
 }
-- 
1.7.1

