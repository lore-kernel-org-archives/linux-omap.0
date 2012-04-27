From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Audio support on OMAP 3430LDP or 4430SDP boards
Date: Fri, 27 Apr 2012 17:50:32 +0100
Message-ID: <20120427165032.GD28062@n2100.arm.linux.org.uk>
References: <20120427135802.GA28062@n2100.arm.linux.org.uk> <CAPo=G1ze3Yfr5FyQG_nByT3b5k=+Ux+6aupg=dD1Qe-Zx1RiqQ@mail.gmail.com> <20120427160445.GC28062@n2100.arm.linux.org.uk> <CAPo=G1xJj_mJAETqtxWdugYhP0LV=0XrMLeFGtkOBJZAi3Jy1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42536 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760451Ab2D0Qum (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Apr 2012 12:50:42 -0400
Content-Disposition: inline
In-Reply-To: <CAPo=G1xJj_mJAETqtxWdugYhP0LV=0XrMLeFGtkOBJZAi3Jy1A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Liam Girdwood <lrg@ti.com>

On Fri, Apr 27, 2012 at 07:32:42PM +0300, Ujfalusi, Peter wrote:
> On Fri, Apr 27, 2012 at 7:04 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > Right, so the only platform I have out of that (as I said above) is
> > SDP4430.
> >
> > And as I've already said, it does *not* appear to support any audio
> > of any kind:
> >
> > root@omap-4430sdp:~# insmod snd-soc-twl6040.ko
> > root@omap-4430sdp:~# insmod snd-soc-omap.ko
> > root@omap-4430sdp:~# insmod snd-soc-omap-mcpdm.ko
> > root@omap-4430sdp:~# insmod snd-soc-omap-abe-twl6040.ko
> > root@omap-4430sdp:~# cat /proc/asound/cards
> > --- no soundcards ---
>
> You need to load the DMIC driver as well:
> insmod snd-soc-omap-dmic.ko

You must be joking...

root@omap-4430sdp:~# insmod snd-soc-twl6040.ko
root@omap-4430sdp:~# insmod snd-soc-omap.ko
root@omap-4430sdp:~# insmod snd-soc-omap-mcpdm.ko
root@omap-4430sdp:~# insmod snd-soc-omap-abe-twl6040.ko
root@omap-4430sdp:~# insmod snd-soc-omap-dmic.ko
root@omap-4430sdp:~# cat /proc/asound/cards
--- no soundcards ---

And...

root@omap-4430sdp:~# rmmod snd_soc_omap_abe_twl6040
root@omap-4430sdp:~# insmod snd-soc-omap-abe-twl6040.ko
omap-abe-twl6040 omap-abe-twl6040: ASoC: Failed to create card debugfs directory
root@omap-4430sdp:~# cat /sys/kernel/debug/asoc/SDP4430/dapm_pop_time
Unable to handle kernel paging request at virtual address bf011e7c
pgd = def1c000
[bf011e7c] *pgd=9f511811, *pte=00000000, *ppte=00000000
Internal error: Oops: 7 [#1] SMP ARM
Modules linked in: snd_soc_omap_abe_twl6040 snd_soc_omap_dmic snd_soc_omap_mcpdm
 snd_soc_twl6040 snd_soc_omap [last unloaded: snd_soc_omap_abe_twl6040]
CPU: 1    Not tainted  (3.4.0-rc3+ #380)
PC is at debugfs_u32_get+0xc/0x20
LR is at simple_attr_read+0x70/0xc4
pc : [<c015fda0>]    lr : [<c00d65e0>]    psr: 60000113
sp : df4f3ef8  ip : df4f3f08  fp : df4f3f04
r10: 00001000  r9 : df4f2000  r8 : be8b5be0
r7 : df53e440  r6 : df4f3f70  r5 : df53e400  r4 : 00000000
r3 : 00000000  r2 : 00000000  r1 : df4f3f10  r0 : bf011e7c
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 10c5387d  Table: 9ef1c04a  DAC: 00000015
Process cat (pid: 1494, stack limit = 0xdf4f22f0)
Stack: (0xdf4f3ef8 to 0xdf4f4000)
3ee0:                                                       df4f3f3c df4f3f08
3f00: c00d65e0 c015fda0 00000001 df532f08 df4f3f44 df4f3f20 df532f00 00001000
3f20: be8b5be0 df4f3f70 00001000 00000000 df4f3f6c df4f3f40 c00b59a4 c00d657c
3f40: df4f2000 def5e000 df4f3f94 00000000 00000000 df532f00 be8b5be0 00001000
3f60: df4f3fa4 df4f3f70 c00b5af4 c00b58fc 00000000 00000000 be8b6ef1 00000000
3f80: c0014068 b6fe7880 00000003 be8b5be0 00000003 c0014068 00000000 df4f3fa8
3fa0: c0013ec0 c00b5abc b6fe7880 00000003 00000003 be8b5be0 00001000 00098728
3fc0: b6fe7880 00000003 be8b5be0 00000003 00000000 00000000 00000003 be8b5bd4
3fe0: 00001000 be8b5bc0 00013140 b6e8da2c 60000110 00000003 4ddc5d55 75f55179
Backtrace:
[<c015fd94>] (debugfs_u32_get+0x0/0x20) from [<c00d65e0>] (simple_attr_read+0x70/0xc4)
[<c00d6570>] (simple_attr_read+0x0/0xc4) from [<c00b59a4>] (vfs_read+0xb4/0x140)
[<c00b58f0>] (vfs_read+0x0/0x140) from [<c00b5af4>] (sys_read+0x44/0x70)
 r8:00001000 r7:be8b5be0 r6:df532f00 r5:00000000 r4:00000000
[<c00b5ab0>] (sys_read+0x0/0x70) from [<c0013ec0>] (ret_fast_syscall+0x0/0x30)
 r8:c0014068 r7:00000003 r6:be8b5be0 r5:00000003 r4:b6fe7880
Code: e89da800 e1a0c00d e92dd800 e24cb004 (e5903000)
---[ end trace ba2e3db072bb311d ]---
Segmentation fault
root@omap-4430sdp:~#

That seems to be because of an error in the ASoC design.  ASoC only
tears down the resources after a card has been fully instantiated.
If it's been partially instantiated, let's not bother and leave
everything registered with all the various subsystems...

Sorry, I'm shelving this until someone reports that OMAP has some
meaningful working audio support.  At the moment, I'm entirely
unconvinced that any of this stuff has been tested as working.
