From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 6/6] ARM: OMAP2+: Remove omap4 ocp2scp pdata
Date: Fri, 17 May 2013 23:05:31 +0300
Message-ID: <20130517200531.GA17851@arwen.pp.htv.fi>
References: <20130517191304.468.73487.stgit@localhost>
 <20130517191803.468.32800.stgit@localhost>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55349 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755998Ab3EQUG3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 May 2013 16:06:29 -0400
Content-Disposition: inline
In-Reply-To: <20130517191803.468.32800.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Felipe Balbi <balbi@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>

--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2013 at 12:18:03PM -0700, Tony Lindgren wrote:
> This is omap4+ only and no longer needed as omap4+ can be booted
> using device tree.
>=20
> Also remove the related pdata handling from the driver and the
> now unneeded platform_data/omap_ocp2scp.h.
>=20
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Olof Johansson <olof@lixom.net>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

fine by me :-)

Acked-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRlo2LAAoJEIaOsuA1yqRE2qwP/i3VFFd8mwyEqsJlggmFDBZX
7dW0J5REuBPa2/rHeQmpP9/REalolbm4xjGZtFO3QqskC011NQHiCnr0tVfk8ZV6
KzUPgxoXPw4JqT2TQ9SRVwMyOSULCX+4eJMksD4exqw/vVz7iKltpgtAibWqrtrc
zqFSMMEXTYp46FaGyWppZy048un9b3j6mpoeTnHHuz1ppuGy7KwSbieFMCOvTWbd
5WGfOHGKp+5uhWETpPYhwO0hyLCv855MuyRwr2FxHuZg8VoSVSMKXxWARu8DF6Yc
rdsLunNR8ZadRCbDDn8x8vkq2XW82LfNOrGEpAq9eC6KCQEY1wj0iItI0VnJEa0u
wX+JiSkflH2pw5Ymeo2EPpnynh2OyASoKsBzUhQe43p33pbQdh+xZNcB0P4GA293
eHgGEypSTNlSj0eNoUNnTKpqY0xo3F67FB2f88CmOuw/Aw2jxgKQFD0NYk7Z9B0Q
ZW1sT06gzSPKcB/IjF6RpxvzpMJZWd4yNhXNKcHpkW3a9zluLhm7UeeQNTTtQMfx
Y0iFgR0lzuaBxFmhxG536m5rgX5O3t4DbsJE616f2pIfsSkaVB1pAkBW/DX35+Qw
fxPcZp0Ifs2i4+T/diILuyaPeymdJSAf71I4fJ6ZhkPOARk8WjWJvJ7FDCMhXean
yd6OS1/VK+EMgweAxih1
=MHOK
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
