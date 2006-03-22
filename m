From: tony@atomide.com
Subject: Re: MMC lockup on 16xx/H2
Date: Wed, 22 Mar 2006 07:19:37 -0800
Message-ID: <20060322151935.GC5748@atomide.com>
References: <441B143D.2020100@mvista.com> <441B1B73.4030303@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <441B1B73.4030303@indt.org.br>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Carlos Aguiar <carlos.aguiar@indt.org.br>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Carlos Aguiar <carlos.aguiar@indt.org.br> [060317 12:27]:
> ext Kevin Hilman wrote:
> 
> >I"m seeing a soft lockup in the OMAP MMC driver on my 1623/H2 board.  
> >I haven't found it yet, but wondering if anyone else sees this.
> >
> >I'm using the default omap_h2_1610_defconfig plus enabling MMC, 
> >MMC_BLOCK and MMC_OMAP (built-in.)  The kernel boots fine without 
> >these enabled.
> >
> >The soft-lockup catches the problem:
> >
> >[ ... ]
> >usb0: Ethernet Gadget, version: May Day 2005
> >usb0: using omap_udc, OUT ep2out-bulk IN ep1in-bulk STATUS ep3in-int
> >usb0: MAC e2:f3:92:66:c0:5a
> >usb0: HOST MAC 66:f8:01:66:fb:8d
> >usb0: RNDIS ready
> >otg: b_idle, SWITCH to gadget, ctrl 098021
> >isp1301_omap 0-002d: ready for dual-role USB ...
> >mice: PS/2 mouse device common for all mice
> >NET: Registered protocol family 2
> >BUG: soft lockup detected on CPU#0!
> >
> >Pid: 4, comm:             events/0
> >CPU: 0
> >PC is at mmc_omap_set_ios+0x130/0x154
> >LR is at schedule_timeout+0x94/0xbc
> >pc : [<c0181a58>]    lr : [<c01eb0fc>]    Not tainted
> >sp : c0325e38  ip : c0325ddc  fp : c0325e58
> >r10: c0354e00  r9 : 00000000  r8 : 00061a80
> >r7 : c0354eac  r6 : 00000879  r5 : c0354f20  r4 : 02dc6c00
> >r3 : 00000000  r2 : fefb7800  r1 : c0325dc0  r0 : 00000000
> >Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  Segment kernel
> >Control: 5317F  Table: 10004000  DAC: 00000017
> >[<c00278f0>] (show_regs+0x0/0x4c) from [<c005d3f8>] 
> >(softlockup_tick+0x64/0x7c)
> > r4 = C0325DF0
> >[<c005d394>] (softlockup_tick+0x0/0x7c) from [<c0049a70>] 
> >(do_timer+0x404/0x480) r4 = C028475C
> >[<c004966c>] (do_timer+0x0/0x480) from [<c002aac4>] 
> >(timer_tick+0xb4/0xe4)
> >[<c002aa10>] (timer_tick+0x0/0xe4) from [<c0030ad4>] 
> >(omap_mpu_timer_interrupt+) r6 = 00000000  r5 = 00000000  r4 = C0283710
> >[<c0030a88>] (omap_mpu_timer_interrupt+0x0/0x6c) from [<c00269b0>] 
> >(__do_irq+0x) r4 = C0232FE8
> >[<c0026964>] (__do_irq+0x0/0x8c) from [<c0026bf8>] 
> >(do_level_IRQ+0x68/0xc0)
> > r8 = C0325DF0  r7 = C0354EAC  r6 = C0325DF0  r5 = 0000001E
> > r4 = C0278BD8
> >[<c0026b90>] (do_level_IRQ+0x0/0xc0) from [<c0026ca4>] 
> >(asm_do_IRQ+0x54/0x140)
> > r6 = FFFFFFFF  r5 = FEFECB00  r4 = C0324000
> >[<c0026c50>] (asm_do_IRQ+0x0/0x140) from [<c0025964>] 
> >(__irq_svc+0x24/0x80)
> >[<c0181928>] (mmc_omap_set_ios+0x0/0x154) from [<c017e690>] 
> >(mmc_rescan+0x90/0x) r8 = C0325E68  r7 = 00000000  r6 = C0354EAC  r5 = 
> >00000002
> > r4 = 00000001
> >[<c017e600>] (mmc_rescan+0x0/0xbc8) from [<c00503a8>] 
> >(run_workqueue+0xb4/0x108)[<c00502f4>] (run_workqueue+0x0/0x108) from 
> >[<c0050518>] (worker_thread+0x11c/0) r7 = C0325F88  r6 = C0325F8C  r5 
> >= C02FB6E8  r4 = C02FB6F0
> >[<c00503fc>] (worker_thread+0x0/0x170) from [<c0053c90>] 
> >(kthread+0xe8/0x11c)
> > r8 = 00000001  r7 = C00503FC  r6 = C030BF24  r5 = C0324000
> > r4 = C02FB6E0
> >[<c0053ba8>] (kthread+0x0/0x11c) from [<c004276c>] (do_exit+0x0/0x7e8)
> >
> >
> >_______________________________________________
> >Linux-omap-open-source mailing list
> >Linux-omap-open-source@linux.omap.com
> >http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> >
> Hi Kevin,
> 
> I'm having exactly the same problem. I've found this soft lockup problem 
> when generating a kernel image to OMAP 1610 and 1710 (using 
> omap_h2_1610_defconfig and omap_h3_1710_defconfig in the last updated 
> linux-omap-2.6.git tree) with MMC support enabled.

This seems to be related to some recent I2C changes as they are used for
powering MMC slot on H2 and H3 via tps65010 chip's gpios. MMC works just
fine at least on boards that use omap gpio for the power.

Tony
