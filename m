From: Felipe Balbi <balbi@ti.com>
Subject: Re: [patch] usb: dwc3: make dwc3_get_device_id() return the id
Date: Mon, 6 Feb 2012 08:44:38 +0200
Message-ID: <20120206064437.GC15652@legolas.emea.dhcp.ti.com>
References: <20120204133714.GA4413@elgon.mountain>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zCKi3GIZzVBPywwA"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:48470 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750792Ab2BFGoo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Feb 2012 01:44:44 -0500
Content-Disposition: inline
In-Reply-To: <20120204133714.GA4413@elgon.mountain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, kernel-janitors@vger.kernel.org


--zCKi3GIZzVBPywwA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 04, 2012 at 04:37:14PM +0300, Dan Carpenter wrote:
> We always return zero instead of the id we found.
>=20
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied, thanks

> ---
> I don't have this hardware so it's not tested.

This one is so obvious that I can't even believe we haven't seen that
before, thanks ;-)

--=20
balbi

--zCKi3GIZzVBPywwA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPL3bUAAoJEIaOsuA1yqREaaYP/Rsyh2nvqBTB1Lm+F/aBiJlF
TqgpbmKPiobsOGX39zG870X/iwx/R2lcOfwxKImnbJa2BTXXC5Amx/vudmhRn04h
4C4vkM6eBByPSOQbAfDDEzy6/KvjbbD6w1CEU19hAQZ8N69zWNbyjan/52qVLtcs
BN++hb/SMBgccgIw83chPugGYLat/4K0qPKwtmidygn/59K2jcRNAPGo/27NQMLI
lp0TASYW/T2mzy9ad8+eETmbvs6JvWjkgnvGuvqDf2F67AlNnF1wISJMDlxSt/hz
g2hHC8v64S+06g6EKgMNHmSkSbMapnknZxPIdJaptOvV62E/WWSLkIFI2OBobEXx
sZ8oWTLKG3TXEVzPt1WfvmggmxCbI9j2DRgn6Xl6RDIIaDpM3iyhv0KARLHc5p8E
4mqrR0U8xAWDy2JTbaC2iAYFezoVFpjZDK+7fG7JK++UdskqAVlPislMlOsQmoXM
JjLdQ3cTewimg3Ir7+z1geKMb3hRjjAAn7mEHK/wQSwiXsqExT6xxaQGp65VV29K
73KBPTvBopGkcbCQb56fXwLhLaobqbCFjMrdEi909DVTNGjPEqEkGzXttN/2r5F/
TyQIP5ye+SuLFfhTjAhNqjDTd4b/WdiLhgvqGy1++hDGqmUx0Atb+fBAlF8DErKS
90EkSBXIjqfbfdM+8lJY
=1Pxj
-----END PGP SIGNATURE-----

--zCKi3GIZzVBPywwA--
