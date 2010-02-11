From: Arno Steffen <arno.steffen@googlemail.com>
Subject: Re: OMAP3 migrating: partition / clock
Date: Thu, 11 Feb 2010 11:42:47 +0100
Message-ID: <804f0d21002110242v68715f09ra4fe489f0c4134a6@mail.gmail.com>
References: <804f0d21002032306h6a61070bof03bec78a6e4364a@mail.gmail.com>
	 <alpine.DEB.2.00.1002050051250.26033@utopia.booyaka.com>
	 <804f0d21002080239t2a5e979bxf570a9df06a4ec20@mail.gmail.com>
	 <alpine.DEB.2.00.1002081208380.22923@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.25]:20255 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885Ab0BKKmt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Feb 2010 05:42:49 -0500
Received: by ey-out-2122.google.com with SMTP id d26so293239eyd.19
        for <linux-omap@vger.kernel.org>; Thu, 11 Feb 2010 02:42:48 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1002081208380.22923@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

2010/2/8 Paul Walmsley <paul@pwsan.com>:
> On Mon, 8 Feb 2010, Arno Steffen wrote:
>
>> Thanks Paul for your help.
>>
>> Switch on the =A0"#define DEBUG" in this both files skip almost all
>> kernel boot messages before this warning and gives just this: !?!
>
> You probably need to enable CONFIG_DEBUG_LL to see all of the message=
s.
>
>> =A0Uncompressing Linux................ done, booting the kernel.
>> lock: associated clk usbtll_ick to clkdm core_l4_clkdm
>> Clocking rate (Crystal/Core/MPU): 12.0/332/600 MHz
>> ------------[ cut here ]------------
>> WARNING: at arch/arm/mach-omap2/clock34xx.c:773
>> omap3_noncore_dpll_set_rate+0x1d4/0x308()
>> Modules linked in:
>> [<c002a924>] (unwind_backtrace+0x0/0xdc) from [<c004a168>]
>> (warn_slowpath_common+0x48/0x60)
>> ....
>>
>> I expected to get more messages, not less:
>> You are right, my board is running at 12 instead of 13MHz, but this
>> setting is (or should be) done in uboot.
>> I don't know what this new line withb the "lock" means.
>
> The leading "c" was apparently dropped. =A0You can recursively grep t=
hrough
> the source tree to locate messages, if you are curious as to where th=
ey
> come from.
>
>> On my board there is no USB at all.
>
> If you're not using any of the DPLL5-connected devices (USB, USIM, et=
c.),
> what happens if you comment out the omap3_clk_lock_dpll5() call in
> clock34xx.c? =A0This is not a proper fix, of course, but it may help =
narrow
> down the problem.
> - Paul

Thanks Paul!

Sorry for bothering you again:
Although I set "#define DEBUG" in clock.c and clock34xx.c and checked
that kernel has been new compiled with "CONFIG_DEBUG_LL=3Dy" the debub
messages are quite strange.

Uncompressing Linux................. done, booting the kernel.
kout2_src_ck to clkdm core_clkdm
Clocking rate (Crystal/Core/MPU): 12.0/332/600 MHz
Reprogramming SDRC clock to 332000000 Hz
GPMC revision 5.0
=2E..

This strange behaviour is just happend if I do a "#define DEBUG" in clo=
ck.c.
Changing the debug setting in clock34xx.c has no effect at all ?!?

Anyhow there are good news too:
I removed the call of omap3_clk_lock_dpll5() and you are right - the
message disappers. How did you know that?
This call
clk_set_rate(dpll5_clk, DPLL5_FREQ_FOR_USBHOST);
causes the first message, and thus I assume that dpll5_clk might be
wrong, which is get by this command:
dpll5_clk =3D clk_get(NULL, "dpll5_ck");

I could live with this workaround (remove the call), but have to be
sure, that clock is not powered (save energy).

Best regards
Arno
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
