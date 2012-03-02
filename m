From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCHv3 4/6] ARM: OMAP3 PM: Enable IO Wake up
Date: Fri, 02 Mar 2012 14:53:45 +0530
Message-ID: <4F5091A1.3030802@ti.com>
References: <1330525621-29836-1-git-send-email-t-kristo@ti.com>	 <1330525621-29836-5-git-send-email-t-kristo@ti.com>	 <4F4F1CBA.7040502@ti.com>  <87sjhsdk2y.fsf@ti.com> <1330679940.2116.95.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:52477 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758567Ab2CBJXx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Mar 2012 04:23:53 -0500
Received: by ggnk1 with SMTP id k1so598709ggn.8
        for <linux-omap@vger.kernel.org>; Fri, 02 Mar 2012 01:23:51 -0800 (PST)
In-Reply-To: <1330679940.2116.95.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Vishwanath BS <vishwanath.bs@ti.com>

On Friday 02 March 2012 02:49 PM, Tero Kristo wrote:
> On Thu, 2012-03-01 at 14:37 -0800, Kevin Hilman wrote:
>> Rajendra Nayak<rnayak@ti.com>  writes:
>>
>>> On Wednesday 29 February 2012 07:56 PM, Tero Kristo wrote:
>>>> From: Vishwanath BS<vishwanath.bs@ti.com>
>>>>
>>>> Enable IO Wake up for OMAP3 as part of PM Init. Currently this has been
>>>> managed in cpuidle path which is not the right place. Subsequent patch
>>>> will remove IO Daisy chain handling in cpuidle path once daisy chain is
>>>> handled as part of hwmod mux.
>>>>
>>>> Signed-off-by: Vishwanath BS<vishwanath.bs@ti.com>
>>>> Tested-by: Govindraj.R<govindraj.raja@ti.com>
>>>> Signed-off-by: Tero Kristo<t-kristo@ti.com>
>>>> ---
>>>>    arch/arm/mach-omap2/pm34xx.c |    4 ++++
>>>>    1 files changed, 4 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
>>>> index e97ec3f..e6c2d39 100644
>>>> --- a/arch/arm/mach-omap2/pm34xx.c
>>>> +++ b/arch/arm/mach-omap2/pm34xx.c
>>>> @@ -793,6 +793,10 @@ static int __init omap3_pm_init(void)
>>>>    		goto err1;
>>>>    	}
>>>>
>>>> +	if (omap3_has_io_wakeup())
>>>> +		omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD,
>>>> +					   PM_WKEN);
>>>
>>> On OMAP4 this GLOBAL IO chain enable happens as part of the trigger
>>> function itself, it might make sense to do that for OMAP3 too to avoid
>>> similar issues as seen on OMAP4 when the GLOBAL switch is enabled too
>>> late in boot. The best however would be to get rid of it in the trigger
>>> function and enable this early during PM init, but I am not sure whats
>>> a good place to do this 'early' enough.
>>
>> What about the subsys_initcall() that's already in the prm*.c files?
>>
>> IMO, the global one-time init doesn't belong in the trigger function
>> because there's no need to do the extra PRM read/write when it should be
>> a one-shot init.
>
> This sounds good to me at least, I can change the patches to work like
> this, Rajendra?

Yup, sounds good to me too. The extra PRM read/write is really an
overhead when done for every trigger. Thanks Kevin.

>
> -Tero
>

