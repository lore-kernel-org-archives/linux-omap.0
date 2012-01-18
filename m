From: NeilBrown <neilb@suse.de>
Subject: Re: DSS2/PM on 3.2 broken?
Date: Thu, 19 Jan 2012 07:30:32 +1100
Message-ID: <20120119073032.74cc0992@notabene.brown>
References: <WC20120109124643.880164@terrafix.co.uk>
	<20120110080849.5a242adf@notabene.brown>
	<alpine.DEB.2.00.1201110632100.31702@utopia.booyaka.com>
	<20120112095940.0a54413e@notabene.brown>
	<alpine.DEB.2.00.1201130253070.3659@utopia.booyaka.com>
	<20120113222045.37f9b4ec@notabene.brown>
	<1326870839.1954.23.camel@deskari>
	<20120118221538.342b4782@notabene.brown>
	<1326886940.1999.5.camel@lappy>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/rZ+3vNSkCEP8NqH5FS=Wc8M"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:51273 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757202Ab2ARUap (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Jan 2012 15:30:45 -0500
In-Reply-To: <1326886940.1999.5.camel@lappy>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Joe Woodward <jw@terrafix.co.uk>, khilman@ti.com, t-kristo@ti.com, govindraj.r@ti.com, linux-omap@vger.kernel.org

--Sig_/rZ+3vNSkCEP8NqH5FS=Wc8M
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 18 Jan 2012 13:42:20 +0200 Tomi Valkeinen <tomi.valkeinen@ti.com>
wrote:

> On Wed, 2012-01-18 at 22:15 +1100, NeilBrown wrote:
> > On Wed, 18 Jan 2012 09:13:59 +0200 Tomi Valkeinen <tomi.valkeinen@ti.co=
m>
> > wrote:
> >=20
> > > On Fri, 2012-01-13 at 22:20 +1100, NeilBrown wrote:
> > > > Having CPUIDLE makes the DSS2 problem worse: lots of=20
> > > >=20
> > > > [   21.085113] omapdss DISPC error: SYNC_LOST on channel lcd,
> > > > restarting the output with video overlays disabled
> > > >=20
> > > > messages whenever the CPU isn't busy.
> > >=20
> > > I'm not sure if it is the case here, but DSS has restrictions about t=
he
> > > max DSS clocks on different OPPs. For example, on OMAP4430 LCD clock
> > > maximum is 186MHz at OPP100, and 93MHz at OPP50. So it's a quite big
> > > drop, causing problems with all but the rather small displays.
> > >=20
> > > And the DSS driver doesn't have any support to handle this at the
> > > moment, as there isn't support in the PM framework to do this. I think
> > > the only way to handle this at the moment is for the DSS driver to set
> > > an arbitrarily high constraint on, say, mem throughput, and hope that=
 it
> > > keeps the OMAP in the required OPP.
> > >=20
> > >  Tomi
> > >=20
> >=20
> > This LCD panel on this device sets:
> >    .pixel_clock	=3D 22000,
> > in the "struct omap_video_timings" so I'm guessing that is 22MHz?
>=20
> No, that's the pixel clock. There are probably limitations on the pix
> clock also, but usually the problem is the functional clocks, which need
> to be n x pck, where n depends on the needs for scaling.

Ahh..

   cat /sys/kernel/debug/omapdss/clk

is below and reports 66461538 for fck, so 66MHz?  Still safe for OPP50.

And disabling SMART REFLEX had no obvious effect.

If you can think of anything else I could try to explore to narrow down=20
the source of this, I am very happy to test or examine anything you suggest.

Thanks,
NeilBrown



- DSS -
dpll4_ck 864000000
DSS_FCK (DSS1_ALWON_FCLK) =3D 864000000 / 13  =3D 66461538
- DISPC -
dispc fclk source =3D DSS_FCK (DSS1_ALWON_FCLK)
fck		66461538       =20
- LCD1 -
lcd1_clk source =3D DSS_FCK (DSS1_ALWON_FCLK)
lck		66461538        lck div	1
pck		22153846        pck div	3
- DSI1 PLL -
dsi pll source =3D pclkfree
Fint		0               regn 0
CLKIN4DDR	0               regm 0
DSS_FCK (DSS1_ALWON_FCLK)	0               regm_dispc 0	(off)
DSS_FCK (DSS1_ALWON_FCLK)	0               regm_dsi 0	(off)
- DSI1 -
dsi fclk source =3D DSS_FCK (DSS1_ALWON_FCLK)
DSI_FCLK	66461538
DDR_CLK		0
TxByteClkHS	0
LP_CLK		0



--Sig_/rZ+3vNSkCEP8NqH5FS=Wc8M
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIVAwUBTxcr6Dnsnt1WYoG5AQLgLBAAnyIh95Zk2sWK8fX2UheW4d0YQ1UHLnsH
KJRRazLXq5xe+Uu9naCGPb3j2guvwmESkX6u6L0xlxM6kjyBt+dwBzcfC1Tmmwm1
wUfTmTqGmIiBonffd+kaSpGZEwrScM+TbPIxtXElx/jzVoXaDeKP+YoXdgO1Gg7x
mUwF6J7mybjwskxw/jwEW59CYkuRV13FBj7yBxs3en6ArKy9sYAhtixYr4Qni3vV
VB+6v7uSuM9tWZX0vnFSsAMuRbLojQKqwZTIzRVgmfqSvgVap7QpyJcarXCnKpH7
Hng+EmtsYQXwzNsVDHGkTxT84AktjZ6HBPBO7MJuxSkAYKInWYEJsLJgj2l+gqn5
MqkGVEc45QDNGL/Wn18iKK9/Qw4vnwjDFb3Kp2tjVq2pzE3psuurL890elTKKMlE
NnUHprJk+6ZzqLkf+Wit1x6STJ/tcKRu40QAq0JXBTdI2oTlyMP1mjTktUk4nD2r
XSlexyEA91p+ee5N5bMM4IHm4mIMg2CaS87j6PmpySW8NuV8/r+36Hfcb67s+tpl
oPufcLd6GzzHd89Hzru4QYk6wuBjRJDomt9gcxYHV+GHKdcaKAt0L8V5IbVtsvsm
FzG2xNaM65xNdgpamE0Tf2r3Oy+O/aRxgkQ7szsXyZ906BzxGhvHU4LNsI79UfAC
liXTAPzmChU=
=Mcao
-----END PGP SIGNATURE-----

--Sig_/rZ+3vNSkCEP8NqH5FS=Wc8M--
