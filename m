From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 4/4] ASoC: tpa6130a2: Add DAPM support
Date: Sun, 19 Jun 2016 22:03:01 +0200
Message-ID: <20160619200300.GB15429@earth>
References: <cover.1466218805.git.helen.koike@collabora.co.uk>
 <2aed60529eea206f2192a7236f2d80386a73f2ee.1466218805.git.helen.koike@collabora.co.uk>
 <20160618232131.GF5510@earth>
 <57666843.2020604@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hQiwHBbRI9kgIhsi"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <57666843.2020604@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Helen Koike <helen.koike@collabora.co.uk>, lgirdwood@gmail.com, broonie@kernel.org, peter.ujfalusi@ti.com, jarkko.nikula@bitmer.com, k.kozlowski@samsung.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, perex@perex.cz, tiwai@suse.com
List-Id: linux-omap@vger.kernel.org


--hQiwHBbRI9kgIhsi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jun 19, 2016 at 11:39:15AM +0200, Lars-Peter Clausen wrote:
> On 06/19/2016 01:21 AM, Sebastian Reichel wrote:
> > On Sat, Jun 18, 2016 at 12:26:31AM -0300, Helen Koike wrote:
> >> Add DAPM support and updated rx51 accordingly.
> >> As a consequence:
> >> - the exported function tpa6130a2_stereo_enable is not needed anymore
> >> - the mutex is dealt in the DAPM
> >> - the power state is tracked by the DAPM
> >=20
> > This breaks headphone on N900. So far I only checked, that
> > tpa6130a2_power_event() is not called. I guess the DAPM
> > graph is wrong.
>=20
> Can you try with
>=20
> +	{"TPA6130A2 HPLEFT", NULL, "LLOUT"},
> +	{"TPA6130A2 HPRIGHT", NULL, "RLOUT"}
>=20
> being replaced with
>=20
> +       {"TPA6130A2 LEFTIN", NULL, "LLOUT"},
> +       {"TPA6130A2 RIGHTIN", NULL, "RLOUT"},

With that change:

Tested-By: Sebastian Reichel <sre@kernel.org>
Reviewed-By: Sebastian Reichel <sre@kernel.org>

-- Sebastian

--hQiwHBbRI9kgIhsi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXZvpxAAoJENju1/PIO/qa//sP/0j3KQo+iJIXi1E4UvAVtd5N
Ws50Def3HIwcHy0W4D01zaLIH+lnmUbnuSws7Zr7l/83ojZnkX7GMODWRfBK1f43
nyTzlO9vhVJSeRV9t916ya88gtSlkc/RR+v0wWvXvnjR78YCvIp29s/OMuZBS/rT
7CGZWHjrFZC8apv4jTFEwGkE4XZEsK2JaL0SbSKtJ4PRLaNmRIXZjS9fcD+JGYLP
ibCwfLX7oGNOf1pfqUJApHo6Teaahq6jmL3YoBICxjOujpuV/SaDhL7RHGKUL+aO
kDuKLpOgCwXS+Gax3sQYVMBST61y3hvYPX6n8RuzVoujrYlP6NjEXe5YMOkRaRjX
j3Iv6hLd37T8MmU0sfSbgWePuN/OG8z0uAWuuxSx4a0OWDZCU14dsxvkVacqWb7y
g3IRtwV5D9jIt1cAfgo9gvxwVEt4ILrkXV7uklmNB97MdR6kaXeuXtQebxFDysdo
3nZ77u6w1VR0xnPBGU7ctgoiQtX89hIA9+X+2n2va9sgvvs7ZqOOa0pdOxhXNzFn
wWv6SKhb0hvtdWsNmDZnma3TWKVkaCuelsMpuOAA9fUC5HRKFxdR8VLv7UwT+8li
NzwpcVUQZDQXvGG2hEOj88gXkWjbF+jDAbjM433viLScBlnasoyEZ+FNC+f04nB8
dIuaKhXPooD3FJSq1ZmR
=mU+9
-----END PGP SIGNATURE-----

--hQiwHBbRI9kgIhsi--
