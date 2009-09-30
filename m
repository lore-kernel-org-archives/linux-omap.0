From: Roger Quadros <ext-roger.quadros@nokia.com>
Subject: Re: linux-omap git tree updated to v2.6.32-rc1, important changes,
 please read
Date: Wed, 30 Sep 2009 18:53:50 +0300
Message-ID: <4AC37F0E.8010206@nokia.com>
References: <20090928190404.GE18957@atomide.com> <94a0d4530909291024kcac6b20m727b2908b2a76b88@mail.gmail.com> <20090929182639.GA16865@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:55373 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754702AbZI3Pym (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Sep 2009 11:54:42 -0400
In-Reply-To: <20090929182639.GA16865@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

ext Tony Lindgren wrote:
> * Felipe Contreras <felipe.contreras@gmail.com> [090929 10:24]:
>> On Mon, Sep 28, 2009 at 10:04 PM, Tony Lindgren <tony@atomide.com> wrote:
>>> Hi all,
>>>
>>> I've updated our linux-omap tree to v2.6.32-rc1. I've also
>>> added a branch omap-2.6.31 for the old code.
>>>
>>> This time I also nuked the remaining omap legacy code we
>>> still had lurking around :) The commits at the end of this
>>> mail describe what I did first as commits, then I merged
>>> everything to be the same as the mainline v2.6.32-rc1.
>>>
>>> So currently the linux-omap master branch is:
>>>
>>> v2.6.32-rc1 + omap-fixes + ehci + cbus
>>>
>>> The new model is that I'll be resetting the linux-omap master
>>> branch to mainline at each -rc, then merge in our various
>>> upstream queues back in again.
>> Excellent! I was wondering why this wasn't being done. I certainly
>> hope linus' 2.6.32 will work on omap right away.
> 
> Yeah, let's hope Tomi gets in the DSS2 code too.
>  
>> Anyway, I haven't been able to make 2.6.31 boot on beagleboard, and
>> other people report similar issues:
>> http://www.spinics.net/lists/linux-omap/msg17968.html
>>
>> Have you got 2.6.32-rc1 (+fixes) to boot?
> 
> Hmm, looks like it's musb again. This is what I get on my
> overo after applying the DEBUG_LL hack from omap-debug branch:

i've just sent a fix for this musb problem. patch is labelled "twl4030: Fix boot 
with twl4030 usb transceiver enabled"

cheers,
-roger

> 
> <3>musb_hdrc musb_hdrc: musb_init_controller failed with status -19             
> <1>Unable to handle kernel NULL pointer dereference at virtual address 00000000 
> <1>pgd = c0004000                                                               
> <1>[00000000] *pgd=00000000                                                     
> Internal error: Oops: 5 [#1]                                                    
> <d>Modules linked in:                                                           
> CPU: 0    Not tainted  (2.6.32-rc2-05967-gd350540-dirty #892)                   
> PC is at musb_free+0x68/0xb8                                                    
> LR is at musb_free+0x34/0xb8                                                    
> pc : [<c028a160>]    lr : [<c028a12c>]    psr: a0000013                         
> sp : c781fe50  ip : 00000064  fp : 00000000                                     
> r10: 00000000  r9 : 00000000  r8 : c0557bc0                                     
> r7 : c7811000  r6 : c78110e8  r5 : c78110e8  r4 : 00000000                      
> r3 : 00000000  r2 : 00000001  r1 : c04c95b6  r0 : ffffffed                      
> Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel             
> Control: 10c5387d  Table: 80004019  DAC: 00000017                               
> Process swapper (pid: 1, stack limit = 0xc781e2f0)                              
> Stack: (0xc781fe50 to 0xc7820000)
> fe40:                                     ffffffed 00000000 c78110e8 c001e8f8   
> fe60: c781fea4 c7804180 00000000 c7804184 c0533dc8 c0533dd0 0000005c d80ab000   
> fe80: c0533dac c7811190 00000000 c781fedc c0114ad8 c7806850 c0546248 c06d74e0   
> fea0: 00000000 c03cd5c8 00000000 c781ff00 c78b8de0 c0114cbc c78b8d80 c781ff00   
> fec0: c78b8de0 c0114864 c78b8d80 c781ff00 c78b8de0 c011493c c781ff00 c78b8de0   
> fee0: c78b8d80 00000000 c781ff00 c78b8de0 c787a210 00000001 00000000 c01157b4   
> ff00: c787a210 00000000 00000000 c0533dd0 c0533dd0 c055df04 c7873600 c0557bc0   
> ff20: 00000000 00000000 00000000 c0210b7c c0533dd0 c020fbd4 c0533dd0 c0533e04   
> ff40: c055df04 c7873600 c0557bc0 c020fce0 00000000 c020fc80 c055df04 c020f420   
> ff60: c7802d08 c787b240 c0026dd4 00000080 c055df04 c020ed38 c03f14f4 c03f14f4   
> ff80: c7820000 c0026dd4 c055def0 c055df04 00000000 00000000 00000000 c020ffb0   
> ffa0: c0026dd4 c055def0 c001dca0 00000000 00000000 c0210f70 c0026dd4 00000000   
> ffc0: c001dca0 c002d2b4 00000031 00000000 00000000 00000192 00000000 c0026dd4   
> ffe0: 00000000 00000000 00000000 c0008578 00000000 c002ee10 817fdf10 00bbff00
> [<c028a160>] (musb_free+0x68/0xb8) from [<c001e8f8>] (musb_probe+0xab8/0xbb4)   
> [<c001e8f8>] (musb_probe+0xab8/0xbb4) from [<c0210b7c>] (platform_drv_probe+0x1)
> [<c0210b7c>] (platform_drv_probe+0x18/0x1c) from [<c020fbd4>] (driver_probe_dev)
> [<c020fbd4>] (driver_probe_device+0xa0/0x14c) from [<c020fce0>] (__driver_attac)
> [<c020fce0>] (__driver_attach+0x60/0x84) from [<c020f420>] (bus_for_each_dev+0x)
> [<c020f420>] (bus_for_each_dev+0x44/0x74) from [<c020ed38>] (bus_add_driver+0xf)
> [<c020ed38>] (bus_add_driver+0xf4/0x278) from [<c020ffb0>] (driver_register+0xa)
> [<c020ffb0>] (driver_register+0xa8/0x130) from [<c0210f70>] (platform_driver_pr)
> [<c0210f70>] (platform_driver_probe+0x10/0x88) from [<c002d2b4>] (do_one_initca)
> [<c002d2b4>] (do_one_initcall+0x5c/0x1b4) from [<c0008578>] (kernel_init+0x90/0)
> [<c0008578>] (kernel_init+0x90/0x10c) from [<c002ee10>] (kernel_thread_exit+0x0)
> Code: e1a01005 ebf80722 e595309c e3a04000 (e5930000)
> <4>---[ end trace 1b75b31a2719ed1c ]---                                         
> <0>Kernel panic - not syncing: Attempted to kill init!
> 
> After disabling musb, it boots further but can't mount root on the MMC:
> 
> ...
> <4>regulator_init_complete: incomplete constraints, leaving VUSB1V8 on          
> regulator_init_complete: incomplete constraints, leaving VUSB1V8 on             
> <4>regulator_init_complete: incomplete constraints, leaving VUSB1V5 on          
> regulator_init_complete: incomplete constraints, leaving VUSB1V5 on             
> <4>regulator_init_complete: incomplete constraints, leaving VMMC1 on            
> regulator_init_complete: incomplete constraints, leaving VMMC1 on               
> <6>twl4030_rtc twl4030_rtc: setting system clock to 2000-01-01 00:00:00 UTC (94)
> twl4030_rtc twl4030_rtc: setting system clock to 2000-01-01 00:00:00 UTC (94668)
> <6>Waiting for root device /dev/mmcblk0p2...                                    
> Waiting for root device /dev/mmcblk0p2...
> 
> What are you getting with DEBUG_LL enabled and the associated patch applied
> from omap-debug branch?
> 
> Regards,
> 
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

