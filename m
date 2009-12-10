From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH] OMAP3: hwmod: check for clkdomain pointer before
 accesing it to change the sleep dependencies.
Date: Thu, 10 Dec 2009 12:04:30 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030ACBFDFF@dbde02.ent.ti.com>
References: <1260098323-26183-1-git-send-email-thara@ti.com>
 <873a3ju4ng.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:32891 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933113AbZLJGeb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Dec 2009 01:34:31 -0500
In-Reply-To: <873a3ju4ng.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>



>>-----Original Message-----
>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>Sent: Thursday, December 10, 2009 4:39 AM
>>To: Gopinath, Thara
>>Cc: linux-omap@vger.kernel.org; Paul Walmsley
>>Subject: Re: [PATCH] OMAP3: hwmod: check for clkdomain pointer before accesing it to change the sleep
>>dependencies.
>>
>>Thara Gopinath <thara@ti.com> writes:
>>
>>> Some clock nodes like wdt1_fck, sr1_fck, sr2_fck etc do not have a
>>> clock domain associated . For such nodes accessing the clock domain pointers
>>> in _add_initiator_dep and _del_initiator_dep, will lead to null pointer
>>> defreferencing crash. Adding support in these functions to check for
>>> existence of clkdm pointer before trying to acess it. Even if tomorrow
>>> we correct all the clock nodes to have an associated clock domain, checking
>>> for the existence of the pointer is a good programming practice.
>>>
>>> Signed-off-by: Thara Gopinath <thara@ti.com>
>>> Cc: Paul Walmsley <paul@pwsan.com>
>>> ---
>>> This patch depends on http://patchwork.kernel.org/patch/63383/
>>
>>I think clocks without associated clockdomains should be handled with
>>a flag instead of a check for a NULL pointer.
>>
>>Your current approach will silently fail if someone forgets to add
>>a clockdomain to a clock that should have one.

Are you suggesting adding a flag to the clock node in case it does not have an associated clockdomain?
I am using your tree origin/pm-wip/omap_device branch. On this I see a commit (e89a95db7095d998991c564a756a33ee0ec722c5) in which a warning is printed in omap2_init_clk_clkdm if there is no clockdomain associated with a clock node. My idea was this warning plus the check so as to avoid the system crash would suffice.
>>
>>Kevin
>>
>>
>>>  arch/arm/mach-omap2/omap_hwmod.c |    8 ++++++--
>>>  1 files changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
>>> index 18e6478..3edc387 100644
>>> --- a/arch/arm/mach-omap2/omap_hwmod.c
>>> +++ b/arch/arm/mach-omap2/omap_hwmod.c
>>> @@ -314,8 +314,10 @@ static int _add_initiator_dep(struct omap_hwmod *oh, struct omap_hwmod
>>*init_oh)
>>>  	if (!oh->_clk)
>>>  		return -EINVAL;
>>>
>>> -	return pwrdm_add_sleepdep(oh->_clk->clkdm->pwrdm.ptr,
>>> +	if (oh->_clk->clkdm)
>>> +		return pwrdm_add_sleepdep(oh->_clk->clkdm->pwrdm.ptr,
>>>  				  init_oh->_clk->clkdm->pwrdm.ptr);
>>> +	return 0;
>>>  }
>>>
>>>  /**
>>> @@ -335,8 +337,10 @@ static int _del_initiator_dep(struct omap_hwmod *oh, struct omap_hwmod
>>*init_oh)
>>>  	if (!oh->_clk)
>>>  		return -EINVAL;
>>>
>>> -	return pwrdm_del_sleepdep(oh->_clk->clkdm->pwrdm.ptr,
>>> +	if (oh->_clk->clkdm)
>>> +		return pwrdm_del_sleepdep(oh->_clk->clkdm->pwrdm.ptr,
>>>  				  init_oh->_clk->clkdm->pwrdm.ptr);
>>> +	return 0;
>>>  }
>>>
>>>  /**
>>> --
>>> 1.5.4.7
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
