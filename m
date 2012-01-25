From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 15/21] OMAP3+: SR: disable spamming interrupts
Date: Wed, 25 Jan 2012 16:16:17 +0100
Message-ID: <1327504583-13408-16-git-send-email-j-pihet@ti.com>
References: <1327504583-13408-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:34423 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753649Ab2AYPRJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jan 2012 10:17:09 -0500
Received: by mail-ww0-f44.google.com with SMTP id ed3so5390421wgb.1
        for <linux-omap@vger.kernel.org>; Wed, 25 Jan 2012 07:17:08 -0800 (PST)
In-Reply-To: <1327504583-13408-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, nm@ti.com
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Jean Pihet <j-pihet@ti.com>

From: Nishanth Menon <nm@ti.com>

At times with bad SR configurations, especially during silicon bring-ups,
we could get continuous spurious interrupts which end up hanging the
platform in the form of an ISR call for status bits that are
automatically enabled by the hardware without any software clearing
option.

If we detect scenarios where ISR was called without the corresponding
notification bit being set, instead of hanging up the system,
we will disable interrupt after noting the event in the system log
to try and keep system sanity and allow developer to debug and fix
the condition.

Change-Id: I2eeb25ef18e4465f41b2462d13bfd60e1b1e8d7c
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |   21 +++++++++++++++++++--
 1 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index a24a228..6971b94 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -215,8 +215,25 @@ static irqreturn_t sr_interrupt(int irq, void *data)
 		value = irqstat_to_notifier_v2(status);
 	}
 
-	if (sr_class->notify)
-		sr_class->notify(sr_info->voltdm, value);
+	/* Attempt some resemblance of recovery! */
+	if (!value) {
+		dev_err(&sr_info->pdev->dev, "%s: Spurious interrupt!"
+			"status = 0x%08x. Disabling to prevent spamming!!\n",
+			__func__, status);
+		disable_irq_nosync(sr_info->irq);
+		sr_info->irq_enabled = false;
+	} else {
+		/* If the caller reports inability to handle, disable as well */
+		if (sr_class->notify &&
+		    sr_class->notify(sr_info->voltdm, value)) {
+			dev_err(&sr_info->pdev->dev, "%s: Callback cant handle!"
+				"status=0x%08x. Disabling to prevent spam!!\n",
+				__func__, status);
+			disable_irq_nosync(sr_info->irq);
+			sr_info->irq_enabled = false;
+		}
+
+	}
 
 	return IRQ_HANDLED;
 }
-- 
1.7.5.4

