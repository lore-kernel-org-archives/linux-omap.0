From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 5/5 v3] OMAP3630: PM: Erratum i583: disable coreoff if
 < ES1.2
Date: Mon, 13 Dec 2010 08:52:52 -0600
Message-ID: <4D063344.2010001@ti.com>
References: <1291395818-8639-1-git-send-email-nm@ti.com> <1291395818-8639-6-git-send-email-nm@ti.com> <2cdf7d3d033ee2c88b6f2d4cfa37d9db@mail.gmail.com> <4D0622FE.2070801@ti.com> <d5e397dafb68b41ec5d7af591a18b044@mail.gmail.com> <4D062806.6090201@ti.com> <b7c3a82268b65ae1d9d09f377d9039f1@mail.gmail.com> <4D062F81.407@ti.com> <96505dfaee73d6785e153ccf5c2856d3@mail.gmail.com> <6f507e24d6ae188e265913e85e815f82@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:34330 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757837Ab0LMOw4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Dec 2010 09:52:56 -0500
Received: by gxk21 with SMTP id 21so3768035gxk.24
        for <linux-omap@vger.kernel.org>; Mon, 13 Dec 2010 06:52:55 -0800 (PST)
In-Reply-To: <6f507e24d6ae188e265913e85e815f82@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath Sripathy <vishwanath.bs@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Eduardo Valentin <eduardo.valentin@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>

Vishwanath Sripathy had written, on 12/13/2010 08:48 AM, the following:
>> -----Original Message-----
>> From: Nishanth Menon [mailto:nm@ti.com]
>> Sent: Monday, December 13, 2010 8:14 PM
>> To: Vishwanath Sripathy
>> Cc: linux-omap; Eduardo Valentin; Kevin Hilman; Tony Lindgren
>> Subject: RE: [PATCH 5/5 v3] OMAP3630: PM: Erratum i583: disable
>> coreoff if < ES1.2
>>
>>> -----Original Message-----
>>> Vishwanath Sripathy had written, on 12/13/2010 08:25 AM, the
>> following:
>>> [...]
>>>>>>>>> +	if
>> (IS_PM34XX_ERRATUM(SDRC_WAKEUP_ERRATUM_i583)
>>>>> &&
>>>>>>>>> +			(core_next_state ==
>> PWRDM_POWER_OFF))
>>>>> {
>>>>>>>>> +		pwrdm_set_next_pwrst(core_pwrdm,
>>>>>>>>> PWRDM_POWER_RET);
>>>>>>>>> +		core_next_state = PWRDM_POWER_RET;
>>>>>>>>> +	}
>>>>>>>> Since next_state in pwrst_list (for core) is not updated, this
> is
>>>>>> throwing
>>>>>>>> up an error "Powerdomain (core_pwrdm) didn't enter target
>> state
>>>>> 0"
>>>>>>> when
>>>>>>>> you off mode is enabled for ES1.1 or lesser (in suspend path).
>> It's
>>>>>> not
>>>>>>>> really true that Core has not entered target state. It has
>> entered
>>>>>>>> Retention state which is the actual target state set in
>>>>>> omap_sram_idle.
>>>>>>>> However it did not enter the state that was passed by
>>>>>>> omap3_pm_suspend. Is
>>>>>>>> this expected behavior?
>>>>>>> we could go both ways on this - this patch will(as you noticed)
>>>>> indicate
>>>>>>> that the transition failed on <ES1.2, or we could make it
>> entirely
>>>>>>> transparent(by modifying the the pwrst_list - claim we achieved
>> off,
>>>>>>> while not really hitting off - I personally dont think that is
>>>> correct.
>>>>>> The point I am making is that you cannot distinguish between
>> genuine
>>>>> off
>>>>>> /retention failure since this message is thrown for both pass and
>>>> fail.
>>>>>> May be an additional trace message indicating that system
>> entered
>>>>>> retention instead of off (for ES<1.2) will be useful.
>>>>> hmm... good point there.
>>>>> two issues here:
>>>>> a) omap3_pm_suspend should probably state which state was
>> achieved
>>>>> as
>>>>> well in the error message (trivial fix).
>>>>> b) how do we notify users that it was due to
>>>>> SDRC_WAKEUP_ERRATUM_i583
>>>>> that core-off was denied. -> do this in omap3_pm_suspend(when
>> user
>>>>> attempts actual OFF) OR omap3_pm_off_mode_enable(when user
>>>>> attempts to
>>>>> enable OFF mode)?
>>>>>
>>>>> Any suggestions to allow the same uImage boot on all silicon +
>> allow
>>>>> cpu_idle + suspend paths not to spew pr_info messages(aka cant
>> add
>>>>> prints in sram_idle)?
>>>> I vote for denying off mode for Core (for ES<1.2) in
>>>> omap3_pm_off_mode_enable and throw up a message saying that
>> Core off
>> is
>>>> not enabled. Then we will not get this failure message in suspend
>> path
>>>> since pwrst_list will have the right state.
>>> Keep in mind - if we disable it in omap3_pm_off_mode_enable - we
>> will
>>> deny OFF wholesale if I understand the logic right- not just core-off
> -
>>> I kind of think that is extreme.
>> I take that back, we could do something like the following instead:
>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-
>> omap2/pm34xx.c
>> index ba3c0d6..74842f1 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -933,7 +933,14 @@ void omap3_pm_off_mode_enable(int enable)
>>
>>         list_for_each_entry(pwrst, &pwrst_list, node) {
>>                 pwrst->next_state = state;
>> -               omap_set_pwrdm_state(pwrst->pwrdm, state);
>> +               if (IS_PM34XX_ERRATUM(SDRC_WAKEUP_ERRATUM_i583)
>> &&
>> +                               pwrst->pwrdm == core_pwrdm) {
>> +                       omap_set_pwrdm_state(pwrst->pwrdm,
>> PWRDM_POWER_RET);
> 			You need to update pwrst->next_state as well.
> Otherwise suspend will still throw the same error. I just sent the code in
> other email.
yep. except, I think we dont need to do string compare. the following 
looks any better?

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index ba3c0d6..da12a56 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -932,8 +932,15 @@ void omap3_pm_off_mode_enable(int enable)
  #endif

         list_for_each_entry(pwrst, &pwrst_list, node) {
-               pwrst->next_state = state;
-               omap_set_pwrdm_state(pwrst->pwrdm, state);
+               if (IS_PM34XX_ERRATUM(SDRC_WAKEUP_ERRATUM_i583) &&
+                               pwrst->pwrdm == core_pwrdm) {
+                       pwrst->next_state = PWRDM_POWER_RET;
+                       pr_err("%s: cannot enable Core OFF due to i583\n",
+                               __func__);
+               } else {
+                       pwrst->next_state = state;
+               }
+               omap_set_pwrdm_state(pwrst->pwrdm, pwrst->next_state);
         }
  }

-- 
Regards,
Nishanth Menon
