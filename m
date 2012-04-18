From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] remove unused FB_OMAP_BOOTLOADER_INIT config option
Date: Wed, 18 Apr 2012 17:16:42 +0300
Message-ID: <1334758602.2027.35.camel@deskari>
References: <1333443555-21559-1-git-send-email-pmeerw@pmeerw.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-gVj3VOQ5jrc/kz573bwV"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog130.obsmtp.com ([74.125.149.143]:50195 "EHLO
	na3sys009aog130.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753427Ab2DROQs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Apr 2012 10:16:48 -0400
Received: by lagv3 with SMTP id v3so7215080lag.13
        for <linux-omap@vger.kernel.org>; Wed, 18 Apr 2012 07:16:45 -0700 (PDT)
In-Reply-To: <1333443555-21559-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-omap@vger.kernel.org, Peter Meerwald <p.meerwald@bct-electronic.com>


--=-gVj3VOQ5jrc/kz573bwV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-04-03 at 10:59 +0200, Peter Meerwald wrote:
> From: Peter Meerwald <p.meerwald@bct-electronic.com>
>=20
> code depending on FB_OMAP_BOOTLOADER_INIT has been removed long before
> (e.g. Tomi Valkeinen, 03 Mar 2011: OMAP: DSS2: Remove FB_OMAP_BOOTLOADER_=
INIT
> support), but the option still exists Kconfig and has no use
>=20
> Signed-off-by: Peter Meerwald <p.meerwald@bct-electronic.com>
>=20
> ---
>  drivers/video/omap/Kconfig |    8 --------
>  1 files changed, 0 insertions(+), 8 deletions(-)

Thanks, I'll apply.

 Tomi


--=-gVj3VOQ5jrc/kz573bwV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPjszKAAoJEPo9qoy8lh71IccP/RlIn4yiRBWJF7v2WcpPcw71
opL8Zt4+e69Xyz+07KiSwAOWVDfLwRq1yaPER8ILLTtbAzGMjsy168wdWwren0AR
iXKoyR9ghUitN3QBUwAGL6ERPgxHFDDTYaFX0skonT9YFXyvtW+/H6XrfZH4zpXS
xr3bS5keLjLW3dKBQLmjRbbPcy6GBD97bBMRm3LsqH6eK0uWnjZq1cDH2g1yySCl
OYwRxFtpCHxO/IAUIZ5mf564lS8l1SA/A2y+6g9sVJmrFzrWTqgslkPthFv8Aq0J
iZk9xfpmmeEzhYwt5IZpSeTG84JQdGEgKpCAie0HQT0hrrHjgBqhGVRUsrSp9gP7
gCixa2oe2eXYQqwL1jIX6/JOuwJzPqPjEl1x59GEQb6miKkpMzCVEDV2Sn3nggpc
fbUoHp33Nim81ZSmfEqUhM2BQyB4ycTDG86ohfS/AAExSqweXCbSKUrm+rWXTc94
vdJQ91eeiray/MMi44Ch4ASFVHva5Fk9La08ZAqsPHoMzXDXWpvTjf1ZJEmWIC1R
DdGYD8TriDemcXbvazXr7ZpIv3x7wNlQr2GJ57DNZ9RFtHTqstL4Ts9k10oEKvUr
Ve/vcL3GmqMpWQW2tk1qKIpNv9miQJKMlwfdx3Ol73kodCThFv0SpPK+RH5AUjRg
ad0SjT1jDJSTnlmDYi8d
=kpDA
-----END PGP SIGNATURE-----

--=-gVj3VOQ5jrc/kz573bwV--

