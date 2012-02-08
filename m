From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 16/16] ARM: omap: disable cpuidle for OMAP3 platforms
Date: Wed, 08 Feb 2012 16:41:11 +0000
Message-ID: <E1RvAZz-0006Hr-9C@rmk-PC.arm.linux.org.uk>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:35025 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755661Ab2BHQlP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 11:41:15 -0500
In-Reply-To: <20120208163546.GA15849@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, linux-arm-kernel@lists.infradead.org

Commit 2fd149645eb4 (ARM: OMAP2+: UART: Remove omap_uart_can_sleep and add pm_qos)
has caused a regression on OMAP3 platforms.

When the UART is trying to transmit data, if we enter a low power mode,
transmission stops, which makes serial on OMAP3 unusable - a 'dmesg'
takes five minutes to be output at 115200 baud, at a rate of around a
block of 16 characters every couple of seconds.

Unfortunately, the commit above can't be reverted because of many other
changes in this area, so this implements a dirty fix by disabling
CPU idle in the places the original commit does, irrespective of the
UART state.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/cpuidle34xx.c |    2 ++
 arch/arm/mach-omap2/pm34xx.c      |    2 +-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 464cffd..1e9256c 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -259,6 +259,8 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 	struct omap3_idle_statedata *cx;
 	int ret;
 
+	{ new_state_idx = drv->safe_state_index; goto select_state; }
+
 	/*
 	 * Prevent idle completely if CAM is active.
 	 * CAM does not have wakeup capability in OMAP3.
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index fc69875..88e95e6 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -421,7 +421,7 @@ static void omap3_pm_idle(void)
 	local_irq_disable();
 	local_fiq_disable();
 
-	if (omap_irq_pending() || need_resched())
+	if (omap_irq_pending() || need_resched() || 1)
 		goto out;
 
 	trace_power_start(POWER_CSTATE, 1, smp_processor_id());
-- 
1.7.4.4

