From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/8] OMAP2+: hwmod/clockevent: allow late-init of individual
 hwmods
Date: Sun, 27 Feb 2011 19:31:47 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1102271928550.505@utopia.booyaka.com>
References: <20110223070455.5874.51326.stgit@twilight.localdomain> <4D651998.3040002@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-871082634-1298860307=:505"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40233 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752079Ab1B1Cbs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 27 Feb 2011 21:31:48 -0500
In-Reply-To: <4D651998.3040002@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Hilman, Kevin" <khilman@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Gopinath, Thara" <thara@ti.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-871082634-1298860307=:505
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Salut Beno=C3=AEt,

On Wed, 23 Feb 2011, Cousson, Benoit wrote:

> On 2/23/2011 8:11 AM, Paul Walmsley wrote:
> > This series adds the ability to late-initialize individual
> > hwmods.  The goal here is for clockevent (and eventually
> > clocksource) hwmods to be late-initialized individually, and
> > right before they are needed, in the timer init code.  Then
> > omap_hwmod_late_init(), which late-inits the rest of the hwmods,
> > is intended to run as an initcall -- much later in the boot
> > process.
> >=20
> > This series includes the OMAP2/3 hwmod data for the GPTIMERs that
> > Tarun posted earlier.  This data is necessary for this new code
> > to avoid warnings during boot.
> >=20
> > Boot-tested on N800, OMAP34xx Beagleboard and OMAP4430ES2 Panda.
>=20
> I'm testing it on 4430sdp, and I have the following warning:
>=20
> [    0.000000] omap_hwmod: dpll_mpu_m2_ck: missing clockdomain for dpll_m=
pu_m2_ck.
> [    0.000000] ------------[ cut here ]------------
> [    0.000000] WARNING: at arch/arm/mach-omap2/timer-gp.c:157 omap2_gp_ti=
mer_init+0x80/0x190()
> [    0.000000] timer-gp: omap_dm_timer_set_source() failed
> [    0.000000] Modules linked in:
> [    0.000000] [<c0062a6c>] (unwind_backtrace+0x0/0xec) from [<c009422c>]=
 (warn_slowpath_common+0x4c/0x64)
> [    0.000000] [<c009422c>] (warn_slowpath_common+0x4c/0x64) from [<c0094=
2c4>] (warn_slowpath_fmt+0x2c/0x3c)
> [    0.000000] [<c00942c4>] (warn_slowpath_fmt+0x2c/0x3c) from [<c0010e30=
>] (omap2_gp_timer_init+0x80/0x190)
> [    0.000000] [<c0010e30>] (omap2_gp_timer_init+0x80/0x190) from [<c000c=
0dc>] (time_init+0x20/0x30)
> [    0.000000] [<c000c0dc>] (time_init+0x20/0x30) from [<c0008cbc>] (star=
t_kernel+0x1a4/0x30c)
> [    0.000000] [<c0008cbc>] (start_kernel+0x1a4/0x30c) from [<80008038>] =
(0x80008038)
> [    0.000000] ---[ end trace 1b75b31a2719ed1c ]---
> [    0.000000] OMAP clockevent source: GPTIMER1 at 32768 Hz

This is due to commit 3b03b58dab847883e6b9a431558c7d8e43fa94c6 ("OMAP4:=20
hwmod data: Prevent timer1 to be reset and idle during init").  Could you=
=20
please try reverting this and see if the warning disappears?

Tony, I guess the omap-for-linus branch will probably need to get rebuilt=
=20
to drop that patch, once this series is merged...

- Paul
--155748971-871082634-1298860307=:505--
