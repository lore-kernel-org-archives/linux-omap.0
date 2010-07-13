From: Nishanth Menon <nm@ti.com>
Subject: Re: [PM-OPP][PATCH 2/4] OMAP: Correct the return value check after
 call into find_device_opp
Date: Tue, 13 Jul 2010 09:42:04 -0500
Message-ID: <4C3C7B3C.9090704@ti.com>
References: <1279000026-24042-1-git-send-email-thara@ti.com> <1279000026-24042-2-git-send-email-thara@ti.com> <1279000026-24042-3-git-send-email-thara@ti.com> <4C3C5AA6.8020303@ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB0323A2BCB7@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40512 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756565Ab0GMOmI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Jul 2010 10:42:08 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0323A2BCB7@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>, "tony@atomide.com" <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sawant, Anand" <sawant@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Premi, Sanjeev" <premi@ti.com>

Gopinath, Thara had written, on 07/13/2010 09:32 AM, the following:
> 
>>> -----Original Message-----
>>> From: Menon, Nishanth
>>> Sent: Tuesday, July 13, 2010 5:53 PM
>>> To: Gopinath, Thara
>>> Cc: linux-omap@vger.kernel.org; khilman@deeprootsystems.com; paul@pwsan.com; tony@atomide.com;
>>> Cousson, Benoit; Sawant, Anand; Sripathy, Vishwanath; Premi, Sanjeev
>>> Subject: Re: [PM-OPP][PATCH 2/4] OMAP: Correct the return value check after call into find_device_opp
>>>
>>> Gopinath, Thara had written, on 07/13/2010 12:47 AM, the following:
>>>> Earlier we were checking on !dev_opp where as find_device_opp returns
>>>> a error pointer in case of error. So correcting the check as in the earlier
>>>> code even if find_device_opp returns an error opp_init_cpufreq_table
>>>> was not exiting.
>>>>
>>>> Signed-off-by: Thara Gopinath <thara@ti.com>
>>>> ---
>>>>  arch/arm/plat-omap/opp.c |    4 +++-
>>>>  1 files changed, 3 insertions(+), 1 deletions(-)
>>>>
>>>> diff --git a/arch/arm/plat-omap/opp.c b/arch/arm/plat-omap/opp.c
>>>> index a06b88d..d88a2e0 100644
>>>> --- a/arch/arm/plat-omap/opp.c
>>>> +++ b/arch/arm/plat-omap/opp.c
>>>> @@ -457,8 +457,10 @@ void opp_init_cpufreq_table(struct device *dev,
>>>>  	int i = 0;
>>>>
>>>>  	dev_opp = find_device_opp(dev);
>>>> -	if (WARN_ON(!dev_opp))
>>>> +	if (IS_ERR(dev_opp)) {
>>>> +		WARN_ON(1);
>>> could we use pr_warning here instead of WARN_ON?
> The WARN_ON was already in the code. Added by you or Kevin. I just corrected the error checking.

:) using a WARN_ON() for an operational code is not a good idea - who 
ever added it (git annotate can help you there). WARN_ON(1) give no 
useful information when debugging in the field - just gives a line 
number and function name which changes btw.. useful info is something like:
pr_warning("%s: failed to find device\n", __func__);

useful when someone posts a log and we need to debug such logic.. esp 
useful after a period of time.

> 
> Regards
> Thara
>>>>  		return;
>>>> +	}
>>>>
>>>>  	freq_table = kzalloc(sizeof(struct cpufreq_frequency_table) *
>>>>  			     (dev_opp->enabled_opp_count + 1), GFP_ATOMIC);
>>>
>>> --
>>> Regards,
>>> Nishanth Menon


-- 
Regards,
Nishanth Menon
