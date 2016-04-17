From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] ARM: dts: omap3-n900: Specify peripherals LDO regulators
 initial mode
Date: Sun, 17 Apr 2016 02:05:36 +0200
Message-ID: <20160417000536.GA1124@earth>
References: <1460788643-18590-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1460788643-18590-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: tony@atomide.com, bcousson@baylibre.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ivo,

On Sat, Apr 16, 2016 at 09:37:23AM +0300, Ivaylo Dimitrov wrote:
> Without that, regulators are left in the mode last set by the bootloader =
or
> by the kernel the device was rebooted from. This leads to various problems
> like non-working peripherals.
>=20
> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> ---
>  arch/arm/boot/dts/omap3-n900.dts | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n=
900.dts
> index b3c26a9..1bb36e2 100644
> --- a/arch/arm/boot/dts/omap3-n900.dts
> +++ b/arch/arm/boot/dts/omap3-n900.dts
> @@ -329,6 +329,7 @@
>  	regulator-name =3D "V28";
>  	regulator-min-microvolt =3D <2800000>;
>  	regulator-max-microvolt =3D <2800000>;
> +	regulator-initial-mode =3D <0x0e>;
>  	regulator-always-on; /* due to battery cover sensor */
>  };

I think this should either get an additional
comment like /* MODE_NORMAL */ or implemented
using a define and a TWL4030_REGULATOR_MODE_NORMAL
constant to keep the *.dts easily readable.

-- Sebastian

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXEtNNAAoJENju1/PIO/qav14P/3YU8bUUoUJc/9BbFqoCFnoZ
xZRtqQx79+UlZi5yGp8AGBXWfQXoHkOePs53NfitbuJhdhhS08NcfbroVbYpq/wo
BAcG5Hxp22cW+1vPQGMUd4zFSpyC760dMKemuQN/YEDYruBdY8pusnGKdMAkgdyj
kA9v2oPXAoVdw9ckvnRUPq6Bf68LAFdur/j0pRaMtyfvnaOliQTw9eCghyhGqUT5
EqVTKzJK2re8cpsK64tACtaa9PspQDVJ81O0b6b8GWQTww+H5eWj+/wRvPDPhWPa
p8NdeIBS4dm23DyiR0Ey/xD5JUVxhc0EPVNMkO6erZDrLKh5EuWJz+zBPISPu04l
cCElSB++ppP5Zhy6Fth4FHRRC4yYugDdeWgA4ihdR6OGTT/yTZh5648GE+k+L0ei
9GwE8vI/C2LPnlaKYflLXS0RSdGOcASdJuUkt3P7tGYGlde9A7Mf8KR0cuMF502P
I/bEgburnX5BMHs/fJHyRJLevwoAP22lCy6QEa0ApgjjIXlqTRRcwkQeklcTJhu8
p2bBK9eX2boL6kb7YPYzoFr8377/xfmn32s0oHuuCJMz2Pe328UoEcyRfk6V3D/L
K/ELEc9873QNlWD1yXD59sGLVyVYnxKKUwXak2o4w7cF9/ktVHm3ljCQvirgJ0NN
xnH0DXWeAY61Oyrnv4w0
=JRX3
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
