From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [GIT PULL] ARM: OMAP: Timer and Counter DT Updates for v3.8
Date: Thu, 8 Nov 2012 13:47:10 -0600
Message-ID: <509C0C3E.6070204@ti.com>
References: <50941812.2070501@ti.com> <20121107004703.GS6801@atomide.com> <20121107234403.GS6801@atomide.com> <509BE9B0.5040608@ti.com> <20121108173824.GE6801@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53277 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752466Ab2KHTrW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Nov 2012 14:47:22 -0500
In-Reply-To: <20121108173824.GE6801@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, device-tree <devicetree-discuss@lists.ozlabs.org>


On 11/08/2012 11:38 AM, Tony Lindgren wrote:
> * Jon Hunter <jon-hunter@ti.com> [121108 09:21]:
>>
>> On 11/07/2012 05:44 PM, Tony Lindgren wrote:
>>
>> That's a bugger. I completely missed your patch last week sorry (I will blame the Danish
>> beer) and had clearly not folded in to my testing!
> 
> :)
>  
>>> I guess we should apply the following fix somewhere or
>>> do we need to check other places too?
>>
>> I will re-test your master branch today and put it through my dmtimer tests to double check.
>> However, in general I did ensure that we checked pdata was not NULL before accessing when 
>> I introduced the dt stuff. In my changelog [1] I had ...
>>
>> "5. When device-tree is present the platform_data structure will be NULL and so check for
>> this."
>>
>> I just need to make sure that get_context_loss_count() is not called before checking it is
>> populated.  
> 
> OK
> 
>   
>>> +
>>> +	if (pdata) {
>>> +		timer->capability = pdata->timer_capability;
>>
>> You don't need this it is already handled a few lines before.
>>
>>> +		timer->get_context_loss_count = pdata->get_context_loss_count;
>>
>> We could probably move this too. For example ...
> 
> OK yeah makes sense to me.
> 
> Regards,
> 
> Tony
>  
>> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
>> index 38c12ef..9dca23e 100644
>> --- a/arch/arm/plat-omap/dmtimer.c
>> +++ b/arch/arm/plat-omap/dmtimer.c
>> @@ -799,12 +799,11 @@ static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
>>                 timer->id = pdev->id;
>>                 timer->capability = pdata->timer_capability;
>>                 timer->reserved = omap_dm_timer_reserved_systimer(timer->id);
>> +               timer->get_context_loss_count = pdata->get_context_loss_count;
>>         }
>>  
>>         timer->irq = irq->start;
>>         timer->pdev = pdev;
>> -       timer->capability = pdata->timer_capability;
>> -       timer->get_context_loss_count = pdata->get_context_loss_count;
>>  
>>         /* Skip pm_runtime_enable for OMAP1 */
>>         if (!(timer->capability & OMAP_TIMER_NEEDS_RESET)) {

I have tested the dmtimers with this on the 3430-beagle and 4430-panda
with and without device tree and is working fine.

Do you want to generate the patch or me?

Cheers
Jon

>> [1] http://marc.info/?l=linux-omap&m=135065877008624&w=2
