From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v8 4/9] pwm: pwm-tiecap: Update dt binding document to
 use proper unit address
Date: Mon, 11 Jul 2016 11:56:23 +0200
Message-ID: <20160711095623.GI5823@ulmo.ba.sec>
References: <1462291015-1919-1-git-send-email-fcooper@ti.com>
 <1462291015-1919-5-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Encpt1P6Mxii2VuT"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1462291015-1919-5-git-send-email-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Franklin S Cooper Jr <fcooper@ti.com>
Cc: robh+dt@kernel.org, tony@atomide.com, linux@arm.linux.org.uk, paul@pwsan.com, t-kristo@ti.com, mturquette@baylibre.com, sboyd@codeaurora.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, vigneshr@ti.com, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org


--Encpt1P6Mxii2VuT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 03, 2016 at 10:56:50AM -0500, Franklin S Cooper Jr wrote:
> Replace unit address from 0 to the proper physical address. Also insure
> that the unit address matches the reg property address.
>=20
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-tiecap.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

I applied this long ago but never let you know: Applied, thanks.

Thierry

--Encpt1P6Mxii2VuT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXg21HAAoJEN0jrNd/PrOhIf8P/1RA6cb3nNXTmNBuoU9w3FNW
1/NyIDBXs8zsOf9c1WMvrRrEbG2fhBHRPfykGJVnb71Lg14aJro1XdJ+4/N1WAbU
E59jJZzIbZ/X7HfY+0kWazhqD5k+MqQJxsNN6aEbH+3nx0q4MpjkqRpvmkD0FyMV
iJ+W33fymyiPdQKYYKV7hNfVG34Sd/5z+G85Wo2DpTSJ1HWToNqcc2n2Nh7QgdxO
J9RJWIy8Y/uDN2OSqPQJwyjKG8r8prZMmc/nznxead2zWUI9anh+wBYIiHW2g/WQ
ZZvDtxGIEPWxmR9Fj196tJE5d5wvR30R8QcCZJ2iaUpqJU0bQ/yVy211EhMLhcyT
q4itTrxjzB5jEbRix3zYdAhpy5rGDJ83y4cgg4bPW2UMbBXntvYo2sdVvGQjVXzP
F9RuRdsUnZOt/4d+jaO+UVh4Z9Ldn5ECA58YMY4nPZFMK41E+TpVMfeqc9ILdt6+
OhKJWqfk33f/ez+59qT3aQxf5iHpXEgly/iFl1uGvew+A0xBtkwrVGNw2IIsNZ0E
uW0WqnK9Qo870a+DBrSWdRZun4N6BA3fFqp2RAReAxl3Z+j1H89YTO32c6lE2yUI
70q+EcMvOascx25ieIZ0jgKiDUxRj1vkClzuQTJxznEzNuNpORkPYThLtQ+hZFGx
3nGf2/oiwyhoC+av9t1O
=pUZU
-----END PGP SIGNATURE-----

--Encpt1P6Mxii2VuT--
