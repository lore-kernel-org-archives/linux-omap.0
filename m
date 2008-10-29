From: David Brownell <david-b@pacbell.net>
Subject: Re: Git tree updated to v2.6.28-rc2, old sound and v4l drivers removed
Date: Wed, 29 Oct 2008 00:08:31 -0700
Message-ID: <200810290008.31634.david-b@pacbell.net>
References: <20081027204323.GA7539@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp128.sbc.mail.sp1.yahoo.com ([69.147.65.187]:48521 "HELO
	smtp128.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752002AbYJ2HIe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Oct 2008 03:08:34 -0400
In-Reply-To: <20081027204323.GA7539@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Monday 27 October 2008, Tony Lindgren wrote:
> I've updated our git tree to 2.6.28-rc2

I thought I'd scrub out some old H4 stuff, and had a few problems:

 - It wouldn't link vmlinux because compressed/misc.o used VFP
   instructions, but the main kernel didn't.  Worked around this
   by adding "--no-warn-mismatch" to the command line.  This
   showed up with two differen CodeSourcery toolchains:  the
   older arm-2007q3 and the current arm-2008q3.

 - Build fix needed, patch to follow (camera driver gone).

 - MMC oopsed; stack backtrace appended.  (Apologies, lines
   are doubled because of LL_DEBUG.)  The BUG() is basically
   that mmc_omap_start_request() doesn't like to be called
   with IRQs blocked ... but, hmm, looks like LOCKDEP forces
   IRQF_DISABLED on, and it breaks *this* MMC driver too.
   (I guess I'll work around by taking MMC out of the build.)

More later...

- Dave



NOTE:  there's no MMC card inserted here.

<7>mmc0: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 21 width 0 timing 0
<7>mmc0: clock 400000Hz busmode 1 powermode 2 cs 1 Vdd 21 width 0 timing 0
<7>mmc0: starting CMD0 arg 00000000 flags 000000c0
<7>mmci-omap mmci-omap.0: MMC IRQ 0001 (CMD 0): EOC
<7>mmc0: req done (CMD0): 0: 00000000 00000000 00000000 00000000
<7>mmc0: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 21 width 0 timing 0
<7>mmc0: starting CMD8 arg 000001aa flags 000002f5
<7>mmci-omap mmci-omap.0: MMC IRQ 0080 (CMD 8): CTO
<7>mmc0: req done (CMD8): -110: 00000000 00000000 00000000 00000000
<7>mmc0: starting CMD5 arg 00000000 flags 000002e1
<7>mmci-omap mmci-omap.0: MMC IRQ 0080 (CMD 5): CTO
<7>mmc0: req failed (CMD5): -110, retrying...
<2>kernel BUG at drivers/mmc/host/omap.c:1159!
kernel BUG at drivers/mmc/host/omap.c:1159!
<1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
Unable to handle kernel NULL pointer dereference at virtual address 00000000
<1>pgd = c0004000
pgd = c0004000
<1>[00000000] *pgd=00000000[00000000] *pgd=00000000

Internal error: Oops: 805 [#1]
Internal error: Oops: 805 [#1]
Modules linked in:Modules linked in:

CPU: 0    Not tainted  (2.6.28-rc2-omap1 #1)
CPU: 0    Not tainted  (2.6.28-rc2-omap1 #1)
PC is at __bug+0x20/0x2c
PC is at __bug+0x20/0x2c
LR is at vprintk+0x2f0/0x338
LR is at vprintk+0x2f0/0x338
pc : [<c0029454>]    lr : [<c00451cc>]    psr: 60000193
sp : c02ede08  ip : c02edd7c  fp : c02ede14
pc : [<c0029454>]    lr : [<c00451cc>]    psr: 60000193
sp : c02ede08  ip : c02edd7c  fp : c02ede14
r10: 00000005  r9 : c38c3ec0  r8 : c38c3ec0
r10: 00000005  r9 : c38c3ec0  r8 : c38c3ec0
r7 : c39be58c  r6 : 00000000  r5 : c3a06000  r4 : c3a06000
r7 : c39be58c  r6 : 00000000  r5 : c3a06000  r4 : c3a06000
r3 : 00000000  r2 : 20000193  r1 : c02ef844  r0 : 0000002f
r3 : 00000000  r2 : 20000193  r1 : c02ef844  r0 : 0000002f
Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 00c5387f  Table: 80004000  DAC: 00000017
Control: 00c5387f  Table: 80004000  DAC: 00000017
Process swapper (pid: 0, stack limit = 0xc02ec258)
Process swapper (pid: 0, stack limit = 0xc02ec258)
Stack: (0xc02ede08 to 0xc02ee000)
Stack: (0xc02ede08 to 0xc02ee000)
de00: de00:                                     c02ede48 c02ede48 c02ede18 c02ede18 c01c93bc c01c93bc c0029440 c0029440 c02ede24 c02ede24 c0065644 c0065644 

de20: de20: c3a06000 c3a06000 c3a06148 c3a06148 c39be88c c39be88c c39be58c c39be58c c38c3ec0 c38c3ec0 00000001 00000001 00000005 00000005 c02ede6c c02ede6c 

de40: de40: c02ede4c c02ede4c c01c9478 c01c9478 c01c90b8 c01c90b8 c38c3ef4 c38c3ef4 c39be58c c39be58c ffffff92 ffffff92 c38c3ec0 c38c3ec0 00000001 00000001 

de60: de60: c02ede9c c02ede9c c02ede70 c02ede70 c01c1a20 c01c1a20 c01c9400 c01c9400 c3a06148 c3a06148 c02ede9c c02ede9c c02ede84 c02ede84 c01c8b00 c01c8b00 

de80: de80: c39be58c c39be58c c38c3ef4 c38c3ef4 00000001 00000001 00000000 00000000 c02edeb4 c02edeb4 c02edea0 c02edea0 c01c8f04 c01c8f04 c01c199c c01c199c 

dea0: dea0: c3a06000 c3a06000 0000000f 0000000f c02edeec c02edeec c02edeb8 c02edeb8 c01c9bb8 c01c9bb8 c01c8e1c c01c8e1c 00000005 00000005 00000000 00000000 

dec0: dec0: 00000000 00000000 c39ad5a4 c39ad5a4 00000000 00000000 00000000 00000000 00000053 00000053 8001def8 8001def8 4107b362 4107b362 8001dec4 8001dec4 

dee0: dee0: c02edf0c c02edf0c c02edef0 c02edef0 c006f80c c006f80c c01c97ec c01c97ec c02fd898 c02fd898 00000053 00000053 c39ad5a4 c39ad5a4 c02fd8cc c02fd8cc 

df00: df00: c02edf2c c02edf2c c02edf10 c02edf10 c0070fa4 c0070fa4 c006f7ec c006f7ec 00000053 00000053 00000000 00000000 c001fd94 c001fd94 c02f0a0c c02f0a0c 

df20: df20: c02edf44 c02edf44 c02edf30 c02edf30 c0025064 c0025064 c0070efc c0070efc ffffffff ffffffff d80fe000 d80fe000 c02edfac c02edfac c02edf48 c02edf48 

df40: df40: c00259c8 c00259c8 c002500c c002500c 00000001 00000001 c02ef844 c02ef844 c02ef844 c02ef844 00002e65 00002e65 c0030e68 c0030e68 c02ec000 c02ec000 

df60: df60: c001fd94 c001fd94 c02f0a0c c02f0a0c 8001def8 8001def8 4107b362 4107b362 8001dec4 8001dec4 c02edfac c02edfac c02edf64 c02edf64 c02edf90 c02edf90 

df80: df80: c0066ef4 c0066ef4 c0031010 c0031010 20000013 20000013 ffffffff ffffffff c02f0a0c c02f0a0c 8001def8 8001def8 c0030e68 c0030e68 c02ec000 c02ec000 

dfa0: dfa0: c02edfc4 c02edfc4 c02edfb0 c02edfb0 c0026d40 c0026d40 c0030e74 c0030e74 c06b4950 c06b4950 c001fd98 c001fd98 c02edfd4 c02edfd4 c02edfc8 c02edfc8 

dfc0: dfc0: c023f818 c023f818 c0026d0c c0026d0c c02edff4 c02edff4 c02edfd8 c02edfd8 c0008abc c0008abc c023f7cc c023f7cc c000860c c000860c c001fd98 c001fd98 

dfe0: dfe0: 00c5387d 00c5387d c03147cc c03147cc 00000000 00000000 c02edff8 c02edff8 80008034 80008034 c000889c c000889c 00000000 00000000 00000000 00000000 

Backtrace: Backtrace: 

[<c0029434>] [<c0029434>] (__bug+0x0/0x2c) (__bug+0x0/0x2c) from [<c01c93bc>] from [<c01c93bc>] (mmc_omap_start_request+0x310/0x348)
(mmc_omap_start_request+0x310/0x348)
[<c01c90ac>] [<c01c90ac>] (mmc_omap_start_request+0x0/0x348) (mmc_omap_start_request+0x0/0x348) from [<c01c9478>] from [<c01c9478>] (mmc_omap_request+0x84/0x90)
(mmc_omap_request+0x84/0x90)
[<c01c93f4>] [<c01c93f4>] (mmc_omap_request+0x0/0x90) (mmc_omap_request+0x0/0x90) from [<c01c1a20>] from [<c01c1a20>] (mmc_request_done+0x90/0x178)
(mmc_request_done+0x90/0x178)
 r8:00000001 r8:00000001 r7:c38c3ec0 r7:c38c3ec0 r6:ffffff92 r6:ffffff92 r5:c39be58c r5:c39be58c r4:c38c3ef4 r4:c38c3ef4

[<c01c1990>] [<c01c1990>] (mmc_request_done+0x0/0x178) (mmc_request_done+0x0/0x178) from [<c01c8f04>] from [<c01c8f04>] (mmc_omap_cmd_done+0xf4/0xfc)
(mmc_omap_cmd_done+0xf4/0xfc)
 r7:00000000 r7:00000000 r6:00000001 r6:00000001 r5:c38c3ef4 r5:c38c3ef4 r4:c39be58c r4:c39be58c

[<c01c8e10>] [<c01c8e10>] (mmc_omap_cmd_done+0x0/0xfc) (mmc_omap_cmd_done+0x0/0xfc) from [<c01c9bb8>] from [<c01c9bb8>] (mmc_omap_irq+0x3d8/0x490)
(mmc_omap_irq+0x3d8/0x490)
 r5:0000000f r5:0000000f r4:c3a06000 r4:c3a06000

[<c01c97e0>] [<c01c97e0>] (mmc_omap_irq+0x0/0x490) (mmc_omap_irq+0x0/0x490) from [<c006f80c>] from [<c006f80c>] (handle_IRQ_event+0x2c/0x68)
(handle_IRQ_event+0x2c/0x68)
[<c006f7e0>] [<c006f7e0>] (handle_IRQ_event+0x0/0x68) (handle_IRQ_event+0x0/0x68) from [<c0070fa4>] from [<c0070fa4>] (handle_level_irq+0xb4/0x11c)
(handle_level_irq+0xb4/0x11c)
 r7:c02fd8cc r7:c02fd8cc r6:c39ad5a4 r6:c39ad5a4 r5:00000053 r5:00000053 r4:c02fd898 r4:c02fd898

[<c0070ef0>] [<c0070ef0>] (handle_level_irq+0x0/0x11c) (handle_level_irq+0x0/0x11c) from [<c0025064>] from [<c0025064>] (__exception_text_start+0x64/0x84)
(__exception_text_start+0x64/0x84)
 r7:c02f0a0c r7:c02f0a0c r6:c001fd94 r6:c001fd94 r5:00000000 r5:00000000 r4:00000053 r4:00000053

[<c0025000>] [<c0025000>] (__exception_text_start+0x0/0x84) (__exception_text_start+0x0/0x84) from [<c00259c8>] from [<c00259c8>] (__irq_svc+0x28/0x80)
(__irq_svc+0x28/0x80)
Exception stack(0xc02edf48 to 0xc02edf90)
Exception stack(0xc02edf48 to 0xc02edf90)
df40: df40:                                     00000001 00000001 c02ef844 c02ef844 c02ef844 c02ef844 00002e65 00002e65 c0030e68 c0030e68 c02ec000 c02ec000 

df60: df60: c001fd94 c001fd94 c02f0a0c c02f0a0c 8001def8 8001def8 4107b362 4107b362 8001dec4 8001dec4 c02edfac c02edfac c02edf64 c02edf64 c02edf90 c02edf90 

df80: df80: c0066ef4 c0066ef4 c0031010 c0031010 20000013 20000013 ffffffff ffffffff                                                                         

 r5:d80fe000 r5:d80fe000 r4:ffffffff r4:ffffffff

[<c0030e68>] [<c0030e68>] (omap2_pm_idle+0x0/0x230) (omap2_pm_idle+0x0/0x230) from [<c0026d40>] from [<c0026d40>] (cpu_idle+0x40/0x60)
(cpu_idle+0x40/0x60)
 r5:c02ec000 r5:c02ec000 r4:c0030e68 r4:c0030e68

[<c0026d00>] [<c0026d00>] (cpu_idle+0x0/0x60) (cpu_idle+0x0/0x60) from [<c023f818>] from [<c023f818>] (rest_init+0x58/0x6c)
(rest_init+0x58/0x6c)
 r5:c001fd98 r5:c001fd98 r4:c06b4950 r4:c06b4950

[<c023f7c0>] [<c023f7c0>] (rest_init+0x0/0x6c) (rest_init+0x0/0x6c) from [<c0008abc>] from [<c0008abc>] (start_kernel+0x22c/0x274)
(start_kernel+0x22c/0x274)
[<c0008890>] [<c0008890>] (start_kernel+0x0/0x274) (start_kernel+0x0/0x274) from [<80008034>] from [<80008034>] (0x80008034)
(0x80008034)
 r5:c03147cc r5:c03147cc r4:00c5387d r4:00c5387d

Code: Code: e1a01000 e1a01000 e59f000c e59f000c eb085c1a eb085c1a e3a03000 e3a03000 (e5833000) (e5833000) 

<0>Kernel panic - not syncing: Fatal exception in interrupt
Kernel panic - not syncing: Fatal exception in interrupt
