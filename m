From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 0/40] Complete set of clocksource/sched_clock patches
Date: Sun, 19 Dec 2010 12:55:08 +0000
Message-ID: <20101219125508.GG3047@n2100.arm.linux.org.uk>
References: <20101217113223.GC9937@n2100.arm.linux.org.uk>
	<19725.57447.256528.883703@pilspetsen.it.uu.se>
	<20101219105209.GN9937@n2100.arm.linux.org.uk>
	<19725.64412.395353.947407@pilspetsen.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <19725.64412.395353.947407@pilspetsen.it.uu.se>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: Viresh Kumar <viresh.kumar@st.com>, Kevin Hilman <khilman@deeprootsystems.com>, Lennert Buytenhek <kernel@wantstofly.org>, linux-samsung-soc@vger.kernel.org, "Hans J. Koch" <hjk@linutronix.de>, Scott Branden <sbranden@broadcom.com>, Tony Lindgren <tony@atomide.com>, David Brown <davidb@codeaurora.org>, Alessandro Rubini <rubini@unipv.it>, Jiandong Zheng <jdzheng@broadcom.com>, Wan ZongShun <mcuos.com@gmail.com>, linux-arm-msm@vger.kernel.org, STEricsson <STEricsson_nomadik_linux@list.st.com>, Kukjin Kim <kgene.kim@samsung.com>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Daniel Walker <dwalker@codeaurora.org>, Eric Miao <eric.y.miao@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Erik Gilling <konkers@android.com>, Nicolas Pitre <nico@fluxnic.net>, Bryan Huntsman <bryanh@codeaurora.org>Sascha Hauer <kernel@>
List-Id: linux-omap@vger.kernel.org

On Sun, Dec 19, 2010 at 01:33:32PM +0100, Mikael Pettersson wrote:
> Here it is:
> 
> Build ATAG
> ATAG_MEM: Overwrite ram_end with real_region_top=0x20000000, memsize=512 M
> ATAG_MEM=536870912@0xa0000000, MACH_TYPE=1101
> Using base address 0x00200000 and length 0x0018e3c0
> Uncompressing Linux... done, booting the kernel.
> Linux version 2.6.37-rc6 (mikpe@brewer) (gcc version 4.4.6 20101116 (prerelease) (GCC) ) #1 Sun Dec 19 12:58:45 CET 2010
> CPU: XScale-80219 [69052e30] revision 0 (ARMv5TE), cr=0000397f
> CPU: VIVT data cache, VIVT instruction cache
> Machine: Thecus N2100
> bootconsole [earlycon0] enabled
> Memory policy: ECC disabled, Data cache writeback
> pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
> pcpu-alloc: [0] 0 
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 130048
> Kernel command line: console=ttyS0,115200 ro root=/dev/sda1 mem=512M@0xa0000000 earlyprintk
> PID hash table entries: 2048 (order: 1, 8192 bytes)
> Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
> Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
> Memory: 512MB = 512MB total
> Memory: 516424k/516424k available, 7864k reserved, 0K highmem
> Virtual kernel memory layout:
>     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
>     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
>     DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
>     vmalloc : 0xe0800000 - 0xfe000000   ( 472 MB)
>     lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
>     modules : 0xbf000000 - 0xc0000000   (  16 MB)
>       .init : 0xc0008000 - 0xc0022000   ( 104 kB)
>       .text : 0xc0022000 - 0xc030d000   (2988 kB)
>       .data : 0xc030e000 - 0xc0329d60   ( 112 kB)
> NR_IRQS:32
> sched_clock: 32 bits at 198MHz, resolution 5ns, wraps every 21691ms
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
> pgd = c0004000
> [00000000] *pgd=00000000
> Internal error: Oops: 80000005 [#1]
> last sysfs file: 
> Modules linked in:
> CPU: 0    Not tainted  (2.6.37-rc6 #1)
> PC is at 0x0
> LR is at iop_timer_interrupt+0x20/0x28
> pc : [<00000000>]    lr : [<c002b580>]    psr: 400000d3
> sp : c030fe98  ip : c030fea8  fp : c030fea4
> r10: a001c494  r9 : 69052e30  r8 : c0315a8c
> r7 : 00000009  r6 : 00000000  r5 : 00000000  r4 : c0312fa0
> r3 : 00000000  r2 : 00000001  r1 : c0312fc8  r0 : c0312fc8
> Flags: nZcv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
> Control: 0000397f  Table: a0004000  DAC: 00000017
> Process swapper (pid: 0, stack limit = 0xc030e270)
> Stack: (0xc030fe98 to 0xc0310000)
> fe80:                                                       c030fec4 c030fea8
> fea0: c005ebfc c002b56c c0315a68 00000009 00000200 60000053 c030fedc c030fec8
> fec0: c0060e78 c005ebdc 00000009 00000000 c030fef4 c030fee0 c002207c c0060dd8
> fee0: ffffffff c030ff2c c030ff6c c030fef8 c0022ba8 c002200c 00000000 00000001
> ff00: 00000000 00000000 c0315a68 c0312fa0 00000009 60000053 c0315a8c 69052e30
> ff20: a001c494 c030ff6c c030ff08 c030ff40 c00603e0 c005f7cc 60000053 ffffffff
> ff40: 52ef041b 00000001 c0312fa0 00000009 c001d9e4 c0311a58 a001c704 a001c494
> ff60: c030ff84 c030ff70 c005fa54 c005f598 c0312fa0 0bcd3d80 c030ffac c030ff88
> ff80: c000c3a4 c005fa38 c0315560 600000d3 c0330020 c0329d60 c001d9e8 c001d9e4
> ffa0: c030ffbc c030ffb0 c000bee4 c000c358 c030ffcc c030ffc0 c0009f54 c000bedc
> ffc0: c030fff4 c030ffd0 c0008a1c c0009f44 c000865c 00000000 00000000 c001d9e8
> ffe0: 0000397d c0329e64 00000000 c030fff8 a0008034 c00088b8 00000000 00000000
> Backtrace: 
> [<c002b560>] (iop_timer_interrupt+0x0/0x28) from [<c005ebfc>] (handle_IRQ_event+0x2c/0xfc)
> [<c005ebd0>] (handle_IRQ_event+0x0/0xfc) from [<c0060e78>] (handle_level_irq+0xac/0x11c)
>  r7:60000053 r6:00000200 r5:00000009 r4:c0315a68
> [<c0060dcc>] (handle_level_irq+0x0/0x11c) from [<c002207c>] (asm_do_IRQ+0x7c/0xa0)
>  r5:00000000 r4:00000009
> [<c0022000>] (asm_do_IRQ+0x0/0xa0) from [<c0022ba8>] (__irq_svc+0x48/0x80)
> Exception stack(0xc030fef8 to 0xc030ff40)
> fee0:                                                       00000000 00000001
> ff00: 00000000 00000000 c0315a68 c0312fa0 00000009 60000053 c0315a8c 69052e30
> ff20: a001c494 c030ff6c c030ff08 c030ff40 c00603e0 c005f7cc 60000053 ffffffff
>  r5:c030ff2c r4:ffffffff
> [<c005f58c>] (__setup_irq+0x0/0x310) from [<c005fa54>] (setup_irq+0x28/0x2c)
> [<c005fa2c>] (setup_irq+0x0/0x2c) from [<c000c3a4>] (iop_init_time+0x58/0x108)
>  r5:0bcd3d80 r4:c0312fa0
> [<c000c34c>] (iop_init_time+0x0/0x108) from [<c000bee4>] (n2100_timer_init+0x14/0x1c)
>  r6:c001d9e4 r5:c001d9e8 r4:c0329d60
> [<c000bed0>] (n2100_timer_init+0x0/0x1c) from [<c0009f54>] (time_init+0x1c/0x24)
> [<c0009f38>] (time_init+0x0/0x24) from [<c0008a1c>] (start_kernel+0x170/0x264)
> [<c00088ac>] (start_kernel+0x0/0x264) from [<a0008034>] (0xa0008034)
>  r5:c0329e64 r4:0000397d
> Code: bad PC value
> ---[ end trace 1b75b31a2719ed1c ]---
> Kernel panic - not syncing: Fatal exception in interrupt
> Backtrace: 
> [<c0026314>] (dump_backtrace+0x0/0x118) from [<c025b65c>] (dump_stack+0x18/0x1c)
>  r7:00000000 r6:c030e270 r5:c032a030 r4:c032a030
> [<c025b644>] (dump_stack+0x0/0x1c) from [<c025b6c4>] (panic+0x64/0x188)
> [<c025b660>] (panic+0x0/0x188) from [<c0026758>] (die+0x194/0x1d8)
>  r3:00010000 r2:c030fcf8 r1:00001315 r0:c02ca1bf
>  r7:00000000
> [<c00265c4>] (die+0x0/0x1d8) from [<c00285d8>] (__do_kernel_fault+0x6c/0x90)
>  r8:00000000 r7:80000005 r6:00000000 r5:c030fe50 r4:00000000
> [<c002856c>] (__do_kernel_fault+0x0/0x90) from [<c00287b8>] (do_page_fault+0x1bc/0x1d4)
>  r9:000000d3 r8:00000000 r7:00000000 r6:00000000 r5:c030fe50
> r4:c0310df8
> [<c00285fc>] (do_page_fault+0x0/0x1d4) from [<c0028868>] (do_translation_fault+0x24/0xac)
> [<c0028844>] (do_translation_fault+0x0/0xac) from [<c0022230>] (do_PrefetchAbort+0x3c/0xa0)
>  r7:c030fe50 r6:00000000 r5:c0311e5c r4:00000005
> [<c00221f4>] (do_PrefetchAbort+0x0/0xa0) from [<c0022c90>] (__pabt_svc+0x50/0x80)
> Exception stack(0xc030fe50 to 0xc030fe98)
> fe40:                                     c0312fc8 c0312fc8 00000001 00000000
> fe60: c0312fa0 00000000 00000000 00000009 c0315a8c 69052e30 a001c494 c030fea4
> fe80: c030fea8 c030fe98 c002b580 00000000 400000d3 ffffffff
>  r7:00000009 r6:00000000 r5:c030fe84 r4:ffffffff
> [<c002b560>] (iop_timer_interrupt+0x0/0x28) from [<c005ebfc>] (handle_IRQ_event+0x2c/0xfc)
> [<c005ebd0>] (handle_IRQ_event+0x0/0xfc) from [<c0060e78>] (handle_level_irq+0xac/0x11c)
>  r7:60000053 r6:00000200 r5:00000009 r4:c0315a68
> [<c0060dcc>] (handle_level_irq+0x0/0x11c) from [<c002207c>] (asm_do_IRQ+0x7c/0xa0)
>  r5:00000000 r4:00000009
> [<c0022000>] (asm_do_IRQ+0x0/0xa0) from [<c0022ba8>] (__irq_svc+0x48/0x80)
> Exception stack(0xc030fef8 to 0xc030ff40)
> fee0:                                                       00000000 00000001
> ff00: 00000000 00000000 c0315a68 c0312fa0 00000009 60000053 c0315a8c 69052e30
> ff20: a001c494 c030ff6c c030ff08 c030ff40 c00603e0 c005f7cc 60000053 ffffffff
>  r5:c030ff2c r4:ffffffff
> [<c005f58c>] (__setup_irq+0x0/0x310) from [<c005fa54>] (setup_irq+0x28/0x2c)
> [<c005fa2c>] (setup_irq+0x0/0x2c) from [<c000c3a4>] (iop_init_time+0x58/0x108)
>  r5:0bcd3d80 r4:c0312fa0
> [<c000c34c>] (iop_init_time+0x0/0x108) from [<c000bee4>] (n2100_timer_init+0x14/0x1c)
>  r6:c001d9e4 r5:c001d9e8 r4:c0329d60
> [<c000bed0>] (n2100_timer_init+0x0/0x1c) from [<c0009f54>] (time_init+0x1c/0x24)
> [<c0009f38>] (time_init+0x0/0x24) from [<c0008a1c>] (start_kernel+0x170/0x264)
> [<c00088ac>] (start_kernel+0x0/0x264) from [<a0008034>] (0xa0008034)
>  r5:c0329e64 r4:0000397d
> 
> We take an early timer interrupt and call NULL in the
> 
> 	evt->event_handler(evt);
> 
> statement in iop_timer_interrupt(). Apparently the evt (dev_id) passed
> to the interrupt handler isn't initialized at this point.

evt is initialized, it's done statically:

static struct irqaction iop_timer_irq = {
        .dev_id         = &iop_clockevent,
};

What isn't initialized at this early point is evt->event_handler.

> The most visible change the sched_clock patches did in plat-iop was to add
> a call to init_sched_clock() at the very start of iop_init_time(), before
> the timer IRQ, clockevent, and clocksource have been set up. Moving that call
> to the very end of iop_init_time() [see below] made the kernel boot again,
> and the interactivity problems were also solved.

I think this is a bug just waiting to happen, and the sched_clock patch
just gives it a helping hand (by accidentally enabling interrupts early
- and that's something which also needs fixing.)

Here's the event device setup code:

        write_tmr0(timer_ctl & ~IOP_TMR_EN);
        setup_irq(IRQ_IOP_TIMER0, &iop_timer_irq);
        clockevents_calc_mult_shift(&iop_clockevent,
                                    tick_rate, IOP_MIN_RANGE);
        iop_clockevent.max_delta_ns =
                clockevent_delta2ns(0xfffffffe, &iop_clockevent);
        iop_clockevent.min_delta_ns =
                clockevent_delta2ns(0xf, &iop_clockevent);
        iop_clockevent.cpumask = cpumask_of(0);
        clockevents_register_device(&iop_clockevent);
        write_trr0(ticks_per_jiffy - 1);
        write_tcr0(ticks_per_jiffy - 1);
        write_tmr0(timer_ctl);

First thing is that although the timer is stopped before the IRQ is
registered, there is no clearing of any pending timer interrupt at that
time.  As we don't know what state the timer was in, we can't be sure
that the interrupt isn't already pending.

Second thing is why is the timer being enabled by this code after it's
been registered.  This is something which should be done by the
clockevents code when it's ready via the ->set_mode callback, not when
the platform decides to do so - otherwise you can call the interrupt
handler when evt->event_handler has not been setup.

So, I think this will solve the IOP misbehaviour.  What I don't know
is what the cryptic txx0() suffixes on these write statements are
(what's the difference between trr and tcr?  tcr = timer counter
register, trr = timer ? register?  Does trr need to be written in
->set_mode (if so that's another bug in this code)?

diff --git a/arch/arm/plat-iop/time.c b/arch/arm/plat-iop/time.c
index 0ca000d..e937e5d 100644
--- a/arch/arm/plat-iop/time.c
+++ b/arch/arm/plat-iop/time.c
@@ -162,6 +162,7 @@ void __init iop_init_time(unsigned long tick_rate)
 	 * Set up interrupting clockevent timer 0.
 	 */
 	write_tmr0(timer_ctl & ~IOP_TMR_EN);
+	write_tisr(1);
 	setup_irq(IRQ_IOP_TIMER0, &iop_timer_irq);
 	clockevents_calc_mult_shift(&iop_clockevent,
 				    tick_rate, IOP_MIN_RANGE);
@@ -171,9 +172,6 @@ void __init iop_init_time(unsigned long tick_rate)
 		clockevent_delta2ns(0xf, &iop_clockevent);
 	iop_clockevent.cpumask = cpumask_of(0);
 	clockevents_register_device(&iop_clockevent);
-	write_trr0(ticks_per_jiffy - 1);
-	write_tcr0(ticks_per_jiffy - 1);
-	write_tmr0(timer_ctl);
 
 	/*
 	 * Set up free-running clocksource timer 1.
