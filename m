From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 5/5 v3] OMAP3630: PM: Erratum i583: disable coreoff if
 < ES1.2
Date: Mon, 13 Dec 2010 08:47:21 -0600
Message-ID: <4D0631F9.4080701@ti.com>
References: <1291395818-8639-1-git-send-email-nm@ti.com> <1291395818-8639-6-git-send-email-nm@ti.com> <2cdf7d3d033ee2c88b6f2d4cfa37d9db@mail.gmail.com> <4D0622FE.2070801@ti.com> <d5e397dafb68b41ec5d7af591a18b044@mail.gmail.com> <4D062806.6090201@ti.com> <b7c3a82268b65ae1d9d09f377d9039f1@mail.gmail.com> <4D062F81.407@ti.com> <f40d9ef033d50e006549480ea24304e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:39844 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754000Ab0LMOrb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Dec 2010 09:47:31 -0500
Received: by mail-yx0-f169.google.com with SMTP id 31so3985155yxl.0
        for <linux-omap@vger.kernel.org>; Mon, 13 Dec 2010 06:47:24 -0800 (PST)
In-Reply-To: <f40d9ef033d50e006549480ea24304e8@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath Sripathy <vishwanath.bs@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Eduardo Valentin <eduardo.valentin@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>

Vishwanath Sripathy had written, on 12/13/2010 08:45 AM, the following:

>> Keep in mind - if we disable it in omap3_pm_off_mode_enable - we will
>> deny OFF wholesale if I understand the logic right- not just core-off -
>> I kind of think that is extreme.
> No, I am not saying that deny idle for all power domains. Deny it only for
> Core domain, something like this.
> void omap3_pm_off_mode_enable(int enable)
> {
> 	struct power_state *pwrst;
> 	u32 state;
> 
> 	if (enable)
> 		state = PWRDM_POWER_OFF;
> 	else
> 		state = PWRDM_POWER_RET;
> 
> #ifdef CONFIG_CPU_IDLE
> 	omap3_cpuidle_update_states();
> #endif
> 
> 	list_for_each_entry(pwrst, &pwrst_list, node) {
> 		pwrst->next_state = state;
> 		if (strcmp("core_pwrdm", pwrst->pwrdm->name)==0) {
> 		if (IS_PM34XX_ERRATUM(SDRC_WAKEUP_ERRATUM_i583)
> && state ==PWRDM_POWER_OFF)
> 		pwrst->next_state = PWRDM_POWER_RET;
> 		}
> 		omap_set_pwrdm_state(pwrst->pwrdm, pwrst->next_state);
yep, I think our emails crossed wires - I realized the same as well.
-- 
Regards,
Nishanth Menon
