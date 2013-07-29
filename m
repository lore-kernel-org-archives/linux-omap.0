From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v3 3/3] Input: omap-keypad: Setup irq type from DT
Date: Mon, 29 Jul 2013 21:09:29 +0300
Message-ID: <20130729180929.GH4964@radagast>
References: <1375116311-13999-1-git-send-email-illia.smyrnov@ti.com>
 <1375116311-13999-4-git-send-email-illia.smyrnov@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wjoFZxbW4tu+iR6v"
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1375116311-13999-4-git-send-email-illia.smyrnov@ti.com>
Sender: linux-input-owner@vger.kernel.org
To: Illia Smyrnov <illia.smyrnov@ti.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

--wjoFZxbW4tu+iR6v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2013 at 07:45:11PM +0300, Illia Smyrnov wrote:
> OMAP4 is DT only, so read the keypad IRQ type from DT instead hardcoding =
it
> in driver.
>=20
> Cc: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Illia Smyrnov <illia.smyrnov@ti.com>

Looks good to my eyes:

Reviewed-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--wjoFZxbW4tu+iR6v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR9q/ZAAoJEIaOsuA1yqREquAP/0pA41s72XEblH5Fgp4KxZ5o
vvLglkBi2fDTCNx4C9FXXr5jO9wQV0ANRiVPt4NRicVCrU97En7o9BkbBjoOTicm
BaQSGED8gah+AHMm6G4bX+TGnyf+RzqecfuKkGgeTMb6RtOEZvlPcRAG59z6IlCw
zQUavrou7IIaN69ysVzWKtnFHHtvQCgc9bbh29OrB0Tk3ogzDuwyXknsoRwPKQ8V
osZcRMBhu5/ajzcXeJ7rSELmZ5XFHYC/EjGaIbgNwlXt87w2ysJ9bBCtc2ve0ylb
npVPuWhsIh8gnomWzEBu3YAHsRQVFgM47so86nBJX0vAILcrFxFs45SXavZS/1am
EM6y4VIwVgTzdcZ8vgJp6Pbvoz57Kbr7SSS/CPYjNomIs7icA8+mZgF+dM/qXKhp
Vu4uUbXlv+IzcB0uOPAgcRoofOzusr+Gwnk8nwKAIQi2z3Ow4lK3qiGS/a56LxSR
93IJFuiY66OJl9OcbNCaBE+QxuTLkw+p712uUmc96fe/9BLc3TC3BQplgFtCx/PZ
ZHFDhrkSvquQjVn/LiwVPeJ99qbSyatjvvPULcnSV4knpGBIpZLDyLCFvuhRxfw3
YHlaHw2tp7XepqlQlXFvfCI5QRYDLZUUoW9pPqnjSAPNrDfBb+qKAEVnJCovMuit
InKKcCu98NaxuZHsQ3xq
=+L4K
-----END PGP SIGNATURE-----

--wjoFZxbW4tu+iR6v--
