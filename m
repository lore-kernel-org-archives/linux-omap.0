From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2] OMAPDSS: Do not require a VDDS_DSI regulator on
 am35xx
Date: Tue, 21 Aug 2012 13:39:44 +0300
Message-ID: <1345545584.4085.49.camel@deskari>
References: <20120815191627.GA22993@renkinjitsu.usine.8d.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-Wg/Yy/qKmwwEdEHUTfCx"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:48630 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756441Ab2HUKjt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Aug 2012 06:39:49 -0400
Received: by lagk11 with SMTP id k11so4550713lag.30
        for <linux-omap@vger.kernel.org>; Tue, 21 Aug 2012 03:39:46 -0700 (PDT)
In-Reply-To: <20120815191627.GA22993@renkinjitsu.usine.8d.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Raphael Assenat <raph@8d.com>
Cc: linux-omap@vger.kernel.org


--=-Wg/Yy/qKmwwEdEHUTfCx
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 2012-08-15 at 15:16 -0400, Raphael Assenat wrote:
> On our AM3505 based board, dpi.c complains that there is no VDSS_DSI regu=
lator
> and the framebuffer cannot be enabled. However, this check does not seem =
to
> apply to AM3505/17 chips.
>=20
> Taking into account comments received after my first patch[1], I have add=
ed
> entries to dss_features.c to support the am35xx soc. Then in dpi.c, inste=
ad
> of using cpu_is_omap34xx() and soc_is_am35xx(), a call to dss_has_feature=
()
> is used.
>=20
> [1] http://marc.info/?l=3Dlinux-fbdev&m=3D134272967203409&w=3D2
>=20
> Signed-off-by: Rapha=C3=ABl Ass=C3=A9nat <raph@8d.com>

Chandrabhanu has posted a series that removes a bunch of cpu_is checks
from omapdss. On of them is the use of VDDS_DSI in dpi.c.

Can you wait until I've merged those patches to omapdss master branch
(probably a few days), and then create a new patch that adds AM35xx to
dss_features?

 Tomi


--=-Wg/Yy/qKmwwEdEHUTfCx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQM2VwAAoJEPo9qoy8lh713DgP/A7JQMU0nKw0UdwvZtcBm2x/
C/TFTT/ptBINn4rc8UJI72NFxz/hnIyZLjBtjvWb4iHhsvedf7zkwPqEPi4pMM0i
sd5XD50iPwtU0L2b8RMkp6xAOaEq/zEZBIiKRpo0UlyIuoiVTpbCiQFROqjo4gPU
DI1RxmMIc2I8vwYc0qOcMY4OYTKn858G3q4fgT2U0FKW+6MfusYTFGUTfiHAp38f
Z9pTOidQYBf7utLgQrCY5WjSe4vq2u7UH83hUH0dCTxh+VmE4g7YrwZR+QDZ6UU4
T9wrJltTsvNWxUHge4EAOHBRiXBmVVDcyfyhxxiZNaeKS8CANLdObvMgTUVnwFZ7
ysrIvmNCssfaiOLuozaHp4mr0ofUI8QSjGH+pBJBEOv95x6wasttYtLjB0b8cQCT
cFOWigMYLcfpvFa9ir/9UiI9QCLa/fguc1rPQgoFccBTGAzsqUeVqcBTc+rY3H5R
QcZInACaZSD27DrfK5/4IRC+NX/aUUznKf0ywZHKiLSrlx9ud9eC673Iva9X05ID
F21km958rrsXNPa8kZyrJ5Y5BxBys9/MttXLnbQqSuVkuFnxJUth+Vlf1ji5NCzi
e+hmDKCrprgK+hht1yHjOwnulldue1/FEdZTXScY8Tpp/SvrrfgYe5TAjA2x6Rzb
TYQSHlT77CKP1Nv1ym+U
=RYXv
-----END PGP SIGNATURE-----

--=-Wg/Yy/qKmwwEdEHUTfCx--

