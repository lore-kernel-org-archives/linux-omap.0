From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH V2] omap_dss: add FocalTech ETM070003DH6 display support
Date: Tue, 22 Nov 2011 12:04:36 +0200
Message-ID: <1321956276.1887.40.camel@deskari>
References: <1321525575.1919.78.camel@deskari>
	 <1321812939-22620-1-git-send-email-yanok@emcraft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-DGuoeqaFo/czg2Bx9g2W"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:44101 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752590Ab1KVKEl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 05:04:41 -0500
Received: by mail-bw0-f54.google.com with SMTP id zs8so5235bkb.41
        for <linux-omap@vger.kernel.org>; Tue, 22 Nov 2011 02:04:40 -0800 (PST)
In-Reply-To: <1321812939-22620-1-git-send-email-yanok@emcraft.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ilya Yanok <yanok@emcraft.com>
Cc: linux-omap@vger.kernel.org, wd@denx.de, dzu@denx.de, sasha_d@emcraft.com


--=-DGuoeqaFo/czg2Bx9g2W
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2011-11-20 at 19:15 +0100, Ilya Yanok wrote:
> Add data for the FocalTech ETM070003DH6 display to the generic_dpi_panel
> display driver.
>=20
> Signed-off-by: Ilya Yanok <yanok@emcraft.com>
> ---
> Changes from V1:
>  - acb, acbi, power_on_delay and power_off_delay fields removed.
>=20
>  drivers/video/omap2/displays/panel-generic-dpi.c |   20 ++++++++++++++++=
++++
>  1 files changed, 20 insertions(+), 0 deletions(-)

Thanks, applied to DSS tree.

 Tomi


--=-DGuoeqaFo/czg2Bx9g2W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJOy3O0AAoJEPo9qoy8lh71NZoQAJVaN/i+XgEzucBkH44CLzCb
jJwHr5InAYUZMPCoiBSe8G832p4HTaPjm6+RFDeLjx2DCBQt8iitVD5vc8rvtiMS
E6lsmuLn2bPZmvlmrBUysN3Ef84w7uQIo3WlaWmndL3riOXSLvkzAPJoZE4xMD9K
d/Tmp21Hrz+fBd9+7tCMqwtIOUMx6jUUJSEE9lV3OINm+0CUsY/1uOk9S7cy0uGs
yh0S0tQahBzt0mkMkLXpvO6l5cYbPmkaGXdyLwPN2z6b4obLrGDuSj3oexpVS+9I
iXBNcUDZdX7+iMrYq5Zp1LIanpjmzjGXuptgLJdBN7OHiLc2gAeDUCWBSz+j4HQD
kElGHd+9Uh8fejRgeFxj/tPXQW4jUQkX0+PmDtuhnROCCqvt8UdPSC7rh9Ts3XsU
MkTwVRt0MQvba/3XyqijswrQP9I7SGDPAjpkDpM498/3o/crLaEFM2BwlE14RiyU
iA2WnFYy34am6OSxRYpGGSqgrQca8sP7OzDazTIdcARdtbnQuxO6c68ftsCj/N3y
zPxxm+6k3LSqiSoFk/4qtsRqOXA7jXtCSNxAMMdbx2LcQMIOtng3zDD1fpfM1fRn
s5OJylhSnvEfATdDD+hv+F0Bwwfugn4nHt3oUCR89XGdx1PB4MW2ThgY7bFdaYbb
5mBRhwIIBKMBIe7Q/o4n
=AaAc
-----END PGP SIGNATURE-----

--=-DGuoeqaFo/czg2Bx9g2W--

