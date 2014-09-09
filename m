From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 02/12] ARM: dts: DRA7: Add DCAN nodes
Date: Tue, 09 Sep 2014 17:06:16 +0200
Message-ID: <540F1768.8090901@pengutronix.de>
References: <1410274534-22826-1-git-send-email-rogerq@ti.com> <1410274534-22826-3-git-send-email-rogerq@ti.com> <540F1702.2000007@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="NaAlKj6ptsagaNwWsbU6RvlWFeW12XFxU"
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <540F1702.2000007@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, tony@atomide.com
Cc: wg@grandegger.com, mugunthanvnm@ti.com, george.cherian@ti.com, balbi@ti.com, nsekhar@ti.comnm@ti.com, sergei.shtylyov@cogentembedded.com, linux-omap@vger.kernel.org, linux-can@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NaAlKj6ptsagaNwWsbU6RvlWFeW12XFxU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/09/2014 05:04 PM, Marc Kleine-Budde wrote:
> On 09/09/2014 04:55 PM, Roger Quadros wrote:
>> The SoC supports 2 DCAN nodes. Add them.
>=20
> I think you should put the device-tree ml for DT related patches on Cc.=

>=20
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>  arch/arm/boot/dts/dra7.dtsi | 30 ++++++++++++++++++++++++++++++
>>  1 file changed, 30 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi=

>> index 370009e..09d5739 100644
>> --- a/arch/arm/boot/dts/dra7.dtsi
>> +++ b/arch/arm/boot/dts/dra7.dtsi
>> @@ -34,6 +34,8 @@
>>  		serial3 =3D &uart4;
>>  		serial4 =3D &uart5;
>>  		serial5 =3D &uart6;
>> +		d_can0 =3D &dcan1;
>> +		d_can1 =3D &dcan2;
>>  	};
>> =20
>>  	timer {
>> @@ -1267,6 +1269,34 @@
>>  			ti,irqs-skip =3D <10 133 139 140>;
>>  			ti,irqs-safe-map =3D <0>;
>>  		};
>> +
>> +		dcan1: can@481cc000 {
>> +			compatible =3D "bosch,d_can";
>> +			ti,hwmods =3D "dcan1";
>> +			reg =3D <0x4ae3c000 0x2000>,
>> +			      <0x558 0x4>; /* index to RAMINIT reg within syscon */
>=20
> Putting the offset within the syscon here doesn't look good.
>=20
>> +			ti,raminit-syscon =3D <&dra7_ctrl_core>;
>=20
> Why not add it as a second parameter to the ti,raminit-syscon instead?

=2E/drivers/power/reset/keystone-reset.c does this.

Marc


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--NaAlKj6ptsagaNwWsbU6RvlWFeW12XFxU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlQPF2gACgkQjTAFq1RaXHMRIQCgmZkiV3HeboDC6v+rMgzvxmt8
5BIAn1cFjPXaYoR4MWmAqk1ShZy4lZuF
=T67Z
-----END PGP SIGNATURE-----

--NaAlKj6ptsagaNwWsbU6RvlWFeW12XFxU--
