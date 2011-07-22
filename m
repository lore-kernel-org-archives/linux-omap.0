From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 1/2] OMAP3+: PM: SR: use put_sync_suspend for disabling
Date: Fri, 22 Jul 2011 00:55:52 -0500
Message-ID: <1311314153-23531-2-git-send-email-nm@ti.com>
References: <1311314153-23531-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:58352 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753196Ab1GVF4L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Jul 2011 01:56:11 -0400
Received: by mail-gy0-f177.google.com with SMTP id 1so1130383gya.36
        for <linux-omap@vger.kernel.org>; Thu, 21 Jul 2011 22:56:10 -0700 (PDT)
In-Reply-To: <1311314153-23531-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin <khilman@ti.com>
Cc: Colin <ccross@google.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>

From: Colin Cross <ccross@google.com>

omap_sr_disable_reset_volt is called with irqs off in omapx_enter_sleep,
as part of idle sequence, this eventually calls sr_disable and
pm_runtime_put_sync. pm_runtime_put_sync calls rpm_idle, which will
enable interrupts in order to call the callback. In this short interval
when interrupts are enabled, scenarios such as the following can occur:
while interrupts are enabled, the timer interrupt that is supposed to
wake the device out of idle occurs and is acked, so when the CPU finally
goes to off, the timer is already gone, missing a wakeup event.

Further, as the documentation for runtime states:"
 However, subsystems can use the pm_runtime_irq_safe() helper function
 to tell the PM core that a device's ->runtime_suspend() and ->runtime_resume()
 callbacks should be invoked in atomic context with interrupts disabled
 (->runtime_idle() is still invoked the default way)."

Hence, replace pm_runtime_put_sync with pm_runtime_put_sync_suspend
to invoke the suspend handler and shut off the fclk for SmartReflex
module instead of using the idle handler in interrupt disabled context.

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Colin Cross <ccross@google.com>
---
 arch/arm/mach-omap2/smartreflex.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index fb7dc52..33a027f 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -622,7 +622,7 @@ void sr_disable(struct voltagedomain *voltdm)
 			sr_v2_disable(sr);
 	}
 
-	pm_runtime_put_sync(&sr->pdev->dev);
+	pm_runtime_put_sync_suspend(&sr->pdev->dev);
 }
 
 /**
-- 
1.7.4.1

