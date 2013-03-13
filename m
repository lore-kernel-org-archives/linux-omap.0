From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH 2/2 v2] pwm_bl: Add mandatory backlight enable regulator
Date: Wed, 13 Mar 2013 22:36:10 +0100
Message-ID: <20130313213610.GB29402@avionic-0098.mockup.avionic-design.de>
References: <1363126934-8754-1-git-send-email-achew@nvidia.com>
 <1363126934-8754-3-git-send-email-achew@nvidia.com>
 <51403F59.2090303@ti.com>
 <643E69AA4436674C8F39DCC2C05F7638629CA51A0B@HQMAIL03.nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:51079 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755231Ab3CMVga (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Mar 2013 17:36:30 -0400
Content-Disposition: inline
In-Reply-To: <643E69AA4436674C8F39DCC2C05F7638629CA51A0B@HQMAIL03.nvidia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andrew Chew <AChew@nvidia.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Alex Courbot <acourbot@nvidia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2013 at 02:10:16PM -0700, Andrew Chew wrote:
> > > +static void pwm_backlight_enable(struct backlight_device *bl) {
> > > +	struct pwm_bl_data *pb =3D dev_get_drvdata(&bl->dev);
> > > +
> > > +	/* Bail if we are already enabled. */
> > > +	if (pb->enabled)
> > > +		return;
> > > +
> > > +	pwm_enable(pb->pwm);
> > > +
> > > +	if (regulator_enable(pb->enable_supply) !=3D 0)
> >=20
> > I would loose the '!=3D 0'
>=20
> I think I prefer the '!=3D 0'.  Without it, it looks at first glance
> like regulator_enable() is following boolean semantics,
> so it reads kind of weird.  But I'll defer to Thierry on this
> one.  Thierry, what's your preference?

Why not assign the return value of regulator_enable() to a variable, for
instance "err", and make that part of the warning message so that people
will have a better chance to diagnose what's going wrong?

Thierry

--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRQPFKAAoJEN0jrNd/PrOhJa0P/33TJrIIfV5pjGtNkBNzuxXK
2LlO1U5MBExzf9m/1RgFEWTz+TFpr94UdzpqMPu/Z/HLvBIeVqUgJVrtIviJ2Si7
Q+bjDNlmPBsrIVPwRY1GJWaRvw2N1LAthe+sI7kDtPn9lk+5HlyeVcrhAZemq5F6
v6sVjDWyJ4Kb46mVEdNhYD6tX7TdkyAPWuKcNoB65iSTHJ/8oQxO1sNjQWn/jiJ8
0ctJsZvoiztLU7krj6q8e5ZBdTsDH29aoULBQoxUX2CKs+ycZq8oRA4HC0ri2bl7
hAngyxyi8lH2E4HKZBNRVYyDtTU2udw87U2JLm9Lwr4A9LavpFmRO7zj84glNUpi
2OxTYrHpggJcTLJFIB0z6Pp/uZ0aoLP6pmTAv3IGoyj3eVcnur6iky7UMTHzXdDc
IMuPOJwvZscZmSMwtVVY4xgkgxiGanOYBXB4JBGaQ926XJU+JIOPCUdZE1hqSYbM
3rDXMk4UDa2rPyYJTbzW4PD/M0TNV/5w23Xw0I3mulfck3g+w1MdJDuUQ7iT3AeF
gvkqem0d3jTZiDV1he70uVAuCjnHG273v8JjpMu2tyyNdBQT3mv/wGpK5Jm9Ndup
wzFeUgltfYoobWdao2mOakN3eMn+Aq5XtvU0pgzfP/Vey+uCN1Rok8VQdSRlSjyg
t7VMs9bGeAp6MRRgPl+p
=EUPo
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--
