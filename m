From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: Integration branch base switchover to Tony's omap-for-linus branch
Date: Tue, 1 Mar 2011 18:08:35 +0530
Message-ID: <3f332cbd75f835ca119bdeccd72c4bb2@mail.gmail.com>
References: <alpine.DEB.2.00.1102251722450.6198@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:40676 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754842Ab1CAMj1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Mar 2011 07:39:27 -0500
Received: by mail-qw0-f47.google.com with SMTP id 2so3525654qwi.6
        for <linux-omap@vger.kernel.org>; Tue, 01 Mar 2011 04:39:17 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1102251722450.6198@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

Pual,
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Paul Walmsley
> Sent: Saturday, February 26, 2011 5:56 AM
> To: linux-omap@vger.kernel.org
> Subject: Integration branch base switchover to Tony's omap-for-linus
> branch
>
>
> Hi,
>
> this is a quick note for anyone using the integration-2.6.39 branch
> on
> git://git.pwsan.com/linux-2.6: I've switched the base over from
> mainline to Tony's omap-for-linus branch.
>

I observed an issue when integrated omap-for-linus + your branch
+ OMAP4 PM patches. After debugging this with Rajendra, it seems
that issue is seen only when static dependency between MPU
and L4PER clock-domain is cleared _and_ L4_PER clock-domain
is programmed to HW_SUP.

Since the issue is observed with only I2C IP block from L4_PER
and none of the other modules are affected, the suspect is I2C
IP block. The hardware team is investigating this issue.

So for now, to avoid this abort, there are two options
	- Remove HW_SUP from L4_PER CD
	- Keep MPU<->L4_PER static dependency.

We tried both the options and they seems to work.
Which one you prefer till we have hardware root-cause
of this issue?

Regards,
Santosh

----
Power Management for TI OMAP4.
clock: disabling unused clocks to save power
omap_device: omap_i2c.1: new worst case activate latency 0: 3143310
Unhandled fault: imprecise external abort (0x1406) at 0x3df31eef
Internal error: : 1406 [#1] SMP
last sysfs file:
Modules linked in:
CPU: 0    Not tainted  (2.6.38-rc6-00023-g0752c56-dirty #280)
PC is at omap_i2c_xfer+0x28/0x320
LR is at omap_i2c_wait_for_bb+0x18/0x7c
pc : [<c031e0dc>]    lr : [<c031d9b8>]    psr: 40000013
sp : ef833f08  ip : 000038ae  fp : c05e1906
r10: 00000002  r9 : ef9d1cb0  r8 : 00000002
r7 : ef9d1c00  r6 : ffff6b4b  r5 : 00000000  r4 : c0b44b9c
r3 : 0000001f  r2 : 00000028  r1 : 83126e98  r0 : 00000000
Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c53c7d  Table: 8000404a  DAC: 00000015
Process swapper (pid: 1, stack limit = 0xef8322f8)
Stack: (0xef833f08 to 0xef834000)
3f00:                   ef9d1c60 c0b44b9c 00000002 ef9d1c60 00000000
ffff6b4b
3f20: c0b44b9c 00000002 00000001 00000000 c05e1906 c031c25c ef9d1800
00000000
3f40: c0b44bb4 c0b44b94 c0b44b90 00000000 c0b44b94 c0299784 0000005c
ef833f97
3f60: efa9d874 8c000013 efa9d874 efa9d800 efa9d870 c05dc73c 00000000
00000000
3f80: 00000000 00000000 00000000 c02658d0 efa9d800 22222222 ffffffd0
c0265984
3fa0: efa9d800 c00260ac c00334dc c0026034 00000002 c00505cc 00000000
c0160000
3fc0: c04f4a05 00000198 c0594350 c00334dc c0594350 00000002 00000013
00000000
3fe0: 00000000 c0008540 00000000 c00083f4 c005b520 c005b520 e72105ac
04088b22
[<c031e0dc>] (omap_i2c_xfer+0x28/0x320) from [<c031c25c>]
(i2c_transfer+0xbc/0x10c)
[<c031c25c>] (i2c_transfer+0xbc/0x10c) from [<c0299784>]
(twl_i2c_read+0xe0/0x12c)
[<c0299784>] (twl_i2c_read+0xe0/0x12c) from [<c02658d0>]
(twlreg_grp+0x18/0x24)
[<c02658d0>] (twlreg_grp+0x18/0x24) from [<c0265984>]
(twlreg_is_enabled+0x8/0x30)
[<c0265984>] (twlreg_is_enabled+0x8/0x30) from [<c00260ac>]
(regulator_init_complete+0x78/0x148)
[<c00260ac>] (regulator_init_complete+0x78/0x148) from [<c00505cc>]
(do_one_initcall+0xcc/0x1a4)
[<c00505cc>] (do_one_initcall+0xcc/0x1a4) from [<c0008540>]
(kernel_init+0x14c/0x214)
[<c0008540>] (kernel_init+0x14c/0x214) from [<c005b520>]
(kernel_thread_exit+0x0/0x8)
Code: e1a07000 ebfffe51 e1a00007 ebfffe30 (e2506000)
---[ end trace ccd8ab0702d3ee85 ]---
