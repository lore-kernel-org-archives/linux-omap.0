From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 5/5 v3] OMAP3630: PM: Erratum i583: disable coreoff if
 < ES1.2
Date: Wed, 15 Dec 2010 15:31:50 -0600
Message-ID: <4D0933C6.1060404@ti.com>
References: <1291395818-8639-1-git-send-email-nm@ti.com>	<1291395818-8639-6-git-send-email-nm@ti.com>	<2cdf7d3d033ee2c88b6f2d4cfa37d9db@mail.gmail.com>	<4D0622FE.2070801@ti.com>	<d5e397dafb68b41ec5d7af591a18b044@mail.gmail.com>	<4D062806.6090201@ti.com>	<b7c3a82268b65ae1d9d09f377d9039f1@mail.gmail.com>	<4D062F81.407@ti.com>	<96505dfaee73d6785e153ccf5c2856d3@mail.gmail.com>	<6f507e24d6ae188e265913e85e815f82@mail.gmail.com>	<4D063344.2010001@ti.com>	<37de3932d97af8e1882a08dd37242a17@mail.gmail.com>	<4D063599.9080905@ti.com> <87ei9l10mk.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:34080 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751819Ab0LOVb5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Dec 2010 16:31:57 -0500
Received: by mail-vw0-f44.google.com with SMTP id 7so1053715vws.17
        for <linux-omap@vger.kernel.org>; Wed, 15 Dec 2010 13:31:57 -0800 (PST)
In-Reply-To: <87ei9l10mk.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Eduardo Valentin <eduardo.valentin@nokia.com>, Tony Lindgren <tony@atomide.com>

Kevin Hilman had written, on 12/13/2010 09:42 PM, the following:
> Nishanth Menon <nm@ti.com> writes:
> 
>> Vishwanath Sripathy had written, on 12/13/2010 08:58 AM, the following:
>> [...]
>>>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-
>>>> omap2/pm34xx.c
>>>> index ba3c0d6..da12a56 100644
>>>> --- a/arch/arm/mach-omap2/pm34xx.c
>>>> +++ b/arch/arm/mach-omap2/pm34xx.c
>>>> @@ -932,8 +932,15 @@ void omap3_pm_off_mode_enable(int enable)
>>>>   #endif
>>>>
>>>>          list_for_each_entry(pwrst, &pwrst_list, node) {
>>>> -               pwrst->next_state = state;
>>>> -               omap_set_pwrdm_state(pwrst->pwrdm, state);
>>>> +               if (IS_PM34XX_ERRATUM(SDRC_WAKEUP_ERRATUM_i583)
>>>> &&
>>>> +                               pwrst->pwrdm == core_pwrdm) {
>>>> +                       pwrst->next_state = PWRDM_POWER_RET;
>>>> +                       pr_err("%s: cannot enable Core OFF due to
>>> i583\n",
>>>> +                               __func__);
>>> 		You probably need to throw up this warning only if state
>>> == PWRDM_POWER_OFF. Otherwise this code looks fine to me.
>> Thanks for the review. added it. will post a v4 later today if no one
>> cribs with this approach. I will retain the logic in sram_idle as well
>> as a backup measure.
> 
> This logic doesn't belong in SRAM idle.  To handle the idle case, you
> should also disable the 'valid' bit for any C-state that has CORE off (I
> think there's only one.)
Apologies, but I dont think I get your point. Do you intend to state 
that we dynamically add the C7 state in cpuidle34xx.c if this condition 
is met?
I agree that this additional check in sram_idle should be removed, but 
as long as I handle it in omap3_pm_off_mode_enable where the next states 
are configured, is'nt that enough or am I missing something?

-- 
Regards,
Nishanth Menon
