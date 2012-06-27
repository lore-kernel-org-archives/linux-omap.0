From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 05/17] OMAPDSS: Add some new fields to omap_video_timings
Date: Wed, 27 Jun 2012 14:48:53 +0300
Message-ID: <1340797733.2649.48.camel@deskari>
References: <1340703414-1915-1-git-send-email-archit@ti.com>
	 <1340703414-1915-7-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-vGKchXdly2ST7PU3afG9"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog138.obsmtp.com ([74.125.149.19]:37767 "EHLO
	na3sys009aog138.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753605Ab2F0Ls5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Jun 2012 07:48:57 -0400
Received: by lbgc1 with SMTP id c1so3342948lbg.1
        for <linux-omap@vger.kernel.org>; Wed, 27 Jun 2012 04:48:54 -0700 (PDT)
In-Reply-To: <1340703414-1915-7-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: rob@ti.com, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org


--=-vGKchXdly2ST7PU3afG9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-06-26 at 15:06 +0530, Archit Taneja wrote:
> Some panel timing related fields are contained in omap_panel_config in th=
e form
> of flags. The fields are:
>=20
> - Hsync logic level
> - Vsync logic level
> - Data driven on rising/falling edge of pixel clock
> - Output enable/Data enable logic level
> - HSYNC/VSYNC driven on rising/falling edge of pixel clock
>=20
> Out of these parameters, Hsync and Vsync logic levels are a part of the t=
imings
> in the Xorg modeline configuration. So it makes sense to move the to
> omap_video_timings. The rest aren't a part of modeline, but it still make=
s
> sense to move these since they are related to panel timings.
>=20
> These fields stored in omap_panel_config in dssdev are configured for LCD
> panels, and the corresponding LCD managers in the DISPC_POL_FREQo registe=
rs.
>=20
> Add the above fields in omap_video_timings. Represent their state via new=
 enums.
> The parameter pclk_edge is configured via omap_dss_signal_level, however =
it
> actually configures whether data is driven on the rising or falling edge.=
 This
> is a bit unclean, but it prevents us from creating another enum.

Hmm, why can't omap_dss_signal_edge be used for pclk_edge? I think it'd
fit fine, except OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES would be an illegal
value for it.

 Tomi


--=-vGKchXdly2ST7PU3afG9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJP6vMlAAoJEPo9qoy8lh71anYQAKJh1Nah8JIm/qnmffuyHusx
l00dSOKtnN/c9Sg5QPQosQJ+WzhdrEL5hs02AHEP7x8Fpa60LEvpHk6H7s9TsDyq
yXuf1aKoXFh6x6/NbpJEtyYrg3MgMDe7+3CobaU8YfEMPnR4D9mrtXRE+plyQXdW
IM7yjCcjR7HR22xFsufNmoeoy48YqwTybvVrzWTBaFre/21V1nK7hGcHmOBBNmBo
Sx1BU01544KhXVEEWvI1Ksa32GV/9falK4AMIBGAwfuJS7gil8K8dNqEzlH8LwbS
Ekkx/19zcuhLxnx0Cno3fsYhx7O1k2WmAcHKaZ+MyL8Lhkb3depMNEnUmShSK05X
h+03juTx2PTLPv+oPHRi9lwso+RlY3Im2uCwhAp4Y4k61V5sxTk8/X2IJWrlHekA
f6vjx/9jJDuhOtzMHNS3VfZo8J5P5Zc+XPao9dTsijIfRvaeEPwlZ2MLkbQh8c74
cC9hr6vfix52bkf73L/zjYu2e2rO4XkxNwuW629zZjkIcrRW7CSSChSAuvkpvj8/
mLgqrQztGFAXStyPYzXQaK9hV/x8beO6CPLN6cm2zSycTpBWbHwmfM484fSmh/ax
nE1WMFcAR6Hk/Nof5MNCxptJw1sGvqnRzc95rEIuFus6vc+MINP6Ryw7w5EQbrsm
1++8MW4VOEZ02iIUByc2
=N6WX
-----END PGP SIGNATURE-----

--=-vGKchXdly2ST7PU3afG9--

