From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 5/5 v3] OMAP3630: PM: Erratum i583: disable coreoff if < ES1.2
Date: Fri, 17 Dec 2010 14:54:29 -0800
Message-ID: <87oc8k6me2.fsf@deeprootsystems.com>
References: <1291395818-8639-1-git-send-email-nm@ti.com>
	<1291395818-8639-6-git-send-email-nm@ti.com>
	<2cdf7d3d033ee2c88b6f2d4cfa37d9db@mail.gmail.com>
	<4D0622FE.2070801@ti.com>
	<d5e397dafb68b41ec5d7af591a18b044@mail.gmail.com>
	<4D062806.6090201@ti.com>
	<b7c3a82268b65ae1d9d09f377d9039f1@mail.gmail.com>
	<4D062F81.407@ti.com>
	<96505dfaee73d6785e153ccf5c2856d3@mail.gmail.com>
	<6f507e24d6ae188e265913e85e815f82@mail.gmail.com>
	<4D063344.2010001@ti.com>
	<37de3932d97af8e1882a08dd37242a17@mail.gmail.com>
	<4D063599.9080905@ti.com> <87ei9l10mk.fsf@deeprootsystems.com>
	<4D0933C6.1060404@ti.com> <87wrnaions.fsf@deeprootsystems.com>
	<4D0957C7.4010907@ti.com> <4D096BC4.4040009@ti.com>
	<87tyidczpy.fsf@deeprootsystems.com> <4D0AB7C3.1050809@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:58148 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755153Ab0LQWye (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Dec 2010 17:54:34 -0500
Received: by gyb11 with SMTP id 11so454612gyb.19
        for <linux-omap@vger.kernel.org>; Fri, 17 Dec 2010 14:54:33 -0800 (PST)
In-Reply-To: <4D0AB7C3.1050809@ti.com> (Nishanth Menon's message of "Thu, 16
	Dec 2010 19:07:15 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Eduardo Valentin <eduardo.valentin@nokia.com>, Tony Lindgren <tony@atomide.com>

Nishanth Menon <nm@ti.com> writes:

> Kevin Hilman had written, on 12/16/2010 12:57 PM, the following:
>> Nishanth Menon <nm@ti.com> writes:
>>
>>> Nishanth Menon had written, on 12/15/2010 06:05 PM, the following:
>>>> Kevin Hilman had written, on 12/15/2010 05:47 PM, the following:
>>>>
>>>>>> I agree that this additional check in sram_idle should be removed, but
>>>>>> as long as I handle it in omap3_pm_off_mode_enable where the next
>>>>>> states are configured, is'nt that enough or am I missing something?
>>>>> Setting the next states only sets the default states, but CPUidle
>>>>> changes them.
>>>>>
>>>>> Looking closer at omap3_pm_off_mode_enable() though, it already calls
>>>>> into CPUidle and disables the valid bit for any states that have
>>>>> *either* MPU or core off.    You'll probably just need to extend this
>>>>> approach to disable only CORE off state(s).
>>>> Thx. it is clear now. let me see how to clean this up.
>>> k. Does the attached look any better now :)? 
>>
>> Yes, but, I still don't quite like it.  Basically, I'm not crazy about
>> the errata knowledge being centralized in pm34xx.c.   How about this:
>>
>> Move the Errata handling core code (pm_errata_* PM_ERRATTA_*) to pm.[ch]
>> as a single patch.  Then both pm34xx.c and cpuidle34xx.c would be free
>> to use it.
>
>> This would allow CPUidle handle the errata itself in the 'update_states'
>> function.  Or even better, if CPUidle core can check this errata, it
>> should probably just never register C7 in the first place, because it is
>> *never* a valid C-state.
>>
>> Make sense?
> hmm.. IMHO at the problems themselves:
> a) cpuidle_params_table -> this needs to become dynamically generated
> if you'd like cpuidle to not know about the existance of the invalid
> states at all(C7 has to disappear from it's radar - but extending it
> to a generic solution where an inbetween C state might be disabled as
> well)
>
> b) extending the problem further - cpu idle state latencies by
> themselves might vary between boards(PMIC variances causing delta in
> voltage setup times as an example).. I suppose we have some way to
> plug that data in as well? but irrelevant to this discussion. or maybe
> some board would like to have a customized additional c state which is
> not really practical for other platforms for what ever reasons..
>
> c) if cpuidle where to get pm errata info, it is nice thing to do,
> but, dont you think it is an overkill atm for just one errata?
>
> d) omap_init_power_states may need some cleanups as well.. too many =
> assignments IMHO..
>
> e) On the topic of argument that the states controlled by
> enable_off_mode is dynamic, though even though enable_off_mode is a
> variable, it is in debugfs - not really a dynamic variant in a
> product.. with that in mind, we may want to have off OR not have off
> mode in a product board file and folks would probably call
> omap3_pm_off_mode_enable or set the variable and set it to 1. That
> makes it even more crazy IMHO.
>
> f) Finally, where do we detect the erratas? it is more handy to have
> them in one place - pm34xx.c was chosen to make it independent of
> silicon type - pm44xx.c might endup having different set with it's own
> requirements - so not all together convinced it should be in
> pm.[ch]. I have tried to restrict the detection and usage purely to
> the file that needs it - pm34xx.c
>
> I think I agree to your overall thought that C state by itself
> should'nt have been registered, but would'nt it be better to do the
> cpuidle cleanups in a different context?

If you want to do all those cleanups, feel free.  They all are valid.

However, your patch targets an isolated problem, and I'm OK with an
isolated fix.

All I was suggesting is moving the PM errata detection/macros etc. into
pm.h, and doing somthing simple (below) in CPUidle.

Kevin

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 81b0a90..92873b4 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -452,6 +452,15 @@ void omap_init_power_states(void)
 	omap3_power_states[OMAP3_STATE_C7].core_state = PWRDM_POWER_OFF;
 	omap3_power_states[OMAP3_STATE_C7].flags = CPUIDLE_FLAG_TIME_VALID |
 				CPUIDLE_FLAG_CHECK_BM;
+
+	/*
+	 * Erratum i583: implementation for ES rev < Es1.2 on 3630
+	 * We cannot enable OFF mode in a stable form for previous
+	 * revisions, transition instead to RET
+	 */
+	if (IS_PM34XX_ERRATUM(SDRC_WAKEUP_ERRATUM_i583)
+	    omap3_power_states[OMAP3_STATE_C7].valid = 0;
+	    
 }
 


