From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 05/10] ARM: OMAP2+: PM/powerdomain: move omap_set_pwrdm_state()
 to powerdomain code
Date: Tue, 29 Jan 2013 20:59:42 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1301292053030.11442@utopia.booyaka.com>
References: <20121209011755.19716.25244.stgit@dusk.lan> <20121209012339.19716.10548.stgit@dusk.lan> <CAORVsuXw6wgK+P5=9LtGHnoLtE4epwWe75by8nmmvSRHfDrdMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:40570 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217Ab3A2U7n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jan 2013 15:59:43 -0500
In-Reply-To: <CAORVsuXw6wgK+P5=9LtGHnoLtE4epwWe75by8nmmvSRHfDrdMQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Kevin Hilman <khilman@deeprootsystems.com>

Hi,

(redacted irrelevant code sections)

On Wed, 12 Dec 2012, Jean Pihet wrote:

> On Sun, Dec 9, 2012 at 2:23 AM, Paul Walmsley <paul@pwsan.com> wrote:
> 
> > -/**
> > - * pwrdm_set_lowpwrstchange - Request a low power state change
> > - * @pwrdm: struct powerdomain *
> > - *
> > - * Allows a powerdomain to transtion to a lower power sleep state
> > - * from an existing sleep state without waking up the powerdomain.
> > - * Returns -EINVAL if the powerdomain pointer is null or if the
> > - * powerdomain does not support LOWPOWERSTATECHANGE, or returns 0
> > - * upon success.
> > - */
> >
> 
> Can this kerneldoc be reused in the new code?

Not directly, since the function is being removed.  But I've added some 
LOWPOWERSTATECHANGE-related documentation  in powerdomain.h in the updated 
patch (below).

> > @@ -984,6 +955,89 @@ int pwrdm_post_transition(struct powerdomain *pwrdm)
> >         return 0;
> >  }
> >
> > +/* Types of sleep_switch used in omap_set_pwrdm_state */
> > +#define ALREADYACTIVE_SWITCH   0
> > +#define FORCEWAKEUP_SWITCH     1
> > +#define LOWPOWERSTATE_SWITCH   2
> >
> 
> Could you add some more documentation here?
> What is the goal of the function, what does it return etc. ?

I've added some related kerneldoc to omap_set_pwrdm_state().

> > +
> > +static u8 _pwrdm_save_clkdm_state_and_activate(struct powerdomain *pwrdm,
> > +                                              u8 pwrst, bool *hwsup)
>
> Same here
> 
> > +static void _pwrdm_restore_clkdm_state(struct powerdomain *pwrdm,
> > +                                      u8 sleep_switch, bool hwsup)
>
> Same here.

I've added kerneldoc for both of these functions.

> > +/*
> > + * This sets pwrdm state (other than mpu & core. Currently only ON &
> > + * RET are supported.
> > + */
> >
> Is this one correct?

This is just a cut and paste from the previous comments in the file.  I 
agree that it is not helpful, so I've added kerneldoc for 
omap_set_pwrdm_state().

The updated patch follows.


- Paul

From: Paul Walmsley <paul@pwsan.com>
Date: Tue, 29 Jan 2013 13:45:09 -0700
Subject: [PATCH] ARM: OMAP2+: PM/powerdomain: move omap_set_pwrdm_state() to
 powerdomain code

Move omap_set_pwrdm_state() from the PM code to the powerdomain code,
and refactor it to split it up into several functions.  A subsequent patch
will rename it to conform with the existing powerdomain function names.

This version includes some additional documentation, based on a
suggestion from Jean Pihet.  It also modifies omap_set_pwrdm_state()
to not bail out early unless both the powerdomain current power state
and the next power state are equal.  (Previously it would terminate
early if the next power state was equal to the target power state,
which was insufficiently rigorous.)

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/pm.c          |   61 --------------
 arch/arm/mach-omap2/pm.h          |    1 -
 arch/arm/mach-omap2/powerdomain.c |  161 ++++++++++++++++++++++++++++++-------
 arch/arm/mach-omap2/powerdomain.h |   13 ++-
 4 files changed, 144 insertions(+), 92 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index f18afc9..48d6d5d 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -108,10 +108,6 @@ static void __init omap2_init_processor_devices(void)
 	}
 }
 
-/* Types of sleep_switch used in omap_set_pwrdm_state */
-#define FORCEWAKEUP_SWITCH	0
-#define LOWPOWERSTATE_SWITCH	1
-
 int __init omap_pm_clkdms_setup(struct clockdomain *clkdm, void *unused)
 {
 	if ((clkdm->flags & CLKDM_CAN_ENABLE_AUTO) &&
@@ -124,63 +120,6 @@ int __init omap_pm_clkdms_setup(struct clockdomain *clkdm, void *unused)
 }
 
 /*
- * This sets pwrdm state (other than mpu & core. Currently only ON &
- * RET are supported.
- */
-int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 pwrst)
-{
-	u8 curr_pwrst, next_pwrst;
-	int sleep_switch = -1, ret = 0, hwsup = 0;
-
-	if (!pwrdm || IS_ERR(pwrdm))
-		return -EINVAL;
-
-	while (!(pwrdm->pwrsts & (1 << pwrst))) {
-		if (pwrst == PWRDM_POWER_OFF)
-			return ret;
-		pwrst--;
-	}
-
-	next_pwrst = pwrdm_read_next_pwrst(pwrdm);
-	if (next_pwrst == pwrst)
-		return ret;
-
-	curr_pwrst = pwrdm_read_pwrst(pwrdm);
-	if (curr_pwrst < PWRDM_POWER_ON) {
-		if ((curr_pwrst > pwrst) &&
-			(pwrdm->flags & PWRDM_HAS_LOWPOWERSTATECHANGE)) {
-			sleep_switch = LOWPOWERSTATE_SWITCH;
-		} else {
-			hwsup = clkdm_in_hwsup(pwrdm->pwrdm_clkdms[0]);
-			clkdm_wakeup(pwrdm->pwrdm_clkdms[0]);
-			sleep_switch = FORCEWAKEUP_SWITCH;
-		}
-	}
-
-	ret = pwrdm_set_next_pwrst(pwrdm, pwrst);
-	if (ret)
-		pr_err("%s: unable to set power state of powerdomain: %s\n",
-		       __func__, pwrdm->name);
-
-	switch (sleep_switch) {
-	case FORCEWAKEUP_SWITCH:
-		if (hwsup)
-			clkdm_allow_idle(pwrdm->pwrdm_clkdms[0]);
-		else
-			clkdm_sleep(pwrdm->pwrdm_clkdms[0]);
-		break;
-	case LOWPOWERSTATE_SWITCH:
-		pwrdm_set_lowpwrstchange(pwrdm);
-		pwrdm_state_switch(pwrdm);
-		break;
-	}
-
-	return ret;
-}
-
-
-
-/*
  * This API is to be called during init to set the various voltage
  * domains to the voltage as per the opp table. Typically we boot up
  * at the nominal voltage. So this function finds out the rate of
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index c22503b..7bdd22a 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -33,7 +33,6 @@ static inline int omap4_idle_init(void)
 extern void *omap3_secure_ram_storage;
 extern void omap3_pm_off_mode_enable(int);
 extern void omap_sram_idle(void);
-extern int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
 extern int omap_pm_clkdms_setup(struct clockdomain *clkdm, void *unused);
 extern int (*omap_pm_suspend)(void);
 
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 97b3881..65c3464 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -42,6 +42,16 @@ enum {
 	PWRDM_STATE_PREV,
 };
 
+/*
+ * Types of sleep_switch used internally in omap_set_pwrdm_state()
+ * and its associated static functions
+ *
+ * XXX Better documentation is needed here
+ */
+#define ALREADYACTIVE_SWITCH		0
+#define FORCEWAKEUP_SWITCH		1
+#define LOWPOWERSTATE_SWITCH		2
+#define ERROR_SWITCH			3
 
 /* pwrdm_list contains all registered struct powerdomains */
 static LIST_HEAD(pwrdm_list);
@@ -200,6 +210,80 @@ static int _pwrdm_post_transition_cb(struct powerdomain *pwrdm, void *unused)
 	return 0;
 }
 
+/**
+ * _pwrdm_save_clkdm_state_and_activate - prepare for power state change
+ * @pwrdm: struct powerdomain * to operate on
+ * @curr_pwrst: current power state of @pwrdm
+ * @pwrst: power state to switch to
+ * @hwsup: ptr to a bool to return whether the clkdm is hardware-supervised
+ *
+ * Determine whether the powerdomain needs to be turned on before
+ * attempting to switch power states.  Called by
+ * omap_set_pwrdm_state().  NOTE that if the powerdomain contains
+ * multiple clockdomains, this code assumes that the first clockdomain
+ * supports software-supervised wakeup mode - potentially a problem.
+ * Returns the power state switch mode currently in use (see the
+ * "Types of sleep_switch" comment above).
+ */
+static u8 _pwrdm_save_clkdm_state_and_activate(struct powerdomain *pwrdm,
+					       u8 curr_pwrst, u8 pwrst,
+					       bool *hwsup)
+{
+	u8 sleep_switch;
+
+	if (curr_pwrst < 0) {
+		WARN_ON(1);
+		sleep_switch = ERROR_SWITCH;
+	} else if (curr_pwrst < PWRDM_POWER_ON) {
+		if (curr_pwrst > pwrst &&
+		    pwrdm->flags & PWRDM_HAS_LOWPOWERSTATECHANGE &&
+		    arch_pwrdm->pwrdm_set_lowpwrstchange) {
+			sleep_switch = LOWPOWERSTATE_SWITCH;
+		} else {
+			*hwsup = clkdm_in_hwsup(pwrdm->pwrdm_clkdms[0]);
+			clkdm_wakeup(pwrdm->pwrdm_clkdms[0]);
+			sleep_switch = FORCEWAKEUP_SWITCH;
+		}
+	} else {
+		sleep_switch = ALREADYACTIVE_SWITCH;
+	}
+
+	return sleep_switch;
+}
+
+/**
+ * _pwrdm_restore_clkdm_state - restore the clkdm hwsup state after pwrst change
+ * @pwrdm: struct powerdomain * to operate on
+ * @sleep_switch: return value from _pwrdm_save_clkdm_state_and_activate()
+ * @hwsup: should @pwrdm's first clockdomain be set to hardware-supervised mode?
+ *
+ * Restore the clockdomain state perturbed by
+ * _pwrdm_save_clkdm_state_and_activate(), and call the power state
+ * bookkeeping code.  Called by omap_set_pwrdm_state().  NOTE that if
+ * the powerdomain contains multiple clockdomains, this assumes that
+ * the first associated clockdomain supports either
+ * hardware-supervised idle control in the register, or
+ * software-supervised sleep.  No return value.
+ */
+static void _pwrdm_restore_clkdm_state(struct powerdomain *pwrdm,
+				       u8 sleep_switch, bool hwsup)
+{
+	switch (sleep_switch) {
+	case FORCEWAKEUP_SWITCH:
+		if (hwsup)
+			clkdm_allow_idle(pwrdm->pwrdm_clkdms[0]);
+		else
+			clkdm_sleep(pwrdm->pwrdm_clkdms[0]);
+		break;
+	case LOWPOWERSTATE_SWITCH:
+		if (pwrdm->flags & PWRDM_HAS_LOWPOWERSTATECHANGE &&
+		    arch_pwrdm->pwrdm_set_lowpwrstchange)
+			arch_pwrdm->pwrdm_set_lowpwrstchange(pwrdm);
+		pwrdm_state_switch(pwrdm);
+		break;
+	}
+}
+
 /* Public functions */
 
 /**
@@ -921,35 +1005,6 @@ bool pwrdm_has_hdwr_sar(struct powerdomain *pwrdm)
 	return (pwrdm && pwrdm->flags & PWRDM_HAS_HDWR_SAR) ? 1 : 0;
 }
 
-/**
- * pwrdm_set_lowpwrstchange - Request a low power state change
- * @pwrdm: struct powerdomain *
- *
- * Allows a powerdomain to transtion to a lower power sleep state
- * from an existing sleep state without waking up the powerdomain.
- * Returns -EINVAL if the powerdomain pointer is null or if the
- * powerdomain does not support LOWPOWERSTATECHANGE, or returns 0
- * upon success.
- */
-int pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm)
-{
-	int ret = -EINVAL;
-
-	if (!pwrdm)
-		return -EINVAL;
-
-	if (!(pwrdm->flags & PWRDM_HAS_LOWPOWERSTATECHANGE))
-		return -EINVAL;
-
-	pr_debug("powerdomain: %s: setting LOWPOWERSTATECHANGE bit\n",
-		 pwrdm->name);
-
-	if (arch_pwrdm && arch_pwrdm->pwrdm_set_lowpwrstchange)
-		ret = arch_pwrdm->pwrdm_set_lowpwrstchange(pwrdm);
-
-	return ret;
-}
-
 int pwrdm_state_switch(struct powerdomain *pwrdm)
 {
 	int ret;
@@ -985,6 +1040,54 @@ int pwrdm_post_transition(struct powerdomain *pwrdm)
 }
 
 /**
+ * omap_set_pwrdm_state - change a powerdomain's current power state
+ * @pwrdm: struct powerdomain * to change the power state of
+ * @pwrst: power state to change to
+ *
+ * Change the current hardware power state of the powerdomain
+ * represented by @pwrdm to the power state represented by @pwrst.
+ * Returns -EINVAL if @pwrdm is null or invalid or if the
+ * powerdomain's current power state could not be read, or returns 0
+ * upon success or if @pwrdm does not support @pwrst or any
+ * lower-power state.  XXX Should not return 0 if the @pwrdm does not
+ * support @pwrst or any lower-power state: this should be an error.
+ */
+int omap_set_pwrdm_state(struct powerdomain *pwrdm, u8 pwrst)
+{
+	u8 curr_pwrst, next_pwrst, sleep_switch;
+	int ret = 0;
+	bool hwsup = false;
+
+	if (!pwrdm || IS_ERR(pwrdm))
+		return -EINVAL;
+
+	while (!(pwrdm->pwrsts & (1 << pwrst))) {
+		if (pwrst == PWRDM_POWER_OFF)
+			return ret;
+		pwrst--;
+	}
+
+	curr_pwrst = pwrdm_read_pwrst(pwrdm);
+	next_pwrst = pwrdm_read_next_pwrst(pwrdm);
+	if (curr_pwrst == pwrst && next_pwrst == pwrst)
+		return ret;
+
+	sleep_switch = _pwrdm_save_clkdm_state_and_activate(pwrdm, curr_pwrst,
+							    pwrst, &hwsup);
+	if (sleep_switch == ERROR_SWITCH)
+		return -EINVAL;
+
+	ret = pwrdm_set_next_pwrst(pwrdm, pwrst);
+	if (ret)
+		pr_err("%s: unable to set power state of powerdomain: %s\n",
+		       __func__, pwrdm->name);
+
+	_pwrdm_restore_clkdm_state(pwrdm, sleep_switch, hwsup);
+
+	return ret;
+}
+
+/**
  * pwrdm_get_context_loss_count - get powerdomain's context loss count
  * @pwrdm: struct powerdomain * to wait for
  *
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index 7c1534b..93e7df8 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -162,6 +162,16 @@ struct powerdomain {
  * @pwrdm_disable_hdwr_sar: Disable Hardware Save-Restore feature for a pd
  * @pwrdm_set_lowpwrstchange: Enable pd transitions from a shallow to deep sleep
  * @pwrdm_wait_transition: Wait for a pd state transition to complete
+ *
+ * Regarding @pwrdm_set_lowpwrstchange: On the OMAP2 and 3-family
+ * chips, a powerdomain's power state is not allowed to directly
+ * transition from one low-power state (e.g., CSWR) to another
+ * low-power state (e.g., OFF) without first waking up the
+ * powerdomain.  This wastes energy.  So OMAP4 chips support the
+ * ability to transition a powerdomain power state directly from one
+ * low-power state to another.  The function pointed to by
+ * @pwrdm_set_lowpwrstchange is intended to configure the OMAP4
+ * hardware powerdomain state machine to enable this feature.
  */
 struct pwrdm_ops {
 	int	(*pwrdm_set_next_pwrst)(struct powerdomain *pwrdm, u8 pwrst);
@@ -228,10 +238,11 @@ bool pwrdm_has_hdwr_sar(struct powerdomain *pwrdm);
 int pwrdm_state_switch(struct powerdomain *pwrdm);
 int pwrdm_pre_transition(struct powerdomain *pwrdm);
 int pwrdm_post_transition(struct powerdomain *pwrdm);
-int pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm);
 int pwrdm_get_context_loss_count(struct powerdomain *pwrdm);
 bool pwrdm_can_ever_lose_context(struct powerdomain *pwrdm);
 
+extern int omap_set_pwrdm_state(struct powerdomain *pwrdm, u8 state);
+
 extern void omap242x_powerdomains_init(void);
 extern void omap243x_powerdomains_init(void);
 extern void omap3xxx_powerdomains_init(void);
-- 
1.7.10.4

