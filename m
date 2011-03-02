From: Nishanth Menon <nm@ti.com>
Subject: [PATCH v2 15/18] omap3+: sr: disable spamming interrupts
Date: Wed,  2 Mar 2011 16:25:28 +0530
Message-ID: <1299063331-27968-16-git-send-email-nm@ti.com>
References: <1299063331-27968-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:46853 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757116Ab1CBK5v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 05:57:51 -0500
Received: by mail-yx0-f171.google.com with SMTP id 35so3110861yxh.2
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 02:57:50 -0800 (PST)
In-Reply-To: <1299063331-27968-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Kevin H <khilman@ti.com>, Tony L <tony@atomide.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>

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
index 49a04ea..d62da3d 100644
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

