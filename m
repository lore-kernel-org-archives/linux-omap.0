From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 4/5] HSI: nokia-modem: drop support for disabled pm
Date: Sun, 31 Jan 2016 17:10:52 +0100
Message-ID: <20160131161052.GA16550@earth>
References: <1454203187-688-1-git-send-email-sre@kernel.org>
 <1454203187-688-5-git-send-email-sre@kernel.org>
 <201601311224.34249@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201601311224.34249@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
List-Id: linux-omap@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jan 31, 2016 at 12:24:34PM +0100, Pali Roh=E1r wrote:
> On Sunday 31 January 2016 02:19:46 Sebastian Reichel wrote:
> > Disabled power management means, that the driver can only be
> > used together with further out-of-tree kernel patches. There
> > is no reason to support this in the mainline kernel and not
> > having support for it means, that userspace can automatically
> > detect if we are running kernel based power management.
>=20
> I'm against this change. It will break support for (patched) Maemo and=20
> proprietary Nokia sscd modem daemon.

Do you have some links for this? So far my assumption was, that sscd
requires /sys/devices/platform/gpio-switch, so you either need to
patch sscd somehow, or patch the kernel to provide gpio-switch, or
provide some kind of userspace wrapper.

> Also you can export GPIOs manually via sysfs and touch that state. Which=
=20
> means that you can do power management with mainline kernel even if you=
=20
> set nokia-modem.pm=3D0.

Yeah... You export GPIOs manually. Did you actually try this? You
will end up with exactly the same result as nokia-modem.pm=3D1, just
with a few less symlinks. Also you have to make sure, that you
actually exported the right gpios, since the global gpio number is
dependent on the gpio-controller registration order.

> So please drop this patch.

Please provide facts, that Maemo can use pm=3D0 without additional
kernel patches and does not work with pm=3D1.

-- Sebastian

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWrjIFAAoJENju1/PIO/qaVqEP/1ua26opJcrFsrfzikQee9Bk
v+cDuir79mmX39QDZ8fxhNfcmZ2i9NkcdHq1+JPp+u3dG39sGiI0eig3l/2Zpgqp
7pvE5QK/7c/fMwObcnB8V8YD30/FJIXbPRfuPxNS7+U+cKrgnwNAwgTQUARmXTHo
cCcO3Oa0VCd32r8xHh5qyc0YZZyJdFwZzQJ2KwAsH1Eq+3snrLDW/HbP7y0Jgdoe
WkDz/mOqJ5GrJ4g1iqVSQ+4joWnoUOIbnz5vKbIA6/7kJle12EYshxXyp1tNsbAF
m06R73w8DAlsIoa9pueS3MRqmlbq/W+/uX418ZGvfGJXpeMvbYYqrESnTLg0TqrK
RN5bDomv0jDHEwTSg2NFwjTC2PyxaN4adkTG/K3x76GonbGEn7EzFq1Ibb75jJPb
TZYOOh6A0GEOOe2HepHMkuyY7SajZr/Amzlq5GDSUDeKorPpSS68DAEmioUqa3Tp
TiGQ2mVtvYUVbyn80tfQgMmi3RmSHqEJrF/u3hE1SmtlDA3Kfh/XdXdUpMTSKYo/
eBNS9CTgTeaWWLioJVvUJj3Vljsf4pCjFvEAf6t/4YcUegSPioTIVWW6hfWNgzj6
/9LTYhiRRDC4xv0aLcRWvlRh7GYtjRw5sepz51MzYoyl528Koqg6deU1BO00t8m7
xD+0Kx8QmwPuFfzS8oOn
=R1p4
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
