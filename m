From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH V2 0/3] OMAPDSS: DISPC: Enable predecimation for DMA
 and VRFB
Date: Tue, 27 Mar 2012 13:49:33 +0300
Message-ID: <1332845373.1867.118.camel@deskari>
References: <1332323484-8975-1-git-send-email-cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-Fdo9h6HxKrYFx1DFpJBX"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:33156 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753821Ab2C0Kth (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Mar 2012 06:49:37 -0400
Received: by mail-lb0-f180.google.com with SMTP id n10so7943757lbo.39
        for <linux-omap@vger.kernel.org>; Tue, 27 Mar 2012 03:49:36 -0700 (PDT)
In-Reply-To: <1332323484-8975-1-git-send-email-cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-Fdo9h6HxKrYFx1DFpJBX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-03-21 at 15:21 +0530, Chandrabhanu Mahapatra wrote:
> Hi everyone,
> the following patch set directs to enable predecimation for DMA and VRFB
> which consists of two pacthes.
>=20
> The first patch is based on code written by Lajos Molnar <lajos@ti.com> i=
n
> Android Kernel, which updates the code with predecimation logic thereby
> increasing the downscaling ability of the DISPC module.
> In version 2 patch description has been modified include reason for maxim=
um
> predecimation limit of 16.

You should have the version changes separately, so that they are easy to
see. For example, a bullet list after the intro text. And you miss to
mention that this patch set adds a new patch to the series.

 Tomi


--=-Fdo9h6HxKrYFx1DFpJBX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPcZs8AAoJEPo9qoy8lh71bikP/3TUW4Cy8f73984YaGIit0ka
qV2Mzaofl1ZYmQEqby955eMwdeC1V+Wk3bwkheBc2DlT4/YLNHZE1iLXNMOTPNp5
PYjcrVOXh7Dxd379QC53sw00eRDtEbo5nRR+r03IJGDWd8qBouO2DwPajuWHFeIe
P4qT5SyrCn1h8RpJ/jVpLgFTqXniuvzRS41yTUmNhEhACu50Hm9F/O56EWFZ7ORS
miUbOlYfV8+u7py1kD615Cor8InoeH1IUEBbNZSxtatV2OCX055jI0rTdWBTQebZ
/JqGAeH4IrRf8AruNil/3J+IKkJZr1WT0hdwJrc2FY6JUgTOjbFoEBXWK1ALe8xx
eXtSo+ZG6pdFexRIiV2Pxstptwlr6Y0fIWsnBihxH7lYRUjEWcV6XPZf7GNlvrkW
L1pad8hQjiJX46VrDh+Xvjh0/SnidU7miRysfmvVjyhIayFV7PeD1lniBA9xdLyc
JC6ORx/iV/R/U+N3C010QyDjt2lvZr+BDIvshTfFY9N2FJOXaLTus7zy62AO7qke
fHa+GGKT5BRzQgyx3iy4XpPv66fgPhXFjA1VflMH3j4JO0YNZUbpzdlAj+25fXdn
xv9+h+Y+ALiI9iSZbw9UzHF9OGDbM+INKMEb3odDKEnVw0Zaywf67paCHPfwJwQT
U3Kc8I+gSwrhcSw+nwmh
=eGCL
-----END PGP SIGNATURE-----

--=-Fdo9h6HxKrYFx1DFpJBX--

