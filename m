From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] fix n900 dts file to work around 4.1 touchscreen
 regression on n900
Date: Sat, 30 May 2015 04:21:12 +0200
Message-ID: <20150530022111.GA28241@earth>
References: <201505241444.41039@pali>
 <20150527132545.GA23434@amd>
 <20150527133311.GJ30798@pali>
 <20150527143722.GA28108@amd>
 <20150527145837.GA13223@earth>
 <20150529190816.GA20232@amd>
 <20150529192505.GA28987@amd>
 <20150529193211.GA7599@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60276 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751373AbbE3CVj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 May 2015 22:21:39 -0400
Content-Disposition: inline
In-Reply-To: <20150529193211.GA7599@amd>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, maxime.ripard@free-electrons.com, dmitry.torokhov@gmail.com, pali.rohar@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 29, 2015 at 09:32:11PM +0200, Pavel Machek wrote:
> Fix dts to match what the Linux kernel expects. This works around
> touchscreen problems in 4.1 linux on Nokia n900.
>    =20
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
>=20
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/tsc2005.=
txt b/Documentation/devicetree/bindings/input/touchscreen/tsc2005.txt
> index 4b641c7..09089a6 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/tsc2005.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/tsc2005.txt
> @@ -32,8 +32,8 @@ Example:
>  		touchscreen-fuzz-x =3D <4>;
>  		touchscreen-fuzz-y =3D <7>;
>  		touchscreen-fuzz-pressure =3D <2>;
> -		touchscreen-max-x =3D <4096>;
> -		touchscreen-max-y =3D <4096>;
> +		touchscreen-size-x =3D <4096>;
> +		touchscreen-size-y =3D <4096>;
>  		touchscreen-max-pressure =3D <2048>;
> =20
>  		ti,x-plate-ohms =3D <280>;
> diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n=
900.dts
> index 5c16145..5f5e0f3 100644
> --- a/arch/arm/boot/dts/omap3-n900.dts
> +++ b/arch/arm/boot/dts/omap3-n900.dts
> @@ -832,8 +832,8 @@
>  		touchscreen-fuzz-x =3D <4>;
>  		touchscreen-fuzz-y =3D <7>;
>  		touchscreen-fuzz-pressure =3D <2>;
> -		touchscreen-max-x =3D <4096>;
> -		touchscreen-max-y =3D <4096>;
> +		touchscreen-size-x =3D <4096>;
> +		touchscreen-size-y =3D <4096>;
>  		touchscreen-max-pressure =3D <2048>;
> =20
>  		ti,x-plate-ohms =3D <280>;

Acked-By: Sebastian Reichel <sre@kernel.org>

max-x/fuzz-x is a leftover from development of the generic bindings
(Initially I used min and max).

If 3eea8b5d68c801fec788b411582b803463834752's behaviour should
become the new behaviour it should be documented, that maximum and
fuzz values are dependent on each other. Instead I suggest to
restore the old behaviour.

-- Sebastian

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVaR6TAAoJENju1/PIO/qaZdwP/23HydGA+Uo0rtkAVMrzE2g8
oA/FUdmbdV0m4g/QNrN1iXPeBOO+Drx7VeXzv1f7BSok5Ub6tiEq0lAXizNUr4ja
IT+QC1gQk6qWns7+0E+Iw106GiBwnDySlGZgwFAbr8Vg5QaHivNzn4yvWQTA/Kbw
1hi+wpP88fPO8ToxsmZK1tLQgavIJkbCBdB6kkcJZabEV4YupIS7EU7qFsFWjfoI
uys8MS/bbHbsRTH/n+DMVCbgULqnR7hi4fXa7Tik2qU7u231SWWPo/HKx5GxXhS5
MNuGfk31Pa79hH38ldJaNoED401IDcH4T8IraRzHldqpbhwHjB/jQG5LmA7i6mry
8w0pPmSyzHTzO19wi976QE2lB427h0DQASG22nA6HeKI8iGyiIayCgcDJo+GrADj
NswTVoy2m1ceKt8UXEndcEkC4gBdR3d57a4IWk1y0mDd2dSeN8vUnXVwl6fIhnnW
LpE9X68SGRn5RyVKRP6AhYTnmUmNZSmcwFhr2al3dABgmUJBqADU59RJk1l3pnIk
ecwwEE7Anb1oATLen1HuNiKkZEV0EsEp+t4OL7vQJQ0g9KXxaxsKBGP766CwOXul
JU7fAzyEiwzyE0TnX11rmPl8VYxyEPKZC0fHNvGCjxiXvoWAXN2PMhIubHYaTFOW
iEOoxUirGhnm2B+NVciy
=sNYK
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
