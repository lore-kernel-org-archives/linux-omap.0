From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 5/5] ASoC: tpa6130a2: Remove goto err_gpio
Date: Tue, 21 Jun 2016 03:42:23 +0200
Message-ID: <20160621014222.GD17167@earth>
References: <cover.1466441036.git.helen.koike@collabora.co.uk>
 <903012887a1b2f8f59e44b1cfb472c9362fd964f.1466441036.git.helen.koike@collabora.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="J5MfuwkIyy7RmF4Q"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <903012887a1b2f8f59e44b1cfb472c9362fd964f.1466441036.git.helen.koike@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Helen Koike <helen.koike@collabora.co.uk>
Cc: lgirdwood@gmail.com, broonie@kernel.org, peter.ujfalusi@ti.com, jarkko.nikula@bitmer.com, lars@metafoo.de, k.kozlowski@samsung.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, perex@perex.cz, tiwai@suse.com, cphealy@gmail.com
List-Id: linux-omap@vger.kernel.org


--J5MfuwkIyy7RmF4Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 20, 2016 at 02:12:33PM -0300, Helen Koike wrote:
> Replace goto err_gpio by return ret
>=20
> Signed-off-by: Helen Koike <helen.koike@collabora.co.uk>

Tested-By: Sebastian Reichel <sre@kernel.org>
Reviewed-By: Sebastian Reichel <sre@kernel.org>

-- Sebastian

--J5MfuwkIyy7RmF4Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXaJt+AAoJENju1/PIO/qakgcP/i8KHgP66ujp9NaYsCZPcYZQ
Eedxor7Nyjci41vRaSuQg03xSlJRoAe6qlbF8Qd3GvHMzVxSmSQc+rdldVU8WLyk
Gcf6e3Tnd+UhloaExUPggizuXE3CcxggeE4c4/DBIAAH+xOJhY5mwh9WGLbxc/H3
GOxQU/9W/c5+Bvh17Ke5li3QrEAIVPXLL6YO19AS5/LyUsG5W0KGqodwiMRkLOE3
gyeFZ63e0gOHStbf9iuebrWp8sI2j5513x07F0RuKgiLJ3Hw3nXVg6UNAYdOD+sh
ckWVW0HUV0dOqliZ7DhlLFdfOMErXVXdH+BeFLkAkoND16ffepqytWJPAtCDVPTu
+NfR6PwogRDzRlnTseemtrYpA3IESoNrOZio9bjm5z5n9qUDeC2d7RTkjbp6gNXl
AmXx075iAh5fcbCfDr8bIRXjxuEOGmSTtaFQj5YezuGXM20fRmq0XAr0GWRI8Wnz
ivVsNEhP70xqHCH/F/5NGA/NI4yQ1UynBuaH3oZdtLAeVTdYYb/0KuGI5kdwFy/+
0I+t7bdtlWE7b4UCXmx9B9p5oCDuon9jQHhJt6A35gw5knMfH1899XC0bn1c6Ju4
PEQTxk5Kp7VqgtoszMPqZ7xyAlTpL4FrXjGshlXpkXhFKRtQGmmLUwbvoZdYh6Rr
WKzchamhnDzDBiEQo19A
=9o5Q
-----END PGP SIGNATURE-----

--J5MfuwkIyy7RmF4Q--
