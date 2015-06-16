From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] i2c: omap: improve duty cycle on SCL
Date: Tue, 16 Jun 2015 14:19:48 -0500
Message-ID: <20150616191948.GC30496@saruman.tx.rr.com>
References: <1434482276-1210-1-git-send-email-balbi@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qbvjkv9qwOGw/5Fx"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58253 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750838AbbFPTWn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Jun 2015 15:22:43 -0400
Content-Disposition: inline
In-Reply-To: <1434482276-1210-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: wsa@the-dreams.de, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Dave Gerlach <d-gerlach@ti.com>, linux-i2c@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--Qbvjkv9qwOGw/5Fx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2015 at 02:17:56PM -0500, Felipe Balbi wrote:
> With this patch we try to be as close to 50%
> duty cycle as possible. The reason for this
> is that some devices present an erratic behavior
> with certain duty cycles.
>=20
> One such example is TPS65218 PMIC which fails
> to change voltages when running @ 400kHz and
> duty cycle is lower than 34%.
>=20
> The idea of the patch is simple:
>=20
> calculate desired scl_period from requested scl
> and use 50% for tLow and 50% for tHigh.
>=20
> tLow is calculated with a DIV_ROUND_UP() to make
> sure it's slightly higher than tHigh and to make
> sure that we end up within I2C specifications.
>=20
> Kudos to Nishanth Menon and Dave Gerlach for helping
> debugging the TPS65218 problem found on AM437x SK.
>=20
> Signed-off-by: Felipe Balbi <balbi@ti.com>

the patch is correct, but I sent the version written on top of v3.14,
I'll resend correct version, sorry.

--=20
balbi

--Qbvjkv9qwOGw/5Fx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVgHbUAAoJEIaOsuA1yqRE6eMP/iA8vVLbGPcapS0n9h8asjsw
eTTQ8sJy1L+ufedwQoj13gING9f2OSiPgBLit0Cgq+9ceadC4UCFlyR+AV36YXMe
uJUMJK/8q5W2/LVKxmGMSC/sP9mxgAjeILZLeENdUgNIZ6CMiteA7/EmJnuGS5HP
Dafrv08xdrlZYA31CwkKFnwyw9eESY5idhsrYzan1Z973sZXOVCLPq6so1Qym2tC
6n7OyWI1wDo4yft4IZedv7l5vYK3VU1zkae4speZasQhRbvrntDJnrkRCz28kst8
DqqxI1urk9yPiCFoV8ehIV7H8d12dMU0MR09tKFFZInsBbRRAD3p2dkwJrEkhDhn
mGhmVrsPZkaXVlq63nlcXHkmBGxf34G8h6j8nRr8zp3hB/mKE3TjBmHEJ2xuhwDG
v6RftbjtPHXJyqc+IaSXhMlTWtCVq3HFUNQIZCcx/wsGa+h4lTybUtkU5ODlZ2nk
VE33HOI3TUMJ04tzM3PfSr1HCL3/YmwRypBYteHuDst6OVvHVoJW9YavlMo95+AX
/e5aafi6F1BPlBu/zZAKyOQoq5U0Bs8DKEqZL3fNM2jO+QUACbKzeRGeH1PxqNIK
LabQPrHdblZNdy2USxYX/JjrKaEbdEr3yRJy1dTx21IV0YWV6/cIIU4q7b7fsjdM
Og7u5bzoBYw58lYOJoGu
=Ua0p
-----END PGP SIGNATURE-----

--Qbvjkv9qwOGw/5Fx--
