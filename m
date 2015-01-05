From: Felipe Balbi <balbi@ti.com>
Subject: Re: 3.18.1->3.19-rc2: In-band Error seen by MPU
Date: Mon, 5 Jan 2015 09:43:13 -0600
Message-ID: <20150105154313.GA19336@saruman>
References: <54A58E23.5080103@gmx.net>
 <20150101182053.GG582@fuloong-minipc.musicnaut.iki.fi>
 <20150102161911.GA3298@atomide.com>
 <54A6E408.1090908@gmx.net>
 <20150102201908.GK582@fuloong-minipc.musicnaut.iki.fi>
 <20150102204018.GF3298@atomide.com>
 <20150102223451.GL582@fuloong-minipc.musicnaut.iki.fi>
 <20150103000220.GE3279@atomide.com>
 <20150103121622.GN582@fuloong-minipc.musicnaut.iki.fi>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58379 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752838AbbAEPoO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Jan 2015 10:44:14 -0500
Content-Disposition: inline
In-Reply-To: <20150103121622.GN582@fuloong-minipc.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, Peter =?iso-8859-1?Q?K=FCmmel?= <syntheticpp@gmx.net>, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Russell King <rmk+kernel@arm.linux.org.uk>, Santosh Shilimkar <ssantosh@kernel.org>

--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jan 03, 2015 at 02:16:22PM +0200, Aaro Koskinen wrote:
> > > > > > >>>When updating (custom DM3730 board) from 3.18.1 ro 3.19-rc2
> > > > > > >>>I see a "In-band ERROR" warning which wasn't present in 3.18=
=2E1.
> > > > > > >>>Could it be that I missed some DT updates?
> > > > > > >>
> > > > > > >>>[    0.366882] In-band Error seen by MPU  at address 0
> > > > > > >>>[    0.366912] ------------[ cut here ]------------
> > > > > > >>>[    0.366943] WARNING: CPU: 0 PID: 1 at drivers/bus/omap_l3=
_smx.c:166 omap3_l3_app_irq+0x100/0x134()
> > > > > > >>
> > > > > > >>This appears also on N900/N950/N9...
> > > > > > >
> > > > > > >Do you have CONFIG_PREEMPT enabled? It seems there's some
> > > > > > >regression related to CONFIG_PREEMPT that started happening
> > > > > > >with the merge window?
> > > > > >=20
> > > > > > Indeed, when I disable CONFIG_PREEMPT the warning is gone.
> > > > >=20
> > > > > Yeah, disabling CONFIG_PREEMPT helps here too. Is there some e-ma=
il
> > > > > thread / patch set for this already; or should we try to bisect t=
his?
> > > >=20
> > > > AFAIK I'm not aware of other threads, I noticied it with the
> > > > "OMAP 4430 SDP: rather sick with recent kernels" thread, but
> > > > never got anywhere with it.
> > > >=20
> > > > Yeah it seems it's somewhere between v3.18 and v3.19-rc1, but
> > > > that too should be verified. Sounds like running git bisect on
> > > > this one is needed.
> > >=20
> > > I tried to bisect this on N950, and it resulted in:
> > >=20
> > > aa25729cfd9709156661bea0f9293deb7729f57a is the first bad commit
> > > commit aa25729cfd9709156661bea0f9293deb7729f57a
> > > Author: Tony Lindgren <tony@atomide.com>
> > > Date:   Wed Nov 5 09:21:23 2014 -0800
> > >=20
> > >     ARM: OMAP3: Fix errors for omap_l3_smx when booted with device tr=
ee
> > >=20
> > > But when I tried to revert this from 3.19-rc2, my board won't boot at
> > > all...
> >=20
> > Hmm OK that commit just fixed the omap_l3_smx so we now see
> > warnings about the unclocked register access.
> >=20
> > It seems that probably the CONFIG_PREEMPT issue has been lurking
> > around for longer but we have not seen any errors because
> > omap_l3_smx just recently started exposing them.
> >=20
> > Does v3.18 + commit aa25729cfd9 manually applied also produce
> > the CONFIG_PREEMPT errors?
>=20
> Yes it does, so I made another bisection between 3.17 and 3.18
> using the above patch to trigger the issue, and I got:
>=20
> 55601c9f24670ba926ebdd4d712ac3b177232330 is the first bad commit
> commit 55601c9f24670ba926ebdd4d712ac3b177232330
> Author: Felipe Balbi <balbi@ti.com>
> Date:   Mon Sep 8 17:54:58 2014 -0700
>=20
>     arm: omap: intc: switch over to linear irq domain

Just booted AM335x with CONFIG_PREEMPT and haven't seen any problem.
Perhaps this is something related to another OMAP3-only driver ? Perhaps
HSI/SSI ?

cheers

--=20
balbi

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUqrERAAoJEIaOsuA1yqREh5kQAIvh+ATIytB+QWbTjyimsluF
gC2zNtdcNtELVqlEdAaqS64a/d7XmbCob+qHrwJNnRZT047SPxIPCqLuUjc0SRHG
J0GIht3wRtr40D4ghSyfw41jdoa6Ad3X5J12inMprX2DXO40OrB6/5ZH6tPi5thw
zuvADtnOlgnVoIqpp+obrO6JKfEHTfNyf2L9bKYO4dSFYrCuwBFmXA5yzPG9jdLw
q1wSIW15iFfjT5YDdCNAPRntZn0Q2i8vD0GEY/fZQCJ2428C1xZXHW9KVm/OTlCK
C70wOJEDhCi+3r5XIrG4A+U9Rsfe7heSLgWR7+LyO0tmqP/w65vSAK/y2Y0ZFHdN
+WYKtxIkAG02uftiqRQOCLOPWb4K2L5L0ymLgYdngo6RBzF9RFVTznnbouzu1IMF
Ggc0I0vmzR6SfXwV0C5mqsEvmkwUHlzPVe0vXa6r/RP8vEBs/MCQtyT0SJhoNfbQ
Tx1uJWQTtQcsV9yESQGDQZyMiEtAZfjntjYC2a3C0UUV38uUV4UfZDaqOl/N/GeX
ynKw2znkxj2UkhPeN52JVMc0egkRiZPkPGdxRFZ9vR4ysMJYiQNt9lF5HPLK+KOf
FSVhM2seZW7vEKPa2IhdXD+bvmK6zFEhTCtgJ/tFvjkkBO0sLeL6wv+DpRuN2BbX
5c3H5Kbly5wmkMWX3i5U
=vWkC
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
