From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 00/12] ARM: OMAP2 DT clock conversion
Date: Fri, 28 Feb 2014 20:18:38 +0200
Message-ID: <5310D2FE.5090209@ti.com>
References: <1393579384-23440-1-git-send-email-t-kristo@ti.com> <5310B271.5040708@ti.com> <20140228180112.GC15399@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52219 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751743AbaB1STU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Feb 2014 13:19:20 -0500
In-Reply-To: <20140228180112.GC15399@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On 02/28/2014 08:01 PM, Tony Lindgren wrote:
> * Nishanth Menon <nm@ti.com> [140228 08:02]:
>> On 02/28/2014 03:22 AM, Tero Kristo wrote:
>>> Hi,
>>>
>>> This set concludes the omap2+ clock DT conversion work by creating the
>>> DT clock data for omap2 SoC also.
>>>
>>> I am also currently doing related work to cleanup CM/PRM codebase in
>>> preparation to move it into drivers/, this set is basically going to
>>> be a pre-requisite for that. I'll hopefully post something related
>>> to that early next week.
>>>
>>> This set has been boot tested on OMAP2430 only (thanks Nishanth, I don't
>>> have access to OMAP2 hardware myself), so any testing feedback on
>>> 2420 board(s) would be appreciated.
>>>
>>> Working tree:
>>>
>>> Tree: https://github.com/t-kristo/linux-pm.git
>>> Branch: 3.14-rc4-omap2-dt-clks
>>
>> I do see checkpatch warnings in the series:
>> http://slexy.org/view/s20mzhlJ93
>>
>> Series boot tested with:
>> 3.14-rc4-omap2-dt-clks  fc73a96 ARM: OMAP2: clock: use DT clock boot
>> if available
>> from the tree mentioned above.
>>
>> Things look good other than the checkpatch violation noticed in
>> report, so other than that,

I noticed the checkpatch warnings also, most of them are impossible to 
fix, and/or are false warnings (see the fixed-factor / fixed-clock 
complaints for example.)

>>
>> Tested-by: Nishanth Menon <nm@ti.com>
>>
>> omap2plus_defconfig
>>   1: am335x-evm:  Boot PASS: http://slexy.org/raw/s2jdV3XMCC
>>   2:  am335x-sk:  Boot PASS: http://slexy.org/raw/s210nZI8Hx
>>   3: am3517-evm:  Boot PASS: http://slexy.org/raw/s21MG8kg6u
>>   4:  am37x-evm:  Boot PASS: http://slexy.org/raw/s20coVhzLt
>>   5: am43xx-epos:  Boot PASS: http://slexy.org/raw/s21XKjjwyk
>>   6: BeagleBoard-XM:  Boot PASS: http://slexy.org/raw/s27PCmlDq7
>>   7: BeagleBone-Black:  Boot PASS: http://slexy.org/raw/s2HX1Q3iPb
>>   8:      crane: No Image built - Missing platform support?:
>>   9:       dra7:  Boot PASS: http://slexy.org/raw/s21ofDfpD2
>> 10:        ldp:  Boot FAIL: http://slexy.org/raw/s2SbrpyX2p
>> ^^ legacy behavior
>> 11: PandaBoard-ES:  Boot PASS: http://slexy.org/raw/s21n4iMUKd
>> 12:    sdp2430:  Boot PASS: http://slexy.org/raw/s2CJ5hYl72
>> 13:    sdp3430:  Boot PASS: http://slexy.org/raw/s20axZ1nyb
>> 14:    sdp4430:  Boot PASS: http://slexy.org/raw/s21wt3C5F3
>> 15: OMAP5432uEVM:  Boot PASS: http://slexy.org/raw/s208PhmCpm
>> TOTAL = 15 boards, Booted Boards = 13, No Boot boards = 2
>
> I'm getting this with omap2 only build:
>
> drivers/clk/ti/dpll.c:235: undefined reference to `clkhwops_omap3_dpll'
> drivers/built-in.o:(.rodata+0x1dd50): undefined reference to `omap3_noncore_dpll_enable'
> drivers/built-in.o:(.rodata+0x1dd54): undefined reference to `omap3_noncore_dpll_disable'
> drivers/built-in.o:(.rodata+0x1dd60): undefined reference to `omap3_dpll_recalc'
> drivers/built-in.o:(.rodata+0x1dd74): undefined reference to `omap3_noncore_dpll_set_rate'
> drivers/built-in.o:(.rodata+0x1ddb8): undefined reference to `omap3_dpll_recalc'
> drivers/built-in.o:(.rodata+0x1ddfc): undefined reference to `omap3_dpll_recalc'
> drivers/built-in.o:(.rodata+0x1de10): undefined reference to `omap3_noncore_dpll_set_rate'
>
> And this if 2430 is not selected:
>
> drivers/clk/ti/interface.c:129: undefined reference to `clkhwops_omap2430_i2chs_wait'

Hmm okay, these should be easy to fix... I'll need to see if I have 
introduced some other build breakages also...

>
> Then I get this early on when trying to boot on n800:
>
> [    0.000000] Unable to handle kernel NULL pointer dereference at virtual address 00000000
> [    0.000000] pgd = c0004000
> [    0.000000] [00000000] *pgd=00000000
> [    0.000000] Internal error: Oops: 5 [#1] ARM
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 3.14.0-rc1-00012-ga93a376 #225
> [    0.000000] task: c073ee80 ti: c0734000 task.ti: c0734000
> [    0.000000] PC is at strcmp+0xc/0x34
> [    0.000000] LR is at __clk_init+0x244/0x4d0
> [    0.000000] pc : [<c0273ed8>]    lr : [<c0401858>]    psr: 200001d3
> [    0.000000] sp : c0735e68  ip : c781cf80  fp : c05440b8
> [    0.000000] r10: 00000000  r9 : c781ba80  r8 : c781ba80
> [    0.000000] r7 : 0000000b  r6 : c781ba80  r5 : 0000000b  r4 : c0cf27f4
> [    0.000000] r3 : c781cfc0  r2 : 00000000  r1 : 00000000  r0 : 00000076
> [    0.000000] Flags: nzCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
> [    0.000000] Control: 00c5387d  Table: 80004000  DAC: 00000017
> [    0.000000] Process swapper (pid: 0, stack limit = 0xc0734240)
> [    0.000000] Stack: (0xc0735e68 to 0xc0736000)
> [    0.000000] 5e60:                   c7df5868 c781ba00 0000000b c781cfc0 c781ba80 c781ba00
> [    0.000000] 5e80: 00000000 c781ce80 c0544074 c0401bcc c781ba80 00000000 c781ba00 c7df5a68
> [    0.000000] 5ea0: c781cec0 c0401d08 c05442b8 c781ba00 0000000b c0403070 c0686038 00000000
> [    0.000000] 5ec0: c0686038 c7df5a68 c781ba08 c781cec0 c0735f0b 00000020 c0d09ce8 00000000
> [    0.000000] 5ee0: c781cf40 c781cf40 00000000 c781cf4c 4107b362 c7df59a8 00000000 c0719f30
> [    0.000000] 5f00: c781ce80 c05442b8 00000000 c0544074 c781cc80 c05440b8 00000000 c781cf44
> [    0.000000] 5f20: 4107b362 c7df59a8 c781cf40 00000002 00000002 c781cf48 c0735f48 c071a040
> [    0.000000] 5f40: c0735f48 c007533c c7df5874 00000000 a00001d3 a00001d3 c0797b6c 80004008
> [    0.000000] 5f60: c0797b6c c04e07c4 a00001d3 c07320d0 c7df59a8 c7df59a8 c7de8d10 c07a7454
> [    0.000000] 5f80: c07408dc 80004008 807244d0 c0403184 c7de8c70 00000000 c07a7454 c07408dc
> [    0.000000] 5fa0: 80004008 c06f6884 c07a69bc 00000001 c073c041 c06f0918 ffffffff c06f317c
> [    0.000000] 5fc0: 4107b362 c06ec8c0 00000000 c06e8a8c ffffffff ffffffff c06e8724 00000000
> [    0.000000] 5fe0: 00000000 c07256d0 00c5387d c073c094 c0725ad4 80008070 00000000 00000000
> [    0.000000] [<c0273ed8>] (strcmp) from [<c0401858>] (__clk_init+0x244/0x4d0)
> [    0.000000] [<c0401858>] (__clk_init) from [<c0401bcc>] (_clk_register+0xe8/0x180)
> [    0.000000] [<c0401bcc>] (_clk_register) from [<c0401d08>] (clk_register+0x38/0x78)
> [    0.000000] [<c0401d08>] (clk_register) from [<c0403070>] (clk_register_composite+0x180/0x244)
> [    0.000000] [<c0403070>] (clk_register_composite) from [<c0719f30>] (ti_clk_register_composite+0x1f8/0x268)
> [    0.000000] [<c0719f30>] (ti_clk_register_composite) from [<c071a040>] (of_ti_composite_clk_setup+0xa0/0xbc)
> [    0.000000] [<c071a040>] (of_ti_composite_clk_setup) from [<c0403184>] (ti_dt_clk_init_provider+0x50/0x10c)
> [    0.000000] [<c0403184>] (ti_dt_clk_init_provider) from [<c06f6884>] (of_prcm_init+0x4c/0x84)
> [    0.000000] [<c06f6884>] (of_prcm_init) from [<c06f0918>] (omap_clk_init+0x18/0x30)
> [    0.000000] [<c06f0918>] (omap_clk_init) from [<c06f317c>] (omap2_sync32k_timer_init+0xc/0x64)
> [    0.000000] [<c06f317c>] (omap2_sync32k_timer_init) from [<c06ec8c0>] (time_init+0x20/0x38)
> [    0.000000] [<c06ec8c0>] (time_init) from [<c06e8a8c>] (start_kernel+0x134/0x2f4)
> [    0.000000] [<c06e8a8c>] (start_kernel) from [<80008070>] (0x80008070)
> [    0.000000] Code: e12fff1e e1a0c000 e3a02000 e7dc0002 (e7d13002)
> [    0.000000] ---[ end trace 3406ff24bd97382e ]---

Hmm, some clock node is broken, might be missing a name or parent name 
for some reason. Can you try to boot with DEBUG enabled so you get 
pr_debug:s out and see which clock is being initialized during the crash?

-Tero
