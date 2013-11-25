From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/5] usb: musb: conditionally save and restore the
 context on suspend
Date: Mon, 25 Nov 2013 14:13:39 -0600
Message-ID: <20131125201339.GH18046@saruman.home>
References: <1385408393-19707-1-git-send-email-zonque@gmail.com>
 <1385408393-19707-2-git-send-email-zonque@gmail.com>
 <20131125194427.GZ18046@saruman.home>
 <5293AE53.9080606@gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="o9mtL5OVI48+DSkO"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47090 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753181Ab3KYUOh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Nov 2013 15:14:37 -0500
Content-Disposition: inline
In-Reply-To: <5293AE53.9080606@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: balbi@ti.com, bigeasy@linutronix.de, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, neumann@teufel.de

--o9mtL5OVI48+DSkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 25, 2013 at 09:08:51PM +0100, Daniel Mack wrote:
> On 11/25/2013 08:44 PM, Felipe Balbi wrote:
> > Hi,
> >=20
> > On Mon, Nov 25, 2013 at 08:39:49PM +0100, Daniel Mack wrote:
> >> It appears not all platforms featuring a musb core need to save the mu=
sb
> >> core registers at suspend time and restore them on resume.
> >>
> >> The dsps platform does, however. So add a bit in struct
> >> musb_hdrc_platform_data to let platforms specify their need of such
> >> action being taken.
> >>
> >> Signed-off-by: Daniel Mack <zonque@gmail.com>
> >> ---
> >>  drivers/usb/musb/musb_core.c | 17 ++++++++++++++++-
> >>  include/linux/usb/musb.h     |  3 +++
> >>  2 files changed, 19 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core=
=2Ec
> >> index 0a43329..a8ded57 100644
> >> --- a/drivers/usb/musb/musb_core.c
> >> +++ b/drivers/usb/musb/musb_core.c
> >> @@ -2202,6 +2202,7 @@ static int musb_suspend(struct device *dev)
> >>  {
> >>  	struct musb	*musb =3D dev_to_musb(dev);
> >>  	unsigned long	flags;
> >> +	struct musb_hdrc_platform_data *plat =3D dev_get_platdata(dev);
> >=20
> > we don't want to have platform_data on DT-based boot. It's best to just
> > save those registers unconditionally as it doesn't hurt.
> >=20
>=20
> My concern about doing it unconditionally from the core is simply that I
> fear regressions for other platforms. I can of course drop it if you're
> certain that that's correct.
>=20
> I can only test this on a dsps glue layer, and I have no documentation
> for the musb core. All I'm left with here is fishing in muddy waters :/

I really don't think it should cause any issues with any other platform.

We can make to leave this soaking in linux-next for a long time and hope
people test it.

--=20
balbi

--o9mtL5OVI48+DSkO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSk69zAAoJEIaOsuA1yqREPPYP/1Jc/3vT+Om4dCKoNfYZfP//
M1u9C3OGlc0Wbv5hyHl4wcSyicF5ed6hN/YCAwZoyilZznv5h30sCYYjOeJTnbVJ
gChkppad0oqYKqot4b27IX3eh+3B7xOS5hbndkIV2sK7VkRC3T9XbqECbIr73n7p
Ciharrpc8mgjsE1PiVk8OdYhntuEWYKf2Or6PwDgclfTzMd54RFL+HVAd7LIKIiK
Jx2FqZanfsBlpwzGSZmjhcEG6YoRjPWLdcX3RHKJAWieqVgPGImKUdStjBMGdDQC
jRBTMsPiUp4FwB6JoFtjxaDcLWS6Lp9u7hunm4q2pbpj/q5ZsbmhCBw0g6SpX2D+
6S9NQN2Sd5PJca+GsbVbwf5Q2QA1LIabQHpj/FaXY/RbIllRPwIM76b/CEEJGJWl
zWbgrksasky1vLJ9ooXvmE9wO2ohsQOMMf59oeJkF81BJDBeHlaM6NwVDir61cd7
zVUNXNhGuRVbSx9J54+BqbVJR4HjpIqiDFhAO3sqwhvb0+RJ6S0AInICnV9JHCaq
iNXyL8Lpn2s8YEjx2X3lyGXVClTT4tFyNPU75/A+HwiNDUh9kXusjo5w4Ph/FO0I
Bi5YZYOwBYum1Q1zeO8ZLy/Bip0jwBcm0Nd/sV70DwqXF0FXsjhfMfoqCAsPSX3m
iHvy7/EnvEdbnPwspc30
=jMPL
-----END PGP SIGNATURE-----

--o9mtL5OVI48+DSkO--
