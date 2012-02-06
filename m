From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH] ARM: OMAP4: cpuidle: Fix the C-state reporting to cpuidle governor.
Date: Mon, 6 Feb 2012 15:08:15 +0530
Message-ID: <1328521095-24025-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60762 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754050Ab2BFJiZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Feb 2012 04:38:25 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, khilman@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

OMAP4 cpuidle driver is reporting the state requested by governor rather than
the actually attempted one.

This is obviously misleading sysfs and powertop cpuidle statistics.
Fix it so that stats are reported correctly.

Reported-by: Kevin Hilman <khilman@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/cpuidle44xx.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index cfdbb86..f128489 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -85,6 +85,7 @@ static int omap4_enter_idle(struct cpuidle_device *dev,
 	cpu1_state = pwrdm_read_pwrst(cpu1_pd);
 	if (cpu1_state != PWRDM_POWER_OFF) {
 		new_state_idx = drv->safe_state_index;
+		index = drv->safe_state_index;
 		cx = cpuidle_get_statedata(&dev->states_usage[new_state_idx]);
 	}
 
-- 
1.7.4.1

