From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v3] i2c: omap: improve duty cycle on SCL
Date: Thu, 9 Jul 2015 21:42:41 +0200
Message-ID: <20150709194241.GF4744@katana>
References: <1434569475-17378-1-git-send-email-balbi@ti.com>
 <55827CD7.7030207@nokia.com>
 <20150618172558.GC27790@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GLp9dJVi+aaipsRk"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150618172558.GC27790-HgARHv6XitJaoMGHk7MhZQC/G2K4zDHf@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--GLp9dJVi+aaipsRk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2015 at 12:25:58PM -0500, Felipe Balbi wrote:
> On Thu, Jun 18, 2015 at 10:09:59AM +0200, Alexander Sverdlin wrote:
> > Hello Felipe,
> >=20
> > On 17/06/15 21:31, ext Felipe Balbi wrote:
> > > With this patch we try to be as close to 50%
> > > duty cycle as possible. The reason for this
> > > is that some devices present an erratic behavior
> > > with certain duty cycles.
> > >=20
> > > One such example is TPS65218 PMIC which fails
> > > to change voltages when running @ 400kHz and
> > > duty cycle is lower than 34%.
> > >=20
> > > The idea of the patch is simple:
> > >=20
> > > calculate desired scl_period from requested scl
> > > and use 50% for tLow and 50% for tHigh.
> > >=20
> > > tLow is calculated with a DIV_ROUND_UP() to make
> > > sure it's slightly higher than tHigh and to make
> > > sure that we end up within I2C specifications.
> >=20
> > if you refuse to change the calculations to achieve maximum possible
> > bus rate (as I've shown you with SCLL=3D9 and SCLH=3D9), maybe you want=
 to
> > change the description? Because you are doing something else than is
> > written here. You are only in spec because you are not doing 50% duty
> > cycle. And you didn't mention here that you lower the bus speed below
> > 400kHz to achieve this.
>=20
> and there's a comment where the calculation goes which states "as close
> to 50% as possible but we make sure tLow is higher than tHigh so we're
> still within spec".

So, is that ready to go in for-next?


--GLp9dJVi+aaipsRk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVns6xAAoJEBQN5MwUoCm2l/UP/1v5ddhiQ7s7KPEm1Q7EGQ6m
ewwB5uXVH+Pb51zKMesTxrj63jb+BNuSrQQGgXHMIn1qT6YUSeMclcZdxfPlyu2O
hbTwoaK42K83M0ibi17DEMy6na/PCLpjdyTOHE0Lne4mhL5ObqUQxPHtZMbXJPX0
YXc5L7MTLwoQ96Acr3lGfhbu5niELyz28Zjuo1Bg4/rPxRWYDxsBaRF1fBI0k0xd
p+uGLFHAZINUdXzhkKNheOv+8u71eGt2Wy3XQ8on6Yz+zBuAyCHv8RGeId2mys3c
a7dFe6KFkRyvL0i16AiYDB9eNF5DLzuretCtG9AeVQh1itZej4jYjVo8maeIoi2q
Sa65rdnEQ18vq2x1ZVNMGJwKrMxkZXCHGWQcEyy3zZlM5YsHO29enOHkUu6Qxax+
qq0oPZtrvLUSjeq2Y+bUBb9WZJNYk2Y72RE4w+KMNoe/NBMNubQClLxKkQTmp7lX
uALMq+hw1S+Zh6zN+UkyUDoquQP1+RgmggYtZJzTwd8u4jt4OAewru1a6zm53I66
7fEYORxZsxZJdWrIdB5o+ac9CNKhTcayeP6okQUL/Z640zKjAwmGGHCN5ANZvgok
WFg0f0tE/O3V5etRtOEyicuTyBDbfRf6dfOuoK9P6KQpQj/vdO3wdUXMTvzrAA5P
EaEiEchBKEKNMD8vKVOy
=eXDP
-----END PGP SIGNATURE-----

--GLp9dJVi+aaipsRk--
