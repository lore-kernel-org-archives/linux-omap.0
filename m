From: Kalle Valo <kalle.valo@iki.fi>
Subject: Re: Git tree updated, clocks and PM code reset to mainline
Date: Sat, 04 Apr 2009 08:27:19 +0300
Message-ID: <87k561htu0.fsf@litku.valot.fi>
References: <20090403001333.GR32530@atomide.com>
	<20090403091553.82ceacf8.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f169.google.com ([209.85.218.169]:49674 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829AbZDDF1Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Apr 2009 01:27:25 -0400
Received: by bwz17 with SMTP id 17so1206524bwz.37
        for <linux-omap@vger.kernel.org>; Fri, 03 Apr 2009 22:27:21 -0700 (PDT)
In-Reply-To: <20090403091553.82ceacf8.jarkko.nikula@nokia.com> (Jarkko Nikula's message of "Fri\, 3 Apr 2009 09\:15\:53 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: ext Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Jarkko Nikula <jarkko.nikula@nokia.com> writes:

> On Fri, 3 Apr 2009 02:13:33 +0200
> ext Tony Lindgren <tony@atomide.com> wrote:
>
>> This means that the PM and some clock features will be broken until
>> we can merge in Paul's clock branch and Kevin's pm branch.
>> 
>> Please everybody take a look at the big commit that resets the code,
>> it's commit eba05254cb561dc27d5664503f91f7c21954e648. I've made sure
>> things build for all omap configs, and booted several boards. But I
>> may have accidentally left out something critical too..
>> 
> Just a test report. N810 is not booting anymore due an oops and Beagle
> hangs when calibrating the delay loop.
>
> Both using their defconfigs + CONFIG_DEBUG_LL=y. N810 boot log below.

I see the same with N800, same configs as Jarkko had:

<6>SRAM: Mapped pa 0x40200000 to va 0xe3000000 size: 0x100000                   
Built 1 zonelists in Zone order, mobility grouping on.  Total pages:
32512      
<5>Kernel command line: root=1f03 rootfstype=jffs2                              
<6>NR_IRQS:368                                                                  
<1>Unable to handle kernel NULL pointer dereference at virtual address
00000000 
<1>pgd = c0004000                                                               
<1>[00000000] *pgd=00000000                                                     
Internal error: Oops: 5 [#1]                                                    
Modules linked in:                                                              
CPU: 0    Not tainted  (2.6.29-omap1 #118)                                      
PC is at propagate_rate+0x34/0x54                                               
LR is at omap2_clk_init+0x28/0x1c8                                              
pc : [<c003494c>]    lr : [<c000dd0c>]    psr: 400001d3                         
sp : c0313f90  ip : 00000003  fp : 00000000                                     
r10: 80021a04  r9 : 4107b362  r8 : 80021a38                                     
r7 : c0315c60  r6 : c0023ee8  r5 : c0317288  r4 : ffffffe0                      
r3 : 00000000  r2 : c0317268  r1 : 00000040  r0 : c0317288                      
Flags: nZcv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment kernel           
Control: 00c5387f  Table: 80004000  DAC: 00000017                               
Process swapper (pid: 0, stack limit = 0xc0312260)                              
Stack: (0xc0313f90 to 0xc0314000)                                               
3f80:                                     c0316cc8 c03172e8 c0023ee8
c000dd0c   
3fa0: 00000000 00000001 00000000 c0339000 c0023ee8 c0315c60 80021a38
c000d5c0   
3fc0: c0023eec c000e3d4 c0023eec c000b110 c0023eec c00089c8 c00084bc
00000000   
3fe0: 00000000 c0023eec 00000000 00c5387d c0339120 80008034 00000000
00000000   
[<c003494c>] (propagate_rate+0x34/0x54) from [<c000dd0c>]
(omap2_clk_init+0x28/0
x1c8)                                                                           
[<c000dd0c>] (omap2_clk_init+0x28/0x1c8) from [<c000d5c0>]
(omap2_init_common_hw
+0x20/0x38)                                                                     
[<c000d5c0>] (omap2_init_common_hw+0x20/0x38) from [<c000e3d4>]
(nokia_n800_init
_irq+0xc/0x50)                                                                  
[<c000e3d4>] (nokia_n800_init_irq+0xc/0x50) from [<c000b110>]
(init_IRQ+0x30/0x4
0)                                                                              
[<c000b110>] (init_IRQ+0x30/0x40) from [<c00089c8>]
(start_kernel+0x120/0x288)  
[<c00089c8>] (start_kernel+0x120/0x288) from [<80008034>] (0x80008034)          
Code: e1a00004 ebfffff4 e5943020 e2434020 (e5943020)                            
<4>---[ end trace 1b75b31a2719ed1c ]---                                         
<0>Kernel panic - not syncing: Attempted to kill the idle task!                 
[<c002c5e4>] (unwind_backtrace+0x0/0xe0) from [<c004abb8>]
(panic+0x40/0x110)   
[<c004abb8>] (panic+0x40/0x110) from [<c004d4d4>] (do_exit+0x60/0x644)          
[<c004d4d4>] (do_exit+0x60/0x644) from [<c002ab70>] (die+0x12c/0x14c)           
[<c002ab70>] (die+0x12c/0x14c) from [<c002d450>]
(__do_kernel_fault+0x64/0x74)  
[<c002d450>] (__do_kernel_fault+0x64/0x74) from [<c002d65c>]
(do_page_fault+0x1f
c/0x218)                                                                        
[<c002d65c>] (do_page_fault+0x1fc/0x218) from [<c002620c>]
(do_DataAbort+0x34/0x
98)                                                                             
[<c002620c>] (do_DataAbort+0x34/0x98) from [<c002692c>]
(__dabt_svc+0x4c/0x60)  
Exception stack(0xc0313f48 to 0xc0313f90)                                       
3f40:                   c0317288 00000040 c0317268 00000000 ffffffe0
c0317288   
3f60: c0023ee8 c0315c60 80021a38 4107b362 80021a04 00000000 00000003
c0313f90   
3f80: c000dd0c c003494c 400001d3 ffffffff                                       
[<c002692c>] (__dabt_svc+0x4c/0x60) from [<c000dd0c>]
(omap2_clk_init+0x28/0x1c8
)                                                                               
[<c000dd0c>] (omap2_clk_init+0x28/0x1c8) from [<c0339000>]
(0xc0339000)         


-- 
Kalle Valo
