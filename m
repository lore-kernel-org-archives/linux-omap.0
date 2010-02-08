From: Arno Steffen <arno.steffen@googlemail.com>
Subject: Re: OMAP3 migrating: partition / clock
Date: Mon, 8 Feb 2010 11:39:00 +0100
Message-ID: <804f0d21002080239t2a5e979bxf570a9df06a4ec20@mail.gmail.com>
References: <804f0d21002032306h6a61070bof03bec78a6e4364a@mail.gmail.com>
	 <alpine.DEB.2.00.1002050051250.26033@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f228.google.com ([209.85.219.228]:53689 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755066Ab0BHKjE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Feb 2010 05:39:04 -0500
Received: by ewy28 with SMTP id 28so2289841ewy.28
        for <linux-omap@vger.kernel.org>; Mon, 08 Feb 2010 02:39:01 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1002050051250.26033@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

Thanks Paul for your help.

Switch on the  "#define DEBUG" in this both files skip almost all
kernel boot messages before this warning and gives just this: !?!

 Uncompressing Linux................ done, booting the kernel.
lock: associated clk usbtll_ick to clkdm core_l4_clkdm
Clocking rate (Crystal/Core/MPU): 12.0/332/600 MHz
------------[ cut here ]------------
WARNING: at arch/arm/mach-omap2/clock34xx.c:773
omap3_noncore_dpll_set_rate+0x1d4/0x308()
Modules linked in:
[<c002a924>] (unwind_backtrace+0x0/0xdc) from [<c004a168>]
(warn_slowpath_common+0x48/0x60)
=2E...

I expected to get more messages, not less:
You are right, my board is running at 12 instead of 13MHz, but this
setting is (or should be) done in uboot.
I don't know what this new line withb the "lock" means. On my board
there is no USB at all.
Regards
Arno


2010/2/5 Paul Walmsley <paul@pwsan.com>:
> Hello Arno,
>
> On Thu, 4 Feb 2010, Arno Steffen wrote:
>
>> I am trying to migrate from kernel 28 to 32 on =A0TI OMA3. Our board=
 is
>> derived from EVM board.
>
> ...
>
>> Also I do get this warning now while boot:
>>
>> Hierarchical RCU implementation.
>> NR_IRQS:368
>> Clocking rate (Crystal/Core/MPU): 12.0/332/500 MHz
>
> I don't have an 3530 EVM here, but I'd assume this is one difference
> between your board and the EVM, since TI usually seems to
> build boards with 26MHz HF clock (resulting in a 13MHz sys_clk).
>
>> ------------[ cut here ]------------
>> WARNING: at arch/arm/mach-omap2/clock34xx.c:773
>> omap3_noncore_dpll_set_rate+0x280/0x2c4()
>
> The above lines tell you exactly where to find the code that's emitti=
ng
> the warning. =A0In this case, the problem is that the DPLL rate round=
ing
> code picked DPLL parameters that resulted in an invalid jitter correc=
tion
> value (from _omap3_dpll_compute_freqsel()). =A0The caller is presumab=
ly
> omap3_clk_lock_dpll5() in clock34xx.c, which probably got inlined whi=
ch is
> why it isn't showing up specifically in the backtrace.
>
> I'd first suggest confirming this by changing the '#undef DEBUG' to
> '#define DEBUG' in clock34xx.c and mach-omap2/clock.c, rebuilding, an=
d
> sending along the output.
>
> If the above hypothesis is confirmed, and the problem is not due to s=
ome
> other bug in the code, it might be necessary to call
> _omap3_dpll_compute_freqsel() to test the freqsel value in
> _dpll_test_mult(), and reject values that result in an invalid freqse=
l.
>
>
>> Modules linked in:
>> [<c002a924>] (unwind_backtrace+0x0/0xdc) from [<c0049e74>]
>> (warn_slowpath_common+0x48/0x60)
>> [<c0049e74>] (warn_slowpath_common+0x48/0x60) from [<c0033d30>]
>> (omap3_noncore_dpll_set_rate+0x280/0x2c4)
>> [<c0033d30>] (omap3_noncore_dpll_set_rate+0x280/0x2c4) from
>> [<c0031674>] (omap2_clk_set_rate+0x20/0x2c)
>> [<c0031674>] (omap2_clk_set_rate+0x20/0x2c) from [<c003494c>]
>> (clk_set_rate+0x4c/0xb0)
>> [<c003494c>] (clk_set_rate+0x4c/0xb0) from [<c000e980>]
>> (omap2_clk_init+0x124/0x1a0)
>> [<c000e980>] (omap2_clk_init+0x124/0x1a0) from [<c000d6ec>]
>> (omap2_init_common_hw+0x4c/0xe0)
>> [<c000d6ec>] (omap2_init_common_hw+0x4c/0xe0) from [<c000ead8>]
>> (omap3_evm_init_irq+0x28/0x94)
>> [<c000ead8>] (omap3_evm_init_irq+0x28/0x94) from [<c000b1b0>]
>> (init_IRQ+0x30/0x40)
>> [<c000b1b0>] (init_IRQ+0x30/0x40) from [<c0008978>] (start_kernel+0x=
140/0x29c)
>> [<c0008978>] (start_kernel+0x140/0x29c) from [<80008034>] (0x8000803=
4)
>> ---[ end trace 1b75b31a2719ed1c ]---
>> Reprogramming SDRC clock to 332000000 Hz
>> GPMC revision 5.0
>>
>> Do you know the reason and how to solve it?
>> Thanks & regards
>> Arno
>
>
> - Paul
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
