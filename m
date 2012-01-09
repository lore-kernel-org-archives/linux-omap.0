From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v4 0/4] OMAPDSS: HDMI: Improve the timings logic in HDMI
Date: Mon, 09 Jan 2012 09:01:17 +0200
Message-ID: <1326092477.1900.12.camel@deskari>
References: <1325852530-4829-1-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-MVHJZG+v0qZsWDz8Ge7b"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:53888 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753339Ab2AIHBW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Jan 2012 02:01:22 -0500
Received: by mail-lpp01m010-f44.google.com with SMTP id h2so2080716laa.17
        for <linux-omap@vger.kernel.org>; Sun, 08 Jan 2012 23:01:20 -0800 (PST)
In-Reply-To: <1325852530-4829-1-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mythripk@ti.com
Cc: linux-omap@vger.kernel.org


--=-MVHJZG+v0qZsWDz8Ge7b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-01-06 at 17:52 +0530, mythripk@ti.com wrote:
> From: Mythri P K <mythripk@ti.com>
>=20
> There are some duplicate timing structure which are not needed thus remov=
ing
> them to clean the code.
> Also the static mapped timing structure is quite complicated to add new
> timings, so simplify it by using array indexed method.
>=20
> changes since v3: Remove double call of function
> changes since v2: Incorporate changes in find_timing function
> changes since V1: change of hdmi_find_timing function to return pointer t=
o the
> timing struct rather than deep copy to timing structure passed as paramet=
er
> variable name change from temp to timing2 in comparator function.

This patch set looks fine now, thanks. I'll apply to dss tree.

 Tomi


--=-MVHJZG+v0qZsWDz8Ge7b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPCpC9AAoJEPo9qoy8lh71AQIP/12YWcUxvsIaY3e4643fBERu
QiQlz5mECaFjzRV6BPgX+aXy48aOEEbRFSX8HkD3UeJ9KY1cbhIpPipYhsZpgPuS
xKyrsGhE7RvwT7LDetGD3rA+y1w/OMDPsr/IVcZTvjux48C+Zkv49025/DbpygKY
D4VZrG1fUuutZpSr0W2albUIZogXlvKhjv8sTs/s9RPMx2EZ93VwbLNicwDbWYni
HxDPsEc7OuwWEcuLR0R58Pml0uw8fpbTQjvNHsM/OeVA318MuNFlNDcNPAvWdkco
7ANBLTGq5KKKVz4HkWw+zLF3qBPds6Wd+iMRajClGOj/GIHbvzQj2GZ4yLgFonRu
DdrKOus5h/lwPwufBe6R6TvFlGaNWwo7OjfQCFMxIU7G2tLbPOEADmG4G3lvt3wC
AjQgsSothM2Rq8u/eWAwXYQGi17rMQkXS4UwG5tlLoWSlq9793hdK+nbVCZ7qRfG
HWgOF2a7D9Rw1PaJW7BOo6t+AcIf7gsh0r0KF7mme5iR9Pps9Ycri1gL7vHVDZgQ
OaHwTB97dKwreFCRAhbFB1JwgYLk0bI7prGwI1rgZZGI7HRSsoZwvE/6N7MBFRAA
Bf88JBGfHRw5EUHEhQlnJA+nqeEdfmXpkRCrUEZ7AGQDhwqB3StfwIH8aNL6CjQb
Pc0oZXElT3zVqzoc3D3F
=j9rJ
-----END PGP SIGNATURE-----

--=-MVHJZG+v0qZsWDz8Ge7b--

