From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] ARM: dts: Fix hsi gdd range for omap4
Date: Thu, 6 Dec 2018 01:20:05 +0100
Message-ID: <20181206002005.gdj4ne4tt5czlcay@earth.universe>
References: <20181205230553.39171-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7829273166628822666=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181205230553.39171-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--===============7829273166628822666==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lo3ntphnvmatqqxg"
Content-Disposition: inline


--lo3ntphnvmatqqxg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 05, 2018 at 03:05:53PM -0800, Tony Lindgren wrote:
> While reviewing the missing mcasp ranges I noticed omap4 hsi range
> for gdd is wrong so let's fix it.
>=20
> I'm not aware of any omap4 devices in mainline kernel though that use
> hsi though.

While OMAP4 HSI seems to be very similar to OMAP3 SSI, it's not
supported by the omap-ssi driver. I don't know what changes are
required and I don't know any hardware using omap4-hsi.

FWIW the change is

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

> Cc: Sebastian Reichel <sre@kernel.org>
> Fixes: 84badc5ec5fc ("ARM: dts: omap4: Move l4 child devices to probe
> them with ti-sysc")
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/boot/dts/omap4-l4.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/omap4-l4.dtsi b/arch/arm/boot/dts/omap4-l4=
=2Edtsi
> --- a/arch/arm/boot/dts/omap4-l4.dtsi
> +++ b/arch/arm/boot/dts/omap4-l4.dtsi
> @@ -196,12 +196,12 @@
>  			clock-names =3D "fck";
>  			#address-cells =3D <1>;
>  			#size-cells =3D <1>;
> -			ranges =3D <0x0 0x58000 0x4000>;
> +			ranges =3D <0x0 0x58000 0x5000>;
> =20
>  			hsi: hsi@0 {
>  				compatible =3D "ti,omap4-hsi";
>  				reg =3D <0x0 0x4000>,
> -				      <0x4a05c000 0x1000>;
> +				      <0x5000 0x1000>;
>  				reg-names =3D "sys", "gdd";
> =20
>  				clocks =3D <&l3_init_clkctrl OMAP4_HSI_CLKCTRL 0>;
> --=20
> 2.19.2

--lo3ntphnvmatqqxg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwIazUACgkQ2O7X88g7
+pqaGxAAi1edlr6ueWWVWilr6vtS8W8nbXXRPsm+JDIkJJCRlqqhoebHj7lZLV+K
sC8gItT9JboczL3kU3rc6A2NdrqX6KeNwpIjJq7VusgNFPJEsqLKbTGS7zW0dVYu
M2gXxvbMopfpj5oq5Er4UDWhpO2F25AkoE5rDAKb5EKRXtNBkBl8UPAQbSurh8bj
JX/YJOdOZI8tZFYoifzr51nCJqaI0xW5JYOCT3RRq945HZP2EAKg92I2kRdla35v
WHdqLM6U8Br2nJtU1yMsRKNlZSlq6veMQjqQnpl8MmbXlkqKVzUs1n+jTrJliGF7
7VccKaMnbAjMb9/Ak/oDt01kDwDRDEFmOICXYNGetfOM4NOW5vZgPm3IvfErn12L
qfXfRPzHl6Lw+JXmJC0ygw3dHrZ4mKwN2gj1aGDr+joGxkQ3nFfBzb2cispMkMB+
Ctd2EUTNTGHbY78bWI7KEY7E33n1aMjrR/XwsQWWLBRyPrmiMdq3QSqJop03lDfz
cvsDlgaOQUV+I/GkLjFSUJyhP4kVGfuKpvX0ZE9+J24eBgLFWS/K++pKqb4ZtUCR
/HLgSbnPDYrsxma5D+FvzTih89IiwBNI1Tk3UpBgndRf2YA1LxHIz72dS6I4MwLk
cH2icwfmTa67uF2Osvbb0Vy2eFAjQ3m/eSyqPYr5GhfFprKdk9o=
=nzf9
-----END PGP SIGNATURE-----

--lo3ntphnvmatqqxg--


--===============7829273166628822666==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7829273166628822666==--
