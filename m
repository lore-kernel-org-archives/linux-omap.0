From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: linux-next: manual merge of the crypto tree with the omap tree
Date: Mon, 27 Sep 2010 14:33:00 +1000
Message-ID: <20100927143300.9fa73063.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Mon__27_Sep_2010_14_33_00_+1000_lY_9B/G0u/26Mr8G"
Return-path: <linux-next-owner@vger.kernel.org>
Sender: linux-next-owner@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Kasatkin <dmitry.kasatkin@nokia.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--Signature=_Mon__27_Sep_2010_14_33_00_+1000_lY_9B/G0u/26Mr8G
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Herbert,

Today's linux-next merge of the crypto tree got a conflict in
arch/arm/mach-omap2/devices.c between commit
5d14f2792f9d63c5d25903bd048017c4b53c7d9a ("omap: crypto: updates to
enable omap aes") from the omap tree and commit
b744c679f62b368cb94c21c1dcd4618e42d88d63 ("crypto: updates to enable omap
aes") from the crypto tree.

Two versions of the same patch.  The version in the omap tree has been
updated, so I used that.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__27_Sep_2010_14_33_00_+1000_lY_9B/G0u/26Mr8G
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMoB58AAoJEDMEi1NhKgbs2g0H/1gv027JndzqJomV2omVaPi+
M710fL0tpiFQ7d0p/d8JnFltkb2Qor0147X7Dgh3lI5maxrj71bLmUQF3NoLjToA
aj14b5H9RCjulnVj3ZMb7nrqFvhQStvwwx6oKucoqBG2YE9p+Inh0JDUhBOl/8Vx
MkW8uRaMzq6VFJpFB/wdEwF1g6pDQoEUv98YaVCN7Dz6N7GZiAB7GYzAqGHRCDks
44+/ZEfpw04M6R6GotLymK+K4hTb/ZZmx0jjwD7YLGqBZlQN/TgdHGf/er/tUx4U
KQFZIvGWBrhptW2I3LQnAC7xwVdIhVUFwIxfpXIbK7oz9v+fEsontGeWhtukSLg=
=FfoV
-----END PGP SIGNATURE-----

--Signature=_Mon__27_Sep_2010_14_33_00_+1000_lY_9B/G0u/26Mr8G--
