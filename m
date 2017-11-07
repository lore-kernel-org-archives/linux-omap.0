From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Battery charging, battery status on Nokia N9, N950
Date: Tue, 7 Nov 2017 21:16:51 +0100
Message-ID: <20171107201651.GB2572@amd>
References: <20171103210349.GA14071@amd>
 <20171107195020.GA19508@amd>
 <20171107195912.GA3274@amd>
 <CAOf5uwnoUkZG6KUzhn2u8vdcd5_+nmUQpXwE1zjNwiakN+Mscg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="K8nIJk4ghYZn606h"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOf5uwnoUkZG6KUzhn2u8vdcd5_+nmUQpXwE1zjNwiakN+Mscg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, khilman@kernel.org, aaro.koskinen@iki.fi, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com
List-Id: linux-omap@vger.kernel.org


--K8nIJk4ghYZn606h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2017-11-07 21:04:19, Michael Nazzareno Trimarchi wrote:
> Hi Pavel
>=20
> On Tue, Nov 7, 2017 at 8:59 PM, Pavel Machek <pavel@ucw.cz> wrote:
> > Hi!
> >
> >>
> >> > I'm fighting with battery status & battery charging on Nokia
> >> > N9/N950. https://elinux.org/N950 contains enough info to get battery
> >> > status (and below is first attempt at kernel implementation), but I'm
> >> > not sure what needs to be done to charge the battery (or at least
> >> > power phone from USB).
> >>
> >> Nemo recovery system (2824336 Jul 25  2016 zImage-moslo) seems to
> >> either charge phone from USB or at power it from USB.
> >>
> >> But 4.13 does not; it seems there are two separate issue.
> >>
> >> First, something needs to be done to enable system power from the
> >> USB. I'm not sure what that one would be :-(. Then, it should be
> >> possible to ask bq24153 to charge the battery.
> >
> > If someone has schematics or pointer to them.. for N9 or N950, that
> > would be useful :-).
> >
>=20
> You can dump pinctrl and configuration and check if some gpio are
> used.  From reference schematic of this charger you have OTG and
> CD. Those pins can be just used to enable/disable and boost charging.
> You should dig a bit in sysfs to figure it out ;)

I tried to search old board file from working version -- seemed better
than randomly toggling stuff in /sys. But I could not find anything
suspicious.

If someone has the schematics, that would be useful.

Best regards,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--K8nIJk4ghYZn606h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAloCFLMACgkQMOfwapXb+vLIXACeOWdffFwMYkzTDMSdOKOAcX1x
QIUAoKsI+MxM0IDx96NIHaOn7i8QYmij
=8D+d
-----END PGP SIGNATURE-----

--K8nIJk4ghYZn606h--
