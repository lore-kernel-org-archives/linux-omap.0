From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: omap2+: Revert omap-smp.c changes resetting cpu1
 during boot
Date: Wed, 15 Feb 2017 11:12:42 -0800
Message-ID: <20170215191242.GP21809@atomide.com>
References: <20170213215013.19929-1-tony@atomide.com>
 <20170214193645.GM21809@atomide.com>
 <20170215183915.GU3897@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170215183915.GU3897@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Tero Kristo <t-kristo@ti.com>, Keerthy <j-keerthy@ti.com>, linux-arm-kernel@lists.infradead.org, "Andrew F. Davis" <afd@ti.com>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [170215 10:40]:
> * Tony Lindgren <tony@atomide.com> [170214 11:39]:
> > * Tony Lindgren <tony@atomide.com> [170213 13:51]:
> > > Commit 3251885285e1 ("ARM: OMAP4+: Reset CPU1 properly for kexec") started
> > > resetting cpu1 because of a kexec boot issue I was seeing earlier in 2016
> > > on omap4 when doing kexec boot between two different kernel versions. The
> > > booted kernel ended up trying to use the old kernel start-up address unless
> > > cpu1 was reset before configuring the cpu1 start-up address.
> > > 
> > > It seems the reset part was not correct but probably working around some
> > > other issue. I have not been able to reproduce this issue any longer despite
> > > testing with backported patches back to v4.6 kernel. So it is possible this
> > > issue was caused by other work in progress kexec patches I had applied. Or
> > > it is possible some other fixes have made the issue go way.
> > > 
> > > The unconditional reset of cpu1 can cause issues booting some devices. For
> > > example, bootloader configured secure OS running on cpu1 will fail as the
> > > configuration is not preserved as reported by Andrew F. Davis <afd@ti.com>.
> > > 
> > > Let's fix the issue by reverting the cpu1 reset parts. If it turns out we
> > > still need to reset cpu1 in some cases, we can add it back and do it
> > > conditionally.
> > 
> > Actually with this I'm now seeing cpu1 not come up after a suspend/resume
> > cycle on duovero:
> > 
> > [  118.257415] CPU1: shutdown
> > [  118.294616] Error taking CPU1 up: -2
> > [  118.299072] PM: noirq resume of devices complete after 3.723 msecs
> > [  118.303802] PM: early resume of devices complete after 3.723 msecs
> > 
> > So this issue needs to be investigated more.
> 
> And then today the omap4 suspend/resume issue is no longer reproducable..
> Go figure.
> 
> But then doing more testing I noticed that also omap5 needs the reset.
> Without it we get the following on omap5-uevm doing a kexec boot. So clearly
> the reset cannot be just removed at least for omap4 and omap5.

And also the same issue happens doing kexec on beagle-x15 naturally if
the cpu1 reset is removed.

Regards,

Tony

> 8< ---------------------
> [    0.156796] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
> [    0.163396] Setting up static identity map for 0x80100000 - 0x80100070
> [    0.172246] smp: Bringing up secondary CPUs ...
> [    0.178970] Unable to handle kernel NULL pointer dereference at virtual address 00000000
> [    0.178974] pgd = c0004000
> [    0.178977] [00000000] *pgd=00000000
> [    0.178990] Internal error: Oops: 80000005 [#1] SMP ARM
> [    0.178995] Modules linked in:
> [    0.179005] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.10.0-rc8-next-20170215+ #120
> [    0.179008] Hardware name: Generic OMAP5 (Flattened Device Tree)
> [    0.179013] task: ee0c8ec0 task.stack: ee0ca000
> [    0.179018] PC is at 0x0
> [    0.179029] LR is at omap4_cpu_die+0x58/0x98
> [    0.179034] pc : [<00000000>]    lr : [<c01243dc>]    psr: 60000093
> [    0.179034] sp : ee0cbfb8  ip : 00000000  fp : 00000000
> [    0.179038] r10: 00000000  r9 : c0d50569  r8 : 00000000
> [    0.179042] r7 : c0c76448  r6 : c0d0792c  r5 : 00000001  r4 : c0b08054
> [    0.179046] r3 : 00000001  r2 : f0880000  r1 : 00000003  r0 : 00000001
> [    0.179051] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
> [    0.179055] Control: 10c5387d  Table: 8000406a  DAC: 00000051
> [    0.179059] Process swapper/1 (pid: 0, stack limit = 0xee0ca218)
> [    0.179063] Stack: (0xee0cbfb8 to 0xee0cc000)
> [    0.179068] bfa0:                                                       00000000 00000000
> [    0.179075] bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    0.179082] bfe0: 00000000 00000000 00000000 00000000 00000013 00000000 681b0041 cf3e4021
> [    0.179092] [<c01243dc>] (omap4_cpu_die) from [<00000000>] (  (null))
> [    0.179098] Code: bad PC value
> [    0.179115] ---[ end trace e14406c260ce69db ]---
> [    0.179121] Kernel panic - not syncing: Attempted to kill the idle task!
> [    0.179135] CPU0: stopping
> [    0.179141] ---[ end Kernel panic - not syncing: Attempted to kill the idle task!
> [    0.339715] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G      D         4.10.0-rc8-next-20170215+ #120
> [    0.348927] Hardware name: Generic OMAP5 (Flattened Device Tree)
> [    0.355112] [<c0110228>] (unwind_backtrace) from [<c010c224>] (show_stack+0x10/0x14)
> [    0.363083] [<c010c224>] (show_stack) from [<c04ca860>] (dump_stack+0xac/0xe0)
> [    0.370513] [<c04ca860>] (dump_stack) from [<c010e72c>] (handle_IPI+0x358/0x3f8)
> [    0.378120] [<c010e72c>] (handle_IPI) from [<c01015a4>] (gic_handle_irq+0x9c/0xb8)
> [    0.385909] [<c01015a4>] (gic_handle_irq) from [<c083b270>] (__irq_svc+0x70/0x98)
> [    0.393602] Exception stack(0xc0d01f38 to 0xc0d01f80)
> [    0.398794] 1f20:                                                       c0108284 00000000
> [    0.407205] 1f40: 00000000 00000000 c0d00000 c0d07994 c0d0792c c0c76448 c0d08560 c0d50569
> [    0.415616] 1f60: 00000000 00000000 00000000 c0d01f88 c0108284 c0108288 60000013 ffffffff
> [    0.424032] [<c083b270>] (__irq_svc) from [<c0108288>] (arch_cpu_idle+0x20/0x3c)
> [    0.431643] [<c0108288>] (arch_cpu_idle) from [<c0190bc4>] (do_idle+0x164/0x218)
> [    0.439251] [<c0190bc4>] (do_idle) from [<c0190ffc>] (cpu_startup_entry+0x18/0x1c)
> [    0.447040] [<c0190ffc>] (cpu_startup_entry) from [<c0c00c40>] (start_kernel+0x35c/0x3d4)
> [    0.455451] [<c0c00c40>] (start_kernel) from [<8000807c>] (0x8000807c)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
