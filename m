From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/1] OMAPDSS: Return right error during connector probe
Date: Mon, 16 Sep 2013 12:41:54 +0300
Message-ID: <5236D262.9030806@ti.com>
References: <yes> <1378975375-14747-1-git-send-email-sathyap@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="wPrF1KlnQsEOGxJdMSCXxjSDBPLx3DSgM"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39994 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415Ab3IPJl4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Sep 2013 05:41:56 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id r8G9fuWl012210
	for <linux-omap@vger.kernel.org>; Mon, 16 Sep 2013 04:41:56 -0500
Received: from DFLE72.ent.ti.com (dfle72.ent.ti.com [128.247.5.109])
	by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id r8G9fuVH014095
	for <linux-omap@vger.kernel.org>; Mon, 16 Sep 2013 04:41:56 -0500
In-Reply-To: <1378975375-14747-1-git-send-email-sathyap@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sathya Prakash M R <sathyap@ti.com>
Cc: linux-omap@vger.kernel.org

--wPrF1KlnQsEOGxJdMSCXxjSDBPLx3DSgM
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/09/13 11:42, Sathya Prakash M R wrote:
> While using HDMI connector driver with sil9022 encoder
> came across issue where connector driver is probed first.
> This resulted in error. A deffered probe solved this.
> Most connector drivers need a encoder driver as their
> video source. This patch ensures we do a probe defferal
> if video source is not present for connector drivers.
>=20
> Signed-off-by: Sathya Prakash M R <sathyap@ti.com>

Thanks, applying to 3.12 fixes.

 Tomi



--wPrF1KlnQsEOGxJdMSCXxjSDBPLx3DSgM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSNtJiAAoJEPo9qoy8lh71gAMP/0tV1nBbUm1NrKrt5N3eAIuI
sO35F43lUwUiVprIgNenNTFMm6Us6iTLj2gqiRvrOz6JQDkrk2GM+86I/pMBXS8V
rWj+tFBOXPJsJOuJbiMHLuVcyGxgc4nB6uwuPDifz3t5CORbOzta7bYOBoq+pM+/
tPD5cPI9S7JA1y/7IO8aVpjOMq8KFeFszUtYMC4DOT7bBswoHla36t8xAQ7WQ4x0
9MOTaTcMMDEzkNje3gEQpTtj5JW5RBeEcfsUej54LyK+aG1yn17jxesDFIyHumZf
9GZ6Gd4633EO/Wjuhm3Ub41takvVJvXXXWCfs38jpOIZnx3KtyCuGqd6dYpjH4hc
YWbd/cHSk9p3vJ9Ll3IOIEDEPhfyz8Lww/egVJqMJ6gnfWdgyFyw4zoRIbLW0DUp
Gai46KZA2bECUeM+mwIoK8K4FSnEcsaJgHyxBCxXh3cxO/CkKVjYDz05GKyM89qi
CQiBgyfPgOh7+G2LPg6UCT5x50DecXPyE/zTBTldbjc7Xudq5UvBuszvsV0cZ8tg
nunL2nt084tEm0xaiCNDD3vH+wjC8TLeDedQ18qadualpLO4abB6Y5sCgmCz9s01
gCZZ7w5vXd+GwoAC8TICyEdc/WFxaOIYSq5EX+ZL9lJdF30Jqquk4lvmJRfjBUMC
X6eDdGgm2pkvn7lZ+H0W
=+bCB
-----END PGP SIGNATURE-----

--wPrF1KlnQsEOGxJdMSCXxjSDBPLx3DSgM--
