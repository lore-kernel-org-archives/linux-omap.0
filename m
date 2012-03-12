From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 2/2] ARM: OMAP: powerdomain: Get rid off duplicate pwrdm_clkdm_state_switch() API
Date: Mon, 12 Mar 2012 20:04:33 +0530
Message-ID: <1331562873-29535-3-git-send-email-santosh.shilimkar@ti.com>
References: <1331562873-29535-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38026 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755564Ab2CLOex (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Mar 2012 10:34:53 -0400
In-Reply-To: <1331562873-29535-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>

With patch 'ARM: OMAP: powerdomain: Wait for powerdomain transition
in pwrdm_state_switch()', the pwrdm_clkdm_state_switch() API becomes
duplicate of pwrdm_state_switch().

Get rid off duplicate pwrdm_clkdm_state_switch() and update the
users of it with pwrdm_state_switch()

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
CC: Rajendra Nayak <rnayak@ti.com>
CC: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock.c       |    2 +-
 arch/arm/mach-omap2/clockdomain.c |    7 +++----
 arch/arm/mach-omap2/powerdomain.c |   10 ----------
 arch/arm/mach-omap2/powerdomain.h |    1 -
 4 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index f57ed5b..77db067 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -439,7 +439,7 @@ void omap2_clk_disable_unused(struct clk *clk)
 		clk->ops->disable(clk);
 	}
 	if (clk->clkdm != NULL)
-		pwrdm_clkdm_state_switch(clk->clkdm);
+		pwrdm_state_switch(clk->clkdm->pwrdm.ptr);
 }
 #endif
 
diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index ad07689..8664f5a 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -840,7 +840,7 @@ void clkdm_allow_idle(struct clockdomain *clkdm)
 	spin_lock_irqsave(&clkdm->lock, flags);
 	clkdm->_flags |= _CLKDM_FLAG_HWSUP_ENABLED;
 	arch_clkdm->clkdm_allow_idle(clkdm);
-	pwrdm_clkdm_state_switch(clkdm);
+	pwrdm_state_switch(clkdm->pwrdm.ptr);
 	spin_unlock_irqrestore(&clkdm->lock, flags);
 }
 
@@ -924,8 +924,7 @@ static int _clkdm_clk_hwmod_enable(struct clockdomain *clkdm)
 
 	spin_lock_irqsave(&clkdm->lock, flags);
 	arch_clkdm->clkdm_clk_enable(clkdm);
-	pwrdm_wait_transition(clkdm->pwrdm.ptr);
-	pwrdm_clkdm_state_switch(clkdm);
+	pwrdm_state_switch(clkdm->pwrdm.ptr);
 	spin_unlock_irqrestore(&clkdm->lock, flags);
 
 	pr_debug("clockdomain: clkdm %s: enabled\n", clkdm->name);
@@ -950,7 +949,7 @@ static int _clkdm_clk_hwmod_disable(struct clockdomain *clkdm)
 
 	spin_lock_irqsave(&clkdm->lock, flags);
 	arch_clkdm->clkdm_clk_disable(clkdm);
-	pwrdm_clkdm_state_switch(clkdm);
+	pwrdm_state_switch(clkdm->pwrdm.ptr);
 	spin_unlock_irqrestore(&clkdm->lock, flags);
 
 	pr_debug("clockdomain: clkdm %s: disabled\n", clkdm->name);
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 96ad3dbe..9611490 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -981,16 +981,6 @@ int pwrdm_state_switch(struct powerdomain *pwrdm)
 	return ret;
 }
 
-int pwrdm_clkdm_state_switch(struct clockdomain *clkdm)
-{
-	if (clkdm != NULL && clkdm->pwrdm.ptr != NULL) {
-		pwrdm_wait_transition(clkdm->pwrdm.ptr);
-		return pwrdm_state_switch(clkdm->pwrdm.ptr);
-	}
-
-	return -EINVAL;
-}
-
 int pwrdm_pre_transition(void)
 {
 	pwrdm_for_each(_pwrdm_pre_transition_cb, NULL);
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index 0d72a8a..8f88d65 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -213,7 +213,6 @@ bool pwrdm_has_hdwr_sar(struct powerdomain *pwrdm);
 int pwrdm_wait_transition(struct powerdomain *pwrdm);
 
 int pwrdm_state_switch(struct powerdomain *pwrdm);
-int pwrdm_clkdm_state_switch(struct clockdomain *clkdm);
 int pwrdm_pre_transition(void);
 int pwrdm_post_transition(void);
 int pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm);
-- 
1.7.4.1

