From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 3/7] OMAPDSS: DISPC: Move DISPC specific dss_params to
 dispc_features
Date: Thu, 29 Nov 2012 14:08:53 +0200
Message-ID: <50B75055.3040600@ti.com>
References: <cover.1354086150.git.cmahapatra@ti.com> <a8148bcef07c0f8c7d2b385c1016f4bfaa90a772.1354086150.git.cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigBE24AD411ADFCDB96E6CCE8E"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57165 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753522Ab2K2MI4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Nov 2012 07:08:56 -0500
In-Reply-To: <a8148bcef07c0f8c7d2b385c1016f4bfaa90a772.1354086150.git.cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

--------------enigBE24AD411ADFCDB96E6CCE8E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-11-28 12:41, Chandrabhanu Mahapatra wrote:
> The DISPC specific dss_param_range are moved from struct omap_dss_featu=
res to
> corresponding DSS version specific dispc_param_range struct, initialize=
d in
> dispc_features thereby enabling local access. The mgr_width_max and
> mgr_height_max, members of dispc_features, are also moved to dispc_para=
m_range.
>=20
> Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
> ---
>  drivers/video/omap2/dss/dispc.c        |   80 +++++++++++++++++++++++-=
--------
>  drivers/video/omap2/dss/dss.h          |    4 ++
>  drivers/video/omap2/dss/dss_features.c |   16 -------
>  drivers/video/omap2/dss/dss_features.h |    3 --
>  4 files changed, 63 insertions(+), 40 deletions(-)

I think the exact same comments, as to the previous patch, apply here.
Instead of creating param_range, use the dss_param_range. And see if

dispc.feat->params[FEAT_PARAM_PCD].min

style lines can be simplified with helper func/pointer.

 Tomi



--------------enigBE24AD411ADFCDB96E6CCE8E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJQt1BVAAoJEPo9qoy8lh71rNgP/R2shKZw6/owxLIIzdnZcrzO
A7nLJB/wqBCWTc0FO6bLK4dn3LSzlc6h/iGhF+nths6fFwSWuq7CwfgWh53E9b47
19qv80Y9HdEGCqTM/lRbk5Ha6Wu9DHatkn4Y9UYKEka7W1KSAHN4zVMFYpfktpv4
05pNPbmuZCzk3cMUBm2VyPSudmkaimTjZ+5naJyd9Im2mIxzc4RLjmnfvPynDowH
4Asw+CxjvNKaJ2Znt48EzHjX4D2Bj00m41GgOpWed5FTTtrMKrMDRX3UQcz9zDWD
UqQifCLYPW+9POcwUglKJkMBRhA1nOH0WnkTAgp6y+1fTJfHH3XDhH7CDo7ZhODg
Z9tBDESGbJwfaG+HRxLod5nnM4qDwmAQDsuJXPhG/sTP5ifYh5AHvVi/e0OnQnhr
o4t4YuUWpx+4GnU91rXHlXO7HXf6rAoRCPwgh7cGusGMQb/ILZKH6z7HyK/OtI/K
5dZMk2YJSzNJ9DEYzGGy96d6bSJWpJ9R3LsVeRhsyZOAcch7KT3jESVixL4fVtw1
J03s53fiB7r1i+KgU/iYPBHgfPj4oxPGn5qwukusdADb2IIFgTG7lAsW/UFXB6Kl
piRYqkRFu9Aku/upeCUdfQE2RjKFyKIlvEg+ENh5cxwtKyb/8p984UndQPAOMGQ9
RWiG1MWWn62JVDupiwvn
=w0uU
-----END PGP SIGNATURE-----

--------------enigBE24AD411ADFCDB96E6CCE8E--
