From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/6] OMAPDSS: APPLY: Treat overlay manager timings as
 shadow registers
Date: Thu, 19 Apr 2012 14:48:55 +0300
Message-ID: <1334836135.1911.40.camel@deskari>
References: <1334561027-28569-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-oo8g7HI0wMb4jFPBhoKR"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:47517 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754899Ab2DSLtA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Apr 2012 07:49:00 -0400
Received: by lagu2 with SMTP id u2so8825260lag.21
        for <linux-omap@vger.kernel.org>; Thu, 19 Apr 2012 04:48:57 -0700 (PDT)
In-Reply-To: <1334561027-28569-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-oo8g7HI0wMb4jFPBhoKR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-04-16 at 12:53 +0530, Archit Taneja wrote:
> An overlay manager's timings (the manager size, and blanking parameters i=
f an
> LCD manager) are DISPC shadow registers, and they should hence follow the
> correct programming model.
>=20
> This set makes the timings a manager_info parameter. The interface driver=
s now
> set the timings in manager_info instead of directly writing to registers.
>=20
> This change also prevents the need to use display resolution for overlay
> checks, hence making some of the APPLY functions less dependent on the di=
splay.
>=20
> These patches apply over:
>=20
> git://gitorious.org/linux-omap-dss2/linux.git dev
>=20
> Archit Taneja (6):
>   OMAPDSS: DISPC/RFBI: Use dispc_mgr_set_lcd_timings() for setting lcd
>     size
>   OMAPDSS: DISPC: Use a common function to set manager timings
>   OMAPDSS: DISPC: Clean up manager timing/size functions
>   OMAPDSS: MANAGER: Make DISPC timings a manager_info parameter
>   OMAPDSS: MANAGER: Check validity of manager timings
>   OMAPDSS: APPLY: Remove display dependency from overlay and manager
>     checks

The patches 1, 2 and 3 in this series look like independent cleanups.
Should I apply those, or do you think there may be changes required?

 Tomi


--=-oo8g7HI0wMb4jFPBhoKR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPj/unAAoJEPo9qoy8lh71VVQP+wdhydNE7pMPjZXeqPGyuD6z
sryg20ttU8bK9d9oEFQoBmPy6aaNhj6RkYwj9EEFycmnhNSIK6lD9dHa4HixHckC
75HupgkDcyGTmoRyvlvVY6A28zKNmkTIN9hhBSwm/f3X07QUttqrO4/TRnIi/SKa
x3Yb8eCjve5nNUYOx3wbhTKSvJKhSXuZOo5LHtVkoXUOdXgHTqfTqIgx5Q5JFInp
mfSRL5M/G+YAglzJrN7s2XIPZd3KX1q9hV5J7pwQ0WARjiwCy43rd1OYnAyQHAUB
thVWKpnqqBd5HEoQ8trQ86Z1qltsIlEf4YuGk1hnYOeOLrUuFfOR3lAoLNYQk+ri
hoMHEa/FC8kJq5hGMZ8v/4AulN9DInX8dM0yQC2Gpy0gsj30jgNcKFalPMc7j88n
+eiQWq/kk9r+0b7dntpsIlwcUt+GZ0wyuFbs65ukhH62ZA4qeh1qpT+HoCN59ZyY
KwLTae7CAidf/hC848WOLoxpVWQOblVk40KTkMUao4nnbllmoUN9ZUh+EzQg7PMb
PqIyVR7mJcBd6TX1rbN7y2ozeYD6oEj5d1Ds9kxLvdpxH07xXgO8g9vKUl+aUv5N
2iDamUCRXZMm81e9FVHL6JKC2iV6wLwBUjkz5X0ERey02EZgkgirpD2VrDwuvS3V
c3uJLwoGbDEsEDp4+ll8
=xwJh
-----END PGP SIGNATURE-----

--=-oo8g7HI0wMb4jFPBhoKR--

