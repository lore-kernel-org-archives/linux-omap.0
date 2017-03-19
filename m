From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 6/6] ARM: dts: omap4-droid4: Add LCD
Date: Sun, 19 Mar 2017 23:55:42 +0100
Message-ID: <20170319225542.ts53qpwdhdrmy2ac@earth>
References: <20170305054359.8293-1-tony@atomide.com>
 <20170305054359.8293-7-tony@atomide.com>
 <20170319012927.kmyqngprpip7le4m@earth>
 <20170319161030.GA20572@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jhksawfyo5gmnb5j"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170319161030.GA20572-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--jhksawfyo5gmnb5j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Mar 19, 2017 at 09:10:30AM -0700, Tony Lindgren wrote:
> * Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [170318 18:31]:
> > Hi,
> >=20
> > On Sat, Mar 04, 2017 at 09:43:59PM -0800, Tony Lindgren wrote:
> > > The LCD panel on droid 4 is a command mode LCD. The binding follows
> > > the standard omapdrm binding and the changes needed for omapdrm comma=
nd
> > > mode panels are posted separately.
> > >=20
> > > Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > > Cc: Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>
> > > Cc: Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > > Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > > Cc: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
> > > Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> >=20
> > Tested-By: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> >=20
> > With a non-modular kernel lcd is not working with omapdrm if HDMI
> > is enabled. After dropping HDMI in droid4's dts file everything
> > worked as expected. I assume both work properly with a modular
> > kernel?
>=20
> Yes with loadable modules both work just fine. If things do not
> work properly as built-in, chances are there's some unhandled
> dependency that needs -EPROBE_DEFER somewhere for a regulator
> or a clock.

I think that would also result in problems with disabled HDMI.
I guess the problem is, that omapdrm is initialized too early.
AFAIK omapdrm is not hotplug-capable.

-- Sebastian

--jhksawfyo5gmnb5j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljPDGsACgkQ2O7X88g7
+pqpaRAAgbeurX0dOBRFAOOO0bElq8n4qPm3zhJRR5gAFZVRQN2D3gtZ+PTMPnZn
lyaYdX4GzK2kCw8Jz/noSyhOzDLHUdTFPuyH8BMGIDEZJv9lr7Hn25o6b9CxcWHx
wZMAG6jF902oXnBemvpwXRTNCB4Ktp9cremOL3cE7COydSPIhlGTt6c29GdttgjV
Fnw6tmFnOyYcyjqQJma52xHWWFo6vIHkiP6xa+cPHmchtqx5m17/0UNu7Ex/6aMI
Q0S5vVJkbeuTCJD1IhXECCCwS2b0UxpYmFTQPGGGMrcVDxCpsBYSPEO9IjnZZ1qH
hNQ/eGXwRoNOpw5KP1cKOmjF13y8Wt1nc29AspewtjZfsZD8NwUgjTr9epNRfRYM
Fc/BlZPMwwwdTm5LHIg4vYQdOiUwjKLwV20uCLvVVaou5XQxBp+n1w+wF2lP6c11
xFgNFJxXYY1JrE4GBQLMMRvhIf4fHBukOX8jwjdrCK5Uoi5nLI1eCh/8/UnfZ5H2
zZr4WBM1+OE60gQMBacasRp5ay2HSjns2+cYW2dsbXjP3/gTwfdXXCe3QSzE0eoD
mxLaewQ+6dJ4tKOhisl1ceAQTG+T4hZbY1w8mTs5bSIfFBSYSWXvjJ3i4OPqcb+t
Ld2z2C+6liB39GF7nRIykcey5727zLCPpnZbe5SaK9XY2eR/RtI=
=PLxj
-----END PGP SIGNATURE-----

--jhksawfyo5gmnb5j--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
