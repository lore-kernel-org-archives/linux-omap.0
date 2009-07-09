From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Oops with /sys/power/vdd1_lock
Date: Thu, 09 Jul 2009 15:15:27 -0700
Message-ID: <87eispmrk0.fsf@deeprootsystems.com>
References: <F12EBA124C6E064B9CF1B45E67DDB7E77CE707BD@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f193.google.com ([209.85.216.193]:40954 "EHLO
	mail-px0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753985AbZGIWPa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jul 2009 18:15:30 -0400
Received: by pxi31 with SMTP id 31so300239pxi.33
        for <linux-omap@vger.kernel.org>; Thu, 09 Jul 2009 15:15:29 -0700 (PDT)
In-Reply-To: <F12EBA124C6E064B9CF1B45E67DDB7E77CE707BD@dlee02.ent.ti.com> (Dominic Curran's message of "Thu\, 9 Jul 2009 17\:00\:17 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Curran, Dominic" <dcurran@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Curran, Dominic" <dcurran@ti.com> writes:

> I'm seeing a oops when I try to write to /sys/power/vdd1_lock.
>
> I am working on 2.6.29 kernel on zoom2.

Can you send .config?  

Also please specify exactly which kernel are you using? Is this the
pm-2.6.29 branch or the android tree?  I assume android since
pm-2.6.29 does not have zoom2 support.

even better, can you reproduce on SDP, beagle or EVM?  that way I
could try and reproduce also.  I don't have a working zoom2.

> I have tried to reproduce oops on your latest pm tree but when I build for zoom2 the kernel gets as far as:
>
> Starting kernel ...
>
> And then freezes.  Another Tier just clone Tony's tree and reported seeing this with zoom2 also.

it doesn't freeze, you just have no console output because the
DEBUG_LL UART support for Z2 has never been submitted upstream.

If you wait long enough, and your userland starts a console on
ttyS3, you'll eventually see a shell.

> Anyway the vdd1_lock Oops is below.
> Does this ring any bells ?
> I think the oops is caused here:
>         if (resp->curr_level == target_level)
>                 return 0;
>
> because resp is NULL, presumably because
>         resp = vdd1_resp;
> vdd1_resp is Null also.
>
> vdd1_resp gets setup in init_opp(), which gets called as a func ptr, but I don't know where from.
> I added printk's and I'm not seeing init_opp() get called with a struct shared_resource for "vdd1-opp" at boot.
>
> I know this is an old kernel for you.
> Still, do you have any pointers ?

Since Zoom2 has never supported/tested on the 2.6.29 PM branch, my
first guess is that the OPP init stuff is missing from the board file.

Does the board file pass in the rate tables in init_common_hw() or just
NULL ptrs.

I'm gessing the rete tables are missing.

If that's the case, this still is a bug as the code should be checking
or valid OPPs before trying to use them.

Kevin

> # echo 1 > /sys/power/vdd1_lock
> Unable to handle kernel NULL pointer dereference at virtual address 00000008
> <1>pgd = c68d8000
> pgd = c68d8000
> <1>[00000008] *pgd=8562c031[00000008] *pgd=8562c031, *pte=00000000, *pte=0000000
> 0. fps=29.762939, *ppte=00000000, *ppte=00000000
>
>
> Internal error: Oops: 17 [#1] PREEMPT
> Internal error: Oops: 17 [#1] PREEMPT
> Modules linked in:Modules linked in:
>
> CPU: 0    Not tainted  (2.6.29-omap1-g70195fc-dirty #15)
> CPU: 0    Not tainted  (2.6.29-omap1-g70195fc-dirty #15)
> PC is at resource_set_opp_level+0x3c/0x16c
> PC is at resource_set_opp_level+0x3c/0x16c
> LR is at vdd_opp_store+0x148/0x184
> LR is at vdd_opp_store+0x148/0x184
> pc : [<c004311c>]    lr : [<c003efbc>]    psr: 60000013
> sp : c5653ea8  ip : c5653ee0  fp : c5653edc
> pc : [<c004311c>]    lr : [<c003efbc>]    psr: 60000013
> sp : c5653ea8  ip : c5653ee0  fp : c5653edc
> r10: c5653f70  r9 : c55d7238  r8 : 00000001
> r10: c5653f70  r9 : c55d7238  r8 : 00000001
> r7 : 00000000  r6 : c0468c58  r5 : 00000001  r4 : 00000001
> r7 : 00000000  r6 : c0468c58  r5 : 00000001  r4 : 00000001
> r3 : c0469158  r2 : 00000001  r1 : 00000001  r0 : 00000001
> r3 : c0469158  r2 : 00000001  r1 : 00000001  r0 : 00000001
> Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
> Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
> Control: 10c5307d  Table: 868d8019  DAC: 00000015
> Control: 10c5307d  Table: 868d8019  DAC: 00000015
> Process ash (pid: 537, stack limit = 0xc56522e0)
> Process ash (pid: 537, stack limit = 0xc56522e0)
> Stack: (0xc5653ea8 to 0xc5654000)
> Stack: (0xc5653ea8 to 0xc5654000)
> 3ea0: 3ea0:                                     c5653ed0 c5653ed0 c5653eb8 c5653
> eb8 c01a55e4 c01a55e4 c01a5050 c01a5050 00000010 00000010 00000001 00000001
>
> 3ec0: 3ec0: 00000001 00000001 c0468c58 c0468c58 00000002 00000002 c04500c4 c0450
> 0c4 c5653f04 c5653f04 c5653ee0 c5653ee0 c003efbc c003efbc c00430ec c00430ec
>
> 3ee0: 3ee0: 40001000 40001000 00017220 00017220 00000002 00000002 c55eaae8 c55ea
> ae8 c55d7220 c55d7220 c681dd60 c681dd60 c5653f14 c5653f14 c5653f08 c5653f08
>
> 3f00: 3f00: c01a060c c01a060c c003ee80 c003ee80 c5653f44 c5653f44 c5653f18 c5653
> f18 c01035d4 c01035d4 c01a05f8 c01a05f8 c5653f70 c5653f70 c68332c0 c68332c0
>
> 3f20: 3f20: 40001000 40001000 c5653f70 c5653f70 00000002 00000002 40001000 40001
> 000 c5652000 c5652000 00000000 00000000 c5653f6c c5653f6c c5653f48 c5653f48
>
> 3f40: 3f40: c00b7188 c00b7188 c01034d0 c01034d0 c68332c0 c68332c0 00000000 00000
> 000 00000000 00000000 00000000 00000000 c68332c0 c68332c0 00000002 00000002
>
> 3f60: 3f60: c5653fa4 c5653fa4 c5653f70 c5653f70 c00b72dc c00b72dc c00b70dc c00b7
> 0dc 00000000 00000000 00000000 00000000 c5653fa4 c5653fa4 00000000 00000000
>
> 3f80: 3f80: c00c3c2c c00c3c2c 00000002 00000002 40001000 40001000 001d41f8 001d4
> 1f8 00000004 00000004 c0031028 c0031028 00000000 00000000 c5653fa8 c5653fa8
>
> 3fa0: 3fa0: c0030e80 c0030e80 c00b72a4 c00b72a4 00000002 00000002 40001000 40001
> 000 00000001 00000001 40001000 40001000 00000002 00000002 00000000 00000000
>
> 3fc0: 3fc0: 00000002 00000002 40001000 40001000 001d41f8 001d41f8 00000004 00000
> 004 00000002 00000002 001db23c 001db23c 00000000 00000000 00000000 00000000
>
> 3fe0: 3fe0: 40001000 40001000 bef47600 bef47600 000f6f6c 000f6f6c 00008e2c 00008
> e2c 60000010 60000010 00000001 00000001 ff0000ff ff0000ff ff0004ff ff0004ff
>
> Backtrace: Backtrace:
>
> [<c00430e0>] [<c00430e0>] (resource_set_opp_level+0x0/0x16c) (resource_set_opp_l
> evel+0x0/0x16c) from [<c003efbc>] from [<c003efbc>] (vdd_opp_store+0x148/0x184)
> (vdd_opp_store+0x148/0x184)
>  r8:c04500c4 r8:c04500c4 r7:00000002 r7:00000002 r6:c0468c58 r6:c0468c58 r5:0000
> 0001 r5:00000001 r4:00000001 r4:00000001
>
> [<c003ee74>] [<c003ee74>] (vdd_opp_store+0x0/0x184) (vdd_opp_store+0x0/0x184) fr
> om [<c01a060c>] from [<c01a060c>] (kobj_attr_store+0x20/0x24)
> (kobj_attr_store+0x20/0x24)
>  r7:c681dd60 r7:c681dd60 r6:c55d7220 r6:c55d7220 r5:c55eaae8 r5:c55eaae8 r4:0000
> 0002 r4:00000002
>
> [<c01a05ec>] [<c01a05ec>] (kobj_attr_store+0x0/0x24) (kobj_attr_store+0x0/0x24)
> from [<c01035d4>] from [<c01035d4>] (sysfs_write_file+0x110/0x144)
> (sysfs_write_file+0x110/0x144)
> [<c01034c4>] [<c01034c4>] (sysfs_write_file+0x0/0x144) (sysfs_write_file+0x0/0x1
> 44) from [<c00b7188>] from [<c00b7188>] (vfs_write+0xb8/0x148)
> (vfs_write+0xb8/0x148)
> [<c00b70d0>] [<c00b70d0>] (vfs_write+0x0/0x148) (vfs_write+0x0/0x148) from [<c00
> b72dc>] from [<c00b72dc>] (sys_write+0x44/0x70)
> (sys_write+0x44/0x70)
>  r7:00000002 r7:00000002 r6:c68332c0 r6:c68332c0 r5:00000000 r5:00000000 r4:0000
> 0000 r4:00000000
>
> [<c00b7298>] [<c00b7298>] (sys_write+0x0/0x70) (sys_write+0x0/0x70) from [<c0030
> e80>] from [<c0030e80>] (ret_fast_syscall+0x0/0x2c)
> (ret_fast_syscall+0x0/0x2c)
>  r8:c0031028 r8:c0031028 r7:00000004 r7:00000004 r6:001d41f8 r6:001d41f8 r5:4000
> 1000 r5:40001000 r4:00000002 r4:00000002
>
> Code: Code: e3500002 e3500002 1a000045 1a000045 e59f311c e59f311c e5937224 e5937
> 224 (e5973008) (e5973008)
>
> <4>---[ end trace c4cd1e6865843b71 ]---
> ---[ end trace c4cd1e6865843b71 ]---
