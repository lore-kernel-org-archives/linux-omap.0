From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: Please help with the OMAP static mapping mess
Date: Tue, 04 Oct 2011 12:34:25 +0530
Message-ID: <4E8AAFF9.3090600@ti.com>
References: <alpine.LFD.2.02.1110031312480.9106@xanadu.home> <20111003205658.GJ6324@atomide.com> <alpine.LFD.2.02.1110031744100.9106@xanadu.home> <20111003223824.GK6324@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:52414 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754071Ab1JDHEd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Oct 2011 03:04:33 -0400
Received: by ggnm2 with SMTP id m2so84804ggn.22
        for <linux-omap@vger.kernel.org>; Tue, 04 Oct 2011 00:04:32 -0700 (PDT)
In-Reply-To: <20111003223824.GK6324@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Nicolas,

On Tuesday 04 October 2011 04:08 AM, Tony Lindgren wrote:
> * Nicolas Pitre <nico@fluxnic.net> [111003 14:36]:
>> On Mon, 3 Oct 2011, Tony Lindgren wrote:
>>
>>> * Nicolas Pitre <nico@fluxnic.net> [111003 11:26]:
>>
>>>> OK, so let's modify omap4_panda_map_io() just to test this one board and 
>>>> reverse the omap44xx_map_common_io() and omap2_set_globals_443x() call 
>>>> order.  Now the mappings will be there before ioremap() is called.  But 
>>>> that, too, doesn't work and the kernel now complains with:
>>>>
>>>> |OMAP revision unknown, please fix!
>>>> |Uninitialized omap_chip, please fix!
>>>> |Could not detect SRAM size
>>>>
>>>> But it looks like omap2_set_globals_tap() still has to be called first!  
>>>> Isn't this wonderfully convoluted?
>>>
>>> We've already unravelled some of that with the init_early changes.
>>>
Sorry about that. We revamped io_map last time around to avoid
use of omap_readl()/omap_writel() and as Tony pointed out, as part
of early init code re-factoring, some more clean-up is happening.

>>> Earlier having the IO space moving around between 2420/2430/3430
>>> meant that we had to map some IO to detect the SoC. Now we have
>>> SoC specific initcalls where we assume the SoC category is initialized
>>> from board-*.c file (and from DT at some point).
>>
>> But the map_io method always has been tied to machine specific 
>> descriptors.  That always implied a fixed SoC category, no?  Unless you 
>> have a machine which can accommodate multiple different SOCs but that's 
>> very uncommon.
> 
> Hmm I think we initially tried to use board-generic.c with custom ATAGs
> to boot multiple SoCs and that's why we needed SoC detection for map_io.
> 
> Now the only variable SoC headache left is that board-omap3beagle.c
> is using the same machine_id for 3430 and 3630 beagle which are somewhat
> different SoCs, but Luckily not from map_io point of view though. So that
> should be fixable with DT when the SoC type will be passed from DT.
>  
>>> Having the SRAM base address move around with different sizes also
>>> requires the SoC detection.. Otherwise we can end up mapping wrong
>>> size and end up trying to access secure SRAM that will hang the system.
>>>
>>> The way to fix it is to move SRAM init happen much later so we don't
>>> have to map it early. I guess now we could use ioremap for SRAM,
>>> although we may not want device attributes for the executable code?
>>> Got any suggestions here on how we should map SRAM later on?
>>
>> You can use a variant of ioremap() such as __arm_ioremap() which let you 
>> specify the memory attribute.
> 
> OK, I'll take a look at that.
> 
I have tried __arm_ioremap_pfn() for some DDR mapping and it didn't
work as expected. The mapping was not getting created. Needless to
say this can't be an IO memory. I later managed to get around with
it by using iotable_init() though downside is I have to pick a
static virtual address for the mapping.

But I agree that SRAM mapping can be moved further down. We
just need to ensure that it's ready before we initialise SDRC
and PM code. SDRC reconfigure of DDR needs to be executed from
SRAM and of-course the PM WFI routine. Today we do SDRC init early
and that's the reason SRAM is mapped before that. So both of them
needs to be moved down in the boot to make it work.

>>>> Furthermore... there is also a static mapping for physical address 
>>>> 0x4e000000 using virtual address 0xff100000 which is already reserved 
>>>> for other purposes i.e. the consistent DMA area.  It is not immediately 
>>>> obvious where this comes from without being intimate with the OMAP code. 
>>>> Can this be fixed as well i.e. moved elsewhere please?
>>>
>>> This sounds like a bug somewhere. Which omap are you seeing this on?
>>
>> OMAP4430 on a Panda board.
>>
>> Here are the static mappings I'm seeing:
>>
>> phys = 0x44000000 virt = 0xf8000000 size = 0x100000
>> phys = 0x4a000000 virt = 0xfc000000 size = 0x400000
>> phys = 0x50000000 virt = 0xf9000000 size = 0x100000
>> phys = 0x4c000000 virt = 0xfd100000 size = 0x100000
>> phys = 0x4d000000 virt = 0xfe100000 size = 0x100000
>> phys = 0x4e000000 virt = 0xff100000 size = 0x100000 <---
>> phys = 0x48000000 virt = 0xfa000000 size = 0x400000
>> phys = 0x54000000 virt = 0xfe800000 size = 0x800000
>>
>> It is also possible that I might have screwed something up on my side.  
>> What is located at 0x4e000000?
> 
This was definitely a BUG which I noticed last merge window. The fix for
this is already getting into 3.2.

Regards
Santosh
