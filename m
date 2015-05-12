From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: omap: implement bus recovery
Date: Tue, 12 May 2015 21:19:34 +0200
Message-ID: <20150512191934.GD4449@schokonusskuchen.bad>
References: <1430931027-19955-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HWvPVVuAAfuRc6SZ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:35530 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753878AbbELTTo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 May 2015 15:19:44 -0400
Content-Disposition: inline
In-Reply-To: <1430931027-19955-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, linux-i2c@vger.kernel.org, grygorii.strashko@ti.com


--HWvPVVuAAfuRc6SZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 06, 2015 at 11:50:27AM -0500, Felipe Balbi wrote:
> implement bus recovery methods for i2c-omap
> so we can recover from situations where SCL/SDA
> are stuck low.
>=20
> Signed-off-by: Felipe Balbi <balbi@ti.com>

Applied to for-next, thanks!


--HWvPVVuAAfuRc6SZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJVUlJFAAoJEBQN5MwUoCm2go4P/iHlUdQ8xF7iPUifcXptdUDm
DsO6C8+6fHQzgaieZmZ+iiZ1BTvE5JjyezDWSnQ9QtxSUMpwPKbU95fADsRJcXwG
TQmYirYEvqdatzo1cEA0ArTctvT2yrzHGDWu2JfFB5QuREmdWCNQ4+URJ5rfrSnn
j4VVCLFfTEgltvX46hlD/jkWSim22cDI+0RWBOBpN9Td++OJXsZ2rt89Y1W+Fkx8
uCweYVUSALduOTpRULMSR2IK6ju40v6IWXAqKAUDIl0OuQAlCOtDMi1uVLD+uv7r
qHlTrrvMj2HGSCJl+3vwKPHZmNZYH52dfXuhzTi13dKYk1mf1rZr4cxZwEh/UOGx
P5iYHsquv84nYtI0GSxCE3QkGIcIkLnbYODJM9JKvAuPPSTDP3+PK8Upqz/xpVzH
cl2MyLNr8T8Vr7rjF4MiSp7i9q3Oj24DU2JlPyxJRmRC/Z5H76+e9+P7ij+oXnqj
4EsKNy2fU9yLQd0vFj0BAIxN0P9BHyGn9V6zvYeX4WLH6zteLTn+/Kw08Jd6gDUd
JxGrGcRejjnBrV8tUWRlRiZP/JfaXXokRmCYoECIGDCqXfqsCb3fI8sQLHIGqdAa
D6Juxtz2TFZOS3XG0kzAilaUVaTT2zPrEnwNDYx4LFkPBOktEsRUP+LRzHobZM5v
zdaXzSF1yRBSQcpikypw
=Xfei
-----END PGP SIGNATURE-----

--HWvPVVuAAfuRc6SZ--
