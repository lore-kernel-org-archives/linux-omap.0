From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH] w1: omap-hdq: Simplify driver with PM runtime
 autosuspend
Date: Mon, 16 Dec 2019 13:05:36 +0100
Message-ID: <20191216130536.5935a587@kemnade.info>
References: <20191215173817.47918-1-tony@atomide.com>
        <20191215230331.645b9064@aktux>
        <20191216030948.GL35479@atomide.com>
        <20191216031637.GM35479@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/pTDkS8g+4Evpb4NGdmMSFgI"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191216031637.GM35479@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Evgeniy Polyakov <zbr@ioremap.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Adam Ford <aford173@gmail.com>, "Andrew F . Davis" <afd@ti.com>, "H . Nikolaus Schaller" <hns@goldelico.com>, Vignesh R <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org

--Sig_/pTDkS8g+4Evpb4NGdmMSFgI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sun, 15 Dec 2019 19:16:37 -0800
Tony Lindgren <tony@atomide.com> wrote:

> * Tony Lindgren <tony@atomide.com> [191216 03:10]:
> > Hi,
> >=20
> > * Andreas Kemnade <andreas@kemnade.info> [191215 22:04]: =20
> > > On Sun, 15 Dec 2019 09:38:17 -0800
> > > If I remember correctly this thing is critical to get the hwmod out of
> > > reset but I need to examine that again: =20
> >=20
> > Thanks for testing, yes that's what I thought might cause it
> > too, but nope :)
> >=20
> > We currently disable interrupts for some reason after
> > the first read. That won't play with runtime PM autosuspend
> > at all as we never enable them again until the device has
> > idled. Can you try the following additional patch on top? =20
>=20
> And we should probably do the following too to make sure
> the mode is initialized before we call runtime PM.
>=20
CM_FCLKEN1/IDLEST1_CORE seem to behave, reading also works=20

With these two additional patches this deserves a
Tested-By: Andreas Kemnade <andreas@kemnade.info> # gta04

Regards,
Andreas

--Sig_/pTDkS8g+4Evpb4NGdmMSFgI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPIWxmAFyOaBcwCpFl4jFM1s/ye8FAl33cxEACgkQl4jFM1s/
ye+XJhAAwAP3mP015ttcaI0o1k+rWARDRYa6ZmIdenggQ1kVJC/wyz81oY+EYOhh
+cjFOKGUHHXDJ8N2HZEqlEW/WamTeTOb94eDD4blf5xcFfqO7TlqcQkZxl++8lJy
J37v+tT+I+7T9j3tA7XlGGy8j5TexKgT0BWXHE9BPryURsA5wANkhLm6jhMxNyWT
ADrM2ey0kMuReKDjCQcJsOapxRs3wfaxKxMs0t93pe7S54Onqr1Eqi6WDEjkJOPD
tClQ4WzEHKad70Whi6jiL/PozkNjB5E6MAaY+uENvHf3X1jcNeJI/63rScJfJGkq
LneGTFeBQ7Bao2bQ/BahxXV9cX6jiZCY6Wsz+ZPizOok3+UWQG5pW0O/DsJ43Rpx
3JEwjtRgyjboj3fH49jJx/5ayHYdbsqyarxoXh9oHpHpcpoU4GT4YPrCQn7QDenB
waDGzKr7DYHZF4T1tA8nGw6uc5C3eSMSIgpwecVb2iBRzdyBRUJg1dPgIuAHQb4K
KXBtkavGIu6mHcqMsCQ1yih8zvVIJnt/A1vo5/flpRY7AQjx+Bz35gZXDYFc/2iI
Xj7SpP8WXDke53CgZLKhayuBRoH08t84w9vrNLA2x7jFmVxKta7T1eu6+j1VxnpC
HdVIAu3bk5YSGE4kh4zg2Y+25hy2bSsQP/rboPD5/deCIFNP/XQ=
=504B
-----END PGP SIGNATURE-----

--Sig_/pTDkS8g+4Evpb4NGdmMSFgI--
