From: Sergey Lapin <slapinid@gmail.com>
Subject: OMAP3: enabling CPU idle leads to panic
Date: Tue, 24 Nov 2009 18:13:13 +0300
Message-ID: <48239d390911240713v50bcae9ek855fb1e07c081486@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f215.google.com ([209.85.219.215]:36472 "EHLO
	mail-ew0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933169AbZKXPNQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Nov 2009 10:13:16 -0500
Received: by ewy7 with SMTP id 7so56956ewy.28
        for <linux-omap@vger.kernel.org>; Tue, 24 Nov 2009 07:13:19 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi, all!

I use PM branch merged with linux-omap branch. A board is custom, so I
can't bisect this problem
(and I don't know latest working revision). It seems that's because
missing clock domain somewhere,


[16515.695617] Unable to handle kernel NULL pointer dereference at
virtual address 00000020
[16515.703735] pgd = c0004000
[16515.706481] [00000020] *pgd=00000000
[16515.710083] Internal error: Oops: 5 [#1] PREEMPT
[16515.714721] last sysfs file:
[16515.717712] Modules linked in:
[16515.720794] CPU: 0    Not tainted  (2.6.32-rc8-07113-g318afc6 #110)
[16515.727111] PC is at pwrdm_for_each_clkdm+0x34/0x88
[16515.731994] LR is at pwrdm_for_each_clkdm+0x24/0x88
[16515.736907] pc : [<c003b5c0>]    lr : [<c003b5b0>]    psr: 600000d3
[16515.736938] sp : c03f3f68  ip : fa004800  fp : 00000000
[16515.748474] r10: c003e81c  r9 : 411fc082  r8 : 00000000
[16515.753723] r7 : a00000d3  r6 : 00000000  r5 : 00000004  r4 : 00000001
[16515.760284] r3 : 00000002  r2 : c03f2000  r1 : 00000001  r0 : 00000000
[16515.766845] Flags: nZCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM
Segment kernel
[16515.774383] Control: 10c5387d  Table: 80004019  DAC: 00000017
[16515.780151] Process swapper (pid: 0, stack limit = 0xc03f22e8)
[16515.786010] Stack: (0xc03f3f68 to 0xc03f4000)
[16515.790405] 3f60:                   c042e4bc 00000003 00000003
c042e4bc 80026398 411fc082
[16515.798645] 3f80: 0000001f c003e76c 00000000 c022f284 00271d5a
00000000 00000005 0ec00c5c
[16515.806854] 3fa0: c03f8640 c03f8710 c042dadc c03f8640 c0474d0c
c022dee8 c03f2000 c042dadc
[16515.815093] 3fc0: c0027e14 c03f5bd0 80026398 c002f49c c0459fa4
c0008914 c0008478 00000000
[16515.823333] 3fe0: 00000000 c0027e18 00000000 10c53c7d c042dbf0
80008034 00000000 00000000
[16515.831573] [<c003b5c0>] (pwrdm_for_each_clkdm+0x34/0x88) from
[<c003e76c>] (omap3_enter_idle+0xc0/0x15c)
[16515.841217] [<c003e76c>] (omap3_enter_idle+0xc0/0x15c) from
[<c022dee8>] (cpuidle_idle_call+0xa4/0x180)
[16515.850677] [<c022dee8>] (cpuidle_idle_call+0xa4/0x180) from
[<c002f49c>] (cpu_idle+0x48/0x98)
[16515.859344] [<c002f49c>] (cpu_idle+0x48/0x98) from [<c0008914>]
(start_kernel+0x250/0x2a8)
[16515.867675] [<c0008914>] (start_kernel+0x250/0x2a8) from
[<80008034>] (0x80008034)
[16515.875274] Code: e3a06000 e1a05008 e1a04006 ea000002 (e595101c)
[16515.881530] ---[ end trace f0a89c74ea639f01 ]---
[16515.886230] Kernel panic - not syncing: Attempted to kill the idle task!


addr2line -e vmlinux c003b5c0
/home/slapin/linux-omap-my-2.6.git/arch/arm/mach-omap2/powerdomain.c:452
It is in function
int pwrdm_for_each_clkdm(), where pwrdm is NULL.
farther investigations found that "core_pwrdm" is defined only for 24xx,
but I use 3525, and it is being searched.

This is where variable allocated. If I add BUG_ON(!core_pd), it crashes here.
arch/arm/mach-omap2/cpuidle34xx.c:348:	core_pd = pwrdm_lookup("core_pwrdm");
Otherwise it crashes the above way. Any ideas on how to fix this?

S.
