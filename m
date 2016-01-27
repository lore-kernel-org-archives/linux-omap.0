From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: omap3: Include missing bandgap data for
 ti-soc-thermal driver
Date: Wed, 27 Jan 2016 19:19:50 +0100
Message-ID: <20160127181950.GB17794@earth>
References: <1451086345-3340-1-git-send-email-pali.rohar@gmail.com>
 <20160121094718.GV7192@pali>
 <20160121171500.GI19432@atomide.com>
 <20160127100447.GI25796@pali>
 <20160127160945.GI19432@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GRPZ8SYKNexpdSJ7"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160127160945.GI19432-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 27, 2016 at 08:09:46AM -0800, Tony Lindgren wrote:
> * Pali Roh=E1r <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [160127 02:05]:
> > On Thursday 21 January 2016 09:15:01 Tony Lindgren wrote:
> > > * Pali Roh=E1r <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [160121 01:48]:
> > > > On Saturday 26 December 2015 00:32:25 Pali Roh=E1r wrote:
> > > > > Driver for omap3 with documentation is there since v4.4-rc1.
> > > ...
> > >=20
> > > > PING! Who can take this patch?
> > >=20
> > > Sounds like /me, but after -rc1 when any possible regressions
> > > are out of the way :)
> >=20
> > Great! Just to note that 4.5-rc1 is out.
> >=20
> > I just do not want to see this patch lost...
>=20
> So is this critical to have as a fix since it's thermal related?

According to somebody from TI, who previously took part in the patch
discussion, the thermal sensors of omap3 are to imprecise to be used
for thermal decisions. The driver "just" informs userspace about the
temperatures.

-- Sebastian

--GRPZ8SYKNexpdSJ7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWqQpFAAoJENju1/PIO/qaOeIQAISWWfk94fgLkGlplM0FllIY
p0jqcUq9R+AfQsKqiVyE7swQ5wwyv2HZqPGRSIRpQX+lAGeEhg4h1+7oGkBVPBOi
tEtAwS6qryniIvolP34mkINRE552LOTYClYDqI4QDLJ/cmtlj2wZC8gJGdMgklWO
WCaNvRDdJrdMnowOdD4TegzxBvFqelcOfQCG27tIllTksRY61TzaK8wpgqahF3NF
pSF3meYb5gpaIIX4o1Ig43tgRxblyz6Jt43d7Q/ZPflWmmP9Jy4EKxjWSpxY6jlg
Ix7Nr+PffzSM295JPaJXSPPtEB5zDWXdEBUKafNtqKfpojIPA6ywYeuAqEjGRgIs
w76JsM/THba+or1SY2dUj8lxG+LwnfKZsztihoKbn3Eckks1kWezPAA83Xd9clzk
I9/WEj4s/PRlcW2IQDQEXX+lfwRMUY9sCqqsUTio6okPZNdaeml5PrHBSWM1bPXV
WQmO8dK5lWOLg1u6XSWFE93ELZRfw5pW8hoao/57H+L4AMHZjCz+KSVhbEKRLwy4
OA3o/HJ5qHh+YKD9/Y5qe+DworFZUgFhmJtP0lU2WD50vU1rWcUBleNlUIcHv+/s
m/LJrjqM2FIkXZtXfaPpbWEytguqXm8dmdhGIuGKIX1BMxBf3wvBh9ectWwSzjT6
Lu8GDLqxXxfzIHKhN/AW
=FYF4
-----END PGP SIGNATURE-----

--GRPZ8SYKNexpdSJ7--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
