From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH] ARM: OMAP2+: timer: remove CONFIG_OMAP_32K_TIMER
Date: Sun, 11 Nov 2012 11:16:19 +0200
Message-ID: <509F6CE3.50806@compulab.co.il>
References: <1352299344-8011-1-git-send-email-grinberg@compulab.co.il> <20121107173343.GF6801@atomide.com> <509B5B84.50605@compulab.co.il> <20121108162004.GA6801@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:39460 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751562Ab2KKJQ0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 11 Nov 2012 04:16:26 -0500
In-Reply-To: <20121108162004.GA6801@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jon Hunter <jon-hunter@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>

On 11/08/12 18:20, Tony Lindgren wrote:
> * Igor Grinberg <grinberg@compulab.co.il> [121107 23:15]:
>> On 11/07/12 19:33, Tony Lindgren wrote:
>>>
>>> I think this should be the default for the timers as that counter
>>> does not stop during deeper idle states.
>>
>> Well, it is the default as you can see from the patch.
>> The problem is that for boards that for some reason do not have
>> the 32k wired and rely on MPU/GP timer source, the default will not work
>> and currently there is no way for board to specify which timer source
>> it can use.
> 
> Yes. I was just wondering if we can avoid patching all the board
> files by doing it the other way around by introducing a new
> omap_gp_timer rather than renaming all the existing ones?

Is the renaming that bad? One line per machine_desc structure?
Of course we can skip the renaming, but then it will be less consistent
and will not reflect the actual timer source used.
I tried to make it flexible as much as possible and self explanatory.
So above are my considerations, but at this point in time I don't really
care if we rename them or just add a new one, but we have to get rid of
the ugly fall back.

> 
>> We have discussed this in San Diego (remember?) and you actually proposed
>> this way as a solution. Well, may be I took it a bit further than you
>> thought, but this is because the board code cannot know which timer source
>> should be used at runtime and the fall back described below, does not work.
> 
> Yes thanks I agree we should get rid of that Kconfig option for sure. 
> 
>>>> --- a/arch/arm/mach-omap2/board-2430sdp.c
>>>> +++ b/arch/arm/mach-omap2/board-2430sdp.c
>>>> @@ -284,6 +284,6 @@ MACHINE_START(OMAP_2430SDP, "OMAP2430 sdp2430 board")
>>>>  	.handle_irq	= omap2_intc_handle_irq,
>>>>  	.init_machine	= omap_2430sdp_init,
>>>>  	.init_late	= omap2430_init_late,
>>>> -	.timer		= &omap2_timer,
>>>> +	.timer		= &omap2_sync32k_timer,
>>>>  	.restart	= omap_prcm_restart,
>>>>  MACHINE_END
>>>> --- a/arch/arm/mach-omap2/board-3430sdp.c
>>>> +++ b/arch/arm/mach-omap2/board-3430sdp.c
>>>> @@ -596,6 +596,6 @@ MACHINE_START(OMAP_3430SDP, "OMAP3430 3430SDP board")
>>>>  	.handle_irq	= omap3_intc_handle_irq,
>>>>  	.init_machine	= omap_3430sdp_init,
>>>>  	.init_late	= omap3430_init_late,
>>>> -	.timer		= &omap3_timer,
>>>> +	.timer		= &omap3_sync32k_timer,
>>>>  	.restart	= omap_prcm_restart,
>>>>  MACHINE_END
>>> ...
>>>
>>> Can't we assume that the default timer is omap[234]_sync32k_timer to
>>> avoid renaming the timer entries in all the board files?
>>
>> Hmmm...
>> How will this work with the macros defining the sys_timer structure?
>> I would also not want to hide the exact timer used under the default name.
> 
> Can't you just add a new sys_timer (or a new macro) for GP only setups? 

Of course I can... but I tried to create a flexible generic code, so
no meter how a board will be wired, you just need to specify which timer source
it uses and be done with it.

>  
>>> Then we just need a new timer entries for the hardware that does
>>> not have the sycn32k_timer available?
>>
>> Well, I tried to make it small patch just for the hardware that needs it,
>> but I always found some corner case where, IMHO, this does not work/look good.
> 
> Can you explain a bit further?

Yes, OMAP4 has its own "local" timer function, OMAP5 - the real time timer
function, we have that fall back from 32k to gptimer for AM33xx and we also
have the use_gptimer_clksrc parameter.
All the above call the same timer source init functions at the end.

> 
> I guess what I'm after is just to avoid renaming the existing
> timers in the board-*.c files and only rename the ones that
> need gp timer only.

This means: get rid of the 32k to gptimer fall back.
I've got your point, will cook something shortly.


-- 
Regards,
Igor.
