From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2 1/8] ARM: DRA7: id: Add cpu detection support for
 DRA7xx based SoCs'
Date: Tue, 30 Jul 2013 17:23:53 +0300
Message-ID: <20130730142353.GL28162@radagast>
References: <1375183546-12758-1-git-send-email-rnayak@ti.com>
 <1375183546-12758-2-git-send-email-rnayak@ti.com>
 <20130730131009.GA28162@radagast>
 <51F7CB2F.6070705@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OGW1Z2JKiS9bXo17"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45473 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755881Ab3G3OY2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Jul 2013 10:24:28 -0400
Content-Disposition: inline
In-Reply-To: <51F7CB2F.6070705@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sricharan R <r.sricharan@ti.com>
Cc: balbi@ti.com, Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, paul@pwsan.com, khilman@linaro.org, benoit.cousson@gmail.com, ambresh@ti.com, sourav.poddar@ti.com

--OGW1Z2JKiS9bXo17
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 30, 2013 at 07:48:23PM +0530, Sricharan R wrote:
> On Tuesday 30 July 2013 06:40 PM, Felipe Balbi wrote:
> > Hi,
> >
> > On Tue, Jul 30, 2013 at 04:55:39PM +0530, Rajendra Nayak wrote:
> >> @@ -379,6 +407,13 @@ IS_OMAP_TYPE(3430, 0x3430)
> >>  # define soc_is_omap543x()		is_omap543x()
> >>  #endif
> >> =20
> >> +# if defined(CONFIG_SOC_DRA7XX)
> >> +# undef soc_is_dra7xx
> >> +# undef soc_is_dra75x
> >> +# define soc_is_dra7xx()		is_dra7xx()
> >> +# define soc_is_dra75x()		is_dra75x()
> > since this platform is DT-only, couldn't we just believe DT-data to be
> > correct of_machine_is_compatible() ? 2/3 of this patch would be removed.
> >
> > I patched this for OMAP5 (compile-tested only, no boards available) and
> > came out with the patch below (still needs to be split):
> >
> > diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5=
-uevm.dts
> > index 08b7267..b3136e5 100644
> > --- a/arch/arm/boot/dts/omap5-uevm.dts
> > +++ b/arch/arm/boot/dts/omap5-uevm.dts
> > @@ -13,7 +13,7 @@
> > =20
> >  / {
> >  	model =3D "TI OMAP5 uEVM board";
> > -	compatible =3D "ti,omap5-uevm", "ti,omap5";
> > +	compatible =3D "ti,omap5-uevm", "ti,omap5432-es2.0", "ti,omap5";
> > =20
>  ok, nice and simpler way.
>  But would this make different revisions, to appear the same ?

well omap5-uevm is omap5432 es2.0 only, right ? If a new board comes up,
it should be treated as such, then you can pass a different string to
that new board's compatible attribute.

--=20
balbi

--OGW1Z2JKiS9bXo17
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR98x5AAoJEIaOsuA1yqREdwkP/2GoImAcohQosTTQCbstb1uk
JKGoPnJ4FMLCTX/DXN8aPy6XE9WlOwKPHLF2zSSmvJKPmY2frNEvHicYzhLZ4cy0
GH/PsWkBxNUZ3MS+kaHn9+ok1sjr57J2eKhGZ4O1OlUHfclru3CJo/BMUQH4JfWN
M1MMPG7zTWSkmHbE2DlqVwChLeu5uQaUfOeWc23tJd6QQ0rq2ka6beON7syHDHz8
5RLIbR/amKKktd6GvdoAhOoOnC0Xeiv1LUB+Hjk2xRCBfnbpYamFdzO+HbRxgiOr
oNLNx1WlNyVGUEI1+2cftzqYVYlWhbIzRf1hHCi+UL9iks97fIiierbpZVSx+b2q
7OBFJl2rz9qZ9Vnh4ldfdLpjTyfOvaNGZ6pUan9mCyyJeJD5J1ddPKTnExfHeI0b
AHv1/f+NcLJcaul4lkMTNzWz6efcvglUUkUiw7JSRUnHQKnSbx7Sv9v/orEMf5vw
nJQKZh1dGqBTcQlHUbzVT37NKpBovmIfswv0fucBB9kDys3FuRgIk9yrlQEW5BpE
iF9+JXM5NtHVUHViQlNCM2WInv7z5D5uGZDLDcNMhOR3Ld6nO+KfqCeiUW08AqoV
+aiKcnb44IckrI2zyX93LY3VjO8i3bzrKM+vxqrk4wrBUjsNNu8C0zJ0MFzC13HH
/aE0l1gccuyo3seDYsZM
=IIMc
-----END PGP SIGNATURE-----

--OGW1Z2JKiS9bXo17--
