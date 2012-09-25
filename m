From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv6 01/11] ARM: OMAP: clockdomain: Fix locking on _clkdm_clk_hwmod_enable / disable
Date: Tue, 25 Sep 2012 19:05:32 +0300
Message-ID: <1348589142-11983-2-git-send-email-t-kristo@ti.com>
References: <1348589142-11983-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48068 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754277Ab2IYQF4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Sep 2012 12:05:56 -0400
In-Reply-To: <1348589142-11983-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Previously the code only acquired spinlock after increasing / decreasing
the usecount value, which is wrong. This leaves a small window where
a task switch may occur between the check of the usecount and the actual
wakeup / sleep of the domain. Fixed by moving the spinlock locking before
the usecount access. Left the usecount as atomic_t if someone wants an
easy access to the parameter through atomic_read.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clockdomain.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 8664f5a..173905d 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -914,15 +914,18 @@ static int _clkdm_clk_hwmod_enable(struct clockdomain *clkdm)
 	if (!clkdm || !arch_clkdm || !arch_clkdm->clkdm_clk_enable)
 		return -EINVAL;
 
+	spin_lock_irqsave(&clkdm->lock, flags);
+
 	/*
 	 * For arch's with no autodeps, clkcm_clk_enable
 	 * should be called for every clock instance or hwmod that is
 	 * enabled, so the clkdm can be force woken up.
 	 */
-	if ((atomic_inc_return(&clkdm->usecount) > 1) && autodeps)
+	if ((atomic_inc_return(&clkdm->usecount) > 1) && autodeps) {
+		spin_unlock_irqrestore(&clkdm->lock, flags);
 		return 0;
+	}
 
-	spin_lock_irqsave(&clkdm->lock, flags);
 	arch_clkdm->clkdm_clk_enable(clkdm);
 	pwrdm_state_switch(clkdm->pwrdm.ptr);
 	spin_unlock_irqrestore(&clkdm->lock, flags);
@@ -939,15 +942,19 @@ static int _clkdm_clk_hwmod_disable(struct clockdomain *clkdm)
 	if (!clkdm || !arch_clkdm || !arch_clkdm->clkdm_clk_disable)
 		return -EINVAL;
 
+	spin_lock_irqsave(&clkdm->lock, flags);
+
 	if (atomic_read(&clkdm->usecount) == 0) {
+		spin_unlock_irqrestore(&clkdm->lock, flags);
 		WARN_ON(1); /* underflow */
 		return -ERANGE;
 	}
 
-	if (atomic_dec_return(&clkdm->usecount) > 0)
+	if (atomic_dec_return(&clkdm->usecount) > 0) {
+		spin_unlock_irqrestore(&clkdm->lock, flags);
 		return 0;
+	}
 
-	spin_lock_irqsave(&clkdm->lock, flags);
 	arch_clkdm->clkdm_clk_disable(clkdm);
 	pwrdm_state_switch(clkdm->pwrdm.ptr);
 	spin_unlock_irqrestore(&clkdm->lock, flags);
-- 
1.7.4.1

