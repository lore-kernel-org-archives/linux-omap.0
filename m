From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: 4.13-rc0: stopped booting on Nokia N900
Date: Mon, 10 Jul 2017 15:36:56 +0200
Message-ID: <20170710133656.og2egbse5plp3afm@earth>
References: <20170710074610.GA22846@amd>
 <20170710081334.GA29726@amd>
 <20170710101608.qdamqomegbjwuweh@earth>
 <20170710130602.GS3730@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2u63r7gtmfchhtcq"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170710130602.GS3730@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Pavel Machek <pavel@ucw.cz>, pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com
List-Id: linux-omap@vger.kernel.org


--2u63r7gtmfchhtcq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 10, 2017 at 06:06:03AM -0700, Tony Lindgren wrote:
> > I just rebased my droid4 development branch. I do not have any
> > problems with segfaulting toolchain, but boot also fails on OMAP4
> > based Droid 4. The problem seems to be SPI being accessed without
> > runtime PM (clocks) being enabled:
>=20
> Care to check if commit c5b3955828ba ("ARM: OMAP4: Fix legacy code
> clean-up regression") make that one go away? I have already sent
> a pull request for that one.

I bisected to the same commit, that you also found. I just replied
to Thomas' pull-request from yesterday with bootlog + bisect result
+ info that current master works again after reverting the patch.

-- Sebastian

--2u63r7gtmfchhtcq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlljgvgACgkQ2O7X88g7
+prdlRAAhfSKnbcE5BLYLwlZjHhgYiFwzAaaIeywlmQf/FVwjMdu2S3EvuqnnfJD
eVkiwf6CedJGfyXgmicGjjQYNFlGVS8vbksdhj5BhM3cRN15Nf6jTpOeTPedC8t0
uFUsTiMtINq4lxmj+bVFw+KbCsPRd/Vu5Oj8sWpQW6zEkLtRVmPKLr0wkiBU743i
hFO+Ox87y3Fni12o95bpvx+3m9FBZxEiLgSsz0I3fdMNU7vujeXcPZYS/n7ZOaVN
G8POtviaD0+Bj7+4RI+3VXCv4PN6gfZVLT/3WxRFkihF1WR7G9czppSFNC8Z8rRg
S+s1+mKIlki7ohmsvsO956qCw5KSZwg8UztGp1TDgP347ry4pQGKrJKO1Rv73+A0
461IdyAq1jAPusqHLGX2DYByjKlokEm+Bq0Q6w89rPR8C5CrRdxdJqsp4a3tUnW+
z8biwDPyG+NwRq+5apS1SHwdBUL88QDiqn+TE+EGdIK9O++Oo78YnkIOdNe9XREc
0GzJpAqwslFP2dUe51y/Lh2Qq4VnQ/lxVsxSWahQJ3smQzvX5ZnVveJbEKHj2AuF
fINUT8VNreouGkJbY6x6GhS16Q4qv46KyaHB1cWy2J0HCqO8BE5CRTDqtr62NhPF
PnC1gAwxZa4M+jt1FvX5q3h1WTah9sVkaxQddOCHAkONcG86qKs=
=N8lH
-----END PGP SIGNATURE-----

--2u63r7gtmfchhtcq--
