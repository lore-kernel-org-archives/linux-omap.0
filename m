From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 4/8] OMAP2+: PM: idle clkdms only if already in idle
Date: Fri, 10 Jun 2011 16:52:18 +0530
Message-ID: <4DF1FE6A.3010202@ti.com>
References: <1307616853-28395-1-git-send-email-rnayak@ti.com> <1307616853-28395-2-git-send-email-rnayak@ti.com> <1307616853-28395-3-git-send-email-rnayak@ti.com> <1307616853-28395-4-git-send-email-rnayak@ti.com> <1307616853-28395-5-git-send-email-rnayak@ti.com> <20110610001556.GA9159@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:32870 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754621Ab1FJLW2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Jun 2011 07:22:28 -0400
Received: by mail-gx0-f179.google.com with SMTP id 1so2096751gxk.10
        for <linux-omap@vger.kernel.org>; Fri, 10 Jun 2011 04:22:27 -0700 (PDT)
In-Reply-To: <20110610001556.GA9159@google.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Todd Poynor <toddpoynor@google.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@ti.com, b-cousson@ti.com, santosh.shilimkar@ti.com, linux-arm-kernel@lists.infradead.org

On 6/10/2011 5:45 AM, Todd Poynor wrote:
>> +	int hwsup = 0;
>> >
>> >    	if (pwrdm == NULL || IS_ERR(pwrdm))
>> >    		return -EINVAL;
>> >  @@ -127,6 +128,7 @@ int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
>> >    			(pwrdm->flags&  PWRDM_HAS_LOWPOWERSTATECHANGE)) {
>> >    			sleep_switch = LOWPOWERSTATE_SWITCH;
>> >    		} else {
>> >  +			hwsup = clkdm_is_idle(pwrdm->pwrdm_clkdms[0]);
>> >    			clkdm_wakeup(pwrdm->pwrdm_clkdms[0]);
>> >    			pwrdm_wait_transition(pwrdm);
>> >    			sleep_switch = FORCEWAKEUP_SWITCH;
>> >  @@ -142,7 +144,7 @@ int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
>> >
>> >    	switch (sleep_switch) {
>> >    	case FORCEWAKEUP_SWITCH:
>> >  -		if (pwrdm->pwrdm_clkdms[0]->flags&  CLKDM_CAN_ENABLE_AUTO)
>> >  +		if (hwsup)
>> >    			clkdm_allow_idle(pwrdm->pwrdm_clkdms[0]);
>> >    		else
>> >    			clkdm_sleep(pwrdm->pwrdm_clkdms[0]);
> Is concurrency protection needed here?  Not sure if it's expected that
> multiple threads would simultaneously manage the state of the same power
> domain, or that the associated clock domain would change state
> concurrently.

Yeah, maybe there is a need for a per-clkdm lock to prevent these
concurrency issues. This race between omap_set_pwrdm_state and
clk_enable/disable all programming clkdm state was one possibility
for a race (even without this series), but with this series to move the
clkdm handling into hwmod there are certainly more possibilities (across 
concurrent omap_hwmod_enable/idle) because the hwmod framework uses 
per-hwmod lock while the clock framework used a global lock.
Thanks for bringing this up.
Paul/Benoit any thoughts on if a per-clkdm lock seems reasonable?

I just did a quick patch to add per-clkdm locking, it also has a
couple instances of arch-specific clkdm calls making
calls back to generic clkdm framework fixed, which
otherwise would result in recursive locking.

----
From: Rajendra Nayak <rnayak@ti.com>
Date: Fri, 10 Jun 2011 15:42:25 +0530
Subject: [PATCH] OMAP: clockdomain: Add per clkdm lock to prevent 
concurrent state programming

Since the clkdm state programming is now done from
within the hwmod framework (which uses a per-hwmod
lock) instead of the being done from the clock
framework (which used a global lock), there is
now a need to have per-clkdm locking to prevent
races between different hwmods/modules belonging to the
same clock domain concurrently programming the
clkdm state.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
  arch/arm/mach-omap2/clockdomain.c          |   42 
++++++++++++++++++++++++++--
  arch/arm/mach-omap2/clockdomain.h          |    2 +
  arch/arm/mach-omap2/clockdomain2xxx_3xxx.c |    6 ++-
  arch/arm/mach-omap2/clockdomain44xx.c      |    7 ++--
  4 files changed, 49 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c 
b/arch/arm/mach-omap2/clockdomain.c
index b98a972..374e669 100644
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
  int clkdm_is_idle(struct clockdomain *clkdm)
  {
+	int ret;
+	unsigned long flags;
+
  	if (!clkdm)
  		return -EINVAL;

@@ -813,7 +838,10 @@ int clkdm_is_idle(struct clockdomain *clkdm)

  	pr_debug("clockdomain: reading idle state for %s\n", clkdm->name);

-	return arch_clkdm->clkdm_is_idle(clkdm);
+	spin_lock_irqsave(&clkdm->lock, flags);
+	ret = arch_clkdm->clkdm_is_idle(clkdm);
+	spin_unlock_irqrestore(&clkdm->lock, flags);
+	return ret;
  }


@@ -835,6 +863,8 @@ int clkdm_is_idle(struct clockdomain *clkdm)
   */
  int clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk)
  {
+	unsigned long flags;
+
  	/*
  	 * XXX Rewrite this code to maintain a list of enabled
  	 * downstream clocks for debugging purposes?
@@ -859,9 +889,11 @@ int clkdm_clk_enable(struct clockdomain *clkdm, 
struct clk *clk)
  	pr_debug("clockdomain: clkdm %s: clk %s now enabled\n", clkdm->name,
  		 clk->name);

+	spin_lock_irqsave(&clkdm->lock, flags);
  	arch_clkdm->clkdm_clk_enable(clkdm);
  	pwrdm_wait_transition(clkdm->pwrdm.ptr);
  	pwrdm_clkdm_state_switch(clkdm);
+	spin_unlock_irqrestore(&clkdm->lock, flags);

  	return 0;
  }
@@ -882,6 +914,8 @@ int clkdm_clk_enable(struct clockdomain *clkdm, 
struct clk *clk)
   */
  int clkdm_clk_disable(struct clockdomain *clkdm, struct clk *clk)
  {
+	unsigned long flags;
+
  	/*
  	 * XXX Rewrite this code to maintain a list of enabled
  	 * downstream clocks for debugging purposes?
@@ -908,8 +942,10 @@ int clkdm_clk_disable(struct clockdomain *clkdm, 
struct clk *clk)
  	pr_debug("clockdomain: clkdm %s: clk %s now disabled\n", clkdm->name,
  		 clk->name);

+	spin_lock_irqsave(&clkdm->lock, flags);
  	arch_clkdm->clkdm_clk_disable(clkdm);
  	pwrdm_clkdm_state_switch(clkdm);
+	spin_unlock_irqrestore(&clkdm->lock, flags);

  	return 0;
  }
diff --git a/arch/arm/mach-omap2/clockdomain.h 
b/arch/arm/mach-omap2/clockdomain.h
index 085ed82..9fd4eb5 100644
--- a/arch/arm/mach-omap2/clockdomain.h
+++ b/arch/arm/mach-omap2/clockdomain.h
@@ -17,6 +17,7 @@
  #define __ARCH_ARM_MACH_OMAP2_CLOCKDOMAIN_H

  #include <linux/init.h>
+#include <linux/spinlock.h>

  #include "powerdomain.h"
  #include <plat/clock.h>
@@ -122,6 +123,7 @@ struct clockdomain {
  	const struct omap_chip_id omap_chip;
  	atomic_t usecount;
  	struct list_head node;
+	spinlock_t lock;
  };

  /**
diff --git a/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c 
b/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
index e0c393f..f841ac8 100644
--- a/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
@@ -193,7 +193,8 @@ static int omap2_clkdm_clk_enable(struct clockdomain 
*clkdm)
  		_clkdm_add_autodeps(clkdm);
  		_enable_hwsup(clkdm);
  	} else {
-		clkdm_wakeup(clkdm);
+		if (clkdm->flags & CLKDM_CAN_FORCE_WAKEUP)
+			omap2_clkdm_wakeup(clkdm);
  	}

  	return 0;
@@ -215,7 +216,8 @@ static int omap2_clkdm_clk_disable(struct 
clockdomain *clkdm)
  		_clkdm_del_autodeps(clkdm);
  		_enable_hwsup(clkdm);
  	} else {
-		clkdm_sleep(clkdm);
+		if (clkdm->flags & CLKDM_CAN_FORCE_SLEEP)
+			omap2_clkdm_sleep(clkdm);
  	}

  	return 0;
diff --git a/arch/arm/mach-omap2/clockdomain44xx.c 
b/arch/arm/mach-omap2/clockdomain44xx.c
index e4b8e06..911770b 100644
--- a/arch/arm/mach-omap2/clockdomain44xx.c
+++ b/arch/arm/mach-omap2/clockdomain44xx.c
@@ -101,7 +101,8 @@ static int omap4_clkdm_is_idle(struct clockdomain 
*clkdm)

  static int omap4_clkdm_clk_enable(struct clockdomain *clkdm)
  {
-	clkdm_wakeup(clkdm);
+	if (clkdm->flags & CLKDM_CAN_FORCE_WAKEUP)
+		return omap4_clkdm_wakeup(clkdm);
  	return 0;
  }

@@ -112,8 +113,8 @@ static int omap4_clkdm_clk_disable(struct 
clockdomain *clkdm)
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

