From: Tony Lindgren <tony@atomide.com>
Subject: Re: linux-omap git tree updated to v2.6.32-rc1, important changes,
	please read
Date: Tue, 29 Sep 2009 12:30:08 -0700
Message-ID: <20090929193007.GD16865@atomide.com>
References: <20090928190404.GE18957@atomide.com> <94a0d4530909291024kcac6b20m727b2908b2a76b88@mail.gmail.com> <20090929182639.GA16865@atomide.com> <71a0d6ff0909291220ve586b41s7c75ff580f34cb95@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:64654 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753896AbZI2TaQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Sep 2009 15:30:16 -0400
Content-Disposition: inline
In-Reply-To: <71a0d6ff0909291220ve586b41s7c75ff580f34cb95@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alexander Shishkin <virtuoso@slind.org>
Cc: Felipe Contreras <felipe.contreras@gmail.com>, linux-omap@vger.kernel.org

* Alexander Shishkin <virtuoso@slind.org> [090929 12:20]:
> 2009/9/29 Tony Lindgren <tony@atomide.com>:
> > * Felipe Contreras <felipe.contreras@gmail.com> [090929 10:24]:
> >> On Mon, Sep 28, 2009 at 10:04 PM, Tony Lindgren <tony@atomide.com>=
 wrote:
> >> > Hi all,
> >> >
> >> > I've updated our linux-omap tree to v2.6.32-rc1. I've also
> >> > added a branch omap-2.6.31 for the old code.
> >> >
> >> > This time I also nuked the remaining omap legacy code we
> >> > still had lurking around :) The commits at the end of this
> >> > mail describe what I did first as commits, then I merged
> >> > everything to be the same as the mainline v2.6.32-rc1.
> >> >
> >> > So currently the linux-omap master branch is:
> >> >
> >> > v2.6.32-rc1 + omap-fixes + ehci + cbus
> >> >
> >> > The new model is that I'll be resetting the linux-omap master
> >> > branch to mainline at each -rc, then merge in our various
> >> > upstream queues back in again.
> >>
> >> Excellent! I was wondering why this wasn't being done. I certainly
> >> hope linus' 2.6.32 will work on omap right away.
> >
> > Yeah, let's hope Tomi gets in the DSS2 code too.
> >
> >> Anyway, I haven't been able to make 2.6.31 boot on beagleboard, an=
d
> >> other people report similar issues:
> >> http://www.spinics.net/lists/linux-omap/msg17968.html
> >>
> >> Have you got 2.6.32-rc1 (+fixes) to boot?
> >
> > Hmm, looks like it's musb again. This is what I get on my
> > overo after applying the DEBUG_LL hack from omap-debug branch:
> >
> > <3>musb_hdrc musb_hdrc: musb_init_controller failed with status -19
> > <1>Unable to handle kernel NULL pointer dereference at virtual addr=
ess 00000000
> > <1>pgd =3D c0004000
> > <1>[00000000] *pgd=3D00000000
> > Internal error: Oops: 5 [#1]
> > <d>Modules linked in:
> > CPU: 0 =A0 =A0Not tainted =A0(2.6.32-rc2-05967-gd350540-dirty #892)
> > PC is at musb_free+0x68/0xb8
> > LR is at musb_free+0x34/0xb8
> > pc : [<c028a160>] =A0 =A0lr : [<c028a12c>] =A0 =A0psr: a0000013
> > sp : c781fe50 =A0ip : 00000064 =A0fp : 00000000
> > r10: 00000000 =A0r9 : 00000000 =A0r8 : c0557bc0
> > r7 : c7811000 =A0r6 : c78110e8 =A0r5 : c78110e8 =A0r4 : 00000000
> > r3 : 00000000 =A0r2 : 00000001 =A0r1 : c04c95b6 =A0r0 : ffffffed
> > Flags: NzCv =A0IRQs on =A0FIQs on =A0Mode SVC_32 =A0ISA ARM =A0Segm=
ent kernel
> > Control: 10c5387d =A0Table: 80004019 =A0DAC: 00000017
> > Process swapper (pid: 1, stack limit =3D 0xc781e2f0)
> > Stack: (0xc781fe50 to 0xc7820000)
> > fe40: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 ffffffed 00000000 c78110e8 c001e8f8
> > fe60: c781fea4 c7804180 00000000 c7804184 c0533dc8 c0533dd0 0000005=
c d80ab000
> > fe80: c0533dac c7811190 00000000 c781fedc c0114ad8 c7806850 c054624=
8 c06d74e0
> > fea0: 00000000 c03cd5c8 00000000 c781ff00 c78b8de0 c0114cbc c78b8d8=
0 c781ff00
> > fec0: c78b8de0 c0114864 c78b8d80 c781ff00 c78b8de0 c011493c c781ff0=
0 c78b8de0
> > fee0: c78b8d80 00000000 c781ff00 c78b8de0 c787a210 00000001 0000000=
0 c01157b4
> > ff00: c787a210 00000000 00000000 c0533dd0 c0533dd0 c055df04 c787360=
0 c0557bc0
> > ff20: 00000000 00000000 00000000 c0210b7c c0533dd0 c020fbd4 c0533dd=
0 c0533e04
> > ff40: c055df04 c7873600 c0557bc0 c020fce0 00000000 c020fc80 c055df0=
4 c020f420
> > ff60: c7802d08 c787b240 c0026dd4 00000080 c055df04 c020ed38 c03f14f=
4 c03f14f4
> > ff80: c7820000 c0026dd4 c055def0 c055df04 00000000 00000000 0000000=
0 c020ffb0
> > ffa0: c0026dd4 c055def0 c001dca0 00000000 00000000 c0210f70 c0026dd=
4 00000000
> > ffc0: c001dca0 c002d2b4 00000031 00000000 00000000 00000192 0000000=
0 c0026dd4
> > ffe0: 00000000 00000000 00000000 c0008578 00000000 c002ee10 817fdf1=
0 00bbff00
> > [<c028a160>] (musb_free+0x68/0xb8) from [<c001e8f8>] (musb_probe+0x=
ab8/0xbb4)
> > [<c001e8f8>] (musb_probe+0xab8/0xbb4) from [<c0210b7c>] (platform_d=
rv_probe+0x1)
> > [<c0210b7c>] (platform_drv_probe+0x18/0x1c) from [<c020fbd4>] (driv=
er_probe_dev)
> > [<c020fbd4>] (driver_probe_device+0xa0/0x14c) from [<c020fce0>] (__=
driver_attac)
> > [<c020fce0>] (__driver_attach+0x60/0x84) from [<c020f420>] (bus_for=
_each_dev+0x)
> > [<c020f420>] (bus_for_each_dev+0x44/0x74) from [<c020ed38>] (bus_ad=
d_driver+0xf)
> > [<c020ed38>] (bus_add_driver+0xf4/0x278) from [<c020ffb0>] (driver_=
register+0xa)
> > [<c020ffb0>] (driver_register+0xa8/0x130) from [<c0210f70>] (platfo=
rm_driver_pr)
> > [<c0210f70>] (platform_driver_probe+0x10/0x88) from [<c002d2b4>] (d=
o_one_initca)
> > [<c002d2b4>] (do_one_initcall+0x5c/0x1b4) from [<c0008578>] (kernel=
_init+0x90/0)
> > [<c0008578>] (kernel_init+0x90/0x10c) from [<c002ee10>] (kernel_thr=
ead_exit+0x0)
> > Code: e1a01005 ebf80722 e595309c e3a04000 (e5930000)
> > <4>---[ end trace 1b75b31a2719ed1c ]---
> > <0>Kernel panic - not syncing: Attempted to kill init!
> >
> > After disabling musb, it boots further but can't mount root on the =
MMC:
> >
> > ...
> > <4>regulator_init_complete: incomplete constraints, leaving VUSB1V8=
 on
> > regulator_init_complete: incomplete constraints, leaving VUSB1V8 on
> > <4>regulator_init_complete: incomplete constraints, leaving VUSB1V5=
 on
> > regulator_init_complete: incomplete constraints, leaving VUSB1V5 on
> > <4>regulator_init_complete: incomplete constraints, leaving VMMC1 o=
n
> > regulator_init_complete: incomplete constraints, leaving VMMC1 on
> > <6>twl4030_rtc twl4030_rtc: setting system clock to 2000-01-01 00:0=
0:00 UTC (94)
> > twl4030_rtc twl4030_rtc: setting system clock to 2000-01-01 00:00:0=
0 UTC (94668)
> > <6>Waiting for root device /dev/mmcblk0p2...
> > Waiting for root device /dev/mmcblk0p2...
> >
> > What are you getting with DEBUG_LL enabled and the associated patch=
 applied
> > from omap-debug branch?
> MUSB enabled gives me the same backtrace. When I disable it, I get
> (this is beagle B6):
>=20
> <1>Unable to handle kernel NULL pointer dereference at virtual addres=
s 00000000
> <1>pgd =3D c0004000
> <1>[00000000] *pgd=3D00000000
> Internal error: Oops: 805 [#1]
> <d>Modules linked in:
> CPU: 0    Tainted: G        W   (2.6.32-rc2-05968-g11ddc16 #7)
> PC is at __mutex_lock_slowpath+0xe0/0x218
> LR is at __mutex_lock_slowpath+0xcc/0x218
> pc : [<c02967bc>]    lr : [<c02967a8>]    psr: 40000093
> sp : c7819e80  ip : 11111111  fp : c6d2e824
> r10: c6d2e800  r9 : c6d2e800  r8 : c7886c24
> r7 : c7817a40  r6 : 60000013  r5 : c7886c20  r4 : c7886c20
> r3 : 00000000  r2 : c7818000  r1 : c7819e80  r0 : c7886c20
> Flags: nZcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
> Control: 10c5387d  Table: 80004019  DAC: 00000017
> Process swapper (pid: 1, stack limit =3D 0xc78182e8)
> Stack: (0xc7819e80 to 0xc781a000)
> 9e80: c7886c24 00000000 11111111 c7819e80 c6d2fd00 c7886c20 c6d2e800 =
00000000
> 9ea0: c7886c20 c7886c00 c6d2e800 c6d2e800 c6d2e824 c0296900 c6d2e800 =
c0197afc
> 9ec0: c7886c00 00000000 c7886e68 00000000 c6d2e800 c0198f90 c6d369c8 =
00000000
> 9ee0: c7819f00 c6d36968 c7810518 69000001 7265746e 006c616e 00000000 =
00000000
> 9f00: c7810518 c0387d50 c0387d50 c03a0504 c03a0504 c03a4800 00000000 =
00000000
> 9f20: 00000000 c019b37c c0387d50 c01c009c c03a0504 c01bf0d4 00000000 =
c0387d50
> 9f40: c0387d84 c03a0504 c7819f60 c01bf204 00000000 c01bf1a4 c03a0504 =
c01be954
> 9f60: c7803af8 c7845970 c03a4800 c0022890 c03a0504 c03a0504 c6d30cc0 =
c01be1f8
> 9f80: c0315ab2 c00187a0 c6d30d40 c0022890 c0022948 c03a0504 00000000 =
00000000
> 9fa0: 00000000 c01bf508 c0022890 c0022948 c00187fc 00000000 00000000 =
c00272b4
> 9fc0: 00000000 00000192 c038ba20 00000000 00000000 c0022890 c0022948 =
00000000
> 9fe0: 00000000 c0008584 00000000 00000000 00000000 c0028d80 853bee50 =
007b4fa4
> [<c02967bc>] (__mutex_lock_slowpath+0xe0/0x218) from [<c0296900>]
> (mutex_lock+0xc/0x1c)
> [<c0296900>] (mutex_lock+0xc/0x1c) from [<c0197afc>]
> (set_fb_fix+0x30/0xbc)
> [<c0197afc>] (set_fb_fix+0x30/0xbc) from [<c0198f90>]
> (omapfb_do_probe+0x404/0x858)
> [<c0198f90>] (omapfb_do_probe+0x404/0x858) from [<c019b37c>]
> (omap3beagle_panel_probe+0x10/0x20)
> [<c019b37c>] (omap3beagle_panel_probe+0x10/0x20) from [<c01c009c>]
> (platform_drv_probe+0x1c/0x24)
> [<c01c009c>] (platform_drv_probe+0x1c/0x24) from [<c01bf0d4>]
> (driver_probe_device+0xa4/0x174)
> [<c01bf0d4>] (driver_probe_device+0xa4/0x174) from [<c01bf204>]
> (__driver_attach+0x60/0x84)
> [<c01bf204>] (__driver_attach+0x60/0x84) from [<c01be954>]
> (bus_for_each_dev+0x4c/0x8c)
> [<c01be954>] (bus_for_each_dev+0x4c/0x8c) from [<c01be1f8>]
> (bus_add_driver+0xa0/0x218)
> [<c01be1f8>] (bus_add_driver+0xa0/0x218) from [<c01bf508>]
> (driver_register+0xbc/0x148)
> [<c01bf508>] (driver_register+0xbc/0x148) from [<c00272b4>]
> (do_one_initcall+0x5c/0x1bc)
> [<c00272b4>] (do_one_initcall+0x5c/0x1bc) from [<c0008584>]
> (kernel_init+0x94/0x110)
> [<c0008584>] (kernel_init+0x94/0x110) from [<c0028d80>]
> (kernel_thread_exit+0x0/0x8)
> Code: e2858004 e585d008 e58d8000 e58d3004 (e583d000)
> <4>---[ end trace da227214a82491b8 ]---

Maybe try Sergio's "omapfb: Condition mutex acquisition" patch:

http://patchwork.kernel.org/patch/50551/

Does that help?

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
