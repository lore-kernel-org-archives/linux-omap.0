From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/3] OMAPDSS: Miscellaneous DISPC Fixes
Date: Wed, 22 Feb 2012 10:29:53 +0200
Message-ID: <1329899393.2070.19.camel@deskari>
References: <1329833192-16529-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-Iu/6KvDJjRfzu9JxvPEl"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:55473 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752632Ab2BVI36 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Feb 2012 03:29:58 -0500
Received: by mail-lpp01m010-f50.google.com with SMTP id m13so10780914lah.23
        for <linux-omap@vger.kernel.org>; Wed, 22 Feb 2012 00:29:57 -0800 (PST)
In-Reply-To: <1329833192-16529-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: lajos@ti.com, linux-omap@vger.kernel.org


--=-Iu/6KvDJjRfzu9JxvPEl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-02-21 at 19:36 +0530, Archit Taneja wrote:
> These are some minor Display Controller fixes.
>=20
> Tested on 4430sdp and 3430sdp on the tree:
>=20
> git://gitorious.org/linux-omap-dss2/linux.git dev
>=20
> Lajos Molnar (3):
>   OMAPDSS: DISPC: Fix OMAP4 supported color formats
>   OMAPDSS: DISPC: Fix FIR coefficients
>   OMAPDSS: DSS: Add runtime_pm protection around wait_for_vsync.
>=20
>  drivers/video/omap2/dss/dispc.c        |   24 +++++++++++++++---------
>  drivers/video/omap2/dss/dispc_coefs.c  |    9 ++++-----
>  drivers/video/omap2/dss/dss_features.c |    3 ++-
>  3 files changed, 21 insertions(+), 15 deletions(-)

Thanks, I've applied these.

 Tomi



--=-Iu/6KvDJjRfzu9JxvPEl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPRKeBAAoJEPo9qoy8lh71r/MP/1YWCrMNS85cnJuOHAyw5uzk
9xmTP3/EoNp6PPTDQWAZkdAPUKYl/dny/A0QpHJbR+/OgFX4U9gyXOYfxvu7uFfI
0nEnrQ0m60x3pPooZ2e/l4xN2VWzU7yK3BAc1w0ZYNGJ4cByZCLPNJKp+XfpkTRm
9BOB3d5o5am/5PBF9BG1CKVb7+vwVyomE56D2YN98pFeLa9xOMwdbW/fK2Ai+5HH
XCmFrDFEm6LClwExVA/nDhW1zmj/uLm45MvuNNc1nQtm05f95TGoAr7r4XuG7Vt4
qarog9OlrlIN3SFhzR/209MSJfh9ofhlgrpOY/XET/SKFbCFuvExPXhRZrRAR5f8
Glcvabuk6n5FGaaZ4aXt7/z6+8gH3/+2oFNkNaiE0YsbzFsYvYDAkdPKRBmp5U1s
2cKka3lNxDYsciSmmzRJVtizbflqlkpCaJCl5QST9PAVVomoBMU9Zw3pBmoEWl3s
eHFtINkcGZLoFSYMkYvdicq96BMhCBeI04Lrn47CoSbg4VUM4x8+mP8sqbPeLIE3
NngE8WcrxEXRnyCeXvw3QB02K69sGP3kRVT8hqPNw17hmaWhS63sdFBC01fKu44+
dl3yFeFtQIZGA0NoLS/56H1c7GljtgHCnhSbMz4/zXqaJaQdb9k7LBOzHvFxpaxc
JWm+JXk1be035+NJlioo
=RciB
-----END PGP SIGNATURE-----

--=-Iu/6KvDJjRfzu9JxvPEl--

