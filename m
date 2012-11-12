From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: timer: remove CONFIG_OMAP_32K_TIMER
Date: Mon, 12 Nov 2012 13:05:58 -0600
Message-ID: <50A14896.1080504@ti.com>
References: <1352299344-8011-1-git-send-email-grinberg@compulab.co.il> <20121107173343.GF6801@atomide.com> <509B5B84.50605@compulab.co.il> <20121108162004.GA6801@atomide.com> <509F6CE3.50806@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58528 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751949Ab2KLTGZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Nov 2012 14:06:25 -0500
In-Reply-To: <509F6CE3.50806@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>


On 11/11/2012 03:16 AM, Igor Grinberg wrote:
> On 11/08/12 18:20, Tony Lindgren wrote:
>> * Igor Grinberg <grinberg@compulab.co.il> [121107 23:15]:
>>> On 11/07/12 19:33, Tony Lindgren wrote:
>>>>
>>>> I think this should be the default for the timers as that counter
>>>> does not stop during deeper idle states.
>>>
>>> Well, it is the default as you can see from the patch.
>>> The problem is that for boards that for some reason do not have
>>> the 32k wired and rely on MPU/GP timer source, the default will not work
>>> and currently there is no way for board to specify which timer source
>>> it can use.
>>
>> Yes. I was just wondering if we can avoid patching all the board
>> files by doing it the other way around by introducing a new
>> omap_gp_timer rather than renaming all the existing ones?
> 
> Is the renaming that bad? One line per machine_desc structure?
> Of course we can skip the renaming, but then it will be less consistent
> and will not reflect the actual timer source used.
> I tried to make it flexible as much as possible and self explanatory.
> So above are my considerations, but at this point in time I don't really
> care if we rename them or just add a new one, but we have to get rid of
> the ugly fall back.

I am not sure if you guys disagree, but does it make sense to start
thinking about this with regard to device-tree? With device-tree all the
boards files will become obsolete and so we need to be able to handle
this during boot time and not compile time.

>>
>>> We have discussed this in San Diego (remember?) and you actually proposed
>>> this way as a solution. Well, may be I took it a bit further than you
>>> thought, but this is because the board code cannot know which timer source
>>> should be used at runtime and the fall back described below, does not work.
>>
>> Yes thanks I agree we should get rid of that Kconfig option for sure. 
>>
>>>>> --- a/arch/arm/mach-omap2/board-2430sdp.c
>>>>> +++ b/arch/arm/mach-omap2/board-2430sdp.c
>>>>> @@ -284,6 +284,6 @@ MACHINE_START(OMAP_2430SDP, "OMAP2430 sdp2430 board")
>>>>>  	.handle_irq	= omap2_intc_handle_irq,
>>>>>  	.init_machine	= omap_2430sdp_init,
>>>>>  	.init_late	= omap2430_init_late,
>>>>> -	.timer		= &omap2_timer,
>>>>> +	.timer		= &omap2_sync32k_timer,
>>>>>  	.restart	= omap_prcm_restart,
>>>>>  MACHINE_END
>>>>> --- a/arch/arm/mach-omap2/board-3430sdp.c
>>>>> +++ b/arch/arm/mach-omap2/board-3430sdp.c
>>>>> @@ -596,6 +596,6 @@ MACHINE_START(OMAP_3430SDP, "OMAP3430 3430SDP board")
>>>>>  	.handle_irq	= omap3_intc_handle_irq,
>>>>>  	.init_machine	= omap_3430sdp_init,
>>>>>  	.init_late	= omap3430_init_late,
>>>>> -	.timer		= &omap3_timer,
>>>>> +	.timer		= &omap3_sync32k_timer,
>>>>>  	.restart	= omap_prcm_restart,
>>>>>  MACHINE_END
>>>> ...
>>>>
>>>> Can't we assume that the default timer is omap[234]_sync32k_timer to
>>>> avoid renaming the timer entries in all the board files?
>>>
>>> Hmmm...
>>> How will this work with the macros defining the sys_timer structure?
>>> I would also not want to hide the exact timer used under the default name.
>>
>> Can't you just add a new sys_timer (or a new macro) for GP only setups? 
> 
> Of course I can... but I tried to create a flexible generic code, so
> no meter how a board will be wired, you just need to specify which timer source
> it uses and be done with it.

If you are concerned about how a board is wired up (if the 32k is
present), then I think that that is best handled via device-tree and we
should query device-tree on boot to see what our options are.

What do you guys think?

Cheers
Jon
