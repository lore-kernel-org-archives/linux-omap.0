From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/3] OMAPDSS: APPLY: Misc Fixes
Date: Mon, 12 Nov 2012 14:00:30 +0200
Message-ID: <50A0E4DE.60401@ti.com>
References: <n> <1352279844-10494-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF0A23A7A609AC770BCB93089"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37892 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752504Ab2KLMAd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Nov 2012 07:00:33 -0500
In-Reply-To: <1352279844-10494-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

--------------enigF0A23A7A609AC770BCB93089
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-11-07 11:17, Archit Taneja wrote:
> This series resolves a few minor issues with APPLY. Tested on a 4430sdp=
, checked
> switching overlays between DSI command mode and HDMI displays for any u=
nexpected
> behavior.
>=20
> Reference tree:
> git://gitorious.org/~boddob/linux-omap-dss2/archit-dss2-clone.git 3.8/a=
pply_fixes
>=20
> Archit Taneja (3):
>   OMAPDSS: APPLY: Don't treat an overlay's channel out as shadow bits
>   OMAPDSS: APPLY: Remove unnecessary variable in dss_apply_irq_handler
>   OMAPDSS: APPLY: Remove unnecessary call to mg_clear_shadow_dirty
>=20
>  drivers/video/omap2/dss/apply.c |   48 +++++++++++++++++++++----------=
--------
>  1 file changed, 26 insertions(+), 22 deletions(-)
>=20

Thanks, looks ok. I'll apply to omapdss tree.

 Tomi



--------------enigF0A23A7A609AC770BCB93089
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQoOTeAAoJEPo9qoy8lh71Aw0P/RAhPv7jeG4NDczD2K2CBcsH
Ezgp59Px+53wFIY5seVo/Zomj8SNyecWE811K6fwb/A9df9wBxr4F341L5EjgOmP
UzXLDeX1X53QvbTdbgmc2gLp3sMHlqeYOjxCfX/puB4j/EXjmKMinM2TevbeyWPA
LZmFE46Ua5UMFANMn96vhTMlbgwHgNOJo74+TI/mesYR/4825fyKq2ZlzZTl8LnR
iLsBaVMG3otlGalgIbNU10AGGKnGjvbPF7uEKzXpE1QdEyG3BvuX6sjNakbl/CaZ
bt2k+BJbiK4i3CkDZe/i0SRF4uSA2OaamFmJM3juNwgkkCe7js9XhC9Qbgi/4Vb/
39TovUNVKVc0Nd8dfpwHEEwvfFrL3rS6vJKRiiD0z/zRSlBNpK2Rbu0vtfUGRwA1
bGR7RUcZhKv7QPIEVclXn6AlvrLwXZH24LLyl3Wvd1zBwDKhdril6miIppTJmFuw
3EIVTISI1sho4O4P8SulrEGZ73FaZls9IK9Om/U3T8TnVCOJPwaUMBy5fL+eO8ii
ZBGIxYVSrtrZCQ4UiFJ1jM4UUQh2rjbKMph8bIcxOSexRZKI6dyBt3MeK8p9gY5g
lnHI92H+In90hq6fbiQscXMulOhN2BmXT7Wft+NbzuLPRS7o4d7wk4G/2tMY7vIR
BRvgz8KGQ855CJkQdSf4
=NsmV
-----END PGP SIGNATURE-----

--------------enigF0A23A7A609AC770BCB93089--
