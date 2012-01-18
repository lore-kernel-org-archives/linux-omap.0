From: NeilBrown <neilb@suse.de>
Subject: Re: DSS2/PM on 3.2 broken?
Date: Wed, 18 Jan 2012 22:15:38 +1100
Message-ID: <20120118221538.342b4782@notabene.brown>
References: <WC20120109124643.880164@terrafix.co.uk>
	<20120110080849.5a242adf@notabene.brown>
	<alpine.DEB.2.00.1201110632100.31702@utopia.booyaka.com>
	<20120112095940.0a54413e@notabene.brown>
	<alpine.DEB.2.00.1201130253070.3659@utopia.booyaka.com>
	<20120113222045.37f9b4ec@notabene.brown>
	<1326870839.1954.23.camel@deskari>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/WB9RGT+G6qp=E79hO35ITpr"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:52303 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750715Ab2ARLPx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Jan 2012 06:15:53 -0500
In-Reply-To: <1326870839.1954.23.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Joe Woodward <jw@terrafix.co.uk>, khilman@ti.com, t-kristo@ti.com, govindraj.r@ti.com, linux-omap@vger.kernel.org

--Sig_/WB9RGT+G6qp=E79hO35ITpr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 18 Jan 2012 09:13:59 +0200 Tomi Valkeinen <tomi.valkeinen@ti.com>
wrote:

> On Fri, 2012-01-13 at 22:20 +1100, NeilBrown wrote:
> > Having CPUIDLE makes the DSS2 problem worse: lots of=20
> >=20
> > [   21.085113] omapdss DISPC error: SYNC_LOST on channel lcd,
> > restarting the output with video overlays disabled
> >=20
> > messages whenever the CPU isn't busy.
>=20
> I'm not sure if it is the case here, but DSS has restrictions about the
> max DSS clocks on different OPPs. For example, on OMAP4430 LCD clock
> maximum is 186MHz at OPP100, and 93MHz at OPP50. So it's a quite big
> drop, causing problems with all but the rather small displays.
>=20
> And the DSS driver doesn't have any support to handle this at the
> moment, as there isn't support in the PM framework to do this. I think
> the only way to handle this at the moment is for the DSS driver to set
> an arbitrarily high constraint on, say, mem throughput, and hope that it
> keeps the OMAP in the required OPP.
>=20
>  Tomi
>=20

This LCD panel on this device sets:
   .pixel_clock	=3D 22000,
in the "struct omap_video_timings" so I'm guessing that is 22MHz?

I'll try building without SMARTREFLEX and see if that makes a difference -
presumably that should keep it at OPP100 (??).

Thanks,
NeilBrown

--Sig_/WB9RGT+G6qp=E79hO35ITpr
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIVAwUBTxap2jnsnt1WYoG5AQJVWg/9FYN0QEQvRtdD5ap5cqKfwqdnXZPwD/KM
bieSlIaCYPOqnytPvJGGINWwvPHial0kS0c3CvwuF/n2oaMujnbZb5DiTnALcG4b
IQaltRkk1HB+OM6D9sIF77OlFbONzvtoYGpivyy6ycNn5e3rriUUB5v7ez5SrZsp
mviHHScdVb8WsQOX/eg2dqqMLcpq6FE1yktlgZ+ILVQmtlAP9MlnEluXO6S4Ma7A
62cty8vpIQWC4Vex1HzXWjj29YbQNnVPricgpstl6ovnZlr0mX+sq0u3gz16ShB+
B83MYKOL4tRHfytUXP6zNW3Q4oytbRIa2oUYE2azBha8qQFCTfPufpa67JCRqU2k
y/5oK2K+qmMd7HVWZdXdKaCPdxGr7ZXgN0UE9hmIOh4rHp5tIwGv6QmnZJ8gF2sJ
j4NgxkoroS28iUx2sw6ImjdbWVPr0huWzFbRT6xuRBP75IN0+Y29G6uhiaAG+1xL
xyOWaDTbz+v+rvkBzI9whGBHTU1mUJARrTpHJkf/B7pcqbTENK7DG62RNqjq2mIk
SPNa+WkkwQd6YPFSN26pd//FzbWg+JeqEtVnrtQt32scQvgbcMmpiA/SZyHJ1rBd
D8JflrWllLIHwS8KriX+YU11JTIgK1HPuqQtBfWp89nlJ7hEOW6hSDPjoKXMebSd
OgIJQ/dAcsA=
=2+is
-----END PGP SIGNATURE-----

--Sig_/WB9RGT+G6qp=E79hO35ITpr--
