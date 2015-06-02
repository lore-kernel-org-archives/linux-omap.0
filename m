From: Felipe Balbi <balbi@ti.com>
Subject: Re: Regression with AM43xx devices
Date: Tue, 2 Jun 2015 14:23:32 -0500
Message-ID: <20150602192332.GG9623@saruman.tx.rr.com>
References: <20150602191752.GE9623@saruman.tx.rr.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y+xroYBkGM9OatJL"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49121 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922AbbFBT0J (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Jun 2015 15:26:09 -0400
Content-Disposition: inline
In-Reply-To: <20150602191752.GE9623@saruman.tx.rr.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Dave Gerlach <d-gerlach@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--Y+xroYBkGM9OatJL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 02, 2015 at 02:17:52PM -0500, Felipe Balbi wrote:
> Hi Dave,
>=20
> You commit fabbe6df130a46d5b5e7484b2273d69c4be3012a (ARM: OMAP: AM43xx
> hwmod: Add data for am43xx emif hwmod) listed below added a new WARNING
> during boot to all AM43xx-based boards. Full boot logs can be found at
> [1], but it seems like we should, at least for the merge window, revert
> said commit unless a fix could come it the next couple days or so.o
>=20
> ps: note that boot log is for AM43xx IDK, but the same thing has been
> reproduced on AM437x SK.
>=20
> [1] http://hastebin.com/kasenikevo

Seems like someone forgot to pick [1] up. I've added my Tested-by as a
reply to that thread.

[1] http://marc.info/?l=3Dlinux-omap&m=3D143093317331247&w=3D2

--=20
balbi

--Y+xroYBkGM9OatJL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVbgK0AAoJEIaOsuA1yqRECCAQAIMvV35mpDHfZpP9TvPKKz1K
Z9GoQXaTx2HNW6kDAkJUIXlhj6Zc44B8dVKCVrNhd5sRKcgQ65aeVoWHTP3xaza0
DFPEvk3s0RSOd4Tp8IH3uibHT+JIzMx6PGyPsnEcF2aheveQcIsu0D+fxh3uV6wn
AaRnkFfP0uStVCHFZ0acwlKy1OuFZ7Xp1/XlEfhkW2U23tqTbIGRR6giEMDxAFDV
K0TCzbMK+aq18Mo3CU5YVsvydQ9G+NzbO7KGjnRpH5KmG4WxuSEQYxUh/BG5A0Zb
Hd3xL7U+tarRmdb83yl5v+csRJOrnRt901q+un+4iaBWS1UM2hHomPX3oNgMqibz
XNurZzzfCaZJTI+E4DYsnD3BhAi9QmaoyvYpymaukmx8g1wOAQoQUiJ78ehlVhD8
IUL2QSf2167SrtGeVBbwa4b7xUfY9pkq+Jwk1NWRwGI2uSaOOHUITcNZ81ncc+Gc
2Dp8SeGNDfy+7D6KbYPyG0l5WDVv6slwI5tMHxaDAz6qe6Rhmg2RfjrCYYBPDg8J
6sH//9089zmJ9z/VTmzwX+9FJsBNCFfNUSa8aBJMky3XqJqkxG5CuFD6BIYvcWqp
AUwU8fmEfTguWao+T5E1ymdAPLUzStxYKOLsRcNbs7Gz7SjdHQKUsFbEsNl8NEaz
G+ohQNu5lbyYFhyUOkrN
=v0eg
-----END PGP SIGNATURE-----

--Y+xroYBkGM9OatJL--
