From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 63/65] OMAPDSS: APPLY: add checking of ovls/mgrs
 settings
Date: Thu, 08 Dec 2011 10:29:25 +0200
Message-ID: <1323332965.1867.20.camel@deskari>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
	 <1321953724-6350-64-git-send-email-tomi.valkeinen@ti.com>
	 <4EDF64AF.6040008@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-Zh5JlGtqhq9lwGSgn8ja"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:45593 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750753Ab1LHI3c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Dec 2011 03:29:32 -0500
In-Reply-To: <4EDF64AF.6040008@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, archit@ti.com


--=-Zh5JlGtqhq9lwGSgn8ja
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2011-12-07 at 18:35 +0530, Archit Taneja wrote:
> Hi,
>=20
> On Tuesday 22 November 2011 02:52 PM, Tomi Valkeinen wrote:
> > Add checks for overlay and manager settings. The checks are a bit
> > complex, as we need to observe the bigger picture instead of overlays
> > and managers independently. Things like the used display and the zorder
> > of other overlays affect the validity of the settings.
>=20
> Minor comment:
>=20
> dss_ovl_check, dss_mgr_check and dss_mgr_check_zorder don't really=20
> qualify as functions which do actual applying of configurations, they=20
> could be moved from apply.c to manager.c and overlay.c.

I had the check functions in apply.c because they used apply.c's
internal datastructures.

However, looking the functions now, only dss_mgr_check_zorder() used the
internal datas, and the function doesn't even use those variables for
anything =3D).

So you're right, they can be moved to manager.c and overlay.c, thanks.

 Tomi


--=-Zh5JlGtqhq9lwGSgn8ja
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJO4HVlAAoJEPo9qoy8lh71SvwQAKD7Z6uSLo7UvUciEpKdt185
VeB4qhxljteT1PfQe6m6RD53gXq40lMgSyk9NEBhE4Y7XIyobXtnrC+WvpLUVXYH
+3s9cjBX7f8Bs5qMwXFwvkbPsanZUcWWfljSc1ctqMUEGVZ2e8c/7egyEInK1EAm
7XnPVcFh+ZTPXoh2hjVXUQfNuLyD6U8/yn9rknzPfOshc2pNK6aomum1/H8OHYtj
GVo2fDaUT5aSMXYvv79HCckCD5mdZztd7QuvpShIqmWSkj0LfkI3dmEgRY6WhteZ
FsgsuXbHsPcmupbEBaGHuvQgm9jFqeR05j+u6teebS921IqgT63maBNhVDJm6evI
FZw+IS8+A4rl4wQlYqEM/EkHTABTWP2dHCrtef9XcMPReM3VcE4xTXLzLM472CnQ
YXJfqCNkwBjoHf17wdullyZlCfAXSHe2VHEu+BqW0m+XWDb1tdAohJD3o1H5pAtt
ID2ptSlFGm6011N7HRd2AuxdB0nmnzxMr5eM9TsWf0s30HBc909P02UVw41sglsB
N6Z73t1Jot70r+TJmcanyPxnjYK3mfVKrmkfKkNcLBXJzzDZj/rDD2SOdFORHQwi
tNHADFJQtVLNBXfUf1BBH7BNDKlB1rlrJHCIbNnKGL7s3tDokL2JeE/SIq92KhSe
Q69DT2H2oJTIg9ZLlaiY
=ueCc
-----END PGP SIGNATURE-----

--=-Zh5JlGtqhq9lwGSgn8ja--

