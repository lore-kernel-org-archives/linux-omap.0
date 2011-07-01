From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v4 6/7] OMAP2+: clockdomain: Add per clkdm lock to prevent concurrent state programming
Date: Fri, 1 Jul 2011 23:27:05 +0200
Message-ID: <1309555626-22608-7-git-send-email-b-cousson@ti.com>
References: <1309555626-22608-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59746 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757668Ab1GAV1Y (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jul 2011 17:27:24 -0400
In-Reply-To: <1309555626-22608-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

Since the clkdm state programming is now done from within the hwmod
framework (which uses a per-hwmod lock) instead of the being done
from the clock framework (which used a global lock), there is now a
need to have per-clkdm locking to prevent races between different
hwmods/modules belonging to the same clock domain concurrently
programming the clkdm state.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clockdomain.c          |   42 ++++++++++++++++++++++++++--
 arch/arm/mach-omap2/clockdomain.h          |    2 +
 arch/arm/mach-omap2/clockdomain2xxx_3xxx.c |    6 ++-
 arch/arm/mach-omap2/clockdomain44xx.c      |   13 ++------
 4 files changed, 49 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 10f6bd2..cc2e495 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -92,6 +92,8 @@ static int _clkdm_register(struct clockdomain *clkdm)
 
 	pwrdm_add_clkdm(pwrdm, clkdm);
 
+	spin_lock_init(&clkdm->lock);
+
 	pr_debug("clockdomain: registered %s\n", clkdm->name);
 
 	return 0;
@@ -690,6 +692,9 @@ int clkdm_clear_all_sleepdeps(struct clockdomain *clkdm)
  */
 int clkdm_sleep(struct clockdomain *clkdm)
 {
+	int ret;
+	unsigned long flags;
+
 	if (!clkdm)
 		return -EINVAL;
 
@@ -704,7 +709,10 @@ int clkdm_sleep(struct clockdomain *clkdm)
 
 	pr_debug("clockdomain: forcing sleep on %s\n", clkdm->name);
 
-	return arch_clkdm->clkdm_sleep(clkdm);
+	spin_lock_irqsave(&clkdm->lock, flags);
+	ret = arch_clkdm->clkdm_sleep(clkdm);
+	spin_unlock_irqrestore(&clkdm->lock, flags);
+	return ret;
 }
 
 /**
@@ -718,6 +726,9 @@ int clkdm_sleep(struct clockdomain *clkdm)
  */
 int clkdm_wakeup(struct clockdomain *clkdm)
 {
+	int ret;
+	unsigned long flags;
+
 	if (!clkdm)
 		return -EINVAL;
 
@@ -732,7 +743,10 @@ int clkdm_wakeup(struct clockdomain *clkdm)
 
 	pr_debug("clockdomain: forcing wakeup on %s\n", clkdm->name);
 
-	return arch_clkdm->clkdm_wakeup(clkdm);
+	spin_lock_irqsave(&clkdm->lock, flags);
+	ret = arch_clkdm->clkdm_wakeup(clkdm);
+	spin_unlock_irqrestore(&clkdm->lock, flags);
+	return ret;
 }
 
 /**
@@ -747,6 +761,8 @@ int clkdm_wakeup(struct clockdomain *clkdm)
  */
 void clkdm_allow_idle(struct clockdomain *clkdm)
 {
+	unsigned long flags;
+
 	if (!clkdm)
 		return;
 
@@ -762,8 +778,10 @@ void clkdm_allow_idle(struct clockdomain *clkdm)
 	pr_debug("clockdomain: enabling automatic idle transitions for %s\n",
 		 clkdm->name);
 
+	spin_lock_irqsave(&clkdm->lock, flags);
 	arch_clkdm->clkdm_allow_idle(clkdm);
 	pwrdm_clkdm_state_switch(clkdm);
+	spin_unlock_irqrestore(&clkdm->lock, flags);
 }
 
 /**
@@ -777,6 +795,8 @@ void clkdm_allow_idle(struct clockdomain *clkdm)
  */
 void clkdm_deny_idle(struct clockdomain *clkdm)
 {
+	unsigned long flags;
+
 	if (!clkdm)
 		return;
 
@@ -792,7 +812,9 @@ void clkdm_deny_idle(struct clockdomain *clkdm)
 	pr_debug("clockdomain: disabling automatic idle transitions for %s\n",
 		 clkdm->name);
 
+	spin_lock_irqsave(&clkdm->lock, flags);
 	arch_clkdm->clkdm_deny_idle(clkdm);
+	spin_unlock_irqrestore(&clkdm->lock, flags);
 }
 
 /**
@@ -805,6 +827,9 @@ void clkdm_deny_idle(struct clockdomain *clkdm)
  */
 int clkdm_allows_idle(struct clockdomain *clkdm)
 {
+	int ret;
+	unsigned long flags;
+
 	if (!clkdm)
 		return -EINVAL;
 
@@ -813,7 +838,10 @@ int clkdm_allows_idle(struct clockdomain *clkdm)
 
 	pr_debug("clockdomain: reading idle state for %s\n", clkdm->name);
 
-	return arch_clkdm->clkdm_allows_idle(clkdm);
+	spin_lock_irqsave(&clkdm->lock, flags);
+	ret = arch_clkdm->clkdm_allows_idle(clkdm);
+	spin_unlock_irqrestore(&clkdm->lock, flags);
+	return ret;
 }
 
 
@@ -821,6 +849,8 @@ int clkdm_allows_idle(struct clockdomain *clkdm)
 
 static int _clkdm_clk_hwmod_enable(struct clockdomain *clkdm)
 {
+	unsigned long flags;
+
 	if (!clkdm || !arch_clkdm || !arch_clkdm->clkdm_clk_enable)
 		return -EINVAL;
 
@@ -832,9 +862,11 @@ static int _clkdm_clk_hwmod_enable(struct clockdomain *clkdm)
 	if ((atomic_inc_return(&clkdm->usecount) > 1) && autodeps)
 		return 0;
 
+	spin_lock_irqsave(&clkdm->lock, flags);
 	arch_clkdm->clkdm_clk_enable(clkdm);
 	pwrdm_wait_transition(clkdm->pwrdm.ptr);
 	pwrdm_clkdm_state_switch(clkdm);
+	spin_unlock_irqrestore(&clkdm->lock, flags);
 
 	pr_debug("clockdomain: clkdm %s: enabled\n", clkdm->name);
 
@@ -843,6 +875,8 @@ static int _clkdm_clk_hwmod_enable(struct clockdomain *clkdm)
 
 static int _clkdm_clk_hwmod_disable(struct clockdomain *clkdm)
 {
+	unsigned long flags;
+
 	if (!clkdm || !arch_clkdm || !arch_clkdm->clkdm_clk_disable)
 		return -EINVAL;
 
@@ -854,8 +888,10 @@ static int _clkdm_clk_hwmod_disable(struct clockdomain *clkdm)
 	if (atomic_dec_return(&clkdm->usecount) > 0)
 		return 0;
 
+	spin_lock_irqsave(&clkdm->lock, flags);
 	arch_clkdm->clkdm_clk_disable(clkdm);
 	pwrdm_clkdm_state_switch(clkdm);
+	spin_unlock_irqrestore(&clkdm->lock, flags);
 
 	pr_debug("clockdomain: clkdm %s: disabled\n", clkdm->name);
 
diff --git a/arch/arm/mach-omap2/clockdomain.h b/arch/arm/mach-omap2/clockdomain.h
index 8f0a7d6..b51f558 100644
--- a/arch/arm/mach-omap2/clockdomain.h
+++ b/arch/arm/mach-omap2/clockdomain.h
@@ -17,6 +17,7 @@
 #define __ARCH_ARM_MACH_OMAP2_CLOCKDOMAIN_H
 
 #include <linux/init.h>
+#include <linux/spinlock.h>
 
 #include "powerdomain.h"
 #include <plat/clock.h>
@@ -123,6 +124,7 @@ struct clockdomain {
 	const struct omap_chip_id omap_chip;
 	atomic_t usecount;
 	struct list_head node;
+	spinlock_t lock;
 };
 
 /**
diff --git a/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c b/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
index 81f3e46..d94a121 100644
--- a/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
@@ -193,7 +193,8 @@ static int omap2_clkdm_clk_enable(struct clockdomain *clkdm)
 		_clkdm_add_autodeps(clkdm);
 		_enable_hwsup(clkdm);
 	} else {
-		clkdm_wakeup(clkdm);
+		if (clkdm->flags & CLKDM_CAN_FORCE_WAKEUP)
+			omap2_clkdm_wakeup(clkdm);
 	}
 
 	return 0;
@@ -215,7 +216,8 @@ static int omap2_clkdm_clk_disable(struct clockdomain *clkdm)
 		_clkdm_del_autodeps(clkdm);
 		_enable_hwsup(clkdm);
 	} else {
-		clkdm_sleep(clkdm);
+		if (clkdm->flags & CLKDM_CAN_FORCE_SLEEP)
+			omap2_clkdm_sleep(clkdm);
 	}
 
 	return 0;
diff --git a/arch/arm/mach-omap2/clockdomain44xx.c b/arch/arm/mach-omap2/clockdomain44xx.c
index 1599b18..3192a5e 100644
--- a/arch/arm/mach-omap2/clockdomain44xx.c
+++ b/arch/arm/mach-omap2/clockdomain44xx.c
@@ -101,13 +101,8 @@ static int omap4_clkdm_allows_idle(struct clockdomain *clkdm)
 
 static int omap4_clkdm_clk_enable(struct clockdomain *clkdm)
 {
-	bool hwsup = false;
-
-	hwsup = omap4_cminst_is_clkdm_in_hwsup(clkdm->prcm_partition,
-					clkdm->cm_inst, clkdm->clkdm_offs);
-
-	if (!hwsup)
-		clkdm_wakeup(clkdm);
+	if (clkdm->flags & CLKDM_CAN_FORCE_WAKEUP)
+		return omap4_clkdm_wakeup(clkdm);
 
 	return 0;
 }
@@ -119,8 +114,8 @@ static int omap4_clkdm_clk_disable(struct clockdomain *clkdm)
 	hwsup = omap4_cminst_is_clkdm_in_hwsup(clkdm->prcm_partition,
 					clkdm->cm_inst, clkdm->clkdm_offs);
 
-	if (!hwsup)
-		clkdm_sleep(clkdm);
+	if (!hwsup && (clkdm->flags & CLKDM_CAN_FORCE_SLEEP))
+		omap4_clkdm_sleep(clkdm);
 
 	return 0;
 }
-- 
1.7.0.4

