From: Vishwanath Sripathy <vishwanath.bs@ti.com>
Subject: RE: [PATCH 5/5 v3] OMAP3630: PM: Erratum i583: disable coreoff if < ES1.2
Date: Mon, 13 Dec 2010 20:15:52 +0530
Message-ID: <f40d9ef033d50e006549480ea24304e8@mail.gmail.com>
References: <1291395818-8639-1-git-send-email-nm@ti.com> <1291395818-8639-6-git-send-email-nm@ti.com>
 <2cdf7d3d033ee2c88b6f2d4cfa37d9db@mail.gmail.com> <4D0622FE.2070801@ti.com>
 <d5e397dafb68b41ec5d7af591a18b044@mail.gmail.com> <4D062806.6090201@ti.com>
 <b7c3a82268b65ae1d9d09f377d9039f1@mail.gmail.com> <4D062F81.407@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:52569 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757837Ab0LMOwQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Dec 2010 09:52:16 -0500
Received: by mail-fx0-f52.google.com with SMTP id 5so5941522fxm.39
        for <linux-omap@vger.kernel.org>; Mon, 13 Dec 2010 06:52:15 -0800 (PST)
In-Reply-To: <4D062F81.407@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Eduardo Valentin <eduardo.valentin@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>

Nishant,

> -----Original Message-----
> From: Nishanth Menon [mailto:nm@ti.com]
> Sent: Monday, December 13, 2010 8:07 PM
> To: Vishwanath Sripathy
> Cc: linux-omap; Eduardo Valentin; Kevin Hilman; Tony Lindgren
> Subject: Re: [PATCH 5/5 v3] OMAP3630: PM: Erratum i583: disable
> coreoff if < ES1.2
>
> Vishwanath Sripathy had written, on 12/13/2010 08:25 AM, the
> following:
> [...]
> >>>>>> +	if (IS_PM34XX_ERRATUM(SDRC_WAKEUP_ERRATUM_i583)
> >> &&
> >>>>>> +			(core_next_state == PWRDM_POWER_OFF))
> >> {
> >>>>>> +		pwrdm_set_next_pwrst(core_pwrdm,
> >>>>>> PWRDM_POWER_RET);
> >>>>>> +		core_next_state = PWRDM_POWER_RET;
> >>>>>> +	}
> >>>>> Since next_state in pwrst_list (for core) is not updated, this is
> >>> throwing
> >>>>> up an error "Powerdomain (core_pwrdm) didn't enter target
> state
> >> 0"
> >>>> when
> >>>>> you off mode is enabled for ES1.1 or lesser (in suspend path).
> It's
> >>> not
> >>>>> really true that Core has not entered target state. It has entered
> >>>>> Retention state which is the actual target state set in
> >>> omap_sram_idle.
> >>>>> However it did not enter the state that was passed by
> >>>> omap3_pm_suspend. Is
> >>>>> this expected behavior?
> >>>> we could go both ways on this - this patch will(as you noticed)
> >> indicate
> >>>> that the transition failed on <ES1.2, or we could make it entirely
> >>>> transparent(by modifying the the pwrst_list - claim we achieved
> off,
> >>>> while not really hitting off - I personally dont think that is
> > correct.
> >>> The point I am making is that you cannot distinguish between
> genuine
> >> off
> >>> /retention failure since this message is thrown for both pass and
> > fail.
> >>> May be an additional trace message indicating that system entered
> >>> retention instead of off (for ES<1.2) will be useful.
> >> hmm... good point there.
> >> two issues here:
> >> a) omap3_pm_suspend should probably state which state was
> achieved
> >> as
> >> well in the error message (trivial fix).
> >> b) how do we notify users that it was due to
> >> SDRC_WAKEUP_ERRATUM_i583
> >> that core-off was denied. -> do this in omap3_pm_suspend(when
> user
> >> attempts actual OFF) OR omap3_pm_off_mode_enable(when user
> >> attempts to
> >> enable OFF mode)?
> >>
> >> Any suggestions to allow the same uImage boot on all silicon + allow
> >> cpu_idle + suspend paths not to spew pr_info messages(aka cant
> add
> >> prints in sram_idle)?
> > I vote for denying off mode for Core (for ES<1.2) in
> > omap3_pm_off_mode_enable and throw up a message saying that
> Core off is
> > not enabled. Then we will not get this failure message in suspend path
> > since pwrst_list will have the right state.
> Keep in mind - if we disable it in omap3_pm_off_mode_enable - we will
> deny OFF wholesale if I understand the logic right- not just core-off -
> I kind of think that is extreme.
No, I am not saying that deny idle for all power domains. Deny it only for
Core domain, something like this.
void omap3_pm_off_mode_enable(int enable)
{
	struct power_state *pwrst;
	u32 state;

	if (enable)
		state = PWRDM_POWER_OFF;
	else
		state = PWRDM_POWER_RET;

#ifdef CONFIG_CPU_IDLE
	omap3_cpuidle_update_states();
#endif

	list_for_each_entry(pwrst, &pwrst_list, node) {
		pwrst->next_state = state;
		if (strcmp("core_pwrdm", pwrst->pwrdm->name)==0) {
		if (IS_PM34XX_ERRATUM(SDRC_WAKEUP_ERRATUM_i583)
&& state ==PWRDM_POWER_OFF)
		pwrst->next_state = PWRDM_POWER_RET;
		}
		omap_set_pwrdm_state(pwrst->pwrdm, pwrst->next_state);
	}
}

Vishwa
>
> --
> Regards,
> Nishanth Menon
