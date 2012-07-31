From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: HDMI: Disable PLL properly in case of error at
 power_on
Date: Tue, 31 Jul 2012 11:50:49 +0300
Message-ID: <1343724649.2633.23.camel@deskari>
References: <1343693522-26170-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-9FRzyh9CjVEDU6sejkDF"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:56051 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755849Ab2GaIux (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 Jul 2012 04:50:53 -0400
Received: by lahi5 with SMTP id i5so4716157lah.14
        for <linux-omap@vger.kernel.org>; Tue, 31 Jul 2012 01:50:50 -0700 (PDT)
In-Reply-To: <1343693522-26170-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: archit@ti.com, s-guiriec@ti.com, linux-omap@vger.kernel.org


--=-9FRzyh9CjVEDU6sejkDF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-07-30 at 19:12 -0500, Ricardo Neri wrote:
> Small patch to disable the PLL appropriately before runtime_put in case
> an error occurs while enabling the PHY.
>=20
> Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
> ---
>  drivers/video/omap2/dss/hdmi.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)

Thanks, applied.

 Tomi


--=-9FRzyh9CjVEDU6sejkDF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQF5xpAAoJEPo9qoy8lh714nYP/RCtAb+Lbe2M7wxfEJp+QQVu
OgMK3q8HlTfs7IfDsjudnp5Bjz1sZghUomjYdsUFtR7mgy51Mu3T41BCZiVf3ZsN
6buCioTC8PmW1ph0Z25VdgBQ4b5H44lngCKFghsU7FezfwXiBcR+/3kfVS7CLGUn
wN3RlPZtrV/UdIDzKm/fgiCp2Gfc1vN4cxvuh3dlMa1glMGtiP95zM0QLcX6NYt/
KBEcnnQePFG1hCEgtZabA3D2fo+0WV6q3/GdlCc722cbg6902/b1QG1ayzhfs4sV
RQaZiVn5Ke0flM+57uSJckfpgfo/nJ8jxR/C0gfsVwlvugqB33D6S8SRcD3LuxBX
4nhzH9/J7T6h9YvClMnztSigxsN8smXkzIQQGKcAYQSx72kUjsqT72ha92CnplmU
MtGx1h/o55iM/VqNgSRG6/BB4uVRm5zMCcmra/gzL7UWQngkMYn1k8rzf6pP5SZE
uBc6RSrzh64LCKjVCPzY7zs9n7Fp+yh+L/+ozMLwYL2AipSDq3LiJbTLtTEGCg47
Icy4j9Bc5Bu/9FCFA/LUVMj+GT21/LKbGFaqBAYbPynmZu7C8gunT6gIiFt4pfkn
P9DgsN17pPk45dERt0VXylq4K2COiPRKSwyFTTl0OHxpDCAnSbb6Hhw+5YQuK+bX
it16eTpZXyDUWR/2d+mP
=p7sI
-----END PGP SIGNATURE-----

--=-9FRzyh9CjVEDU6sejkDF--

