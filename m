From: Sebastian Reichel <sre@kernel.org>
Subject: Re: HSI: fix omap ssi driver dependency
Date: Wed, 4 Jun 2014 01:18:07 +0200
Message-ID: <20140603231807.GA13171@earth.universe>
References: <5261510.XDu5DxNnFl@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:41212 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751955AbaFCXSL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 3 Jun 2014 19:18:11 -0400
Content-Disposition: inline
In-Reply-To: <5261510.XDu5DxNnFl@wuerfel>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, linux-kernel@lists.codethink.co.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

On Tue, Jun 03, 2014 at 05:14:01PM +0200, Arnd Bergmann wrote:
> The SSI protocol implementation has an incorrect dependency on the OMAP_S=
SI
> driver, which allows SSI to be built-in while the underlying OMAP_SSI
> implementation is a loadable module, causing a link error.
>=20
> This changes the dependency to the simpler 'depends on OMAP_SSI' that also
> ensures that SSI-protocol can only be a module if OMAP_SSI is not built-i=
n.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, applied:

https://git.kernel.org/cgit/linux/kernel/git/sre/linux-hsi.git/commit/?h=3D=
for-next&id=3D518e1624f56615a88c91bc79c7b4b4d9eb2419e5

-- Sebastian

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTjleuAAoJENju1/PIO/qaBW0P+gNIQQuUewyzScNDOgkdDnAr
FCOU1MFfTLSWNWusD+eSkxQMX6iOyQZ96s075ikkbCKtbiOjLLOHccHp5OUxPd4/
1d2DSxhkUDihcDr4cutgAYUregCwEfLqJiOnMRvkMYBtFFL43ayeMdHKg2FUt6bH
0s8LDyHxxO6YBAd8mHTuzMZzdcMC4S/9AkraTU8yxm0oYg4XM4k5jqbkT9z3Oc4n
88tmOZn4PX9Ykb06UZGxv++Nt4UykA0vjW4jt7wUCF2miQfL0uQuWppgK929OfDJ
T7FPuotCk/cbtyhWpSJbYGZyX5xJWft80x8X8tdc6NEd+mtGIMTL6K1CmSWW6ua0
Vb1DSnzxvgVaLmt9La54TXCK28iIC3jsr8rMDXtH0lzWgLREl4Asm0eQXHu4qbs3
PX0BOCyxPnHy4l0TPIlviAbCkSqYEm/krwuRGSoqacRbHnomuhWg8uziB+tz8UIz
5hFVriS/dsFnXci4qsAoyetKrNxZAZGTCRcJ4geWLHkiUTPb+eTsEmDePJ8nTo4t
4M36hfkVgHTrtvJK8pTBmbfOOwZkM0gPu3++dNi1RExj0x/P5WiI19cgZ9cFSFHy
TtXzhLimsqvP2RLdObffmTLWcacRUPpfuyrhZa1zh2ppja/9d09ml0JxJI2Y5sXF
1AfpaHmquJ+D6ZnVIxLg
=q32A
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
