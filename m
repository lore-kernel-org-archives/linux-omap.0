From: Michael Welling <mwelling@ieee.org>
Subject: Re: linux 4.2-rc1 broken Nokia N900
Date: Tue, 21 Jul 2015 16:28:52 -0500
Message-ID: <20150721212852.GA29640@deathstar>
References: <201507111405.06048@pali>
 <201507132234.22082@pali>
 <20150713215232.GA22584@deathray>
 <201507140002.44119@pali>
 <20150713223607.GA23001@deathray>
 <20150714071412.GA12844@pali>
 <20150720204647.GA11931@deathstar>
 <20150721093441.GA23241@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150721093441.GA23241@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 21, 2015 at 11:34:41AM +0200, Pavel Machek wrote:
> Actually.. for the record I'm _not_ using modules. So either I hit
> something different, or problem happens regardless of modules.
> 									Pavel

I was able to reproduce the error by using my Beagleboard.

I added a registration for the tsc2005 and built the driver as a module.

[    4.318878] Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa09802c
[    4.326934] pgd = cf114000
[    4.329742] [fa09802c] *pgd=48011452(bad)
[    4.333953] Internal error: : 1028 [#1] PREEMPT ARM
[    4.339050] Modules linked in: tsc2005(+) twl4030_wdt(+) rtc_twl(+) omap_ssi hsi
[    4.346832] CPU: 0 PID: 74 Comm: udevd Not tainted 4.2.0-rc3+ #2
[    4.353118] Hardware name: Generic OMAP3-GP (Flattened Device Tree)
[    4.359680] task: cf0a8f00 ti: cf112000 task.ti: cf112000
[    4.365356] PC is at omap2_mcspi_set_cs+0x3c/0x44
[    4.370269] LR is at spi_setup+0xd4/0x10c
[    4.374450] pc : [<c0328b5c>]    lr : [<c0326a6c>]    psr: 200f0113
[    4.374450] sp : cf113d48  ip : 00000001  fp : 00000fff
[    4.386474] r10: cf31ffe4  r9 : 00000000  r8 : 00000008
[    4.391937] r7 : 00000fff  r6 : 00000000  r5 : 00000000  r4 : cfbdbe00
[    4.398773] r3 : 200103dc  r2 : fa098000  r1 : 00000001  r0 : cfbdbe00
[    4.405578] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
[    4.413055] Control: 10c5387d  Table: 8f114019  DAC: 00000015
[    4.419067] Process udevd (pid: 74, stack limit = 0xcf112210)
[    4.425079] Stack: (0xcf113d48 to 0xcf114000)
[    4.429626] 3d40:                   cfbdbe00 cfbdbe00 cfce7ab8 bf017ac8 cfbdd5a0 c015dc08
[    4.438201] 3d60: cf352190 00000000 00000fff 00000004 00000008 00000002 00000118 00001f40
[    4.446746] 3d80: 00000001 bf0183cc cfbdbe00 00000000 bf0183dc 00000008 00000001 cf31ffe4
[    4.455322] 3da0: cf31ffc8 c0326458 c0326408 cfbdbe00 c073e81c c02e7ca0 cfbdbe00 cfbdbe34
[    4.463867] 3dc0: bf0183dc c06e8254 c06aefe0 c02e7e6c 00000000 bf0183dc c02e7e04 c02e6530
[    4.472442] 3de0: cf964c4c cfbd89b0 bf0183dc 00000000 cf322200 c02e74e8 bf01830f bf018310
[    4.480987] 3e00: 00000000 bf0183dc bf01a000 00000000 c06aefe0 c02e8904 00000000 cf353080
[    4.489562] 3e20: bf01a000 c0009640 cf978000 00000001 00000000 00000000 00000001 00000000
[    4.498107] 3e40: cf07c008 00150013 cf07c000 600f0113 c06db824 c06db824 cfedf9c0 0040003f
[    4.506683] 3e60: cfedf9c0 00150013 cfcf9000 00080000 cf801f00 000000d0 bf018440 bf018440
[    4.515228] 3e80: 00000001 cf353040 bf018488 cf31ffc0 00000001 c046c4b8 bf018440 c06ffb90
[    4.523803] 3ea0: cf113f58 00000001 bf018440 c00875b0 bf01844c 00007fff 00000000 c0084f8c
[    4.532348] 3ec0: c0084b28 bf018614 bf018640 00000000 00026d29 d09c503c b6f0aec0 c0084c60
[    4.540924] 3ee0: d09a8000 00026d29 000003e9 00000000 0b300002 00000000 00000000 00000000
[    4.549468] 3f00: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    4.558044] 3f20: 00000000 00000000 00000000 00000000 00000138 00000000 b6f0aec0 00000005
[    4.566589] 3f40: 0000017b c000ebc4 cf112000 00000000 bef58e70 c0087bec d09a8000 00026d29
[    4.575134] 3f60: d09c4934 d09c4764 d09ce71c 00001640 000019e0 00000000 00000000 00000000
[    4.583709] 3f80: 0000002d 0000002e 00000017 00000014 00000012 00000000 00000000 0004a898
[    4.592254] 3fa0: 00000000 c000ea40 00000000 0004a898 00000005 b6f0aec0 00000000 00020000
[    4.600830] 3fc0: 00000000 0004a898 00000000 0000017b 00000000 0004a898 0004aa30 bef58e70
[    4.609374] 3fe0: bef58d98 bef58d88 b6f0399c b6e93ed0 60070010 00000005 00000000 00000000
[    4.617950] [<c0328b5c>] (omap2_mcspi_set_cs) from [<c0326a6c>] (spi_setup+0xd4/0x10c)
[    4.626281] [<c0326a6c>] (spi_setup) from [<bf017ac8>] (tsc2005_probe+0x108/0x5d4 [tsc2005])
[    4.635131] [<bf017ac8>] (tsc2005_probe [tsc2005]) from [<c0326458>] (spi_drv_probe+0x50/0x6c)
[    4.644165] [<c0326458>] (spi_drv_probe) from [<c02e7ca0>] (driver_probe_device+0xf4/0x258)
[    4.652893] [<c02e7ca0>] (driver_probe_device) from [<c02e7e6c>] (__driver_attach+0x68/0x8c)
[    4.661743] [<c02e7e6c>] (__driver_attach) from [<c02e6530>] (bus_for_each_dev+0x6c/0x90)
[    4.670318] [<c02e6530>] (bus_for_each_dev) from [<c02e74e8>] (bus_add_driver+0xcc/0x1e4)
[    4.678863] [<c02e74e8>] (bus_add_driver) from [<c02e8904>] (driver_register+0x9c/0xe0)
[    4.687255] [<c02e8904>] (driver_register) from [<c0009640>] (do_one_initcall+0x100/0x1b0)
[    4.695922] [<c0009640>] (do_one_initcall) from [<c046c4b8>] (do_init_module+0x58/0x1c0)
[    4.704406] [<c046c4b8>] (do_init_module) from [<c00875b0>] (load_module+0x16ac/0x1b64)
[    4.712799] [<c00875b0>] (load_module) from [<c0087bec>] (SyS_finit_module+0x60/0x68)
[    4.721008] [<c0087bec>] (SyS_finit_module) from [<c000ea40>] (ret_fast_syscall+0x0/0x3c)
[    4.729553] Code: e5823018 e5902188 e5922000 e582302c (e592302c) 
[    4.735961] ---[ end trace 375298308353557f ]---

Now to figure out why this is happening.

> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
