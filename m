From: jean.pihet@newoldbits.com
Subject: [PATCH 4/6] ARM: OMAP3+: SmartReflex: disable spamming interrupts
Date: Tue, 13 Mar 2012 11:26:19 +0100
Message-ID: <1331634381-31436-5-git-send-email-j-pihet@ti.com>
References: <1331634381-31436-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:62731 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030344Ab2CMK0x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Mar 2012 06:26:53 -0400
Received: by mail-wi0-f178.google.com with SMTP id hq7so577560wib.1
        for <linux-omap@vger.kernel.org>; Tue, 13 Mar 2012 03:26:52 -0700 (PDT)
In-Reply-To: <1331634381-31436-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Jean Pihet <j-pihet@ti.com>

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

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |   21 +++++++++++++++++++--
 1 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index dfe8075..8a10c0a 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -223,8 +223,25 @@ static irqreturn_t sr_interrupt(int irq, void *data)
 		return IRQ_NONE;
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

