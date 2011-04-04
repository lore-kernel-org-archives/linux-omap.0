From: Avik Sil <aviksil@linux.vnet.ibm.com>
Subject: Re: arm: pmu: support pmu/perf on OMAP4 - booting problem on pandaboard
Date: Mon, 04 Apr 2011 21:31:15 +0530
Message-ID: <4D99EB4B.3020303@linux.vnet.ibm.com>
References: <4D95E244.1050400@linux.vnet.ibm.com> <BANLkTi=nOR=yX=QgbyCoYUE1U7DPxUCCzw@mail.gmail.com> <4D99D251.6000901@linux.vnet.ibm.com> <BANLkTikmC_OT5TsN_jfVoUjvvcSsR2p3HA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from e39.co.us.ibm.com ([32.97.110.160]:54332 "EHLO
	e39.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754996Ab1DDQB2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Apr 2011 12:01:28 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e39.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p34FmDui016738
	for <linux-omap@vger.kernel.org>; Mon, 4 Apr 2011 09:48:13 -0600
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id p34G1Nf8078722
	for <linux-omap@vger.kernel.org>; Mon, 4 Apr 2011 10:01:23 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p34G6INc025949
	for <linux-omap@vger.kernel.org>; Mon, 4 Apr 2011 10:06:18 -0600
In-Reply-To: <BANLkTikmC_OT5TsN_jfVoUjvvcSsR2p3HA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Monday 04 April 2011 07:53 PM, Ming Lei wrote:
> Hi,
>
> 2011/4/4 Avik Sil<aviksil@linux.vnet.ibm.com>:
>> Hi Ming,
>>
>> On Saturday 02 April 2011 10:57 AM, Ming Lei wrote:
>>>
>>> Hi Avik,
>>>
>>> 2011/4/1 Avik Sil<aviksil@linux.vnet.ibm.com>:
>>>>
>>>> Hi,
>>>>
>>>> I've applied the patches in
>>>>
>>>> http://lists.infradead.org/pipermail/linux-arm-kernel/2011-March/045283.html
>>>> on top of a linaro kernel which resulted in booting problem on
>>>> Pandaboard.
>>>> It hangs inside the cti_unlock() while reading the LOCKSTATUS value,
>>>> which
>>>> happens when omap_init_pmu() is called. Please help me debug the issue.
>>>
>>> Please check if  l3 clocks are enabled to drive CTI, such as done in
>>> below:
>>>
>>>         omap_writel(1, CM_L3INSTR_L3_3_CLKCTRL);
>>>         omap_writel(1, CM_L3INSTR_L3_INSTR_CLKCTRL);
>>>         omap_writel(2, CM_EMU_CLKSTCTRL);
>>>         while ((omap_readl(CM_EMU_CLKSTCTRL)&    0x300) != 0x300);
>>>
>> Can you please tell me where should I insert the above code to enable l3
>> clocks to drive CTI?
>
> It should be inserted before calling omap4_configure_pmu_irq.
>
After inserting the above code, I got build error saying undeclared 
identifiers. After searching, I found the above identifiers are defined 
with 'OMAP4430_' prefix in arch/arm/mach-omap2/cm2_44xx.h 
(OMAP4430_CM_L3INSTR_L3_3_CLKCTRL and 
OMAP4430_CM_L3INSTR_L3_INSTR_CLKCTRL) and arch/arm/mach-omap2/prm44xx.h 
(OMAP4430_CM_EMU_CLKSTCTRL):

#define OMAP4430_CM_L3INSTR_L3_3_CLKCTRL	 
OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CORE_INST, 0x0720)
[...]

Should I use those identifier instead?

I gave a try with those identifiers and it built the image successfully 
although with some warnings - "passing argument 2 of 'omap_writel' makes 
integer from pointer without a cast". And the kernel ended up with oops:

[    1.082122] Unable to handle kernel paging request at virtual address 
ae008e20
[    1.089630] pgd = c0004000
[    1.092498] [ae008e20] *pgd=00000000
[    1.096252] Internal error: Oops: 805 [#1] SMP
[    1.100891] last sysfs file:
[    1.104034] Modules linked in:
[    1.107269] CPU: 0    Not tainted  (2.6.38.2+ #13)
[    1.112274] PC is at omap_writel+0x4/0xc
[    1.116394] LR is at omap2_init_devices+0x108/0x42c
[    1.121490] pc : [<c006f174>]    lr : [<c0011274>]    psr: 60000013
[    1.121490] sp : da845f98  ip : 271beb3a  fp : 00000000
[    1.133453] r10: 00000000  r9 : 00000000  r8 : c001116c
[    1.138916] r7 : 00000000  r6 : c0789738  r5 : 00000002  r4 : c078acd0
[    1.145690] r3 : da848000  r2 : 271beb3a  r1 : ae008e20  r0 : 00000001
[    1.152496] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM 
Segment kernel
[    1.160064] Control: 10c53c7f  Table: 8000404a  DAC: 00000015
[    1.166046] Process swapper (pid: 1, stack limit = 0xda8442f8)
[    1.172119] Stack: (0xda845f98 to 0xda846000)
[    1.176696] 5f80: 
    c07ed3a0 c003b82c
[    1.185180] 5fa0: c0789738 c00535a4 00000000 271beb3a c07bddf4 
0000019a c0789738 c07843d4
[    1.193664] 5fc0: c003b2bc c003b82c c0789738 c07843d4 00000004 
00000000 00000000 c000874c
[    1.202148] 5fe0: 00000000 c0008588 c00600b0 00000013 00000000 
c00600b0 38c64703 060aa000
[    1.210632] [<c006f174>] (omap_writel+0x4/0xc) from [<c0011274>] 
(omap2_init_devices+0x108/0x42c)
[    1.219848] [<c0011274>] (omap2_init_devices+0x108/0x42c) from 
[<c00535a4>] (do_one_initcall+0x34/0x18c)
[    1.229675] [<c00535a4>] (do_one_initcall+0x34/0x18c) from 
[<c000874c>] (kernel_init+0x1c4/0x250)
[    1.238891] [<c000874c>] (kernel_init+0x1c4/0x250) from [<c00600b0>] 
(kernel_thread_exit+0x0/0x8)
[    1.248107] Code: e28114b2 e1c100b0 e12fff1e e28114b2 (e5810000)
[    1.254455] ---[ end trace da227214a82491b7 ]---
[    1.259338] Kernel panic - not syncing: Attempted to kill init!
[    1.265533] [<c00673ac>] (unwind_backtrace+0x0/0xfc) from 
[<c057d2f0>] (panic+0xb8/0x1dc)
[    1.274047] [<c057d2f0>] (panic+0xb8/0x1dc) from [<c00a75fc>] 
(do_exit+0x6e4/0x74c)
[    1.282012] [<c00a75fc>] (do_exit+0x6e4/0x74c) from [<c0063458>] 
(die+0x1e0/0x1f8)
[    1.289916] [<c0063458>] (die+0x1e0/0x1f8) from [<c006b884>] 
(__do_kernel_fault+0x74/0x84)
[    1.298492] [<c006b884>] (__do_kernel_fault+0x74/0x84) from 
[<c05831c8>] (do_page_fault+0xa8/0x338)
[    1.307891] [<c05831c8>] (do_page_fault+0xa8/0x338) from [<c00534e0>] 
(do_DataAbort+0x38/0x98)
[    1.316833] [<c00534e0>] (do_DataAbort+0x38/0x98) from [<c05811ec>] 
(__dabt_svc+0x4c/0x60)
[    1.325408] Exception stack(0xda845f50 to 0xda845f98)
[    1.330718] 5f40:                                     00000001 
ae008e20 271beb3a da848000
[    1.339202] 5f60: c078acd0 00000002 c0789738 00000000 c001116c 
00000000 00000000 00000000
[    1.347686] 5f80: 271beb3a da845f98 c0011274 c006f174 60000013 ffffffff
[    1.354583] [<c05811ec>] (__dabt_svc+0x4c/0x60) from [<c006f174>] 
(omap_writel+0x4/0xc)
[    1.362915] [<c006f174>] (omap_writel+0x4/0xc) from [<c0011274>] 
(omap2_init_devices+0x108/0x42c)
[    1.372131] [<c0011274>] (omap2_init_devices+0x108/0x42c) from 
[<c00535a4>] (do_one_initcall+0x34/0x18c)
[    1.381958] [<c00535a4>] (do_one_initcall+0x34/0x18c) from 
[<c000874c>] (kernel_init+0x1c4/0x250)
[    1.391174] [<c000874c>] (kernel_init+0x1c4/0x250) from [<c00600b0>] 
(kernel_thread_exit+0x0/0x8)
[    1.400390] CPU1: stopping
[    1.403259] [<c00673ac>] (unwind_backtrace+0x0/0xfc) from 
[<c0053384>] (do_IPI+0x108/0x118)
[    1.411926] [<c0053384>] (do_IPI+0x108/0x118) from [<c058123c>] 
(__irq_svc+0x3c/0x120)
[    1.420166] Exception stack(0xda86bf90 to 0xda86bfd8)
[    1.425445] bf80:                                     c07cb574 
00000000 da86a000 00000000
[    1.433929] bfa0: da86a000 c07ed464 c058ae04 c0789dc4 c078a004 
411fc092 00000000 00000000
[    1.442413] bfc0: 00000000 da86bfd8 c0060154 c0060158 60000113 ffffffff
[    1.449279] [<c058123c>] (__irq_svc+0x3c/0x120) from [<c0060158>] 
(default_idle+0x28/0x2c)
[    1.457855] [<c0060158>] (default_idle+0x28/0x2c) from [<c00609fc>] 
(cpu_idle+0xc8/0xfc)
[    1.466278] [<c00609fc>] (cpu_idle+0xc8/0xfc) from [<8057990c>] 
(0x8057990c)


Are there other definitions for the identifiers you have used?

Regards,
Avik

> thanks,

