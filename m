From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC 13/23] spi: omap2-mcspi: raw read and write endian fix
Date: Sat, 16 Nov 2013 10:19:22 +0000
Message-ID: <20131116101922.GL15393@sirena.org.uk>
References: <1384560086-11994-1-git-send-email-taras.kondratiuk@linaro.org>
 <1384560086-11994-14-git-send-email-taras.kondratiuk@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qgd2S+2VS1hsWwXW"
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1384560086-11994-14-git-send-email-taras.kondratiuk-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Taras Kondratiuk <taras.kondratiuk-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linaro-networking-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Victor Kamensky <victor.kamensky-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--Qgd2S+2VS1hsWwXW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 16, 2013 at 02:01:16AM +0200, Taras Kondratiuk wrote:
> From: Victor Kamensky <victor.kamensky-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>=20
> All OMAP IP blocks expect LE data, but CPU may operate in BE mode.
> Need to use endian neutral functions to read/write h/w registers.
> I.e instead of __raw_read[lw] and __raw_write[lw] functions code
> need to use read[lw]_relaxed and write[lw]_relaxed functions.
> If the first simply reads/writes register, the second will byteswap
> it if host operates in BE mode.

Applied, thanks.

--Qgd2S+2VS1hsWwXW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSh0ahAAoJELSic+t+oim9d6sQAJ2WAD+rogo+Y8PLKc30XOL4
jVj7dmC8Mj9yDgZOpyW1YsOwVv55BgCzeXlbBLwOHlgl3o1jl+KObUQ5JfzYLVX5
SfYPmjOPKoRYhptQBb4q15XbaiW8JNoX3iqgrEsON8exPjh3FvoMe69fYw/O+Q5+
VTgkzE/Y3L3pD4XQI4cbqI8J9fjPRf6PuFKP1z0zcQdbMizrglSKAwYhE30AOH9e
6W98RgxDWDsP0WoGF49POhOdPvl/VCQvEIL4pWqU5B0LvVlhbQhl+WUfo1cvDKvM
VTk1YFahKiP4GvBjfWHNIqdAgb0pbWcVVlKFtj+um7SNjpvmgaH4honX1ForaK26
yIAnyV+omlGJry1UN9ZdVKVlwtj/skuYb7vYdgTjzeLaJK+ZymxTE5/NBs25MD3m
hC8L45DLr856mgwF7Q3FfIfduGlFopHx7tkScpCQ2kKnkQX7bhcJdIxl1qjxYJBE
LUVbL/cgvMUIKxYDwd60H8Yw2Tw8O/x+06qS587fU+5tm0N4ys+18wRsQ1rROnA0
p1Q1VmbdJkw0F5TdYYMD0rF+0cYi8zmOxV9OWEcC8TpwBDnB/y04puu/EbgLG9s7
grkO27wOJ4JD1FCiUn0IXNI5r9KMXsnfGZaCdjsNq80qMSBPF89WltczmgT2Q/2Z
pvvEBUskftZQK5GCKSnX
=FkQl
-----END PGP SIGNATURE-----

--Qgd2S+2VS1hsWwXW--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
