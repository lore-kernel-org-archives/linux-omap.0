From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 03/10] OMAP3: PM: move device-specific special cases from PM core into CPUidle
Date: Thu, 23 Sep 2010 17:16:14 -0700
Message-ID: <87vd5wm1wx.fsf@deeprootsystems.com>
References: <1284594946-28963-1-git-send-email-khilman@deeprootsystems.com>
	<1284594946-28963-4-git-send-email-khilman@deeprootsystems.com>
	<alpine.DEB.2.00.1009210147180.17727@utopia.booyaka.com>
	<878w2vkp65.fsf@deeprootsystems.com>
	<alpine.DEB.2.00.1009231709000.10678@utopia.booyaka.com>
	<87eickowdo.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:62636 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753540Ab0IXAQR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Sep 2010 20:16:17 -0400
Received: by iwn5 with SMTP id 5so1864746iwn.19
        for <linux-omap@vger.kernel.org>; Thu, 23 Sep 2010 17:16:17 -0700 (PDT)
In-Reply-To: <87eickowdo.fsf@deeprootsystems.com> (Kevin Hilman's message of
	"Thu, 23 Sep 2010 16:47:31 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <tero.kristo@nokia.com>

Kevin Hilman <khilman@deeprootsystems.com> writes:

> Paul Walmsley <paul@pwsan.com> writes:
>
>> Hi Kevin
>>
>> On Tue, 21 Sep 2010, Kevin Hilman wrote:
>>
>>> Paul Walmsley <paul@pwsan.com> writes:
>>> 
>>> > On Wed, 15 Sep 2010, Kevin Hilman wrote:
>>> >
>>> >> In an effort to simplify the core idle path, move any device-specific
>>> >> special case handling from the core PM idle path into the CPUidle
>>> >> pre-idle checking path.
>>> >
>>> > As with the original patch, I don't quite understand the improvement 
>>> > here.  In particular, this part:
>>> >
>>> >> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
>>> >> index 3d3d035..0923b82 100644
>>> >> --- a/arch/arm/mach-omap2/cpuidle34xx.c
>>> >> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
>>> >> @@ -233,14 +234,54 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
>>> >>  			       struct cpuidle_state *state)
>>> >>  {
>>> >>  	struct cpuidle_state *new_state = next_valid_state(dev, state);
>>> >> +	u32 core_next_state, per_next_state = 0, per_saved_state = 0;
>>> >> +	u32 cam_state;
>>> >> +	struct omap3_processor_cx *cx;
>>> >> +	int ret;
>>> >>  
>>> >>  	if ((state->flags & CPUIDLE_FLAG_CHECK_BM) && omap3_idle_bm_check()) {
>>> >>  		BUG_ON(!dev->safe_state);
>>> >>  		new_state = dev->safe_state;
>>> >> +		goto select_state;
>>> >> +	}
>>> >> +
>>> >> +	cx = cpuidle_get_statedata(state);
>>> >> +	core_next_state = cx->core_state;
>>> >> +
>>> >> +	/*
>>> >> +	 * Prevent idle completely if CAM is active.
>>> >> +	 * CAM does not have wakeup capability in OMAP3.
>>> >> +	 */
>>> >> +	cam_state = pwrdm_read_pwrst(cam_pd);
>>> >> +	if (cam_state == PWRDM_POWER_ON) {
>>> >> +		new_state = dev->safe_state;
>>> >> +		goto select_state;
>>> >>  	}
>>> >>  
>>> >> +	/*
>>> >> +	 * Prevent PER off if CORE is not in retention or off as this
>>> >> +	 * would disable PER wakeups completely.
>>> >> +	 */
>>> >> +	per_next_state = per_saved_state = pwrdm_read_next_pwrst(per_pd);
>>> >> +	if ((per_next_state == PWRDM_POWER_OFF) &&
>>> >> +	    (core_next_state > PWRDM_POWER_RET)) {
>>> >> +		per_next_state = PWRDM_POWER_RET;
>>> >> +		pwrdm_set_next_pwrst(per_pd, per_next_state);
>>> >> +	}
>>> >> +
>>> >> +	/* Are we changing PER target state? */
>>> >> +	if (per_next_state != per_saved_state)
>>> >> +		pwrdm_set_next_pwrst(per_pd, per_next_state);
>>> >
>>> > In this case, the PER / CORE constraints don't have anything to do with 
>>> > the MPU or CPUIdle, so they don't seem to belong in the CPUIdle code.  The 
>>> > extra comments are certainly nice -- they make it more clear as to what is 
>>> > going on here -- but maybe those can just be added to pm34xx.c ?
>>> 
>>> CPUidle currently manages MPU and CORE powerdomains, so the CORE
>>> constraints seem to make perfect sense here (at least to me.)
>>
>> I do mean CORE also -- basically, anything that is not the CPU.  IMHO 
>> CPUIdle shouldn't manage CORE directly since it's not part of the CPU.  
>> Also since OMAPs have other processors (e.g., DSP, DMA, etc) that can use 
>> the CORE independently of the CPU's power state, it doesn't make sense for 
>> that code to live inside CPUIdle -- probably it should live in some type 
>> of SystemIdle, CORE powerdomain idle or L3 idle.  Again IMHO, the C states 
>> should only represent the MPU's idle state.
>>
>>> The question is probably more about the PER constraints.
>>> 
>>> The basic goal of this is to streamline the core idle (omap_sram_idle())
>>> to be the minimum streamline idle, and to move all the constraint
>>> checking and activity checking to higher layers (like CPUidle.)
>>> Specifically, I'm working towards moving the device-specific idle
>>> constraints out of the core idle path (omap_sram_idle()) and move them
>>> into higher layers where we're checking for activity etc.
>>> 
>>> This is just a baby step towards moving the device-idle out of CPUidle
>>> completely to a place where it can be managed by the driver themeselves
>>> using runtime PM or by using constraints instead of these hard-coded
>>> hacks.
>>
>> I agree completely with the goal; it's the implementation that I don't 
>> like ;-)  But if you agree with the basic idea, that CORE / PER / 
>> whatever-idle should ultimately go elsewhere, since I don't have time to 
>> come up with a constructive alternative at the moment, would you be 
>> willing to just drop a FIXME comment in that code, near the CAM and the 
>> PER / CORE stuff, that mentions that that code should ultimately be 
>> segmented out into its own idle code?
>
> Absolutely...  will do.
>

Here's an updated patch, which will be included in the forthcoming
pm-next pull request.  I updated the changelog with a 'NOTE' and also
added a FIXME in the code.

Thanks for the feedback Paul.

Kevin


>From e7410cf7831c2e5106a90dac6179df5d2c9bd60e Mon Sep 17 00:00:00 2001
From: Kevin Hilman <khilman@deeprootsystems.com>
Date: Wed, 8 Sep 2010 16:37:42 -0700
Subject: [PATCH 03/13] OMAP3: PM: move device-specific special cases from PM core into CPUidle

In an effort to simplify the core idle path, move any device-specific
special case handling from the core PM idle path into the CPUidle
pre-idle checking path.

This keeps the core, interrupts-disabled idle path streamlined and
independent of any device-specific handling, and also allows CPUidle
to do the checking only for certain C-states as needed.  This patch
has the device checks in place for all states with the CHECK_BM flag,
namely all states >= C2.

This patch was inspired by a similar patch written by Tero Kristo as
part of a larger series to add INACTIVE state support.

NOTE: This is a baby-step towards decoupling device idle (or system
idle) from CPU idle.  Eventually, CPUidle should only manage the CPU,
and device/system idle should be managed elsewhere.

Cc: Tero Kristo <tero.kristo@nokia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   58 +++++++++++++++++++++++++++++++++++--
 arch/arm/mach-omap2/pm34xx.c      |   14 +--------
 2 files changed, 56 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 3d3d035..8ea012e 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -60,7 +60,8 @@ struct omap3_processor_cx {
 
 struct omap3_processor_cx omap3_power_states[OMAP3_MAX_STATES];
 struct omap3_processor_cx current_cx_state;
-struct powerdomain *mpu_pd, *core_pd;
+struct powerdomain *mpu_pd, *core_pd, *per_pd;
+struct powerdomain *cam_pd;
 
 /*
  * The latencies/thresholds for various C states have
@@ -233,14 +234,62 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 			       struct cpuidle_state *state)
 {
 	struct cpuidle_state *new_state = next_valid_state(dev, state);
+	u32 core_next_state, per_next_state = 0, per_saved_state = 0;
+	u32 cam_state;
+	struct omap3_processor_cx *cx;
+	int ret;
 
 	if ((state->flags & CPUIDLE_FLAG_CHECK_BM) && omap3_idle_bm_check()) {
 		BUG_ON(!dev->safe_state);
 		new_state = dev->safe_state;
+		goto select_state;
+	}
+
+	cx = cpuidle_get_statedata(state);
+	core_next_state = cx->core_state;
+
+	/*
+	 * FIXME: we currently manage device-specific idle states
+	 *        for PER and CORE in combination with CPU-specific
+	 *        idle states.  This is wrong, and device-specific
+	 *        idle managment needs to be separated out into 
+	 *        its own code.
+	 */
+
+	/*
+	 * Prevent idle completely if CAM is active.
+	 * CAM does not have wakeup capability in OMAP3.
+	 */
+	cam_state = pwrdm_read_pwrst(cam_pd);
+	if (cam_state == PWRDM_POWER_ON) {
+		new_state = dev->safe_state;
+		goto select_state;
+	}
+
+	/*
+	 * Prevent PER off if CORE is not in retention or off as this
+	 * would disable PER wakeups completely.
+	 */
+	per_next_state = per_saved_state = pwrdm_read_next_pwrst(per_pd);
+	if ((per_next_state == PWRDM_POWER_OFF) &&
+	    (core_next_state > PWRDM_POWER_RET)) {
+		per_next_state = PWRDM_POWER_RET;
+		pwrdm_set_next_pwrst(per_pd, per_next_state);
 	}
 
+	/* Are we changing PER target state? */
+	if (per_next_state != per_saved_state)
+		pwrdm_set_next_pwrst(per_pd, per_next_state);
+
+select_state:
 	dev->last_state = new_state;
-	return omap3_enter_idle(dev, new_state);
+	ret = omap3_enter_idle(dev, new_state);
+
+	/* Restore original PER state if it was modified */
+	if (per_next_state != per_saved_state)
+		pwrdm_set_next_pwrst(per_pd, per_saved_state);
+
+	return ret;
 }
 
 DEFINE_PER_CPU(struct cpuidle_device, omap3_idle_dev);
@@ -328,7 +377,8 @@ void omap_init_power_states(void)
 			cpuidle_params_table[OMAP3_STATE_C2].threshold;
 	omap3_power_states[OMAP3_STATE_C2].mpu_state = PWRDM_POWER_ON;
 	omap3_power_states[OMAP3_STATE_C2].core_state = PWRDM_POWER_ON;
-	omap3_power_states[OMAP3_STATE_C2].flags = CPUIDLE_FLAG_TIME_VALID;
+	omap3_power_states[OMAP3_STATE_C2].flags = CPUIDLE_FLAG_TIME_VALID |
+				CPUIDLE_FLAG_CHECK_BM;
 
 	/* C3 . MPU CSWR + Core inactive */
 	omap3_power_states[OMAP3_STATE_C3].valid =
@@ -426,6 +476,8 @@ int __init omap3_idle_init(void)
 
 	mpu_pd = pwrdm_lookup("mpu_pwrdm");
 	core_pd = pwrdm_lookup("core_pwrdm");
+	per_pd = pwrdm_lookup("per_pwrdm");
+	cam_pd = pwrdm_lookup("cam_pwrdm");
 
 	omap_init_power_states();
 	cpuidle_register_driver(&omap3_idle_driver);
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 429268e..bb2ba1e 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -346,7 +346,6 @@ void omap_sram_idle(void)
 	int core_next_state = PWRDM_POWER_ON;
 	int core_prev_state, per_prev_state;
 	u32 sdrc_pwr = 0;
-	int per_state_modified = 0;
 
 	if (!_omap_sram_idle)
 		return;
@@ -391,19 +390,10 @@ void omap_sram_idle(void)
 	if (per_next_state < PWRDM_POWER_ON) {
 		omap_uart_prepare_idle(2);
 		omap2_gpio_prepare_for_idle(per_next_state);
-		if (per_next_state == PWRDM_POWER_OFF) {
-			if (core_next_state == PWRDM_POWER_ON) {
-				per_next_state = PWRDM_POWER_RET;
-				pwrdm_set_next_pwrst(per_pwrdm, per_next_state);
-				per_state_modified = 1;
-			} else
+		if (per_next_state == PWRDM_POWER_OFF)
 				omap3_per_save_context();
-		}
 	}
 
-	if (pwrdm_read_pwrst(cam_pwrdm) == PWRDM_POWER_ON)
-		omap2_clkdm_deny_idle(mpu_pwrdm->pwrdm_clkdms[0]);
-
 	/* CORE */
 	if (core_next_state < PWRDM_POWER_ON) {
 		omap_uart_prepare_idle(0);
@@ -470,8 +460,6 @@ void omap_sram_idle(void)
 		if (per_prev_state == PWRDM_POWER_OFF)
 			omap3_per_restore_context();
 		omap_uart_resume_idle(2);
-		if (per_state_modified)
-			pwrdm_set_next_pwrst(per_pwrdm, PWRDM_POWER_OFF);
 	}
 
 	/* Disable IO-PAD and IO-CHAIN wakeup */
-- 
1.7.2.1


