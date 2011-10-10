From: Felipe Balbi <balbi@ti.com>
Subject: Re: [v2 2/2] usb: musb: omap2+: save and restore OTG_INTERFSEL
Date: Mon, 10 Oct 2011 09:08:25 +0300
Message-ID: <20111010060824.GE31707@legolas.emea.dhcp.ti.com>
References: <1315412364-21384-1-git-send-email-vikram.pandita@ti.com>
 <1315412364-21384-3-git-send-email-vikram.pandita@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lteA1dqeVaWQ9QQl"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:47750 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752027Ab1JJGIb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Oct 2011 02:08:31 -0400
Content-Disposition: inline
In-Reply-To: <1315412364-21384-3-git-send-email-vikram.pandita@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vikram Pandita <vikram.pandita@ti.com>
Cc: balbi@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Hema HK <hemahk@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>


--lteA1dqeVaWQ9QQl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 07, 2011 at 09:19:24AM -0700, Vikram Pandita wrote:
> From: Hema HK <hemahk@ti.com>
>=20
> we need to save and restore OTG_INTERFSEL register
> else we will be unable to function on resume after
> OFF mode.
>=20
> Reported-by: Devaraj Rangasamy <dev@ti.com>
> Signed-off-by: Hema HK <hemahk@ti.com>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>

applied thanks

--=20
balbi

--lteA1dqeVaWQ9QQl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOkovYAAoJEAv8Txj19kN1WAwH/2U5LU9knlaG5wPgDmcJIrxZ
6P9nwWI5/OdIX40r5YelToP8KDlZNCf2vPiZS56G86YM50x7MitTMha0QMTc9FPo
jV995X3GtF390mx039J5NC+ukF+VoPtyLQyhWsJCwg2mrI/9jIeKsB0gWYF/rOIt
5DCiPzGlMDr9cLquE1mYDkprQg+RCF2FKyRB6tIPi6SNHaEdU+ws8HfLUraCzz9z
iWZn/266CDCDr/tMdm2GgT57FjlpOXaUNuDDCPPZHvE3wmcu/qdhLVYk0SLowGhG
CPiyvtM91mI0DBY/KY24Uz25JCzYOGb4EsTVf1XHI1KLYBwA0T4eKMOHBZeN3wE=
=63ES
-----END PGP SIGNATURE-----

--lteA1dqeVaWQ9QQl--
