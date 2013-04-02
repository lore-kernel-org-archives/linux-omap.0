From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v4] drivers: video: use module_platform_driver_probe()
Date: Tue, 2 Apr 2013 13:21:07 +0300
Message-ID: <515AB113.6030700@ti.com>
References: <1363352558-6275-1-git-send-email-fabio.porcedda@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC485F9D041B16CBE60546AC9"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36155 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754228Ab3DBKVW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Apr 2013 06:21:22 -0400
In-Reply-To: <1363352558-6275-1-git-send-email-fabio.porcedda@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, David Howells <dhowells@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

--------------enigC485F9D041B16CBE60546AC9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-03-15 15:02, Fabio Porcedda wrote:
> This patch converts the drivers to use the
> module_platform_driver_probe() macro which makes the code smaller and
> a bit simpler.
>=20
> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
> Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com> # atmel_lcdfb.c
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com> # amifb.=
c
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>=20
> Notes:
>     v4:
>      - add acked-by Nicolas & Laurent
>      - fix amifb.c
>     v3:
>      - add missing drivers: amifb, atmel_lcdfb, vrfb
>      - split patch set to each maintainer to easy up respin
>     v2:
>      - rebased over linux-next and remove already converted drivers
>=20
>  drivers/video/amifb.c          | 14 +-------------
>  drivers/video/atmel_lcdfb.c    | 13 +------------
>  drivers/video/omap2/vrfb.c     | 13 +------------
>  drivers/video/sh_mipi_dsi.c    | 12 +-----------
>  drivers/video/sh_mobile_hdmi.c | 12 +-----------
>  5 files changed, 5 insertions(+), 59 deletions(-)

Thanks, applied to fbdev branch.

 Tomi



--------------enigC485F9D041B16CBE60546AC9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRWrETAAoJEPo9qoy8lh71OaIP/1IqoM04jBJlAKUXmLqMqNZJ
Oc75Y6cVVRyVs65ndoYO5J1IBy/LUere14Zig0fFHr2kOtC81XobiQePEcEMJS/k
6poqaZUQ8/hoZgeCwVgrMWK/frdpjuxHyTE+t9iMCf3Cq1UO6uqrjd+tkQNm02YT
1gbj8PF2zYLAdVMc3tVGv7Qyjso6IK6jQtLfetvap0Ao+uA/8KNypRQQh5kzlcej
sGB5Vxn82kR7pBD+BbsBe0xqe0NGBsTKGcyrNuHrFRv7UAcwma46qGLrBMr28AUo
zkvA6YZGTr9dCuxuSKDxuDmw2R5sHNd/CfpsHjJZAGiH3XMMd9YbBvpHAYofnc7Z
xxuWzwQ/oSpsCVCGCoy8k3CyioqjGgOxb1YuZyIBUwQgZzn2CXgHDRIFaIEUthJd
fKvntsDFHDOW6G/b9ZfSRFyC94S+bwzmxf4MNHtVlryEvoaN6O2oI6TtxxYB4U/6
nmz6PYsVC2DOloU3/upCbAIvNbKcLO+Gnyp62eg3JlCsr+fhsO7jGFDITugDHDSP
amT5CNuY6TTlWPop6r3EdFxAd5WHnnxzSKmzIPfLfPXHbtgUMBB/SUOPxw1a5mEG
kARFpofHPRciT30zpR8Y2QqDQlqmmFkT8Ffc/LWwYhijJ18Jqgib6js+iSJnACqF
YAcWYqHwKZURBirTQfRj
=gciT
-----END PGP SIGNATURE-----

--------------enigC485F9D041B16CBE60546AC9--
