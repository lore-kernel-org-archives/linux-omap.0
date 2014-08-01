From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP baseline test results for v3.16-rc4
Date: Fri, 1 Aug 2014 00:52:41 -0700
Message-ID: <20140801075241.GE29045@atomide.com>
References: <20140729084930.GH29045@atomide.com>
 <alpine.DEB.2.02.1407291225070.13035@utopia.booyaka.com>
 <alpine.DEB.2.02.1407291256270.13035@utopia.booyaka.com>
 <20140729145312.GT29045@atomide.com>
 <alpine.DEB.2.02.1407291922370.13035@utopia.booyaka.com>
 <20140730053940.GX29045@atomide.com>
 <alpine.DEB.2.02.1407300725290.4477@utopia.booyaka.com>
 <20140731131107.GB29045@atomide.com>
 <alpine.DEB.2.02.1407311922350.1845@utopia.booyaka.com>
 <20140801071056.GD29045@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:27818 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750838AbaHAHyH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Aug 2014 03:54:07 -0400
Content-Disposition: inline
In-Reply-To: <20140801071056.GD29045@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org

* Tony Lindgren <tony@atomide.com> [140801 00:14]:
> * Paul Walmsley <paul@pwsan.com> [140731 12:29]:
> > On Thu, 31 Jul 2014, Tony Lindgren wrote:
> > 
> > > * Paul Walmsley <paul@pwsan.com> [140730 00:55]:
> > > > On Tue, 29 Jul 2014, Tony Lindgren wrote:
> > > > 
> > > > > The following patch should fix the tests above for 3530es3beagle.
> > > > > Care to test and ack as I don't have one?
> > > > 
> > > > 3530es3beagle retention dynamic idle tests hang on next-20140729.  (Maybe 
> > > > other boards fail too - haven't tested any others).  
> > > 
> > > I just checked that today's linux next works for off-idle and
> > > wake-up events for at least 37xx evm.
> > 
> > I ran the full set of tests across all boards.  The only board that passed 
> > the dynamic idle testing on next-20140729 was the 3730beaglexm.
> > 
> > http://www.pwsan.com/omap/testlogs/next_20140729/20140730124836/README.txt
> > 
> > 37xxevm hangs on the first suspend entry:
> > 
> > http://www.pwsan.com/omap/testlogs/next_20140729/20140730124836/pm/37xxevm/37xxevm_log.txt
> > 
> > If I find some extra time, I'll set up a bisection run.
> 
> OK that sounds like some driver suspend regression that needs
> to be tracked down. I'm seeing it on my 37xx evm also with
> linux next too.

With no_console_suspend I'm seeing the following for smsc911x.
This does not happen with v3.16-rc, and there have been no changes
to smsc911x.c, so sounds like a good candidate for an automated
bisect and boot test.

Regards,

Tony

[   47.804443] PM: Syncing filesystems ... done.
[   47.807342] PM: Preparing system for mem sleep
[   47.817871] Freezing user space processes ... (elapsed 0.002 seconds) done.
[   47.821258] Freezing remaining freezable tasks ... (elapsed 0.003 seconds) done.
[   47.825073] PM: Entering mem sleep
[   47.838897] random: nonblocking pool is initialized
[   47.839630] Unable to handle kernel NULL pointer dereference at virtual address 00000698
[   47.
*pte=00000000, *ppte=00000000
[   47.840423] Internal error: Oops: 17 [#1] SMP ARM
[   47.840545] Modules linked in:
[   47.840728] CPU: 0 PID: 882 Comm: bash Not tainted 3.16.0-rc7-next-20140731-10331-ge9fab93 #303
[   47.840942] task: ce4dd140 ti: ce508000 task.ti: ce508000
[   47.841125] PC is at __lock_acquire+0x128/0xb78
[   47.841247] LR is at lock_acquire+0xa4/0x10c
[   47.841369] pc : [<c0088524>]    lr : [<c00894d8>]    psr: 20010093
[   47.841369] sp : ce509c68  ip : ce508000  fp : ce509cc4
[   47.841583] r10: 00000000  r9 : 00000000  r8 : ce4dd140
[   47.841766] r7 : 00000698  r6 : c097d068  r5 : c1165764  r4 : 00000001
[   47.841888] r3 : c09676f0  r2 : 00000001  r1 : 00000000  r0 : 00000698
[   47.842071] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
[   47.842254] Control: 10c5387d  Table: 8e534019  DAC: 00000015
[   47.842376] Process bash (pid: 882, stack limit = 0xce508248)
[   47.842559] Stack: (0xce509c68 to 0xce50a000)
[   47.842681] 9c60:                   ce4dd700 00000000 00000000 00000000 00011e89 f8316096
[   47.842895] 9c80: 
0000000
[   47.843017] 9ca0: 00000698 00000000 00000000 00000000 ce508000 c0436c94 ce509d14 ce509cc8
[   47.843231] 9cc0: c00894d8 c0088408 00000001 00000080 00000000 c0436c94 00000000 00000006
[   47.843444] 9ce0: ce4dd140 60010093 ce593cac 00000688 60010013 c0436c94 00000002 00000002
[   47.843658] 9d00: c07a83e8 c0436c6c ce509d44 ce509d18 c05db420 c0089440 00000001 00000000
[   47.843811] 9d20: c0436c94 60010013 c1165764 00000000 00000688 ce593c78 ce509d64 ce509d48
[   47.844024] 9d40: c0436c94 c05db3dc c09b43b0 00000000 00000000 ce593c78 ce509da4 ce509d68
[   47.844238] 9d60: c03bbc88 c0436c78 ce509d8c ce509d78 00000000 00000000 00000000 ce593c78
[   47.844451] 9d80: 00000000 c11aa6d8 000000
da0: c03bce3c c03bbc40 ce593c78 009886cc c11aa6d8 ce593c78 c09886cc c11aa6d8
[   47.844787] 9dc0: 00000000 00000002 ce509e14 ce5
05dbf74 0000000b 00000000 00000002 00000000 00000003 c09b6550 c1164e64
[   47.845153] 9e00: 0000000c c077086c ce509e2c ce509e18 c03bea04 c03be2dc c1164e78 c1164e58
[   47.845367] 9e20: ce509e7c ce509e30 c008f0c8 c03be9a8 c09b6550 c1164e64 0000000c c077086c
[   47.845550] 9e40: ce509e6c ce509e50 c05d158c c0092104 c07707d8 00000003 00000000 c0770848
[   47.845764] 9e60: c09b6550 c1164e64 0000000c c077086c ce509eb4 ce509e80 c008f920 c008f03c
[   47.845916] 9e80: ce4dd140 c077086c ce509eb4 00000003 c076b6d4 c1164e68 00000003 ce377140
[   47.846130] 9ea0: ce6a2e4c 00000004 ce509edc ce509eb8 c008e00c c008f534 ce6a2e40 00000004
[   47.846343] 9ec0: ce377140 ce509f78 00000004 ce6a2e40 ce509eec ce509ee0 c032699c c008dfa0
[   47.846557] 9ee0: ce509f0c ce509ef0 c01b109c c032698c c01b1040 00000000 00000000 ce377140
[   47.846679] 9f00: ce509f44 ce509f10 c01b0328 c01b104c 00000000 00000000 ce509f4c ce4cae00
[   47.846893] 9f20: 00000004 000bcc08 ce509f78 00000004 ce508000 000bcc08 ce509f74 ce509f48
[   47.847106] 9f40: c014406c c01b0250 c01604b4 c0160424 00000000 00000000 ce4cae00 ce4cae00
[   47.847259] 9f60: 00000004 000bcc08 ce509fa4 ce509f78 c01444b4 c0143fc4 00000000 00000000
[   47.847473] 9f80: 00000004 000bcc08 b6e94b50 00000004 c000f1c4 00000000 00000000 ce509fa8
[   47.847686] 9fa0: c000ef40 c0144474 00000004 000bcc08 0000000
c08 b6e94b50 00000004 00000004 00000000 000b5174 00000000
[   47.848052] 9fe0: 00000000 be94b92c b6e01671 b6e3a7c6 40010030 00000001 fffe7fff ffffffff
[   47.848266] [<c0088524>] (__lock_acquire) from [<c00894d8>] (lock_acquire+0xa4/0x10c)
[   47.848510] [<c00894d8>] (lock_acquire) from [<c05db420>] (_raw_spin_lock_irqsave+0x50/0x64)
[   47.848754] [<c05db420>] (_raw_spin_lock_irqsave) from [<c0436c94>] (smsc911x_suspend+0x28/0x5c)
[   47.848907] [<c0436c94>] (smsc911x_suspend) from [<c03bbc88>] (dpm_run_callback+0x54/0x108)
[   47.849121] [<c03bbc88>] (dpm_run_callback) from [<c03bce3c>] (__device_suspend+0x13c/0x388)
[   47.849334] [<c03bce3c>] (__device_suspend) from [<c03be340>] (dpm_suspend+0x70/0x2d0)
[   47.849548] [<c03be340>] (dpm_suspend) from [<c03bea04>] (dpm_suspend_start+0x68/0x70)
[   47.849670] [<c03bea04>] (dpm_suspend_start) from [<c008f0c8>] (suspend_devices_and_enter+0x98/0x4f8)
[   47.849914] [<c008f0c8>] (suspend_devices_and_enter) from [<c008f920>] (pm_suspend+0x3f8/0x470)
[   47.850128] [<c008f920>] (pm_suspend) from [<c008e00c>] (state_store+0x78/0xc8)
[   47.850250] [<c008e00c>] (state_store) from [<c032699c>] (kobj_attr_store+0x1c/0x28)
[   47.850463] [<c032699c>] (kobj_attr_store) from [<c01b109c>] (sysfs_kf_write+0x5c/0x60)
[   47.850677] [<c01b109c>] (sysfs_kf_write) from [<c01b0328>] (kernfs_fop_write+0xe4/0x198)
[   47.850891] [<c01b0328>] (kernfs_fop_wr
014406c>] (vfs_write) from [<c01444b4>] (SyS_write+0x4c/0x98)
[   47.851257] [<c01444b4>] (SyS_write) from [<c000ef40>] (ret_fast_syscall+0x0/0x48)
[   47.851470] Code: 1a00000e e3a00000 e24bd028 e89daff0 (e5971000) 
[   47.851593] ---[ end trace c6b1f330200fefe5 ]---
