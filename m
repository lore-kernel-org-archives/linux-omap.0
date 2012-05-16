From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: v3.4-rc4 DSS PM problem (Was: Re: Problems with 3.4-rc5)
Date: Wed, 16 May 2012 12:20:01 +0300
Message-ID: <1337160001.7692.24.camel@deskari>
References: <1336033721.14378.2.camel@deskari>
	 <WC20120503084938.900446@terrafix.co.uk>
	 <1336050442.14378.10.camel@deskari>
	 <WC20120504091902.970499@terrafix.co.uk> <1336139415.2552.4.camel@deskari>
	 <1336140072.2552.6.camel@deskari> <WC20120504140943.7604D0@terrafix.co.uk>
	 <1336143281.2552.21.camel@deskari> <1336143500.2552.23.camel@deskari>
	 <1336483598.5761.45.camel@deskari> <WC20120514073642.6306D7@terrafix.co.uk>
	 <1336982138.2532.32.camel@lappyti>
	 <alpine.DEB.2.00.1205151148440.16649@utopia.booyaka.com>
	 <1337159300.7692.22.camel@deskari>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-urjRnN/zoRZaA6wX7K4A"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:36542 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932936Ab2EPJUG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 May 2012 05:20:06 -0400
Received: by lagw12 with SMTP id w12so343835lag.10
        for <linux-omap@vger.kernel.org>; Wed, 16 May 2012 02:20:03 -0700 (PDT)
In-Reply-To: <1337159300.7692.22.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Joe Woodward <jw@terrafix.co.uk>, khilman@ti.com, Archit Taneja <a0393947@ti.com>, linux-omap@vger.kernel.org


--=-urjRnN/zoRZaA6wX7K4A
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-05-16 at 12:08 +0300, Tomi Valkeinen wrote:
> On Tue, 2012-05-15 at 11:55 -0600, Paul Walmsley wrote:
> > Hello Tomi,
> >=20
> > On Mon, 14 May 2012, Tomi Valkeinen wrote:
> >=20
> > > I've been doing testing to understand the problem, but so far I don't
> > > have any idea why things go wrong. I haven't found out any logic in
> > > which configuration works and which doesn't. Looks to me that for som=
e
> > > reason the PM prevents DSS from getting data fast enough with certain
> > > fifo thresholds.
> > >=20
> > > I have two ways to avoid the problem, but I've been reluctant to make
> > > patches for those because I feel it's just hiding the problem. One wa=
y
> > > is to change DISPC SIDLEMODE or MIDLEMODE to disallow idle/standby. T=
he
> > > other is to use certain fifo threshold values, which just seem to wor=
k
> > > for unknown reasons.
> > >=20
> > > Considering that we already have a SIDLEMODE hack in DSS for omap3 wh=
en
> > > using DSI, I wonder if the omap3 PM + DSS combination is just plain
> > > broken, and we should disallow idle. I'm not quite sure what are the
> > > implications of that.
> > >=20
> > > I'd appreciate comments from the PM people =3D).
> >=20
> > This may be caused by one of the DPLLs going into autoidle.  This can=
=20
> > involve a significant wakeup latency.  I'd suggest looking at DPLL3, wh=
ich=20
> > provides the DSS interface clock, and DPLL4, which can provide the DSS=
=20
> > functional clock.
> >=20
> > Could you try:
> >=20
> > 1. applying something like the patch at the bottom of this message and=
=20
> > seeing if it makes any difference?
> >=20
> > 2. if #1 does not work, changing the "dpll3" in the patch to "dpll4" ?
> >=20
> > 3. if #2 does not work, disabling autoidle on both dpll3 and dpll4?
>=20
> Disabling DPLL3 autoidle fixes the problem. Disabling DPLL4 autoidle
> doesn't affect the problem.

JFYI, I also tested changing DISPC's SYSCONFIG:CLOCKACTIVITY, which, to
me, sounds a bit related to dpll autoidle. By default it's 0, "interface
and functional clocks can be switched off". I tested the three other
values, but none of them had any effect.

 Tomi


--=-urjRnN/zoRZaA6wX7K4A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPs3FBAAoJEPo9qoy8lh71stoP/jrvN2yGX8CdnR/vTiWEg1zX
fVEPRB/OFreUVOrjjH2wwwERJ3k9Vtb1Z8ljzmtEFb0D3MXcSffFOP4f6me6PJCC
IJ4LSN1ELzl6RX8emeCp3i04ll4mDqMo/OhPbF/r15sNmuwqvR6f9/7p3VNHjoER
TCLSW3sIvIlchMF/gyYXSrkEIgjGMdSFLduIaREIXlCXAw2n/GzyQPMB7UxBS3cb
jHLUiLO1sRiW+zbg3tlZqmwJI/rQPvOeyyN7ZVqNX9PR8NCRMJFGbZDJ2dsDN2Ua
OSLjv7PueeLSMqg4o4l1TLrYLjLK6j5dzt7UjQoKi9looWc1inlrNA9Hr8C4QuJv
uHAGPeCfRmLW0AHg168DarwaTpDE145ItcxoUbBwTgh3Zdh6ik/xtCw1TBBbOgU9
LkNeW2hEvn5tOJJdxPhUhVdt/X7pXHWtPW33my+kym/W3YskwCIcbpXAwBG/lSLa
aKiqKIjmQyp8UXURDlErxz9rJj6Ql74XTeYXfA7ILLsyqTizM6rYy7KPekgCGclj
tJkenX9adZGqx7Ez7T44CzjTzt8zoKzGBRDG/Hpp3IErYWXb3ZCR7NsSDp19Y02c
Qb1aoz4TxLSXZ9vr4lD1XAafaSdk44VIAF5zh5qW7eOzGjKFgT5WMdZ23VlnWEKm
8LcLi431cNW6wU7/PbR2
=NO8v
-----END PGP SIGNATURE-----

--=-urjRnN/zoRZaA6wX7K4A--

