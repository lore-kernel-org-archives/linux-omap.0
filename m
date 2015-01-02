From: Tony Lindgren <tony@atomide.com>
Subject: Re: 3.18.1->3.19-rc2: In-band Error seen by MPU
Date: Fri, 2 Jan 2015 12:40:19 -0800
Message-ID: <20150102204018.GF3298@atomide.com>
References: <54A58E23.5080103@gmx.net>
 <20150101182053.GG582@fuloong-minipc.musicnaut.iki.fi>
 <20150102161911.GA3298@atomide.com>
 <54A6E408.1090908@gmx.net>
 <20150102201908.GK582@fuloong-minipc.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:45325 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751888AbbABUnx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Jan 2015 15:43:53 -0500
Content-Disposition: inline
In-Reply-To: <20150102201908.GK582@fuloong-minipc.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Peter =?utf-8?Q?K=C3=BCmmel?= <syntheticpp@gmx.net>, linux-omap@vger.kernel.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [150102 12:21]:
> Hi,
>=20
> On Fri, Jan 02, 2015 at 07:31:36PM +0100, Peter K=C3=BCmmel wrote:
> > Am 02.01.2015 um 17:19 schrieb Tony Lindgren:
> > >* Aaro Koskinen <aaro.koskinen@iki.fi> [150101 10:23]:
> > >>On Thu, Jan 01, 2015 at 07:12:51PM +0100, Peter K=C3=BCmmel wrote=
:
> > >>>When updating (custom DM3730 board) from 3.18.1 ro 3.19-rc2
> > >>>I see a "In-band ERROR" warning which wasn't present in 3.18.1.
> > >>>Could it be that I missed some DT updates?
> > >>
> > >>>[    0.366882] In-band Error seen by MPU  at address 0
> > >>>[    0.366912] ------------[ cut here ]------------
> > >>>[    0.366943] WARNING: CPU: 0 PID: 1 at drivers/bus/omap_l3_smx=
=2Ec:166 omap3_l3_app_irq+0x100/0x134()
> > >>
> > >>This appears also on N900/N950/N9...
> > >
> > >Do you have CONFIG_PREEMPT enabled? It seems there's some
> > >regression related to CONFIG_PREEMPT that started happening
> > >with the merge window?
> >=20
> > Indeed, when I disable CONFIG_PREEMPT the warning is gone.
>=20
> Yeah, disabling CONFIG_PREEMPT helps here too. Is there some e-mail
> thread / patch set for this already; or should we try to bisect this?

AFAIK I'm not aware of other threads, I noticied it with the
"OMAP 4430 SDP: rather sick with recent kernels" thread, but
never got anywhere with it.

Yeah it seems it's somewhere between v3.18 and v3.19-rc1, but
that too should be verified. Sounds like running git bisect on
this one is needed.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
