From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v3 4/5] OMAPDSS: APPLY: Remove display dependency from
 overlay and manager checks
Date: Tue, 08 May 2012 13:50:23 +0300
Message-ID: <1336474223.1821.6.camel@lappyti>
References: <1334561027-28569-1-git-send-email-archit@ti.com>
	 <1336471096-21096-1-git-send-email-archit@ti.com>
	 <1336471096-21096-5-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-hHtQiRlsei8k3BIaaRsK"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog138.obsmtp.com ([74.125.149.19]:49958 "EHLO
	na3sys009aog138.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752612Ab2EHKud (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 06:50:33 -0400
Received: by lban1 with SMTP id n1so3125581lba.10
        for <linux-omap@vger.kernel.org>; Tue, 08 May 2012 03:50:30 -0700 (PDT)
In-Reply-To: <1336471096-21096-5-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-hHtQiRlsei8k3BIaaRsK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-05-08 at 15:28 +0530, Archit Taneja wrote:
> In order to check the validity of overlay and manager info, there was a n=
eed to
> use the omap_dss_device struct to get the panel resolution. The manager's
> private data in APPLY now contains the manager timings. Hence, we don't n=
eed to
> rely on the display resolution any more.
>=20
> Pass the manager's timings(in private data) to dss_mgr_check(). Remove th=
e need
> of passing omap_dss_device structs in the functions which check for overl=
ay and
> managers.
>=20
> Have some initial values for manager timings in apply_init(), these would=
 ensure
> that manager checks don't fail if an interface driver or a panel driver h=
asn't
> set the manager timings yet.

In what code patch were the initial values needed?

Checking the validity of all the settings is a bit tricky, but currently
I think, as a rule of thumb, we should accept any settings when things
are disabled. So, until the interface driver sets the timings before
enabling the output, all ovl/mgr settings should be allowed. And we
shouldn't even write any shadow registers until the moment the output is
enabled.

Except settings that do not depend on anything, like, if max ovl width
is 2048, it's fine to reject 2049+ width anytime.

> -int dss_ovl_check(struct omap_overlay *ovl,
> -		struct omap_overlay_info *info, struct omap_dss_device *dssdev)
> +int dss_ovl_check(struct omap_overlay *ovl, struct omap_overlay_info *in=
fo,
> +		const struct omap_video_timings *mgr_timings)
>  {
>  	u16 outw, outh;
> -	u16 dw, dh;
> +	u16 mgr_width, mgr_height;
> =20
> -	if (dssdev =3D=3D NULL)
> -		return 0;
> -
> -	dssdev->driver->get_resolution(dssdev, &dw, &dh);
> +	mgr_width =3D mgr_timings->x_res;
> +	mgr_height =3D mgr_timings->y_res;

I think you could've just used the existing dw and dh variables, thus
avoiding the need to change the rest of the function. The 'd' refers to
display, which is more or less the same as mgr width.

 Tomi


--=-hHtQiRlsei8k3BIaaRsK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPqPpvAAoJEPo9qoy8lh71MJgP/iwTeeZ5XEiBkh00rQTqKxzp
hBBJf48G27c7AtHeGg7Tc2eZqs3W24VFrxXyqmBuOC8qVefCsTGrZyBbNBLs713y
ndMZrOiShSwf2P1o/MqmpsPoZnFN+u/PfaaBiADU/24k0e6Kj8tVTWlrI33XRKVK
eCxtUbXrjmUendMEVM115pKj55fhm8jYeclXqSDAzYRxx6nqjmSSsx/yhSYqkbWk
+waBYcyMBTVwzCHgTl+tVf95oS6Ke/T7NGDBDafwl8m7kANDcplnHStTWZcRkfhM
U68LORn8FNz4j7976FhqFPJ8pA2kIB8AHEPr3d8APFAy7pVI3RVKrang+Pv1I1gq
Y7vJ8v8sPt84C3NrBE4Nt8QYiW/LYyW/uNkWHQBQe+EZWql74U3L6wniy6TG/kUi
zNMkbWTVDv3/NQhi78HFmP5YgzgGZuSVUERqJfFul+jTWT+JpiPgI2u91/SsgRoC
Y5W0gsCMSwZH4gRslZHBm1MgZ0Qtoppn/qAW/PSqTXTaCmn0Xvba7kPzqimmGEwR
CZ0pbP/q8ryRljmphc6ZWk3Fsk5N64iBmgOWUEdWyvtfmjwKouQMDUpho2S4NbMe
oBi8bMXDqWZk/NffGkkQEWi1psUeGJZ+Ys44CuF1yCck3c6QVrjalOtgPtm1FT0a
V5ANdPGbj+/f8U9tf+q+
=pu/s
-----END PGP SIGNATURE-----

--=-hHtQiRlsei8k3BIaaRsK--

