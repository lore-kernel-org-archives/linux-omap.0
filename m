From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCHv11 07/49] clk: divider: add support for low level ops
Date: Fri, 20 Dec 2013 16:09:07 +0530
Message-ID: <52B41E4B.8040808@ti.com>
References: <1387452260-23276-1-git-send-email-t-kristo@ti.com> <1387452260-23276-8-git-send-email-t-kristo@ti.com> <20131219182620.GQ27438@atomide.com> <52B342D2.1010301@ti.com> <52B416E8.8070006@ti.com> <52B41C15.8040304@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54684 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755855Ab3LTKjf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Dec 2013 05:39:35 -0500
In-Reply-To: <52B41C15.8040304@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, paul@pwsan.com, nm@ti.com, bcousson@baylibre.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On Friday 20 December 2013 03:59 PM, Tero Kristo wrote:
> On 12/20/2013 12:07 PM, Rajendra Nayak wrote:
>> On Friday 20 December 2013 12:32 AM, Tero Kristo wrote:
>>> On 12/19/2013 08:26 PM, Tony Lindgren wrote:
>>>> * Tero Kristo <t-kristo@ti.com> [131219 03:26]:
>>>>> Divider clock can now be registered to use low level register access ops.
>>>>> Preferred initialization method is via clock description.
>>>>
>>>> This seems to make omap2 not boot for me. No output whatsoever even with
>>>> DEBUG_LL and earlyprintk.
>>>
>>> Thats weird... I was kind of afraid something like this might happen though as these patches touch the clock low level routines globally, but I can't see what could be broken...
>>
>> I got hold of a 2430sdp and saw the same behavior, however DEBUG_LL and earlyprintk worked and this is
>> what I see
>>
>> [    0.000000] Unable to handle kernel NULL pointer dereference at virtual address 00000000
>> [    0.000000] pgd = c0004000
>> [    0.000000] [00000000] *pgd=00000000
>> [    0.000000] Internal error: Oops: 5 [#1] SMP ARM
>> [    0.000000] Modules linked in:
>> [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.13.0-rc4-00056-ga9fa93e #2
>> [    0.000000] task: c07dfcb8 ti: c07d4000 task.ti: c07d4000
>> [    0.000000] PC is at clk_mux_get_parent+0x14/0xcc
>> [    0.000000] LR is at clk_mux_get_parent+0x10/0xcc
>> [    0.000000] pc : [<c044a234>]    lr : [<c044a230>]    psr: a00001d3
>> [    0.000000] sp : c07d5f40  ip : 00000000  fp : 00000000
>> [    0.000000] r10: c07dc880  r9 : 4107b366  r8 : c07f46a4
>> [    0.000000] r7 : c0edfa80  r6 : ffffffff  r5 : c07f6810  r4 : 00000002
>> [    0.000000] r3 : 00000000  r2 : 00000000  r1 : c069da67  r0 : 00000002
>> [    0.000000] Flags: NzCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
>> [    0.000000] Control: 00c5387d  Table: 80004000  DAC: 00000017
>> [    0.000000] Process swapper/0 (pid: 0, stack limit = 0xc07d4248)
>> [    0.000000] Stack: (0xc07d5f40 to 0xc07d6000)
>> [    0.000000] 5f40: c044a220 00000002 c6001f40 c0448e54 c07dfcb8 c0862f7c c07f3600 c07f4368
>> [    0.000000] 5f60: ffffffff c0edfa80 c07b6b80 4107b366 c07dc880 c077edf4 c0531008 c07f4380
>> [    0.000000] 5f80: c07f34d4 c077f20c c0878964 c0edfa80 c07b6b80 c0877ac4 c0877640 ffffffff
>> [    0.000000] 5fa0: c0edfa80 c0777268 00000001 c07792ac c07b5250 c077221c 00000002 c076e974
>> [    0.000000] 5fc0: ffffffff ffffffff c076e57c 00000000 00000000 c07b6b80 00000000 00c5387d
>> [    0.000000] 5fe0: c07dc928 c07b6b7c c07e1474 80004008 8052c544 80008074 00000000 00000000
>> [    0.000000] [<c044a234>] (clk_mux_get_parent+0x14/0xcc) from [<c0448e54>] (__clk_init+0xe4/0x3f0)
>> [    0.000000] [<c0448e54>] (__clk_init+0xe4/0x3f0) from [<c077edf4>] (omap_clocks_register+0x24/0x48)
>> [    0.000000] [<c077edf4>] (omap_clocks_register+0x24/0x48) from [<c077f20c>] (omap2430_clk_init+0x4c/0x124)
>> [    0.000000] [<c077f20c>] (omap2430_clk_init+0x4c/0x124) from [<c0777268>] (omap_clk_init+0x28/0x30)
>> [    0.000000] [<c0777268>] (omap_clk_init+0x28/0x30) from [<c07792ac>] (omap2_sync32k_timer_init+0x8/0x58)
>> [    0.000000] [<c07792ac>] (omap2_sync32k_timer_init+0x8/0x58) from [<c077221c>] (time_init+0x1c/0x30)
>> [    0.000000] [<c077221c>] (time_init+0x1c/0x30) from [<c076e974>] (start_kernel+0x1d4/0x360)
>> [    0.000000] [<c076e974>] (start_kernel+0x1d4/0x360) from [<80008074>] (0x80008074)
>> [    0.000000] Code: e1a05000 e5900000 ebfff7f5 e595300c (e5933000)
>> [    0.000000] ---[ end trace 3406ff24bd97382e ]---
>> [    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
>>
>> I'll try and debug further but any quick thoughts on what could be wrong?
> 
> I have a fix for this already and will be posting v12 today. I will just re-post the drivers/clk part of the series though, rest of the patches should be fine.
> 
> This bug was silly actually, I didn't think of the static clock data initialization through the macros from clk-private.h... This caused the resulting clock structures to have NULL for clk_ll_ops as it bypassed the init function where I set it up. So, I will need to check against NULL every time I do anything with ll_ops.

yeah, the crash was indeed when ll_ops was dereferenced despite being NULL.

> 
> -Tero
> 

