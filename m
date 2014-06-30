From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: OMAP 3630 random crashes
Date: Mon, 30 Jun 2014 15:47:36 +0200
Message-ID: <CAOf5uwn_+P5JkU7szHZNj74fqk7ArskiZnYn=eCeamPZ_dWS+g@mail.gmail.com>
References: <1403254242990.39117@grundfos.com>
	<20140620091431.GA28884@atomide.com>
	<1403272840480.35753@grundfos.com>
	<CAK8F28=pF=gy10Lar35q2-s=f0TxNJFZ6XpdTFvHYankXtzH4Q@mail.gmail.com>
	<1403274413159.44797@grundfos.com>
	<1404135826925.10774@grundfos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:44058 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897AbaF3Nri (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jun 2014 09:47:38 -0400
Received: by mail-wg0-f45.google.com with SMTP id l18so8002998wgh.28
        for <linux-omap@vger.kernel.org>; Mon, 30 Jun 2014 06:47:37 -0700 (PDT)
In-Reply-To: <1404135826925.10774@grundfos.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Casper Lyngesen Mogensen <clmogensen@grundfos.com>
Cc: Ash Charles <ash@gumstix.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi

On Mon, Jun 30, 2014 at 3:43 PM, Casper Lyngesen Mogensen
<clmogensen@grundfos.com> wrote:
> Hi
>
> I got two new Overo AirStorm today, and they have same behavior. I tried disabling
> the SMSC9xxx again and booted from MMC. This seems to make the backtrace a
> little more consistent(Tried on both new and old). There is (almost) always something
> about Alignment trap, the crash log itself differs every time. Also i get to allocate a lot
> more memory before crash with these settings.
>
>

What kernel version are you using?

Michael

> mallocsize = 34460000
> mallocsize = 34464000
> mallocsize = 34468000
> [  425.438629] Alignment trap: not handling instruction e1932f9f at [<c0082060>]
> [  425.446136] Unhandled fault: alignment exception (0x001) at 0x7be3c202
> [  425.453002] Internal error: : 1 [#1] SMP ARM
> [  425.457489] Modules linked in: snd_soc_omap_twl4030 libertas_sdio libertas snd_soc_omap snd_pcm_dmaengine lib80211 cfg80211 snd_soc_twl4030 snd_soc_core snd_compress snd_pcm snd_timer snd soundcore
> [  425.476226] CPU: 0 PID: 1582 Comm: kworker/u2:2 Not tainted 3.15.0-dirty #14
> [  425.483642] task: de062080 ti: dd1b8000 task.ti: dd1b8000
> [  425.489349] PC is at __lock_acquire+0x160/0x1cb8
> [  425.494232] LR is at lock_acquire+0xa0/0xfc
> [  425.498626] pc : [<c0082064>]    lr : [<c00843c4>]    psr: 20000193
> [  425.498626] sp : dd1b9bb0  ip : 00000001  fp : 7be3c0fe
> [  425.510681] r10: c0854c10  r9 : c0d7785c  r8 : de062080
> [  425.516174] r7 : 00000000  r6 : dd1b8030  r5 : 00000000  r4 : dfaef6d0
> [  425.523010] r3 : 7be3c202  r2 : dfaef6d0  r1 : 28014a03  r0 : dfaef6d0
> [  425.529876] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
> [  425.537628] Control: 10c5307d  Table: 9e76c019  DAC: 00000015
> [  425.543670] Process kworker/u2:2 (pid: 1582, stack limit = 0xdd1b8248)
> [  425.550506] Stack: (0xdd1b9bb0 to 0xdd1ba000)
> [  425.555114] 9ba0:                                     de062080 00000004 00000006 c07fb7e4
> [  425.563720] 9bc0: 00000008 c0081998 dd1b8020 de062080 00000000 00000001 c07ef168 c0081ab8
> [  425.572296] 9be0: 1f2b8000 ddbe1780 ddbe65c0 dd1b8000 1f2b8000 c01486d4 00000000 ddbd60f0
> [  425.580902] 9c00: ddbe65c0 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [  425.589508] 9c20: dfaef6d0 00000000 00000000 00000000 00000001 00000000 c007914c c00843c4
> [  425.598114] 9c40: 00000001 00000080 00000000 c007914c 00000000 00000002 dd1b8000 60000193
> [  425.606689] 9c60: c0854c10 dfaef6c0 00000113 c007914c 00000003 dd1b9cc8 c0146d90 c0147b3c
> [  425.615295] 9c80: 00000001 c054a808 00000001 00000000 c007914c 00000000 dfaef6c0 00000000
> [  425.623901] 9ca0: 00000001 c007914c 00000000 00000000 ddbe65c0 00000000 dd1b9d30 00000060
> [  425.632507] 9cc0: 00000001 c00791ac ddbe65c0 00000002 00000000 c0149548 00000001 00000000
> [  425.641082] 9ce0: 00000001 ddbd60f0 dd1b9d40 00000001 dd1b9d2c c01b60a0 dd1b9d2c 00000001
> [  425.649688] 9d00: de062080 00000004 00000006 00000001 00000001 00000000 de1ff000 dde0a490
> [  425.658294] 9d20: dd1b9d9c 00000000 00000001 00000000 ddbe65c0 c00843c4 00000001 00000000
> [  425.666900] 9d40: ddbe65c0 c0130274 00000000 c007fa8c dd1b8038 60000113 de1ff000 ddbd22a0
> [  425.675506] 9d60: dde0a468 dde0a468 ddbd60f0 ddbd2240 dd1b8000 de141015 de141014 00000000
> [  425.684082] 9d80: dd1b9eb8 c01b6534 dde0a468 c054a8d4 ddbd2240 c01302a8 00000000 00000000
> [  425.692687] 9da0: dde0a468 ddbd2240 ddbd2240 c0121cb4 00000001 00000011 ddbd2240 c012297c
> [  425.701293] 9dc0: dd1b8000 01141015 de141014 dd1b9eb8 dd1b9e10 c0123344 00000000 dd1b9e18
> [  425.709899] 9de0: dd1b9e10 00000003 dd1b8000 c0123c08 c0124b3c 00000001 00000000 c0081ab8
> [  425.718505] 9e00: dd1b9eb8 dd1b8030 c01269a4 de086dc0 00000000 c0124b3c 00000001 00000000
> [  425.727081] 9e20: 00727375 00000003 de141011 de086e00 de11fb80 de11fb80 dd1b9eb8 c0565f50
> [  425.735687] 9e40: de141000 ffffff9c 00000000 00000000 dd1b8000 c01269cc dd1b9e70 00000000
> [  425.744293] 9e60: dd1b8038 00000002 de062080 c0d7785c 00000000 00000000 00000000 00000000
> [  425.752899] 9e80: 00192082 c0926c08 0000000d c0565f50 00000001 de141000 ffffff9c de770500
> [  425.761474] 9ea0: de062080 dd1b8000 00000000 c0127ed8 00000041 00000004 de0361d0 ddbd2240
> [  425.770080] 9ec0: 00727375 00000003 de141011 de086e00 de0361d0 ddbd2240 ddbd60f0 00000011
> [  425.778686] 9ee0: 00000002 00000056 00000000 00000000 00000000 00000002 00000000 00000000
> [  425.787292] 9f00: c011fbfc c00843c4 00000000 00000000 00000000 c011fbfc 00000000 de141000
> [  425.795867] 9f20: dd1b8010 de671344 00000000 c011e450 de671344 00000000 de062080 de141000
> [  425.804473] 9f40: dd1b8010 de671344 00000000 c011fcd8 00000000 00000000 c011fbfc de141010
> [  425.813079] 9f60: 00000021 ffffffff 00000000 de0623ac 00000021 dd0b8940 00000000 de498140
> [  425.821685] 9f80: ffffffff ffffffff 00000000 00000000 00000000 c0053580 de498140 c00535b0
> [  425.830291] 9fa0: 00000000 00000000 00000000 c000e5e8 00000000 00000000 00000000 00000000
> [  425.838867] 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [  425.847473] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
> [  425.856079] [<c0082064>] (__lock_acquire) from [<c00843c4>] (lock_acquire+0xa0/0xfc)
> [  425.864257] [<c00843c4>] (lock_acquire) from [<c054a808>] (_raw_spin_lock_irqsave+0x38/0x4c)
> [  425.873107] [<c054a808>] (_raw_spin_lock_irqsave) from [<c007914c>] (__wake_up+0x1c/0x4c)
> [  425.881713] [<c007914c>] (__wake_up) from [<c00791ac>] (__wake_up_bit+0x30/0x38)
> [  425.889495] [<c00791ac>] (__wake_up_bit) from [<c0149548>] (ll_rw_block+0x2c/0xf4)
> [  425.897460] [<c0149548>] (ll_rw_block) from [<c01b60a0>] (ext4_find_entry+0x190/0x5ec)
> [  425.905792] [<c01b60a0>] (ext4_find_entry) from [<c01b6534>] (ext4_lookup+0x38/0x164)
> [  425.914031] [<c01b6534>] (ext4_lookup) from [<c0121cb4>] (lookup_real+0x20/0x4c)
> [  425.921844] [<c0121cb4>] (lookup_real) from [<c012297c>] (__lookup_hash+0x38/0x40)
> [  425.929779] [<c012297c>] (__lookup_hash) from [<c0123344>] (lookup_slow+0x3c/0xa8)
> [  425.937744] [<c0123344>] (lookup_slow) from [<c0123c08>] (link_path_walk+0x404/0x85c)
> [  425.945983] [<c0123c08>] (link_path_walk) from [<c01269cc>] (path_openat+0x8c/0x604)
> [  425.954132] [<c01269cc>] (path_openat) from [<c0127ed8>] (do_filp_open+0x2c/0x80)
> [  425.962005] [<c0127ed8>] (do_filp_open) from [<c011e450>] (do_open_exec+0x18/0xf4)
> [  425.969970] [<c011e450>] (do_open_exec) from [<c011fcd8>] (do_execve+0x1a8/0x5cc)
> [  425.977844] [<c011fcd8>] (do_execve) from [<c0053580>] (____call_usermodehelper+0x100/0x130)
> [  425.986724] [<c0053580>] (____call_usermodehelper) from [<c000e5e8>] (ret_from_fork+0x14/0x2c)
> [  425.995788] Code: 0affffc8 e28b3f41 f5d3f000 e1932f9f (e2822001)
> [  426.002197] ---[ end trace 713ce209622ee484 ]---
> [  426.007141] Unable to handle kernel NULL pointer dereference at virtual address 00000000
> [  426.015624] pgd = c0004000
> [  426.018463] [00000000] *pgd=00000000
> [  426.022247] Internal error: Oops: 17 [#2] SMP ARM
> [  426.027191] Modules linked in: snd_soc_omap_twl4030 libertas_sdio libertas snd_soc_omap snd_pcm_dmaengine lib80211 cfg80211 snd_soc_twl4030 snd_soc_core snd_compress snd_pcm snd_timer snd soundcore
> [  426.045898] CPU: 0 PID: 1582 Comm: kworker/u2:2 Tainted: G      D       3.15.0-dirty #14
> [  426.054412] task: de062080 ti: dd1b8000 task.ti: dd1b8000
> [  426.060119] PC is at perf_event_task_tick+0xac/0x104
> [  426.065368] LR is at scheduler_tick+0x70/0xd4
> [  426.069976] pc : [<c00d3e8c>]    lr : [<c006a808>]    psr: 60000193
> [  426.069976] sp : dd1b9800  ip : 00000000  fp : dd1b983c
> [  426.082031] r10: 00000000  r9 : 1f2b8000  r8 : 1f2b8000
> [  426.087554] r7 : 00000000  r6 : dfaa6da4  r5 : fffffeb8  r4 : be8deef8
> [  426.094421] r3 : fffffeb8  r2 : 0000129c  r1 : c07eedb8  r0 : fffffeb8
> [  426.101287] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
> [  426.108886] Control: 10c5307d  Table: 9e76c019  DAC: 00000015
> [  426.114959] Process kworker/u2:2 (pid: 1582, stack limit = 0xdd1b8248)
> [  426.121826] Stack: (0xdd1b9800 to 0xdd1ba000)
> [  426.126434] 9800: 00000001 dfaa8100 c07f0100 c07fb7e4 00000000 de062080 c00a16b0 c006a808
> [  426.135070] 9820: 00000000 dd1b8000 de062080 00000000 00000000 dd1b98f0 00000000 c004b560
> [  426.143676] 9840: 60000113 2fc2853e 00000063 dfaa5ba8 dd1b99b8 c00a16a4 00000001 c00a170c
> [  426.152313] 9860: dfaa5450 00000063 2fc2853e 00000063 00000001 dfaa5ba8 00000063 dfaa54a0
> [  426.160949] 9880: dfaa5450 c00600d4 dfaa5450 7fffffff ffffffff 2fc20e08 00000063 dfaa5460
> [  426.169586] 98a0: 00000000 dfaa5450 dfaa5450 c0060cfc ffffffff 7fffffff 2fc20e08 00000063
> [  426.178192] 98c0: c0d77061 00000003 ffffffff 7fffffff dfaa5508 dfaa5540 dfaa5578 dfaa5460
> [  426.186828] 98e0: 2fc20e08 00000063 2fc20e08 00000063 2fc20e08 00000063 dd02b810 c0801280
> [  426.195465] 9900: de0068d4 00000035 00000035 00000000 00000000 c088428c c08842a0 c002517c
> [  426.204071] 9920: c0025158 c008bcfc 00000035 00000000 00000000 de006880 de0068d4 de006880
> [  426.212707] 9940: de0068d4 c0801280 00000035 00000000 00000000 00000001 de062080 c008bebc
> [  426.221343] 9960: de006880 de0068d4 00001307 c008e89c 00000035 c07ef1b0 dd1b8008 c008b3dc
> [  426.229980] 9980: c07fb7e4 c000ee48 fa200000 dd1b99b8 c08874b8 00000035 c0082068 c00085fc
> [  426.238586] 99a0: de062080 c054a978 60000113 ffffffff dd1b99ec c054b2e4 c054a974 00000001
> [  426.247222] 99c0: 0000002a 00000000 de24f284 0000000b c0082066 c07ff5c4 c0082068 00000000
> [  426.255859] 99e0: 00000001 de062080 00000000 dd1b9a00 c054a974 c054a978 60000113 ffffffff
> [  426.264495] 9a00: dd1b8000 c003ffbc 00000001 c008b0f0 00000001 dd1b8008 c008b024 c0543050
> [  426.273101] 9a20: c06c9fec c0840100 0000000b dd1b8000 0000000b c0082066 c07ff5c4 c0082068
> [  426.281738] 9a40: 00000000 00000001 c0886b44 c00121a0 dd1b8248 0000000b c0d7747e 60000193
> [  426.290374] 9a60: 00000000 00000008 30000000 66666661 20386366 62383265 31346633 64356620
> [  426.298980] 9a80: 30306633 31652030 66323339 28206639 32383265 31303032 7b002029 c0543050
> [  426.307617] 9aa0: c06be158 00000001 00000007 c080016c 7be3c202 dd1b9b68 c0d7785c c0854c10
> [  426.316253] 9ac0: 7be3c0fe c0008438 00000000 c0926c08 00000007 00000000 00030001 7be3c202
> [  426.324859] 9ae0: 243a01a7 00000003 00000000 00000000 00000000 00000000 00000000 00000000
> [  426.333496] 9b00: 00000000 00000000 00000000 00000000 00000000 00000000 c08404fc 00000000
> [  426.342132] 9b20: 00000000 00000002 00000000 00000000 dd803994 00000000 00000000 00000000
> [  426.350738] 9b40: 00000001 00000000 c014722c c00843c4 c0082060 20000193 ffffffff dd1b9b9c
> [  426.359374] 9b60: de062080 c054b264 dfaef6d0 28014a03 dfaef6d0 7be3c202 dfaef6d0 00000000
> [  426.368011] 9b80: dd1b8030 00000000 de062080 c0d7785c c0854c10 7be3c0fe 00000001 dd1b9bb0
> [  426.376617] 9ba0: c00843c4 c0082064 20000193 ffffffff de062080 00000004 00000006 c07fb7e4
> [  426.385253] 9bc0: 00000008 c0081998 dd1b8020 de062080 00000000 00000001 c07ef168 c0081ab8
> [  426.393890] 9be0: 1f2b8000 ddbe1780 ddbe65c0 dd1b8000 1f2b8000 c01486d4 00000000 ddbd60f0
> [  426.402526] 9c00: ddbe65c0 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [  426.411132] 9c20: dfaef6d0 00000000 00000000 00000000 00000001 00000000 c007914c c00843c4
> [  426.419769] 9c40: 00000001 00000080 00000000 c007914c 00000000 00000002 dd1b8000 60000193
> [  426.428375] 9c60: c0854c10 dfaef6c0 00000113 c007914c 00000003 dd1b9cc8 c0146d90 c0147b3c
> [  426.437011] 9c80: 00000001 c054a808 00000001 00000000 c007914c 00000000 dfaef6c0 00000000
> [  426.445648] 9ca0: 00000001 c007914c 00000000 00000000 ddbe65c0 00000000 dd1b9d30 00000060
> [  426.454284] 9cc0: 00000001 c00791ac ddbe65c0 00000002 00000000 c0149548 00000001 00000000
> [  426.462890] 9ce0: 00000001 ddbd60f0 dd1b9d40 00000001 dd1b9d2c c01b60a0 dd1b9d2c 00000001
> [  426.471527] 9d00: de062080 00000004 00000006 00000001 00000001 00000000 de1ff000 dde0a490
> [  426.480133] 9d20: dd1b9d9c 00000000 00000001 00000000 ddbe65c0 c00843c4 00000001 00000000
> [  426.488769] 9d40: ddbe65c0 c0130274 00000000 c007fa8c dd1b8038 60000113 de1ff000 ddbd22a0
> [  426.497406] 9d60: dde0a468 dde0a468 ddbd60f0 ddbd2240 dd1b8000 de141015 de141014 00000000
> [  426.506042] 9d80: dd1b9eb8 c01b6534 dde0a468 c054a8d4 ddbd2240 c01302a8 00000000 00000000
> [  426.514648] 9da0: dde0a468 ddbd2240 ddbd2240 c0121cb4 00000001 00000011 ddbd2240 c012297c
> [  426.523284] 9dc0: dd1b8000 01141015 de141014 dd1b9eb8 dd1b9e10 c0123344 00000000 dd1b9e18
> [  426.531921] 9de0: dd1b9e10 00000003 dd1b8000 c0123c08 c0124b3c 00000001 00000000 c0081ab8
> [  426.540527] 9e00: dd1b9eb8 dd1b8030 c01269a4 de086dc0 00000000 c0124b3c 00000001 00000000
> [  426.549163] 9e20: 00727375 00000003 de141011 de086e00 de11fb80 de11fb80 dd1b9eb8 c0565f50
> [  426.557800] 9e40: de141000 ffffff9c 00000000 00000000 dd1b8000 c01269cc dd1b9e70 00000000
> [  426.566436] 9e60: dd1b8038 00000002 de062080 c0d7785c 00000000 00000000 00000000 00000000
> [  426.575042] 9e80: 00192082 c0926c08 0000000d c0565f50 00000001 de141000 ffffff9c de770500
> [  426.583679] 9ea0: de062080 dd1b8000 00000000 c0127ed8 00000041 00000004 de0361d0 ddbd2240
> [  426.592315] 9ec0: 00727375 00000003 de141011 de086e00 de0361d0 ddbd2240 ddbd60f0 00000011
> [  426.600921] 9ee0: 00000002 00000056 00000000 00000000 00000000 00000002 00000000 00000000
> [  426.609558] 9f00: c011fbfc c00843c4 00000000 00000000 00000000 c011fbfc 00000000 de141000
> [  426.618194] 9f20: dd1b8010 de671344 00000000 c011e450 de671344 00000000 de062080 de141000
> [  426.626800] 9f40: dd1b8010 de671344 00000000 c011fcd8 00000000 00000000 c011fbfc de141010
> [  426.635437] 9f60: 00000021 ffffffff 00000000 de0623ac 00000021 dd0b8940 00000000 de498140
> [  426.644073] 9f80: ffffffff ffffffff 00000000 00000000 00000000 c0053580 de498140 c00535b0
> [  426.652679] 9fa0: 00000000 00000000 00000000 c000e5e8 00000000 00000000 00000000 00000000
> [  426.661315] 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [  426.669921] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
> [  426.678558] [<c00d3e8c>] (perf_event_task_tick) from [<c006a808>] (scheduler_tick+0x70/0xd4)
> [  426.687469] [<c006a808>] (scheduler_tick) from [<c004b560>] (update_process_times+0x54/0x60)
> [  426.696380] [<c004b560>] (update_process_times) from [<c00a16a4>] (tick_sched_handle.isra.18+0x44/0x50)
> [  426.706298] [<c00a16a4>] (tick_sched_handle.isra.18) from [<c00a170c>] (tick_sched_timer+0x5c/0x90)
> [  426.715820] [<c00a170c>] (tick_sched_timer) from [<c00600d4>] (__run_hrtimer+0x7c/0x1e0)
> [  426.724365] [<c00600d4>] (__run_hrtimer) from [<c0060cfc>] (hrtimer_interrupt+0x128/0x2b8)
> [  426.733093] [<c0060cfc>] (hrtimer_interrupt) from [<c002517c>] (omap2_gp_timer_interrupt+0x24/0x34)
> [  426.742645] [<c002517c>] (omap2_gp_timer_interrupt) from [<c008bcfc>] (handle_irq_event_percpu+0x40/0x1c4)
> [  426.752838] [<c008bcfc>] (handle_irq_event_percpu) from [<c008bebc>] (handle_irq_event+0x3c/0x5c)
> [  426.762176] [<c008bebc>] (handle_irq_event) from [<c008e89c>] (handle_level_irq+0xac/0x154)
> [  426.770996] [<c008e89c>] (handle_level_irq) from [<c008b3dc>] (generic_handle_irq+0x28/0x3c)
> [  426.779907] [<c008b3dc>] (generic_handle_irq) from [<c000ee48>] (handle_IRQ+0x4c/0xb4)
> [  426.788269] [<c000ee48>] (handle_IRQ) from [<c00085fc>] (omap3_intc_handle_irq+0x80/0x9c)
> [  426.796874] [<c00085fc>] (omap3_intc_handle_irq) from [<c054b2e4>] (__irq_svc+0x44/0x5c)
> [  426.805389] Exception stack(0xdd1b99b8 to 0xdd1b9a00)
> [  426.810729] 99a0:                                                       c054a974 00000001
> [  426.819366] 99c0: 0000002a 00000000 de24f284 0000000b c0082066 c07ff5c4 c0082068 00000000
> [  426.827972] 99e0: 00000001 de062080 00000000 dd1b9a00 c054a974 c054a978 60000113 ffffffff
> [  426.836608] [<c054b2e4>] (__irq_svc) from [<c054a978>] (_raw_spin_unlock_irq+0x28/0x2c)
> [  426.845092] [<c054a978>] (_raw_spin_unlock_irq) from [<c003ffbc>] (do_exit+0x138/0x924)
> [  426.853546] [<c003ffbc>] (do_exit) from [<c00121a0>] (die+0x1fc/0x3b8)
> [  426.860443] [<c00121a0>] (die) from [<c0008438>] (do_DataAbort+0x88/0x98)
> [  426.867584] [<c0008438>] (do_DataAbort) from [<c054b264>] (__dabt_svc+0x44/0x80)
> [  426.875366] Exception stack(0xdd1b9b68 to 0xdd1b9bb0)
> [  426.880706] 9b60:                   dfaef6d0 28014a03 dfaef6d0 7be3c202 dfaef6d0 00000000
> [  426.889343] 9b80: dd1b8030 00000000 de062080 c0d7785c c0854c10 7be3c0fe 00000001 dd1b9bb0
> [  426.897949] 9ba0: c00843c4 c0082064 20000193 ffffffff
> [  426.903289] [<c054b264>] (__dabt_svc) from [<c0082064>] (__lock_acquire+0x160/0x1cb8)
> [  426.911560] [<c0082064>] (__lock_acquire) from [<c00843c4>] (lock_acquire+0xa0/0xfc)
> [  426.919738] [<c00843c4>] (lock_acquire) from [<c054a808>] (_raw_spin_lock_irqsave+0x38/0x4c)
> [  426.928649] [<c054a808>] (_raw_spin_lock_irqsave) from [<c007914c>] (__wake_up+0x1c/0x4c)
> [  426.937255] [<c007914c>] (__wake_up) from [<c00791ac>] (__wake_up_bit+0x30/0x38)
> [  426.945068] [<c00791ac>] (__wake_up_bit) from [<c0149548>] (ll_rw_block+0x2c/0xf4)
> [  426.953033] [<c0149548>] (ll_rw_block) from [<c01b60a0>] (ext4_find_entry+0x190/0x5ec)
> [  426.961364] [<c01b60a0>] (ext4_find_entry) from [<c01b6534>] (ext4_lookup+0x38/0x164)
> [  426.969604] [<c01b6534>] (ext4_lookup) from [<c0121cb4>] (lookup_real+0x20/0x4c)
> [  426.977386] [<c0121cb4>] (lookup_real) from [<c012297c>] (__lookup_hash+0x38/0x40)
> [  426.985351] [<c012297c>] (__lookup_hash) from [<c0123344>] (lookup_slow+0x3c/0xa8)
> [  426.993286] [<c0123344>] (lookup_slow) from [<c0123c08>] (link_path_walk+0x404/0x85c)
> [  427.001525] [<c0123c08>] (link_path_walk) from [<c01269cc>] (path_openat+0x8c/0x604)
> [  427.009674] [<c01269cc>] (path_openat) from [<c0127ed8>] (do_filp_open+0x2c/0x80)
> [  427.017547] [<c0127ed8>] (do_filp_open) from [<c011e450>] (do_open_exec+0x18/0xf4)
> [  427.025512] [<c011e450>] (do_open_exec) from [<c011fcd8>] (do_execve+0x1a8/0x5cc)
> [  427.033386] [<c011fcd8>] (do_execve) from [<c0053580>] (____call_usermodehelper+0x100/0x130)
> [  427.042266] [<c0053580>] (____call_usermodehelper) from [<c000e5e8>] (ret_from_fork+0x14/0x2c)
> [  427.051300] Code: e1973003 1a00000b e1a03005 e1a00005 (e5b35148)
> [  427.057708] ---[ end trace 713ce209622ee485 ]---
> [  427.062561] Kernel panic - not syncing: Fatal exception in interrupt
> [  427.069244] ---[ end Kernel panic - not syncing: Fatal exception in interrupt
>
>
>
>
> Med venlig hilsen/Best regards
>
> Casper Mogensen
>
> ________________________________________
> From: Casper Lyngesen Mogensen
> Sent: Friday, June 20, 2014 16:26
> To: Ash Charles
> Cc: Tony Lindgren; linux-omap@vger.kernel.org
> Subject: RE: OMAP 3630 random crashes
>
> Hi
>
> The memory on the Overo, i have with me right now, is actually marked JW513,
> and 18 months is also around the time, they were bought. Will check my other
> modules, when i get back to the office.
> However i have not been able to recreate the problem with the 3.5.0 kernel on
> same Overo
>
> Med venlig hilsen/Best regards
>
> Casper Mogensen
>
> ________________________________________
> From: ashcharles@gmail.com <ashcharles@gmail.com> on behalf of Ash Charles <ash@gumstix.com>
> Sent: Friday, June 20, 2014 16:17
> To: Casper Lyngesen Mogensen
> Cc: Tony Lindgren; linux-omap@vger.kernel.org
> Subject: Re: OMAP 3630 random crashes
>
> Hi Casper,
>
> What is the top-side marking on the memory chip on your Overo?  There
> were some random faults due to poor memory chips marked 'JW513' from
> about 18 months ago.
>
> --Ash
>
> On Fri, Jun 20, 2014 at 7:00 AM, Casper Lyngesen Mogensen
> <clmogensen@grundfos.com> wrote:
>> Hi
>>
>> U-boot seems to set the speed to 165 Mhz
>> "OMAP36XX/37XX-GP ES1.2, CPU-OPP2, L3-165MHz, Max CPU Clock 1 Ghz"
>>
>> I have a LAN9221, but tried the other timings, still same result.
>>
>> Also tried running the entire system from an MMC card, same result, but my test had
>> to run a little longer.
>>
>> Found a quicker test to reproduce the error, a little C-program:
>>
>> #include <stdio.h>
>> #include <stdlib.h>
>> #include <errno.h>
>>
>> int main(void){
>>         long long var=0;
>>
>>         int *ptr=NULL;
>>
>>         int run=1;
>>         while(run){
>>                 ptr=malloc(sizeof(int)*1000);
>>                 if(ptr==NULL){
>>                         run=0;
>>                 }
>>                 var+=1000;
>>                 printf("mallocsize = %lld\n",var*sizeof(int));
>>         }
>> }
>>
>>
>> Booting from NFS, the system crashes at ~40mb allocated
>> On MMC at ~60MB
>>
>> Med venlig hilsen/Best regards
>>
>> Casper Mogensen
>>
>> ________________________________________
>> From: Tony Lindgren <tony@atomide.com>
>> Sent: Friday, June 20, 2014 11:14
>> To: Casper Lyngesen Mogensen
>> Cc: linux-omap@vger.kernel.org
>> Subject: Re: OMAP 3630 random crashes
>>
>> Hi,
>>
>> * Casper Lyngesen Mogensen <clmogensen@grundfos.com> [140620 01:52]:
>>> Hi
>>>
>>> I have  custom board with a Gumstix Overo, my board is similar to a
>>> Tobi board. Right now i have it running with a 3.5.0 kernel. I'm
>>> trying to upgrade the kernel, and have tried several versions (3.10 ->
>>> 3.15) and i seem to be hitting the same problem with all versions, i
>>> get random crashes. Found a way to  trigger the crash within
>>> minutes/seconds:
>>>
>>> # dd if=/dev/urandom of=/tmp/test.file bs=1024 count=100000
>>>
>>> A count > 10000 will at some point trigger the crash. The hang/crash
>>> is repeatable everytime but the log is not, sometimes i do not get
>>> any trace at all. I can provide more logs if necessary.  Config and
>>> crash log are below..
>>>
>>> Have tried disabling various peripherals, such as sound, usb,
>>> ethernet, wifi, bluetooth, but with no luck. Also tried different Overo
>>> boards.
>>>
>>> Hope someone can help me/point me in the right direction
>>
>> I was seeing similar issues with NFSroot until commit dcf21919
>> (ARM: dts: Fix GPMC timings for LAN9220). Turns out LAN9220 has
>> much slower timings compared to LAN9221. So you need to check that
>> you're using right timings if you have LAN9220.
>>
>> Also, check what rate your bootloader is setting the L3 speed.
>> If it's set to 200MHz, then LAN9220 timings seem to overflow the
>> GPMC registers for the calculated values and bootloader timings
>> are used instead.
>>
>>> Starting kernel ...
>>>
>>> [    0.000000] Booting Linux on physical CPU 0x0
>>> [    0.000000] Linux version 3.15.0 (clmo@N66266) (gcc version 4.8.1 (crosstool-NG 1.19.0) ) #3 SMP Wed Jun 11 23:50:13 CEST 2014
>>> [    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c5387d
>>> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
>>> [    0.000000] Machine model: OMAP36xx/AM37xx/DM37xx Gumstix Overo on Tobi
>>> [    0.000000] cma: CMA: reserved 16 MiB at 8d800000
>>> [    0.000000] Memory policy: Data cache writeback
>>> [    0.000000] CPU: All CPU(s) started in SVC mode.
>>> [    0.000000] OMAP3630 ES1.2 (l2cache neon isp 192mhz_clk )
>>> [    0.000000] PERCPU: Embedded 9 pages/cpu @cecc6000 s14080 r8192 d14592 u36864
>>> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 60704
>>> [    0.000000] Kernel command line: console=ttyO2,115200n8 root=/dev/nfs nfsroot=192.168.100.1:/export/bbroot,nolock rw ip=192.168.100.7::192.168.100.1:::eth0:off mem=240M
>>
>> Maybe also check if your test works with NFSroot idsabled.
>>
>> Regards,
>>
>> Tony
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |
