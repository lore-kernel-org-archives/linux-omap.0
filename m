From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4 09/10] ARM: dts: am33xx: Update DCAN nodes
Date: Thu, 13 Nov 2014 17:03:49 +0100
Message-ID: <20141113160349.GA1275@katana>
References: <1415881371-4982-1-git-send-email-rogerq@ti.com>
 <1415881371-4982-10-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Return-path: <linux-can-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1415881371-4982-10-git-send-email-rogerq@ti.com>
Sender: linux-can-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, wg@grandegger.com, mkl@pengutronix.de, mugunthanvnm@ti.com, george.cherian@ti.com, balbi@ti.com, nsekhar@ti.comnm@ti.com, sergei.shtylyov@cogentembedded.com, linux-omap@vger.kernel.org, linux-can@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2014 at 02:22:50PM +0200, Roger Quadros wrote:
> Add "raminit-syscon" property to specify the RAMINIT register.
> Add clock information.
> Rename can nodes from "d_can" to "can" to be compliant
> with the ePAPR specs.
>=20
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  arch/arm/boot/dts/am33xx.dtsi | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index 9f3058c..74fefa1 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -338,20 +338,24 @@
>  			interrupts =3D <91>;
>  		};
> =20
> -		dcan0: d_can@481cc000 {
> -			compatible =3D "bosch,d_can";
> +		dcan0: can@481cc000 {
> +			compatible =3D "ti,am3352-d_can";
>  			ti,hwmods =3D "d_can0";
> -			reg =3D <0x481cc000 0x2000
> -				0x44e10644 0x4>;
> +			reg =3D <0x481cc000 0x2000>;
> +			clocks =3D <&dcan0_fck>;
> +			clock-names =3D "fck";
> +			syscon-raminit =3D <&am33xx_control_module 0x644 0>;

Yeah, I missed to write the mail that I disagreed with the "dcan_0/1"
compatible-properties of V3. The second parameter to syscon here is much
better!

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUZNZlAAoJEBQN5MwUoCm2pEUP/1mgDo7Nxbw/Cj8EyNr3kMaC
6CEIQFZ2W7TgMGZuGzRd7qpIepHPM5NHiqqsgKOOLyFsuCQUXCE64padMFdcQ28S
DQQ7DVbbOAZfPVctZ9wqcyD45HvYxg3DGtg+Dfo0/+zHMKYGgmbwdXMOsS1NRapw
aQ2dQemYlsOZN8RX7nLeKo7XbGv+6RgVWxNTtT3pOfW9xKjdD5MGfJVELV3A7SP3
wn1STeoGDoyH9QvL//5Lb+iuAmwRPm4px8YcVQM0b/KgutyFHiOSrQITZVetIcyG
czmks5gjyASvSJCoi1V1fQpcT/jm7rkqgateu56vVzLzj789XCj9hjb7qkGvMk8t
Me8Rt5EnwSh92zKgksnQm7ztVAmIWq/qaaj1MkrZ8IPb14OZ0ZJ5T1X+7Ow5O3Ua
83xSc/r8FgQEqyVyM4ZvFo6A3HZt17yRwkwnivOy7koeVRp2jLMwxi0zMTLgDdkH
IqYxrreSBpqiWKjpJC8D7RLP7yz24zDOIjoEXZwyRfZolJKU32mWkxP8dNSQbups
p/w+vU/BrjiAxIVPcnm3h+V9szrPxzJaMveR98lgDB6SDrWsPmSEClyxFiUv332t
0Rkh25gCvAQ+x26Fa8VnGaGDDpmm/4VNjYhiufI6Riho8oxSO0833jFRzioosSNe
CcE9e1cfaHrLGEb80KL9
=2YPi
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
