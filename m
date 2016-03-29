From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/7] ARM: dts: Enable N950 keyboard sleep leds by default
Date: Tue, 29 Mar 2016 16:52:09 +0200
Message-ID: <20160329145209.GB31858@earth>
References: <1457827580-16919-1-git-send-email-sre@kernel.org>
 <1457827580-16919-5-git-send-email-sre@kernel.org>
 <20160329105128.GA30184@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f2QGlHpHGjS2mn6Y"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160329105128.GA30184@amd>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 29, 2016 at 12:51:28PM +0200, Pavel Machek wrote:
> For 1-3 in the series, Acked-by: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
>=20
> > Like the Nokia N900, the N950 has leds to show
> > the state of sys_clkreq and sys_off_mode pins.
> >=20
> > A detailed description for the LEDs and
> > OMAP's sleep states can be found in Tony's
> > commit for the Nokia N900:
> >=20
> > c1be2032f66df9e1238bd5bc4ca666de88a62abc
>=20
> I must say I've seen it on N900, and yes, it is useful, but no, I
> don't think this is right.
>
> This is not a LED. This is a interface that changes meaning of two
> other LEDs. I guess it should go to debugfs somewhere.

I don't think we should diverge N900 and N950 userspace
APIs in this regard.

Actually the correct way would be a custom trigger
for the leds IMHO. I don't know if the led framework
supports per led custom triggers, though.

-- Sebastian

--f2QGlHpHGjS2mn6Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJW+paZAAoJENju1/PIO/qairgP/02hw81Pvhp/+FkeFJH8+Y+n
G9Krb/1bpTJdkHsIehWwVm5/8SUh6jKcM+5xHOOQS633oRTmAmkusSKfgA9A29TC
NdtV/VG30T8QuytuEoC6RcTeAQgmuvipMF4RFXCqG05irN405mpio/N2HJcq0b6d
YYKggmG+RBo63cX8kYl1ZZmQYKOmLBCDX7R3ChLj7hA8ye/9y5BzWEq9i1iECsLN
cgfjDldESvXmbM7VIX540XCdkNqCamx7bDO4Q3yQPncirIrAR04s5uEMsXTB8GL7
I7gX2T9rC9easdYdEACW3DiX2WQx3wzdmF/6UJSI9mYuk1Ti/LzcQAMx60dkd8mG
6tLl22xrgndXtoAJgUhd61jzvmvetOlBXnoPX2mHqG+I//KFG+k1aCPsfyf7TF2Q
sG+UwWBY5OjQj+xFOT+cuM45elHowP6ZdYSduCcWEyl0wLn5Cct/JL6M6wH8/e5b
ZgHYvoONmIySre5hLJKMAtSHRKuRTGuT264CZwVJFDasVmbMLqFqvtDZhtwa90QO
tyqWiScTEgjUT7LM2hANBAwnTREKEJFt9ia+4Oi7cDMBkVsuBrNLlqlOAUoplU3h
QebCOSLFGFVb3QnJArNQ58sKsEJgFwVJJFo3/0Lg4/WVQuxo2aiCaBDuOF8Dqe4Y
r9NGJmDS12R5HF5ZqmxM
=SwvO
-----END PGP SIGNATURE-----

--f2QGlHpHGjS2mn6Y--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
