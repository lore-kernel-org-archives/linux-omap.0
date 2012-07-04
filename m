From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH] ARM: architected timers: Mark the clockevent with the C3_STOP feature
Date: Wed, 4 Jul 2012 15:24:33 +0530
Message-ID: <1341395673-29660-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59078 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753541Ab2GDJy6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jul 2012 05:54:58 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Marc Zyngier <marc.zyngier@arm.com>

ARM arch timers stop in low power state and hence can not wakeup CPUs in
deeper idle states when used as cloc event devices. Marking these clock event
devices with C3_STOP so that during lowpower states, the tick is managed by
wakeup capable broadcast timer.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/kernel/arch_timer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/arch_timer.c b/arch/arm/kernel/arch_timer.c
index dd58035..df44c8c 100644
--- a/arch/arm/kernel/arch_timer.c
+++ b/arch/arm/kernel/arch_timer.c
@@ -137,7 +137,7 @@ static int __cpuinit arch_timer_setup(struct clock_event_device *clk)
 	/* Be safe... */
 	arch_timer_disable();
 
-	clk->features = CLOCK_EVT_FEAT_ONESHOT;
+	clk->features = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_C3STOP;
 	clk->name = "arch_sys_timer";
 	clk->rating = 450;
 	clk->set_mode = arch_timer_set_mode;
-- 
1.7.9.5

