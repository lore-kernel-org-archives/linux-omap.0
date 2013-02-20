From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 7/8] ARM: OMAP: hwmod: extract module address space from
 DT blob
Date: Wed, 20 Feb 2013 17:42:58 +0200
Message-ID: <20130220154258.GI16652@arwen.pp.htv.fi>
References: <1361374735-22018-1-git-send-email-santosh.shilimkar@ti.com>
 <1361374735-22018-8-git-send-email-santosh.shilimkar@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tctmm6wHVGT/P6vA"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54511 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935543Ab3BTPnE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Feb 2013 10:43:04 -0500
Content-Disposition: inline
In-Reply-To: <1361374735-22018-8-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>

--tctmm6wHVGT/P6vA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 20, 2013 at 09:08:54PM +0530, Santosh Shilimkar wrote:
> Patch adds the code for extracting the module ocp address space from devi=
ce
> tree blob in case the hwmod address space look up fails.

IMHO you should lookup on DT first and if that fails try hwmod ;-)

--=20
balbi

--tctmm6wHVGT/P6vA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRJO8CAAoJEIaOsuA1yqREJ1kP/AtL/da4WfLYtK8ppHgxv856
wz5nsZwBRchRfJ7wtF7NFiNxdsx6CGdurvE4J9OGMrxk32pfnM1PrsFWvFcJAZJv
k4xBVRzX9L6gMNwzP3ar0QzSGDdN2HRXKC8o6dOe3y7sziOv7ImAW6J+OdYBh8Jr
MsEAELNmTG+8hYutXRevj4TKz0nVPH8BjQS5hHK3Bzav617uri21DzNB+0fZUVkQ
79FZfpY5PnQIxgAspd/ndM8nurGEaPJ9JYibBSIoMH97QJyq1gYp2vUAtXrBQq87
JXH8uVWhAnjRbli6IEPMxqNu0tLXqbCjYQl5yz5r3POfxkVPDmltPEfkDiOiJpBi
ofQ9zni5gM4OLXJg9unVdf9BJ9KD6EOZyZJLrHc3Obc1W+QpTtCRynzXj+wKTyZ7
rXIHJKA7oKX7wZ0OSP39qxySHhPVxaLC7Oj4qZridleJ0uiSx1YaqAQl+ErJki76
jAD5DLLVSuUAHcLnJxqkDpzyx96NDf9fuKPmoUJ5gNs4YQ/xeLf+4bDfFfz9PgZD
0sdRWTpwjMf+q6auojh2tA4eCjVWFH2aVt5n9ecEybcmSjJXUNhtQ9WHsnZ7KMMV
UCshzZQX1EFDPNY4+66s+M95i+7FE8uvSNpPlxYCrbcNIeUMxTmn85fNw0ZkCMKz
jx4A2mktLT/ypIoJ+WpD
=pQkX
-----END PGP SIGNATURE-----

--tctmm6wHVGT/P6vA--
