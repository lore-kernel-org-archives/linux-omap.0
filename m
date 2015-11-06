From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2 5/5] ARM: dts: AM4372: add entry for qspi mmap region
Date: Thu, 5 Nov 2015 23:14:39 -0600
Message-ID: <878u6b1zgg.fsf@saruman.tx.rr.com>
References: <1446545174-14193-1-git-send-email-vigneshr@ti.com> <1446545174-14193-6-git-send-email-vigneshr@ti.com> <20151105235124.GA2805@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
	protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151105235124.GA2805@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, Vignesh R <vigneshr@ti.com>
Cc: Mark Brown <broonie@kernel.org>, Tony Lindgren <tony@atomide.com>, Michal Suchanek <hramrach@gmail.com>, Russell King <linux@arm.linux.org.uk>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Rob Herring <robh@kernel.org> writes:
> On Tue, Nov 03, 2015 at 03:36:14PM +0530, Vignesh R wrote:
>> Add qspi memory mapped region entries for AM43xx based SoCs. Also,
>> update the binding documents for the controller to document this change.
>>=20
>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>
> Acked-by: Rob Herring <robh@kernel.org>
>
>> ---
>>  Documentation/devicetree/bindings/spi/ti_qspi.txt | 5 +++--
>>  arch/arm/boot/dts/am4372.dtsi                     | 4 +++-
>>  2 files changed, 6 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/Documentation/devicetree/bindings/spi/ti_qspi.txt b/Documen=
tation/devicetree/bindings/spi/ti_qspi.txt
>> index f05dd631bef1..05488970060b 100644
>> --- a/Documentation/devicetree/bindings/spi/ti_qspi.txt
>> +++ b/Documentation/devicetree/bindings/spi/ti_qspi.txt
>> @@ -17,9 +17,10 @@ Recommended properties:
>>=20=20
>>  Example:
>>=20=20
>> +For am4372:
>>  qspi: qspi@4b300000 {
>> -	compatible =3D "ti,dra7xxx-qspi";
>> -	reg =3D <0x47900000 0x100>, <0x30000000 0x3ffffff>;
>> +	compatible =3D "ti,am4372-qspi";
>> +	reg =3D <0x47900000 0x100>, <0x30000000 0x4000000>;
>>  	reg-names =3D "qspi_base", "qspi_mmap";
>>  	#address-cells =3D <1>;
>>  	#size-cells =3D <0>;

and how does the user for this look like ? Don't you need to give this a
proper 'ranges' binding ?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWPDdAAAoJEIaOsuA1yqREHKEP/R4PUJz+OIvfv6uTsS8vm6Kx
PBgXBM1N4IcswdRVUHKvm5Zhg8QG+B4PukBdM2Va5kzle2wM3FzBrkx3wedem2Oh
dUR+56Y8u7+3Iz6pqp0/NhHFGw/8kZdmSAIOaKjt/Q5kDIwWYksA3hZ/6iMRzZ7C
i6pbSrKRQNCpeyxdL75F6sCfiA9yl1LomWekzZ2/lVzPVCD8Qr7m6xgy6Gu4F+SJ
/2fjmr3e3x640t9eaqzn2IdQqV9dxjk6AgW/ym1Rq712LAyU+iETYU9zSsRDKdr1
z1o7Zm6eCXgOVw85nGxdCBwAxzq3JVev5qF6VgMHLUwyUu5NeXFTrUWBil0BB5Or
6kKCNEVZUWjtacs4EC+03QrAKaEJEyzsMRi2D25X3DALz4hHa5mOhZL1VGeUMlT/
uvr388oSZfpahC/r5M7GZar+HH+ykz+7g7/qXGTmFeB7cLob8Of3O4MTG46gtT2B
jFOO47Rg58jN2DYkjQMihZYU6z+R8ZopWR7Lde576XnhBUJYfJna9evT/EKYrPBa
BCczWGyrCC9NvGutN7Oyv3r/nYd8s1chxyR93U3zTBeWGoLlKV1bRgbY6dEV+I4p
w6J8p/2HqjrmzAfMLEpogf6u5wxY24ms7d+4Z3wPjmJT3na5l11dywXif8CG/ogN
LaEsTgEbXyqjE7XxL8yt
=Vw+s
-----END PGP SIGNATURE-----
--=-=-=--
