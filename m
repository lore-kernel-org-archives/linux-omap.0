From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 16/23] ASoC: omap: mcbsp, mcpdm,
 dmic: raw read and write endian fix
Date: Mon, 18 Nov 2013 11:15:22 +0000
Message-ID: <20131118111522.GC10877@sirena.org.uk>
References: <1384560086-11994-1-git-send-email-taras.kondratiuk@linaro.org>
 <1384560086-11994-17-git-send-email-taras.kondratiuk@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8392656600557136467=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1384560086-11994-17-git-send-email-taras.kondratiuk@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Taras Kondratiuk <taras.kondratiuk@linaro.org>
Cc: alsa-devel@alsa-project.org, Victor Kamensky <victor.kamensky@linaro.org>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linaro-networking@linaro.org, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org


--===============8392656600557136467==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VMt1DrMGOVs3KQwf"
Content-Disposition: inline


--VMt1DrMGOVs3KQwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 16, 2013 at 02:01:19AM +0200, Taras Kondratiuk wrote:
> From: Victor Kamensky <victor.kamensky@linaro.org>
>=20
> All OMAP IP blocks expect LE data, but CPU may operate in BE mode.
> Need to use endian neutral functions to read/write h/w registers.
> I.e instead of __raw_read[lw] and __raw_write[lw] functions code
> need to use read[lw]_relaxed and write[lw]_relaxed functions.
> If the first simply reads/writes register, the second will byteswap
> it if host operates in BE mode.

Applied, thanks.

--VMt1DrMGOVs3KQwf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSifbHAAoJELSic+t+oim9bZwP/0VR95R4lczYwmThvtn5zfGF
21fJVSTfe2V4oxx/oNKkbx4S0Bk+vbTmHzYV9f5qD4FbV/x6Iud6G5GLXpX3Nw5F
lHalWJ+79JHOPoBGKL2YGORoNHMnYUVvAN42mA93h/Z7P0t2r8zE94UIW44za1r1
0r9lePznWK1XzHNFngHDuLdT1OHlvaWSYhxppWaoDdUhBOrtYbT6zWXrpEmqGLuB
HwZcqj7Ne8dBE9RpC5GL0MGA+4KPzO6/OG0rHIG5A7r7OyrlOt/Hwoyzu2uVEDsy
tapaznfpyOGa7fqbiNO6hRhvXwf/eJYoOc93qDEZGo7TgdrDF2GMwOKsFNbsUDfn
XDB/exDaJWub3TtY6bNB+GG9oZd7cwTqWs9L4vaYYFW6DwAGmFjt8pVoNTmVYbs1
r0qe9Ynxmhb4dESvBhRK6QvfsApgEmt+WeUbYH/gTsiuXU+tj96O1J6lyV3tSSz2
3KsLiPoDeGFTGzF1hprJ08a+ZhFjvZQz4O/zt+KyDZKL01142G1CDf8dJCJEabTp
loUkS1Zsz1lY7ePrVf0Wzrgb7aqpl822s3gAatwJA3KcTWf0Hb8VbPMspb0F6wzz
qXomOS7QUattqOyZjZLdxnDUjgbUpD705f2KpV9A0jnIhzt0t5EM+Q9kg5OlhNi9
SCkNYvET7VltPeazcx/F
=cG8q
-----END PGP SIGNATURE-----

--VMt1DrMGOVs3KQwf--

--===============8392656600557136467==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8392656600557136467==--
