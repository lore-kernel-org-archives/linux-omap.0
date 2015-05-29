From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] fix n900 dts file to work around 4.1 touchscreen
 regression on n900
Date: Fri, 29 May 2015 14:49:55 -0500
Message-ID: <20150529194955.GV2026@saruman.tx.rr.com>
References: <201505241444.41039@pali>
 <20150527132545.GA23434@amd>
 <20150527133311.GJ30798@pali>
 <20150527143722.GA28108@amd>
 <20150527145837.GA13223@earth>
 <20150529190816.GA20232@amd>
 <20150529192505.GA28987@amd>
 <20150529193211.GA7599@amd>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MzUyxqdXrKJm2YZW"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58523 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756539AbbE2Twy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 May 2015 15:52:54 -0400
Content-Disposition: inline
In-Reply-To: <20150529193211.GA7599@amd>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, maxime.ripard@free-electrons.com, dmitry.torokhov@gmail.com, pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com

--MzUyxqdXrKJm2YZW
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

IMHO, the older binding needs to be supported as well. It's fine to
update the DTS for the new binding, but even Documentation says
touchscreen-max-[xy] and if the driver changed that, the driver should
be fixed too. Besides, it seems like this has been in tree since v3.16:

$ git describe a38cfebb56898633687ab337fd53710e63a0aedd
v3.15-rc5-72-ga38cfebb5689

So, because this has been wrongly documented for so long, we should
support both bindings. Sure, deprecate touchscreen-max-[xy], but they
must still be supported, IMO.

In any case, for this patch:

Reviewed-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--MzUyxqdXrKJm2YZW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIbBAEBAgAGBQJVaMLiAAoJEIaOsuA1yqRE69MP+I+eb5AqwNhrOpqAYvIqJBKM
FKC+Cx1tRFNsPnx733fFEw/Q6AHl2soWY9lxkHbou3VAdUYuTnzUHDBT5UeQHnHF
i3AuP2LKjyqOxl1QtBX8suBA1q+orAUpQDUwMYNvS3V3HStjdqzcRZohE2qcwub2
aPzbfXqRrEWhxo6HqlvxsqukYB2FdMGRp95GKoet3QjtvaEAtPunirWnHlXVPE9q
3ABhEbNCrD7+B61LoQMlQh5aA/oDgcuN2YBPEwDnBGuVrcn7slyzlMZq+gSm0AM3
5PI8bYZAgrAWkSh5Kvd5LQRtDKC5UCUE2cLaHGwkezMA85AKAJcAvtjR1MDfz5Sk
jDFk0lRXihNkx1XJvfaCHXUqVViPV/IDzpYmtWiEUkV2tw5kBEus4bDDQxQrfqDK
9TZCIL2EAhbdzgjGNOnSxvIfUiAYfax4MRkmH4s2u9U+xK4zdhog5IYoZoqFtpXw
VTArIKXSBskgw6YCyvacO8Mw0O+H72saBp1OboFNvsioRkHaZV12FtTVP6CiYzAi
4FUP07XpSwHDa6wpXQgbCUC5H0jCclYSS1GyZXC7prb+lJhR9GcmSiV514BQJkw0
Q3QmuOlGG7aPAVQk5pZrVU7Pdu70XqI2QrKsQ0Ad941GvW7l4q45PBGoZDZw2cQO
35UPxTM8vEJQdy4AUSE=
=4UxG
-----END PGP SIGNATURE-----

--MzUyxqdXrKJm2YZW--
