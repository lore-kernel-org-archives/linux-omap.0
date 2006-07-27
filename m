From: "Richard Copeman" <richard.copeman@lauterbach.co.uk>
Subject: JTAG halt produces straneg message on terminal - OSK5912
Date: Thu, 27 Jul 2006 16:12:04 +0100
Message-ID: <000801c6b18f$056cbd90$642aa8c0@Buffy>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

 

I have a 2.6.15 Kernel built for OMAP 5912 OSK using GCC 3.4.1 cross
compiled form a standard SUSE 9.2 PC.

 

I have the system running but when I halt the target using my JTAG debugger
and then restart it I get a message dumped to the  serial console. 

 

BUG: soft lockup detected on CPU#0!

 

Pid: 0, comm:              swapper

CPU: 0

PC is at omap_pm_idle+0xe8/0x130

LR is at omap_pm_idle+0x80/0x130

pc : [<c002dc64>]    lr : [<c002dbfc>]    Not tainted

sp : c01f9f94  ip : c02445d0  fp : c01f9fa8

r10: 1001d464  r9 : 41069263  r8 : 1001d494

r7 : c025aba8  r6 : c024ca68  r5 : 00000001  r4 : 000013c3

r3 : 00000013  r2 : 00000400  r1 : fefedc02  r0 : 00000000

Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  Segment kernel

Control: 5317F  Table: 11FF4000  DAC: 00000017

[<c00248e8>] (show_regs+0x0/0x4c) from [<c0059d28>]
(softlockup_tick+0x64/0x7c)

 r4 = C01F9F4C

[<c0059cc4>] (softlockup_tick+0x0/0x7c) from [<c0046404>]
(do_timer+0x3e8/0x468)

 

 r4 = C024B49C

[<c004601c>] (do_timer+0x0/0x468) from [<c002792c>] (timer_tick+0xb4/0xe4)

[<c0027878>] (timer_tick+0x0/0xe4) from [<c00381a8>]
(omap_32k_timer_interrupt+0

x5c/0xac)

 r6 = 00000093  r5 = C024A450  r4 = 04424267

[<c003814c>] (omap_32k_timer_interrupt+0x0/0xac) from [<c0023a08>]
(__do_irq+0xa

4/0xe8)

 r7 = 00000036  r6 = 00000000  r5 = 00000000  r4 = C01FF864

[<c0023964>] (__do_irq+0x0/0xe8) from [<c0023c50>] (do_level_IRQ+0x68/0xbc)

 r8 = C01F9F4C  r7 = C025ABA8  r6 = C01F9F4C  r5 = 00000036

 r4 = C023FDBC

[<c0023be8>] (do_level_IRQ+0x0/0xbc) from [<c0023cf8>]
(asm_do_IRQ+0x54/0x140)

 r6 = FFFFFFFF  r5 = FEFE0000  r4 = C01F8000

[<c0023ca4>] (asm_do_IRQ+0x0/0x140) from [<c00229a4>] (__irq_svc+0x24/0x80)

[<c002db7c>] (omap_pm_idle+0x0/0x130) from [<c002464c>] (cpu_idle+0x48/0x64)

 r5 = C01F8000  r4 = C002DB7C

[<c0024604>] (cpu_idle+0x0/0x64) from [<c0022024>] (__init_end+0x24/0x2c)

 r5 = C023EE7C  r4 = 00000000

[<c0022000>] (__init_end+0x0/0x2c) from [<c00087ec>]
(start_kernel+0x174/0x1bc)

[<c0008678>] (start_kernel+0x0/0x1bc) from [<10008094>] (0x10008094)

 

/ #

/ #

/ #

/ #

/ #

 

The system is trying to tell me something but what?

How do I decode this message and understand what's been going on?

The system continues to run stably and without any apparent problems but I'd
like to know what's going on and what I should be doing about it.

 

TIA,

 

Richard.
