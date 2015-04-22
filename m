From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] omap: i2c: Add calls for pinctrl state select
Date: Wed, 22 Apr 2015 10:12:40 +0200
Message-ID: <20150422081240.GH1511@katana>
References: <1429283277-28161-1-git-send-email-pascal.huerst@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dx9iWuMxHO1cCoFc"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:35131 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934219AbbDVIMp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Apr 2015 04:12:45 -0400
Content-Disposition: inline
In-Reply-To: <1429283277-28161-1-git-send-email-pascal.huerst@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: pascal.huerst@gmail.com
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org


--Dx9iWuMxHO1cCoFc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2015 at 05:07:57PM +0200, pascal.huerst@gmail.com wrote:
> From: Pascal Huerst <pascal.huerst@gmail.com>
>=20
> This adds calls to pinctrl subsystem in order to switch pin states
> on suspend/resume if you provide a "sleep" state in DT.
>=20
> Signed-off-by: Pascal Huerst <pascal.huerst@gmail.com>

? Don't you get a build error? I do. Rightfully, I'd think, there is no
pinctrl-include.


--Dx9iWuMxHO1cCoFc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVN1f3AAoJEBQN5MwUoCm2MLgP/3s3iOT+Uor6cw4IAGP3vVD7
rjmt/dADrGx0KMtmjhotAcu7+YFPQ1byLyksvWsCVaX9hpeVlaVwPP3uqMMt5vax
I6BqjBPo6A7jyYECcV9FE0lSX6pqMaOpjj1L5cxWcpgLq9QEGmz0CLtZDM8Rfgud
XNq/yj6PTZxmh+vNBoLTC1bw/QTTQ3im2ebV43shaEpG5ZRL4jXb+r4PBVExPUGt
DpCoID5RhNqGMwg8E4qa6BeEdTLOOEY8oY97TSJD7oYPcSEMMX6m1RjvYaW/HKw5
PSifCjfsli4d/YjPLJX2AEOWQ9cSkR5I+nV2zvSwzIsKKozV2aQHLjzpzowSZdWN
mvqizNzU472JxexPSf1H4qEZJCuqJN2ubxfaESUC53937Kt2q07H+AUvoPmjVaii
c/YVJuZ6aWrvUBYBpmWASkTZMUJLwvKVpNF//04z0Y7oLsBM2rrMDNxBF60lJ8x3
D/8wMS5a3vwALxqh+olNckQfQm1+cY2gk2srQQrjwDcAWLHhQpPap0Rtavt+B4jW
VdKfAwuQcfmUA8OQbTrRT2QwBCFeK8CcLr/9GpprlTIEA1J9erSn7s57Z7/2FxS1
Xnl89aCnkabIF48s51ap9Hgbkn8HOOE1SAyfEM4dcIQ7vtxpr5tz6zi1cUDRoPTb
PJCzYq5JUsWK5LDBbj+M
=srmk
-----END PGP SIGNATURE-----

--Dx9iWuMxHO1cCoFc--
