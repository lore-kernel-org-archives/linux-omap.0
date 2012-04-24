From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: [PATCH 05/12] arm: omap3: am35x: Add PWROFF feature
Date: Mon, 23 Apr 2012 21:36:39 -0700
Message-ID: <20120424043639.GA24317@animalcreek.com>
References: <1334171147-7517-1-git-send-email-mgreer@animalcreek.com>
 <1334171147-7517-6-git-send-email-mgreer@animalcreek.com>
 <87iph5q43n.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:56100 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287Ab2DXEgm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Apr 2012 00:36:42 -0400
Content-Disposition: inline
In-Reply-To: <87iph5q43n.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com

On Wed, Apr 11, 2012 at 03:46:20PM -0700, Kevin Hilman wrote:
> Hi Mark,

Hi Kevin.

> "Mark A. Greer" <mgreer@animalcreek.com> writes:
> 
> > From: "Mark A. Greer" <mgreer@animalcreek.com>
> >
> > Typical OMAP3 SoCs have four power domain states: ON,
> > INACTIVE, RETENTION, and OFF.  The am35x family of SoCs
> > has only two states: ON and INACTIVE.  To distinguish which
> > set of states the current device has, add the 'OMAP3_HAS_PWROFF'
> > feature.  When that feature/bit is set, the device supports the
> > RETENTION and OFF states; otherwise, it doesn't.
> >
> > Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
> 
> Paul has mentioned this already, but the same applies here: We shouldn't
> be using SoC-global feature flag for this.   We already have per-pwrdm
> flags that indicate what states a given powerdomain suports (see .pwrsts
> field.)
> 
> Wherever we have blind writes to next powerstates that assume support
> for RET/OFF is present, those should probably use a helper function from
> the powerdomain code that checks if that state is even supported.

How about something like the patch below?
Note: its not well tested; just RFC.

> Jean's work on functional powerstates will probably help here if you
> really need to support INACTIVE.  However, Paul may be right in that you
> might just start with supporing ON only, and validate that module-level
> wakups acutally work.

Yes, I think INACTIVE is a red herring so I'm going to stick with k.o
master branch for now (IOW, not base on Jean's patches).  If you still
want me to base on his patches, just let me know.

Mark
--

>From 32c54adb15c76396aeec809d38de4dde936b1e66 Mon Sep 17 00:00:00 2001
From: "Mark A. Greer" <mgreer@animalcreek.com>
Date: Mon, 23 Apr 2012 17:48:06 -0700
Subject: [PATCH] arm: omap: Use only valid power domain states

Some parts of the OMAP code assume that all power
domains support certain states (e.g., RET & OFF).
This isn't always true (e.g., the am35x family of
SoC's) so those assumptions need to be removed.

Remove those assumptions by looking up the deepest
state that a power domain can be in whereever its
being blindly set.  The 'max()' of the deepest
state and what the code formerly wanted to set it
to, is the correct state.  If the code formerly
wanted to set it to PWRDM_POWER_OFF, then the
deepest possible state will be used (i.e., no
need to perform the 'max()').

The code still assumes that ON is a valid state.

Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   14 ++++++++++----
 arch/arm/mach-omap2/pm34xx.c      |   15 +++++++++------
 arch/arm/mach-omap2/powerdomain.c |   25 +++++++++++++++++++++++++
 arch/arm/mach-omap2/powerdomain.h |    2 ++
 4 files changed, 46 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 5358664..60aa0c3 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -175,19 +175,25 @@ static int next_valid_state(struct cpuidle_device *dev,
 	struct cpuidle_state_usage *curr_usage = &dev->states_usage[index];
 	struct cpuidle_state *curr = &drv->states[index];
 	struct omap3_idle_statedata *cx = cpuidle_get_statedata(curr_usage);
-	u32 mpu_deepest_state = PWRDM_POWER_RET;
-	u32 core_deepest_state = PWRDM_POWER_RET;
+	u32 mpu_deepest_state, mpu_deepest_possible;
+	u32 core_deepest_state, core_deepest_possible;
 	int next_index = -1;
 
+	mpu_deepest_possible = pwrdm_get_deepest_state(mpu_pd);
+	mpu_deepest_state = max(mpu_deepest_possible, (u32)PWRDM_POWER_RET);
+
+	core_deepest_possible = pwrdm_get_deepest_state(core_pd);
+	core_deepest_state = max(core_deepest_possible, (u32)PWRDM_POWER_RET);
+
 	if (enable_off_mode) {
-		mpu_deepest_state = PWRDM_POWER_OFF;
+		mpu_deepest_state = mpu_deepest_possible;
 		/*
 		 * Erratum i583: valable for ES rev < Es1.2 on 3630.
 		 * CORE OFF mode is not supported in a stable form, restrict
 		 * instead the CORE state to RET.
 		 */
 		if (!IS_PM34XX_ERRATUM(PM_SDRC_WAKEUP_ERRATUM_i583))
-			core_deepest_state = PWRDM_POWER_OFF;
+			core_deepest_state = core_deepest_possible;
 	}
 
 	/* Check if current state is valid */
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index ec92676..7737bfb 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -614,12 +614,11 @@ void omap3_pm_off_mode_enable(int enable)
 	struct power_state *pwrst;
 	u32 state;
 
-	if (enable)
-		state = PWRDM_POWER_OFF;
-	else
-		state = PWRDM_POWER_RET;
-
 	list_for_each_entry(pwrst, &pwrst_list, node) {
+		state = pwrdm_get_deepest_state(pwrst->pwrdm);
+		if (!enable)
+			state = max(state, (u32)PWRDM_POWER_RET);
+
 		if (IS_PM34XX_ERRATUM(PM_SDRC_WAKEUP_ERRATUM_i583) &&
 				pwrst->pwrdm == core_pwrdm &&
 				state == PWRDM_POWER_OFF) {
@@ -660,6 +659,7 @@ int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state)
 static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 {
 	struct power_state *pwrst;
+	u32 state;
 
 	if (!pwrdm->pwrsts)
 		return 0;
@@ -668,7 +668,10 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 	if (!pwrst)
 		return -ENOMEM;
 	pwrst->pwrdm = pwrdm;
-	pwrst->next_state = PWRDM_POWER_RET;
+
+	state = pwrdm_get_deepest_state(pwrdm);
+	pwrst->next_state = max(state, (u32)PWRDM_POWER_RET);
+
 	list_add(&pwrst->node, &pwrst_list);
 
 	if (pwrdm_has_hdwr_sar(pwrdm))
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 96ad3dbe..9c80c19 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -1078,3 +1078,28 @@ bool pwrdm_can_ever_lose_context(struct powerdomain *pwrdm)
 
 	return 0;
 }
+
+/**
+ * pwrdm_get_deepest_state - Get deepest valid state domain can enter
+ * @pwrdm: struct powerdomain *
+ *
+ * Find and return the deepest valid state a power domain can be in.
+ * Returns the deepest state that @pwrdm can enter.
+ */
+u32 pwrdm_get_deepest_state(struct powerdomain *pwrdm)
+{
+	u32 valid_states, deepest_state;
+
+	valid_states = pwrdm->pwrsts;
+
+	if (valid_states & PWRSTS_OFF)
+		deepest_state = PWRDM_POWER_OFF;
+	else if (valid_states & PWRSTS_RET)
+		deepest_state = PWRDM_POWER_RET;
+	else if (valid_states & PWRSTS_INACTIVE)
+		deepest_state = PWRDM_POWER_INACTIVE;
+	else
+		deepest_state = PWRDM_POWER_ON;
+
+	return deepest_state;
+}
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index 0d72a8a..9688ff1 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -220,6 +220,8 @@ int pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm);
 int pwrdm_get_context_loss_count(struct powerdomain *pwrdm);
 bool pwrdm_can_ever_lose_context(struct powerdomain *pwrdm);
 
+u32 pwrdm_get_deepest_state(struct powerdomain *pwrdm);
+
 extern void omap242x_powerdomains_init(void);
 extern void omap243x_powerdomains_init(void);
 extern void omap3xxx_powerdomains_init(void);
-- 
1.7.9.4

