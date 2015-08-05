From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/7] phy: ti-pipe3: use ti_pipe3_power_off to power off
 the PHY during probe
Date: Wed, 5 Aug 2015 10:35:03 -0500
Message-ID: <20150805153503.GC12328@saruman.tx.rr.com>
References: <1438701646-7876-1-git-send-email-kishon@ti.com>
 <1438701646-7876-3-git-send-email-kishon@ti.com>
 <20150804160631.GH23659@saruman.tx.rr.com>
 <55C219C8.8010304@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xo44VMWPx7vlQ2+2"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55C219C8.8010304@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: balbi@ti.com, rogerq@ti.com, tony@atomide.com, t-kristo@ti.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

--xo44VMWPx7vlQ2+2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 05, 2015 at 07:42:24PM +0530, Kishon Vijay Abraham I wrote:
> Hi,
>=20
> On Tuesday 04 August 2015 09:36 PM, Felipe Balbi wrote:
> > On Tue, Aug 04, 2015 at 08:50:41PM +0530, Kishon Vijay Abraham I wrote:
> >> No functional change. Previously omap_control_phy_power() was used to =
power
> >=20
> > there is a slight functional change. You moved PHY power off from before
> > to after pm_runtime_enable(), clk_prepare_enable() and creation of the
> > PHY device. That ought to have a slight impact on how the driver
> > behaves.
>=20
> okay. I'll modify the commit log. I think it won't impact the functionali=
ty as
> such since the ->init and ->power_on callbacks won't be invoked at that p=
oint.

all right, then

--=20
balbi

--xo44VMWPx7vlQ2+2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVwi0nAAoJEIaOsuA1yqRE6KQP/jtJ1X8urHOy6NPE9wOBP/cm
NVUIHrNAbXWmLIxiCvwTt+ahn9jWv3m6nJ4StSrUnOgj9ouJgmbSkpdM+yZULC8+
Y7s/5pSKpmqQxBGjqmylK89PRbV8wCGBekbnc0Sn6ZGg5Ugtsp4VyJ4XgHKUIssR
sV8xrUtTlwQor4Obb5qq5zDnlFTtuSB39juKAf/AHZLy2vl46m9hv7O8ncvU3y6h
AwQDv+J1Qy0HwDYwP+/eyNZGgvUX7Gl/XjCgiip1HI+bBbFXUGU5z4hXtkF+nwXQ
g5TpWN7E5vJx3ANYpqzeGPDJ+2hVofjhLqKxItsxfTv/3GEbyepnVh3lEze9op8M
L1Df8w417zRaM6yt+TzIHUv1qiXN82AVtHYRe4HqbY2tbiM3fbxuJkU9Nq+xn+Pg
nQ3oHjFkkRDfzMKw/3Z3iz6yVO6QOeK5x1OYNBYNQSxmbdN4LF/kc1kMpOfHpYKv
xRDEKpMJ25bO23Zi+EuJxfmW9OoqIJcrCGF7qxECi1yzkuSh8tDOto/VeAceE430
e+K9XiSwLTxKcP5VfaF/Ldn8LAIEfJzSLWrohAsQQ7URDFvtIT9PQBIZqTwU6T28
9dZ+FGvxFLo5DOc+FpgqvZYkFl1HhQGJxPhXX9EWfAQBZyFgFrwHdEwAQH9exn5U
cN1FUDnQcVVGKx7YU11b
=sYg4
-----END PGP SIGNATURE-----

--xo44VMWPx7vlQ2+2--
