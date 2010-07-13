From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PM-OPP][PATCH 2/4] OMAP: Correct the return value check after
 call into find_device_opp
Date: Tue, 13 Jul 2010 20:02:57 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0323A2BCB7@dbde02.ent.ti.com>
References: <1279000026-24042-1-git-send-email-thara@ti.com>
 <1279000026-24042-2-git-send-email-thara@ti.com>
 <1279000026-24042-3-git-send-email-thara@ti.com> <4C3C5AA6.8020303@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51192 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755351Ab0GMOdJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jul 2010 10:33:09 -0400
In-Reply-To: <4C3C5AA6.8020303@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>, "tony@atomide.com" <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sawant, Anand" <sawant@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Premi, Sanjeev" <premi@ti.com>



>>-----Original Message-----
>>From: Menon, Nishanth
>>Sent: Tuesday, July 13, 2010 5:53 PM
>>To: Gopinath, Thara
>>Cc: linux-omap@vger.kernel.org; khilman@deeprootsystems.com; paul@pwsan.com; tony@atomide.com;
>>Cousson, Benoit; Sawant, Anand; Sripathy, Vishwanath; Premi, Sanjeev
>>Subject: Re: [PM-OPP][PATCH 2/4] OMAP: Correct the return value check after call into find_device_opp
>>
>>Gopinath, Thara had written, on 07/13/2010 12:47 AM, the following:
>>> Earlier we were checking on !dev_opp where as find_device_opp returns
>>> a error pointer in case of error. So correcting the check as in the earlier
>>> code even if find_device_opp returns an error opp_init_cpufreq_table
>>> was not exiting.
>>>
>>> Signed-off-by: Thara Gopinath <thara@ti.com>
>>> ---
>>>  arch/arm/plat-omap/opp.c |    4 +++-
>>>  1 files changed, 3 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/arch/arm/plat-omap/opp.c b/arch/arm/plat-omap/opp.c
>>> index a06b88d..d88a2e0 100644
>>> --- a/arch/arm/plat-omap/opp.c
>>> +++ b/arch/arm/plat-omap/opp.c
>>> @@ -457,8 +457,10 @@ void opp_init_cpufreq_table(struct device *dev,
>>>  	int i = 0;
>>>
>>>  	dev_opp = find_device_opp(dev);
>>> -	if (WARN_ON(!dev_opp))
>>> +	if (IS_ERR(dev_opp)) {
>>> +		WARN_ON(1);
>>could we use pr_warning here instead of WARN_ON?
The WARN_ON was already in the code. Added by you or Kevin. I just corrected the error checking.

Regards
Thara
>>
>>>  		return;
>>> +	}
>>>
>>>  	freq_table = kzalloc(sizeof(struct cpufreq_frequency_table) *
>>>  			     (dev_opp->enabled_opp_count + 1), GFP_ATOMIC);
>>
>>
>>--
>>Regards,
>>Nishanth Menon
