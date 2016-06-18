From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 4/4] ASoC: tpa6130a2: Add DAPM support
Date: Sun, 19 Jun 2016 01:21:31 +0200
Message-ID: <20160618232131.GF5510@earth>
References: <cover.1466218805.git.helen.koike@collabora.co.uk>
 <2aed60529eea206f2192a7236f2d80386a73f2ee.1466218805.git.helen.koike@collabora.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1Y7d0dPL928TPQbc"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2aed60529eea206f2192a7236f2d80386a73f2ee.1466218805.git.helen.koike@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Helen Koike <helen.koike@collabora.co.uk>
Cc: lgirdwood@gmail.com, broonie@kernel.org, peter.ujfalusi@ti.com, jarkko.nikula@bitmer.com, lars@metafoo.de, k.kozlowski@samsung.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, perex@perex.cz, tiwai@suse.com
List-Id: linux-omap@vger.kernel.org


--1Y7d0dPL928TPQbc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Sat, Jun 18, 2016 at 12:26:31AM -0300, Helen Koike wrote:
> Add DAPM support and updated rx51 accordingly.
> As a consequence:
> - the exported function tpa6130a2_stereo_enable is not needed anymore
> - the mutex is dealt in the DAPM
> - the power state is tracked by the DAPM

This breaks headphone on N900. So far I only checked, that
tpa6130a2_power_event() is not called. I guess the DAPM
graph is wrong.

-- Sebastian

--1Y7d0dPL928TPQbc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXZdd4AAoJENju1/PIO/qa6SwP/1mVFmKCisiccYDwyV4+wJY4
G7Kwiis2ogYzPbYm1ukYD6JjjhNio1/A6yUujEzS07V+B/XWgWQ0/gIX9ySYFhXZ
YBrxLhPUQhXjWuJSiXQT8FzUxIdQ2td6zXn34xs498XsRniupvIkb9p2u1l5LZp7
km/JhAVJgluuo0Sp+3a+62Yf7m5T4Ry/j24hEG3IlFMeYU8s5BIsT3042//45F3k
jvGfxMe5Ua3ytYVpJje0WF/u12GiI6ro69d/x8/pZDN4OZ1ZgHZqXvxYKmCTv2w1
QYdCkk6M5C85J1wqx1HAJsR0g+BRqhcqvyYJsRIK1CvAgzoAVYmS6jfyYZ4X/H8+
v0nd/C5t8trApk0diFB2/euc+R8yQBYkYt8EEEIOuJl9OilJq5x1yd0UT3K1tJwb
jcBMq2HpRc83RUKYwOu0B4kwwMJLefUt/CxKUJD+a4Kt6GCRzXveTclmRK2cMfp2
bQ8A/9S93CgBcjaD8pmYzcyVkTCBpdLuAdo0LYp4/PEcoqwV5TQqSXhft7Lk+K6m
oWzKSo6FiIH7xDPO7+uDaCXCSl9u0CPVsxQOryV2QOu/zhgU5IM+1u0OKVDSwPtG
SVwq10LtDkkd3KOQ70oz3l+9VixfE79lL20qFsDUgb5S7eVvpFdn1y174p9hn0OS
B1TZ+z3L9tRa2c/OBYn9
=bGow
-----END PGP SIGNATURE-----

--1Y7d0dPL928TPQbc--
