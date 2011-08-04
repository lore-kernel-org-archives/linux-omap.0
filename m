From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 5/6] OMAP2+: PM: SmartReflex: use put_sync_suspend for IRQ-safe disabling
Date: Thu,  4 Aug 2011 08:45:09 -0700
Message-ID: <1312472710-31758-6-git-send-email-khilman@ti.com>
References: <1312472710-31758-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:38988 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754478Ab1HDPor (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Aug 2011 11:44:47 -0400
Received: by mail-pz0-f47.google.com with SMTP id 2so1747959pzk.6
        for <linux-omap@vger.kernel.org>; Thu, 04 Aug 2011 08:44:45 -0700 (PDT)
In-Reply-To: <1312472710-31758-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

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
[khilman@ti.com: minor Subject edits]
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index dc8e86a..34c01a7 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -621,7 +621,7 @@ void sr_disable(struct voltagedomain *voltdm)
 			sr_v2_disable(sr);
 	}
 
-	pm_runtime_put_sync(&sr->pdev->dev);
+	pm_runtime_put_sync_suspend(&sr->pdev->dev);
 }
 
 /**
-- 
1.7.6

