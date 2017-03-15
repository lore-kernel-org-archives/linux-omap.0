From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCHv4 0/2] Two bq24190 PM improvments
Date: Wed, 15 Mar 2017 21:46:16 +0100
Message-ID: <20170315204616.2axcvv3yoteoh6dj@earth>
References: <20170208231301.1666-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gmoptbfa2wf5rw5q"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170208231301.1666-1-tony@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Liam Breck <kernel@networkimprov.net>, "Mark A . Greer" <mgreer@animalcreek.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--gmoptbfa2wf5rw5q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 08, 2017 at 03:12:59PM -0800, Tony Lindgren wrote:
> Here's v4 repost of the two bq24190 patches against current power-supply
> tree.
>
> [...]
>
> Tony Lindgren (2):
>   power: bq24190_charger: Check the interrupt status on resume
>   power: bq24190_charger: Use PM runtime autosuspend
>=20
>  drivers/power/supply/bq24190_charger.c | 214 +++++++++++++++++++++++++--=
------
>  1 file changed, 164 insertions(+), 50 deletions(-)

Thanks, queued.

-- Sebastian

--gmoptbfa2wf5rw5q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljJqBgACgkQ2O7X88g7
+poi4A/7BEqoPGMxpePoXyYmTGe1aeQNI4wuwWUkXBR312O5qti68J9fz5HKepdr
h+ZF2fgNnia2lK6D4j2PO2V0/cIABZTqF+9WJliya72uyLFLJ09f2myuzAjTdRKm
N+hAoYqQR8ShXSBS6fWfHTn7O6mmIQ3F7bSF5WpDfHHJXfsE3ih4deuOl+XXWRDd
HNxU5UwdXUl04HIAfZ7/0Z+/o/+3LCSAznZiUojNlKeQXcQQ9/WL68ffnHOWiDbi
RQ9hoXdeVHlu1VslTq/6yTtkuY/5zk9BUZ8vkNpqZCJavwoahGiw/W+mOUJvPo7+
o7mlMZupxdWeNiywWj9iOKVOEcqyDAWUTd2yfbf4EJyiKKs62cyqxqZSuTfEtPbh
kUliWe7zU0BXfaVUnRlVgWJTNV6vEVmhu2NNLccJGlEIA7IXOAMvf9voXOpsREXI
W+4jDzAsAmlMGxuFLQwvTEk2iwwR3wAREehUBt4DYm7wqr0pGo3mhJd9j73FwduQ
n+b+pDdZxBDKI5Nf3ordiy7bxi5E9yCv0XXQOKPshzQzxqXSf0sjhv1QWkoUhoDn
0t2hBfhX9TpPbtsfU6E4LIfN9zgFSlTVvUGcDf6XEcivJjTgSC+AFYBw2tnZ/qP1
uGN2/TcN1+r5OS1xN/ovjk0Jj60UVYUgFNR5TmRc9YqGG8qwkgg=
=29MV
-----END PGP SIGNATURE-----

--gmoptbfa2wf5rw5q--
