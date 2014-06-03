From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: free jack GPIOs before the sound card is freed
Date: Tue, 3 Jun 2014 10:47:14 +0100
Message-ID: <20140603094714.GS31751@sirena.org.uk>
References: <1401475377-12123-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FYef6pHvFBuPZp1D"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1401475377-12123-1-git-send-email-swarren@wwwdotorg.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Philipp Zabel <philipp.zabel@gmail.com>, Paul Parsons <lost.distance@yahoo.com>, Eric Miao <eric.y.miao@gmail.com>, Russell King <linux@arm.linux.org.uk>, Haojian Zhuang <haojian.zhuang@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Sangbeom Kim <sbkim73@samsung.com>, "open list:OMAP AUDIO SUPPORT" <linux-omap@vger.kernel.org>, "moderated list:ARM/SAMSUNG ARM A..." <linux-samsung-soc@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


--FYef6pHvFBuPZp1D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2014 at 12:42:57PM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>=20
> This is the same change as commit fb6b8e71448a "ASoC: tegra: free jack
> GPIOs before the sound card is freed", but applied to all other ASoC
> machine drivers where code inspection indicates the same problem exists.

Applied, thanks.

--FYef6pHvFBuPZp1D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTjZmeAAoJELSic+t+oim9N8oP/1SKkfvf0ai6JYcI3UJKuU2m
oitENvUr5hYRCmfHyrRHFwcgG1iio5iItSfAcGpyN7sNGKz3QECpkFxR3dxLNYTk
jt1Hlh37Zz/XexvM9zWp0g62RbuZ5CKsf3xA+zgVAAgbVM58qapaDLtYbrLrcy6r
0HZVvcVrIgn8QOlnb7Iw03nw+hFa6MS1S8NWSi+5FW7NhwHrwAJAyCDPsU1MrqS8
svlxuOTBw0f218IAcb8tcQvhVer75Eky0LI5ELIqIPFI5Ru5AjnEaLKoqO9DMDZH
9mKd++aqzKOoSxaJKXfBRYo7AGFc254zPGEkbVM9q/tAai1tOhwqseWTeLyaS63n
QG0ouVFf2L8UiDnx5VDG53abNHdO383atRaLyz6CePkcfKpfP8x1TSmEmPZ+YjXd
b4o307UhS8VQmVq3z8gXkbOtuJOr3OR2rzLi+sJhlnmPiMQnCnl4m0J66/syGiz5
z/64+ES4fknWET9K1flijnPsokRfYPFku5lq+8qlFTyUoKKnnv06iOe2AhZEgqNy
SX3ZTY71xoXUF1KhwAB0zyrs2XIigmDm0G2Bhs3unnp1iHX6hiXDnaIgUkUJomrd
Ps6wtN2DIe7FMBAT1/OYUXSToEn4umBWx/VjSA6R+a/J5Cu1H6n4IqqQ/k7wGP51
CiODml83mXKzjn3YbwGo
=Cxnt
-----END PGP SIGNATURE-----

--FYef6pHvFBuPZp1D--
