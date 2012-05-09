From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v4 0/9] OMAPDSS: APPLY: Treat overlay manager timings as
 shadow registers
Date: Wed, 09 May 2012 14:13:11 +0300
Message-ID: <1336561991.3962.31.camel@deskari>
References: <1334561027-28569-1-git-send-email-archit@ti.com>
	 <1336558256-26140-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-mXDq4nSVgR4lnzuL575o"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog137.obsmtp.com ([74.125.149.18]:53733 "EHLO
	na3sys009aog137.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758027Ab2EILNR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 May 2012 07:13:17 -0400
Received: by lags15 with SMTP id s15so100177lag.20
        for <linux-omap@vger.kernel.org>; Wed, 09 May 2012 04:13:14 -0700 (PDT)
In-Reply-To: <1336558256-26140-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-mXDq4nSVgR4lnzuL575o
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-05-09 at 15:40 +0530, Archit Taneja wrote:
> An overlay manager's timings (the manager size, and blanking parameters i=
f an
> LCD manager) are DISPC shadow registers, and they should hence follow the
> correct programming model.
>=20
> This set makes the timings an extra_info parameter in manager's private d=
ata .
> The interface drivers now apply the timings in instead of directly writin=
g to
> registers.
>=20
> This change also prevents the need to use display resolution for overlay
> checks, hence making some of the APPLY functions less dependent on the di=
splay.
> Some DISPC functions that needed display width can also use these private=
ly
> stored timings.
>=20
> Changes since v3:
>=20
> - Remove direct setting of go bit in dpi_set_timings()
> - Take some of the patches in "OMAPDSS: Misc fixes and cleanups" and make=
 them a
>   part of this series as they are more related.
> - Don't have an initial set of manager timings in private data, only chec=
k
>   manager and overlay parameters once the manager is enabled.
>=20
> These patches apply over:
>=20
> git://gitorious.org/linux-omap-dss2/linux.git dev
>=20
> Reference tree containing this series:
>=20
> git://gitorious.org/~boddob/linux-omap-dss2/archit-dss2-clone.git mgr_tim=
ing_and_fixes_2
>=20
> Tested on OMAP4 SDP and Panda.

I did some quick tests on omap3 overo, worked fine. I'll merge to dss
master branch.

 Tomi


--=-mXDq4nSVgR4lnzuL575o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPqlFHAAoJEPo9qoy8lh71cQYQAKsQ3cpIaFJH46oUoWzur7tM
yd0sMLZIDYGtm/vwhCe8ZGq1yX+eHsSnXaqyXdEkMWpSykuJHZ2fB0fscIJA8N6m
/bZwAtXAvm5pkvuXVZAsPWoiUz/wcXGRd3C2qMvvZP0u7W2tAxQ1uUrr92dlTWnp
j/IGia2HNyrLGtAl9/Y3dw2dG46FyefMKF73dgH64i8F5kxiTQjMULUrv8sY29B0
3SUc+IdvJ1pEu62459YcUGN0L2tHNzDp3xamPYkJRcECodAvNH3AuPmCQH/NhxLY
fexlwSdJTpzVyU0i2N+yaOrFC07L0DqxQE3X0zRsmP7gMFhTjCWn2S8URPJHc0M+
UUiaNE8ApYvUa6BFTrm7bAUOKsa9T/8TKiSCHiEoL0Urbs4RVLMT08HeL7eWRUoT
Acf/7YFkCbf2TBih7R3W3Dv2BVurdSGHcgyn+8AK1Y9psl67N13eFE1B5Rbdol+q
353evqBoDDohw/ShJDBKlz0E9Ils5J3GpdGcZVntzOSTtzmMg0R+6AXDZimmAr1E
p00gcVPsxiEqF5XJBAkKpMBriA9k+XhoZiS2Pw6BOW8PsYH998HgN36v7p5ADpJN
otHRV6paFk/6vLD8+lMY0LCfSwPhvt3+7IiPjUdnRwofzpoNjhzhDmbsmfYlabiV
1oGve5Q7cnmXcbRKjKc5
=XlCU
-----END PGP SIGNATURE-----

--=-mXDq4nSVgR4lnzuL575o--

