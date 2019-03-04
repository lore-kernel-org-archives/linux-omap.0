From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RFC PATCH v2 6/7] i2c: tegra-bpmp: convert to use new atomic
 callbacks
Date: Mon, 4 Mar 2019 13:59:06 +0100
Message-ID: <20190304125906.GH9040@ulmo>
References: <20190302134735.4393-1-wsa+renesas@sang-engineering.com>
 <20190302134735.4393-7-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2xzXx3ruJf7hsAzo"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190302134735.4393-7-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Keerthy <j-keerthy@ti.com>, Peter Rosin <peda@axentia.se>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Stefan Lengfeld <contact@stefanchrist.eu>, Phil Reid <preid@electromag.com.au>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--2xzXx3ruJf7hsAzo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 02, 2019 at 02:47:34PM +0100, Wolfram Sang wrote:
> The driver did handle this internally, convert it to use the new
> callbacks.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/i2c/busses/i2c-tegra-bpmp.c | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--2xzXx3ruJf7hsAzo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlx9IRcACgkQ3SOs138+
s6E+Vw//d+WlRyraorEvpmkVgh3EUTwvY1rnjUuWH1rrNvveKGzdXYpDWjpKeCo0
OObme4tLuXOMLneWMmemPmOFTNY/dgrwUG0HuGxn9SYq9SrY2WZEMjIEmwW4d+iQ
+h5KvMBz9r/lV17lBQgIeQImpIE2o4/AhDskidyTImBDqtIdIwojSkashTq3TH2w
HDhbowCJKoXZzfhU2Xo1i7obJFXljsbCE2GsOzUq/U4uZcXMuoCMtLvHrWX2sxX1
4BiVxNjm3CAQ55nC1hJzMUBvhiXRm10WdA/WIfBc7r+JXsG2oylDRrYRiTBJ08op
RCcDwJcU8bb6xvFFuuE+m7kcNXEnR0JY0zx7dXUhJI1Jfk1zln2Rfjfbt/akhYPq
gBUw9YcmrPWxo9708UzaakUyCvm6zzjOXaLDA2sYW643CxrIzDmCIFkG1JdNxON+
IjnmJLyNWB77LffG/H7j6hP8DhzBrzbddJPP5pKigASC+Lwmzr/6d9h9muvaXT5w
SpsZyonXJht8vALeZHUEw0DtSFJuB41TFVuVFvUi+VRKuWQ/DReWZa2iV+HzK1Oz
P6C/9p6n6CCBWiXpfYMqrD7sSQGqd+OuRZdevGozd5KEtWaCTr3jR76/xY0j/Iwn
7Hj1G4m4ycWw25ZClqsVG0REm/o0aneAL8a/PIT4FRmpWoZvL94=
=Ldlv
-----END PGP SIGNATURE-----

--2xzXx3ruJf7hsAzo--
