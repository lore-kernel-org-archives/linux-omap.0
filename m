From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH 00/11] Add L2 cache cleaning to generic CPU suspend
Date: Thu, 1 Sep 2011 23:57:54 +0800
Message-ID: <20110901155752.GC5147@S2100-06.ap.freescale.net>
References: <20110901124752.GE29729@n2100.arm.linux.org.uk>
 <20110901153342.GB5147@S2100-06.ap.freescale.net>
 <20110901153451.GA16024@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:45055 "EHLO
	TX2EHSOBE008.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932439Ab1IAPtG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Sep 2011 11:49:06 -0400
Content-Disposition: inline
In-Reply-To: <20110901153451.GA16024@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Sep 01, 2011 at 04:34:51PM +0100, Russell King - ARM Linux wrote:
> On Thu, Sep 01, 2011 at 11:33:43PM +0800, Shawn Guo wrote:
> > This is also the case on i.MX6Q, which L2 cache is retained during a
> > suspend/resume cycle.  Currently, I have to call into the following
> > before calling generic cpu_suspend() to clean/invalidate the entire
> > L2 cache.
> > 
> > 	outer_flush_all();
> > 	outer_disable();
> > 
> > But there is a wired thing on using generic cpu_resume().  I have to
> > invalidate L1 before calling into cpu_resume() like below.
> > 
> > ENTRY(imx6q_cpu_resume)
> >         bl      v7_invalidate_l1
> >         b       cpu_resume
> > ENDPROC(imx6q_cpu_resume)
> > 
> > ENTRY(imx6q_secondary_startup)
> >         bl      v7_invalidate_l1
> >         b       secondary_startup
> > ENDPROC(imx6q_secondary_startup)
> > 
> > The v7_invalidate_l1() is the function copied from mach-tegra/headsmp.S,
> > which has to be called before calling secondary_startup to boot
> > secondary cores (same situation between Tegra and i.MX6Q).
> 
> Presumably that's because your L1 cache contains randomized data with
> random validity (and presumably random dirtyness) at boot time - something
> which unfortunately the ARM ARM permits.  I don't think we can go to the
> extent of dealing with this in the generic code as it would unnecessarily
> perturb those implementations which either the boot loader has already
> sorted out that issue, or which don't have the issue at all.
> 
Yes, agreed.  It seems that Tegra and i.MX6Q are the only two CA9MP
cases here.  But is it possible to maintain this v7_invalidate_l1()
function in cache-v7.S, so that we do not need to duplicate it in
platform codes?

> > Before applying this patch series, I have something like below actually
> > working.
> > 
> > 
> > 	outer_flush_all();
> > 	outer_disable();
> > 	imx_set_cpu_jump(0, imx6q_cpu_resume);
> > 	/* Zzz ... */
> > 	cpu_suspend(0, imx6q_suspend_finish);
> > 
> > I expect with you patches applied, I can still have it work with simply
> > removing those two lines outer cache codes.
> 
> That should be the case.
> 
> > But unfortunately, I'm
> > running into Oops when resuming back.  And I also have Oops with
> > imx_set_cpu_jump(0, cpu_resume) which means skipping the
> > v7_invalidate_l1() and calling generic cpu_resume() only.
> 
> Do you have a copy of the oops?
> 

root@freescale ~$ echo mem > /sys/power/state
PM: Syncing filesystems ... done.
PM: Preparing system for mem sleep
Freezing user space processes ... (elapsed 0.01 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.01 seconds) done.
PM: Entering mem sleep
PM: suspend of devices complete after 0.402 msecs
PM: suspend devices took 0.000 seconds
PM: late suspend of devices complete after 0.276 msecs
Disabling non-boot CPUs ...
CPU1: shutdown
CPU2: shutdown
CPU3: shutdown
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = eb308000
[00000000] *pgd=7b11d831, *pte=00000000, *ppte=00000000
Internal error: Oops: 80000005 [#1] SMP
Modules linked in:
CPU: 0    Not tainted  (3.1.0-rc4+ #319)
PC is at 0x0
LR is at cpu_init+0x28/0x74
pc : [<00000000>]    lr : [<80010544>]    psr: 800001f3
sp : eb3dbe70  ip : eb3dbe4c  fp : eb2b2560
r10: 8001d8dc  r9 : 8001ef68  r8 : 00000004
r7 : 00000003  r6 : 00000000  r5 : eb0b8b60  r4 : 804865d0
r3 : 80012758  r2 : eb3dbe34  r1 : 7b8f806a  r0 : 00000000
Flags: Nzcv  IRQs off  FIQs off  Mode SVC_32  ISA Thumb  Segment user
Control: 10c53c7d  Table: 7b8f804a  DAC: 00000015
Process login (pid: 445, stack limit = 0xeb3da2f0)
Stack: (0xeb3dbe70 to 0xeb3dc000)
be60:                                     ffffffff 00000000 eb3dbeac eb3dbe88
be80: 8008adc8 8008a5f8 eb3dbeb4 eb3dbe98 801dbec0 eb0a01e0 eb406600 00000000
bea0: 00000000 00000003 eb3dbed4 eb3dbeb8 80063ffc 80063c78 0000006d eb321000
bec0: 8000e34c 8004d730 eb3dbee4 00000b04 800bc9e4 eb868140 ffffffff 00000000
bee0: eb3dbf70 eb8286c0 00000004 eb806bc0 eb3dbf0c eb3dbf00 801d7344 800633a8
bf00: eb3dbf2c 00000003 2aad7000 00000000 eb3da000 eb0b91e0 00000007 00001000
bf20: eb3dbf64 eb3dbf30 801dbff4 80311644 80000013 eb0b8b9c eb3da000 2aaeb000
bf40: 800a71ec 80025538 800aae40 eb181000 eb3dbfb0 00000000 eb3dbfb0 eb0df000
bf60: 00020000 00000000 00000024 00000100 02012080 00000008 02012080 00000005
bf80: 8000e504 00000000 eb3dbfa4 eb3dbf98 8009fb74 8009f9d8 00000000 eb3dbfa8
bfa0: 8000e380 8002f8a8 7e837d90 00000000 00000000 00000000 00a69008 00000000
bfc0: 00000004 2ab06000 2acb95f8 00000004 00000004 0201029c 00000001 00000000
bfe0: 00000004 7ebc0478 2ac0798c 2ac53e6c 60000010 00000001 00000000 00000000
Backtrace: frame pointer underflow
[<eb2b02d4>] (0xeb2b02d4) from [<2571140e>] (0x2571140e)
Backtrace aborted due to bad frame pointer <2551140e>
Code: bad PC value
---[ end trace b4510fc09c2ffbd1 ]---
Fixing recursive fault but reboot is needed!
Unable to handle kernel NULL pointer dereference at virtual address 00000010
pgd = eb308000
[00000010] *pgd=7b11d831, *pte=00000000, *ppte=00000000
Internal error: Oops: 5 [#2] SMP
Modules linked in:
CPU: 0    Tainted: G      D      (3.1.0-rc4+ #319)
PC is at find_busiest_group+0xd0/0xa4c
LR is at 0x0
pc : [<80023810>]    lr : [<00000000>]    psr: 600001d3
sp : eb3dba58  ip : 00000000  fp : eb3dbb44
r10: 80415ba0  r9 : eb346000  r8 : 80427b3c
r7 : 80427d10  r6 : 00000010  r5 : 80415ba0  r4 : 00000000
r3 : 00000000  r2 : 00000000  r1 : 00000024  r0 : eb3dbaf4
Flags: nZCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment user
Control: 10c53c7d  Table: 7b8f804a  DAC: 00000015
Process login (pid: 445, stack limit = 0xeb3da2f0)
Stack: (0xeb3dba58 to 0xeb3dc000)
ba40:                                                       eb926500 0000000a
ba60: eb3dba84 eb3dba70 eb3dbb90 00000002 00000000 00000000 00000000 00000000
ba80: 00000000 8020475c eb346000 eb3dba98 80017d90 00000000 80415ba0 80427ab0
baa0: 80415ba0 eb3dbab0 802048a4 00000000 00000000 00000000 00000000 00000000
bac0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
bae0: 00000000 00000000 00000000 00000000 00000000 00001f61 8042d8b4 8042d8b4
bb00: 00001f61 80443ae0 eb3dbb34 eb3dbb18 8004d4b0 80311644 8002b684 8166e0e4
bb20: eb2b2560 eb3da000 80427d10 eb2b26dc eb346000 00000000 eb3dbbc4 eb3dbb48
bb40: 80024240 8002374c 8166e0e4 eb3dbc0c eb3da000 00000002 eb3dbb8c 8166eba0
bb60: eb346000 80415ba0 8166e0e4 80427b3c 80427d10 80427d10 80415ba0 00000020
bb80: eb3dbbac 00000000 8001e5f0 8001ef20 ffffffb5 00000000 eb2b2560 8166eba0
bba0: eb2b2560 eb3da000 80427d10 eb2b26dc eb346000 00000000 eb3dbc3c eb3dbbc8
bbc0: 8030f5ac 80024198 eb3dbc0c 8042d8b4 eb2b2560 eb2b02d8 000bc20f 00000000
bbe0: 00000001 8041a080 80415ba0 80415ba0 ffff9442 00000006 fffffffc 80415ba0
bc00: 80415ba0 804150c0 eb3dbc2c 00000001 8030ed50 eb2b2560 0000000b 00000000
bc20: fffffffc eb3dbc9b 00000020 eb3da000 eb3dbc74 eb3dbc40 8002f534 8030ef88
bc40: eb3da000 00000000 fffffffc eb3dbc9b 00000020 fffffff8 eb3dbc74 eb3dbc68
bc60: 8002b50c fffffffc eb3dbcfc eb3dbc78 80011c88 8002ee9c eb3da2f0 0000000b
bc80: 00000004 7f000000 00000000 00000004 8039a080 8039a088 62000005 50206461
bca0: 61762043 0065756c eb3dbccc eb3dbcb8 8030ed50 8002bdd0 80000005 eb3dbcd4
bcc0: eb3dbcfc eb3dbce0 800147cc 8030ed38 803ad880 eb3dbe28 00000000 00000000
bce0: 80000005 eb0b8b60 eb0b8b98 eb2b2560 eb3dbd24 eb3dbd00 8001485c 800119fc
bd00: eb3dbe28 eb0b8b60 eb3dbe28 00000000 00010000 80000005 eb3dbd5c eb3dbd28
bd20: 800149c0 800147ec eb922d80 eb44fd30 00000000 80000005 8042af98 00000000
bd40: eb3dbe28 00000004 8001ef68 8001d8dc eb3dbd7c eb3dbd60 80014b74 80014878
bd60: 00000005 8042af98 00000000 eb3dbe28 eb3dbe24 eb3dbd80 800085c4 80014adc
bd80: 8032433c 00000000 eb3dbdac eb3dbd98 80074b6c 80074ad8 80074b48 fffffffa
bda0: eb90d9e0 00000000 eb3dbdec eb3dbdb8 80027170 80311644 00000001 40000093
bdc0: 800401b4 80027408 eb3dbdec eb3dbdd8 80040248 80040198 80415ba0 80415ba0
bde0: 8020add0 8020ad10 00000000 8048d5c0 0000003f 0000003e eb93a000 8048dee4
be00: eb8295a0 eb3da000 00000000 800001f3 ffffffff eb3dbe5c eb2b2560 eb3dbe28
be20: 8000e018 80008590 00000000 7b8f806a eb3dbe34 80012758 804865d0 eb0b8b60
be40: 00000000 00000003 00000004 8001ef68 8001d8dc eb2b2560 eb3dbe4c eb3dbe70
be60: 80010544 00000000 800001f3 ffffffff ffffffff 00000000 eb3dbeac eb3dbe88
be80: 8008adc8 8008a5f8 eb3dbeb4 eb3dbe98 801dbec0 eb0a01e0 eb406600 00000000
bea0: 00000000 00000003 eb3dbed4 eb3dbeb8 80063ffc 80063c78 0000006d eb321000
bec0: 8000e34c 8004d730 eb3dbee4 00000b04 800bc9e4 eb868140 ffffffff 00000000
bee0: eb3dbf70 eb8286c0 00000004 eb806bc0 eb3dbf0c eb3dbf00 801d7344 800633a8
bf00: eb3dbf2c 00000003 2aad7000 00000000 eb3da000 eb0b91e0 00000007 00001000
bf20: eb3dbf64 eb3dbf30 801dbff4 80311644 80000013 eb0b8b9c eb3da000 2aaeb000
bf40: 800a71ec 80025538 800aae40 eb181000 eb3dbfb0 00000000 eb3dbfb0 eb0df000
bf60: 00020000 00000000 00000024 00000100 02012080 00000008 02012080 00000005
bf80: 8000e504 00000000 eb3dbfa4 eb3dbf98 8009fb74 8009f9d8 00000000 eb3dbfa8
bfa0: 8000e380 8002f8a8 7e837d90 00000000 00000000 00000000 00a69008 00000000
bfc0: 00000004 2ab06000 2acb95f8 00000004 00000004 0201029c 00000001 00000000
bfe0: 00000004 7ebc0478 2ac0798c 2ac53e6c 60000010 00000001 00000000 00000000
Backtrace:
[<80023740>] (find_busiest_group+0x0/0xa4c) from [<80024240>] (load_balance+0xb4
/0x5ac)
[<8002418c>] (load_balance+0x0/0x5ac) from [<8030f5ac>] (schedule+0x630/0x6a8)
[<8030ef7c>] (schedule+0x0/0x6a8) from [<8002f534>] (do_exit+0x6a4/0x6f0)
[<8002ee90>] (do_exit+0x0/0x6f0) from [<80011c88>] (die+0x298/0x2ec)
 r7:fffffffc
[<800119f0>] (die+0x0/0x2ec) from [<8001485c>] (__do_kernel_fault+0x7c/0x8c)
[<800147e0>] (__do_kernel_fault+0x0/0x8c) from [<800149c0>] (do_page_fault+0x154
/0x1f8)
 r8:80000005 r7:00010000 r6:00000000 r5:eb3dbe28 r4:eb0b8b60
r3:eb3dbe28
[<8001486c>] (do_page_fault+0x0/0x1f8) from [<80014b74>] (do_translation_fault+0
xa4/0xa8)
[<80014ad0>] (do_translation_fault+0x0/0xa8) from [<800085c4>] (do_PrefetchAbort
+0x40/0xa4)
 r7:eb3dbe28 r6:00000000 r5:8042af98 r4:00000005
[<80008584>] (do_PrefetchAbort+0x0/0xa4) from [<8000e018>] (__pabt_svc+0x38/0x80
)
Exception stack(0xeb3dbe28 to 0xeb3dbe70)
be20:                   00000000 7b8f806a eb3dbe34 80012758 804865d0 eb0b8b60
be40: 00000000 00000003 00000004 8001ef68 8001d8dc eb2b2560 eb3dbe4c eb3dbe70
be60: 80010544 00000000 800001f3 ffffffff
 r7:eb3dbe5c r6:ffffffff r5:800001f3 r4:00000000
Backtrace aborted due to bad frame pointer <eb2b2560>
Code: e51b20c8 e3a01024 e28e6010 e51b30cc (e7965002)
---[ end trace b4510fc09c2ffbd2 ]---
Fixing recursive fault but reboot is needed!
Unable to handle kernel NULL pointer dereference at virtual address 00000008
pgd = eb308000
[00000008] *pgd=7b11d831, *pte=00000000, *ppte=00000000
Internal error: Oops: 5 [#3] SMP
Modules linked in:
CPU: 0    Tainted: G      D      (3.1.0-rc4+ #319)
PC is at rb_next+0xc/0x74
LR is at pick_next_task_fair+0xd8/0x114
pc : [<801dbb18>]    lr : [<80022230>]    psr: 600001d3
sp : eb3db778  ip : eb3db788  fp : eb3db784
r10: 00000000  r9 : 80313ac0  r8 : eb2b26dc
r7 : 80427d10  r6 : 00000000  r5 : 8166eba0  r4 : 00000000
r3 : 80022158  r2 : ffffffff  r1 : 00000000  r0 : 00000008
Flags: nZCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment user
Control: 10c53c7d  Table: 7b8f804a  DAC: 00000015
Process login (pid: 445, stack limit = 0xeb3da2f0)
Stack: (0xeb3db778 to 0xeb3dc000)
b760:                                                       eb3db7a4 eb3db788
b780: 80022230 801dbb18 8166eba0 eb2b2560 eb3da000 80427d10 eb3db81c eb3db7a8
b7a0: 8030f450 80022164 00000000 8042d8b4 8039a085 ffffffff ffffffff 8039a087
b7c0: 00000001 0039a085 80415ba0 80415ba0 0000000b 00000000 00000001 80415ba0
b7e0: 80415ba0 804150c0 eb3db80c eb3db7f8 8030ed50 eb2b2560 0000000b 00000000
b800: 00000001 eb3db8aa 00000000 eb3da000 eb3db854 eb3db820 8002f534 8030ef88
b820: eb3da000 00000000 00000001 eb3db8aa 00000000 80023812 eb3db854 eb3db848
b840: 8002b50c 00000001 eb3db8dc eb3db858 80011c88 8002ee9c eb3da2f0 0000000b
b860: 00000004 7f000000 00000000 00000008 8039a080 8039a088 65000005 32623135
b880: 20386330 30613365 34323031 38326520 31303665 35652030 30336231 28206363
b8a0: 36393765 32303035 80002029 8030ed38 803ad880 eb3dba10 00000010 00000000
b8c0: 00000005 eb0b8b60 eb0b8b98 eb2b2560 eb3db904 eb3db8e0 8001485c 800119fc
b8e0: eb3dba10 eb0b8b60 eb3dba10 00000010 00010000 00000005 eb3db93c eb3db908
b900: 800149c0 800147ec eb3db930 eb3db918 801df694 00000005 00000010 8042af48
b920: 00000005 eb3dba10 eb346000 80415ba0 eb3db95c eb3db940 80014b74 80014878
b940: 00000005 00000010 8042af48 00000005 eb3dba0c eb3db960 80008520 80014adc
b960: 00000000 eb3db991 80443f0c 80443b39 00000000 ffffffff eb3dba94 eb3db988
b980: 801de75c 801de3d0 ffffffff ffffffff 327830f8 31313735 00653034 00001831
b9a0: 0000001c 80427afc eb3dba0c 0000184d 8042d8b4 8042d8b4 0000184d 80443ae0
b9c0: eb3db9ec eb3db9d0 8004d4b0 80311644 8002b684 8002b51c 0000184d 0000184d
b9e0: eb3dba24 eb3db9f0 eb3dba0c 80023810 600001d3 ffffffff eb3dba44 80427b3c
ba00: eb3dbb44 eb3dba10 8000de98 800084f0 eb3dbaf4 00000024 00000000 00000000
ba20: 00000000 80415ba0 00000010 80427d10 80427b3c eb346000 80415ba0 eb3dbb44
ba40: 00000000 eb3dba58 00000000 80023810 600001d3 ffffffff eb926500 0000000a
ba60: eb3dba84 eb3dba70 eb3dbb90 00000002 00000000 00000000 00000000 00000000
ba80: 00000000 8020475c eb346000 eb3dba98 80017d90 00000000 80415ba0 80427ab0
baa0: 80415ba0 eb3dbab0 802048a4 00000000 00000000 00000000 00000000 00000000
bac0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
bae0: 00000000 00000000 00000000 00000000 00000000 00001f61 8042d8b4 8042d8b4
bb00: 00001f61 80443ae0 eb3dbb34 eb3dbb18 8004d4b0 80311644 8002b684 8166e0e4
bb20: eb2b2560 eb3da000 80427d10 eb2b26dc eb346000 00000000 eb3dbbc4 eb3dbb48
bb40: 80024240 8002374c 8166e0e4 eb3dbc0c eb3da000 00000002 eb3dbb8c 8166eba0
bb60: eb346000 80415ba0 8166e0e4 80427b3c 80427d10 80427d10 80415ba0 00000020
bb80: eb3dbbac 00000000 8001e5f0 8001ef20 ffffffb5 00000000 eb2b2560 8166eba0
bba0: eb2b2560 eb3da000 80427d10 eb2b26dc eb346000 00000000 eb3dbc3c eb3dbbc8
bbc0: 8030f5ac 80024198 eb3dbc0c 8042d8b4 eb2b2560 eb2b02d8 000bc20f 00000000
bbe0: 00000001 8041a080 80415ba0 80415ba0 ffff9442 00000006 fffffffc 80415ba0
bc00: 80415ba0 804150c0 eb3dbc2c 00000001 8030ed50 eb2b2560 0000000b 00000000
bc20: fffffffc eb3dbc9b 00000020 eb3da000 eb3dbc74 eb3dbc40 8002f534 8030ef88
bc40: eb3da000 00000000 fffffffc eb3dbc9b 00000020 fffffff8 eb3dbc74 eb3dbc68
bc60: 8002b50c fffffffc eb3dbcfc eb3dbc78 80011c88 8002ee9c eb3da2f0 0000000b
bc80: 00000004 7f000000 00000000 00000004 8039a080 8039a088 62000005 50206461
bca0: 61762043 0065756c eb3dbccc eb3dbcb8 8030ed50 8002bdd0 80000005 eb3dbcd4
bcc0: eb3dbcfc eb3dbce0 800147cc 8030ed38 803ad880 eb3dbe28 00000000 00000000
bce0: 80000005 eb0b8b60 eb0b8b98 eb2b2560 eb3dbd24 eb3dbd00 8001485c 800119fc
bd00: eb3dbe28 eb0b8b60 eb3dbe28 00000000 00010000 80000005 eb3dbd5c eb3dbd28
bd20: 800149c0 800147ec eb922d80 eb44fd30 00000000 80000005 8042af98 00000000
bd40: eb3dbe28 00000004 8001ef68 8001d8dc eb3dbd7c eb3dbd60 80014b74 80014878
bd60: 00000005 8042af98 00000000 eb3dbe28 eb3dbe24 eb3dbd80 800085c4 80014adc
bd80: 8032433c 00000000 eb3dbdac eb3dbd98 80074b6c 80074ad8 80074b48 fffffffa
bda0: eb90d9e0 00000000 eb3dbdec eb3dbdb8 80027170 80311644 00000001 40000093
bdc0: 800401b4 80027408 eb3dbdec eb3dbdd8 80040248 80040198 80415ba0 80415ba0
bde0: 8020add0 8020ad10 00000000 8048d5c0 0000003f 0000003e eb93a000 8048dee4
be00: eb8295a0 eb3da000 00000000 800001f3 ffffffff eb3dbe5c eb2b2560 eb3dbe28
be20: 8000e018 80008590 00000000 7b8f806a eb3dbe34 80012758 804865d0 eb0b8b60
be40: 00000000 00000003 00000004 8001ef68 8001d8dc eb2b2560 eb3dbe4c eb3dbe70
be60: 80010544 00000000 800001f3 ffffffff ffffffff 00000000 eb3dbeac eb3dbe88
be80: 8008adc8 8008a5f8 eb3dbeb4 eb3dbe98 801dbec0 eb0a01e0 eb406600 00000000
bea0: 00000000 00000003 eb3dbed4 eb3dbeb8 80063ffc 80063c78 0000006d eb321000
bec0: 8000e34c 8004d730 eb3dbee4 00000b04 800bc9e4 eb868140 ffffffff 00000000
bee0: eb3dbf70 eb8286c0 00000004 eb806bc0 eb3dbf0c eb3dbf00 801d7344 800633a8
bf00: eb3dbf2c 00000003 2aad7000 00000000 eb3da000 eb0b91e0 00000007 00001000
bf20: eb3dbf64 eb3dbf30 801dbff4 80311644 80000013 eb0b8b9c eb3da000 2aaeb000
bf40: 800a71ec 80025538 800aae40 eb181000 eb3dbfb0 00000000 eb3dbfb0 eb0df000
bf60: 00020000 00000000 00000024 00000100 02012080 00000008 02012080 00000005
bf80: 8000e504 00000000 eb3dbfa4 eb3dbf98 8009fb74 8009f9d8 00000000 eb3dbfa8
bfa0: 8000e380 8002f8a8 7e837d90 00000000 00000000 00000000 00a69008 00000000
bfc0: 00000004 2ab06000 2acb95f8 00000004 00000004 0201029c 00000001 00000000
bfe0: 00000004 7ebc0478 2ac0798c 2ac53e6c 60000010 00000001 00000000 00000000
Backtrace:
[<801dbb0c>] (rb_next+0x0/0x74) from [<80022230>] (pick_next_task_fair+0xd8/0x11
4)
[<80022158>] (pick_next_task_fair+0x0/0x114) from [<8030f450>] (schedule+0x4d4/0
x6a8)
 r7:80427d10 r6:eb3da000 r5:eb2b2560 r4:8166eba0
[<8030ef7c>] (schedule+0x0/0x6a8) from [<8002f534>] (do_exit+0x6a4/0x6f0)
[<8002ee90>] (do_exit+0x0/0x6f0) from [<80011c88>] (die+0x298/0x2ec)
 r7:00000001
[<800119f0>] (die+0x0/0x2ec) from [<8001485c>] (__do_kernel_fault+0x7c/0x8c)
[<800147e0>] (__do_kernel_fault+0x0/0x8c) from [<800149c0>] (do_page_fault+0x154
/0x1f8)
 r8:00000005 r7:00010000 r6:00000010 r5:eb3dba10 r4:eb0b8b60
r3:eb3dba10
[<8001486c>] (do_page_fault+0x0/0x1f8) from [<80014b74>] (do_translation_fault+0
xa4/0xa8)
[<80014ad0>] (do_translation_fault+0x0/0xa8) from [<80008520>] (do_DataAbort+0x3
c/0xa0)
 r7:00000005 r6:8042af48 r5:00000010 r4:00000005
[<800084e4>] (do_DataAbort+0x0/0xa0) from [<8000de98>] (__dabt_svc+0x38/0x60)
Exception stack(0xeb3dba10 to 0xeb3dba58)
ba00:                                     eb3dbaf4 00000024 00000000 00000000
ba20: 00000000 80415ba0 00000010 80427d10 80427b3c eb346000 80415ba0 eb3dbb44
ba40: 00000000 eb3dba58 00000000 80023810 600001d3 ffffffff
 r8:80427b3c r7:eb3dba44 r6:ffffffff r5:600001d3 r4:80023810
[<80023740>] (find_busiest_group+0x0/0xa4c) from [<80024240>] (load_balance+0xb4
/0x5ac)
[<8002418c>] (load_balance+0x0/0x5ac) from [<8030f5ac>] (schedule+0x630/0x6a8)
[<8030ef7c>] (schedule+0x0/0x6a8) from [<8002f534>] (do_exit+0x6a4/0x6f0)
[<8002ee90>] (do_exit+0x0/0x6f0) from [<80011c88>] (die+0x298/0x2ec)
 r7:fffffffc
[<800119f0>] (die+0x0/0x2ec) from [<8001485c>] (__do_kernel_fault+0x7c/0x8c)
[<800147e0>] (__do_kernel_fault+0x0/0x8c) from [<800149c0>] (do_page_fault+0x154
/0x1f8)
 r8:80000005 r7:00010000 r6:00000000 r5:eb3dbe28 r4:eb0b8b60
r3:eb3dbe28
[<8001486c>] (do_page_fault+0x0/0x1f8) from [<80014b74>] (do_translation_fault+0
xa4/0xa8)
[<80014ad0>] (do_translation_fault+0x0/0xa8) from [<800085c4>] (do_PrefetchAbort
+0x40/0xa4)
 r7:eb3dbe28 r6:00000000 r5:8042af98 r4:00000005
[<80008584>] (do_PrefetchAbort+0x0/0xa4) from [<8000e018>] (__pabt_svc+0x38/0x80
)
Exception stack(0xeb3dbe28 to 0xeb3dbe70)
be20:                   00000000 7b8f806a eb3dbe34 80012758 804865d0 eb0b8b60
be40: 00000000 00000003 00000004 8001ef68 8001d8dc eb2b2560 eb3dbe4c eb3dbe70
be60: 80010544 00000000 800001f3 ffffffff
 r7:eb3dbe5c r6:ffffffff r5:800001f3 r4:00000000
Backtrace aborted due to bad frame pointer <eb2b2560>
Code: e89da800 e1a0c00d e92dd800 e24cb004 (e5903000)
---[ end trace b4510fc09c2ffbd3 ]---
Fixing recursive fault but reboot is needed!

-- 
Regards,
Shawn

