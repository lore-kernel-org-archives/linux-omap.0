From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: 3.18.1->3.19-rc2: In-band Error seen by MPU
Date: Sat, 3 Jan 2015 00:34:51 +0200
Message-ID: <20150102223451.GL582@fuloong-minipc.musicnaut.iki.fi>
References: <54A58E23.5080103@gmx.net>
 <20150101182053.GG582@fuloong-minipc.musicnaut.iki.fi>
 <20150102161911.GA3298@atomide.com>
 <54A6E408.1090908@gmx.net>
 <20150102201908.GK582@fuloong-minipc.musicnaut.iki.fi>
 <20150102204018.GF3298@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:49534 "EHLO
	filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752197AbbABWfA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Jan 2015 17:35:00 -0500
Content-Disposition: inline
In-Reply-To: <20150102204018.GF3298@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Peter =?iso-8859-1?Q?K=FCmmel?= <syntheticpp@gmx.net>, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Russell King <rmk+kernel@arm.linux.org.uk>, Santosh Shilimkar <ssantosh@kernel.org>

Hi,

On Fri, Jan 02, 2015 at 12:40:19PM -0800, Tony Lindgren wrote:
> * Aaro Koskinen <aaro.koskinen@iki.fi> [150102 12:21]:
> > On Fri, Jan 02, 2015 at 07:31:36PM +0100, Peter K=FCmmel wrote:
> > > Am 02.01.2015 um 17:19 schrieb Tony Lindgren:
> > > >* Aaro Koskinen <aaro.koskinen@iki.fi> [150101 10:23]:
> > > >>On Thu, Jan 01, 2015 at 07:12:51PM +0100, Peter K=FCmmel wrote:
> > > >>>When updating (custom DM3730 board) from 3.18.1 ro 3.19-rc2
> > > >>>I see a "In-band ERROR" warning which wasn't present in 3.18.1=
=2E
> > > >>>Could it be that I missed some DT updates?
> > > >>
> > > >>>[    0.366882] In-band Error seen by MPU  at address 0
> > > >>>[    0.366912] ------------[ cut here ]------------
> > > >>>[    0.366943] WARNING: CPU: 0 PID: 1 at drivers/bus/omap_l3_s=
mx.c:166 omap3_l3_app_irq+0x100/0x134()
> > > >>
> > > >>This appears also on N900/N950/N9...
> > > >
> > > >Do you have CONFIG_PREEMPT enabled? It seems there's some
> > > >regression related to CONFIG_PREEMPT that started happening
> > > >with the merge window?
> > >=20
> > > Indeed, when I disable CONFIG_PREEMPT the warning is gone.
> >=20
> > Yeah, disabling CONFIG_PREEMPT helps here too. Is there some e-mail
> > thread / patch set for this already; or should we try to bisect thi=
s?
>=20
> AFAIK I'm not aware of other threads, I noticied it with the
> "OMAP 4430 SDP: rather sick with recent kernels" thread, but
> never got anywhere with it.
>=20
> Yeah it seems it's somewhere between v3.18 and v3.19-rc1, but
> that too should be verified. Sounds like running git bisect on
> this one is needed.

I tried to bisect this on N950, and it resulted in:

aa25729cfd9709156661bea0f9293deb7729f57a is the first bad commit
commit aa25729cfd9709156661bea0f9293deb7729f57a
Author: Tony Lindgren <tony@atomide.com>
Date:   Wed Nov 5 09:21:23 2014 -0800

    ARM: OMAP3: Fix errors for omap_l3_smx when booted with device tree

But when I tried to revert this from 3.19-rc2, my board won't boot at
all...

A.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
