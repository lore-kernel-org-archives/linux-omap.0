From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCHv2 3/3] arm: dts: add bandgap entry for OMAP4460 devices
Date: Wed, 15 May 2013 12:36:58 -0400
Message-ID: <5193B9AA.7020507@ti.com>
References: <1368629928-6723-1-git-send-email-eduardo.valentin@ti.com>
 <1368629928-6723-4-git-send-email-eduardo.valentin@ti.com>
 <5193A875.1020000@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6716343872136691422=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5193A875.1020000@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Russell King <linux@arm.linux.org.uk>, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============6716343872136691422==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="----enig2AHSMNFSXBHAXNXAONRQT"

------enig2AHSMNFSXBHAXNXAONRQT
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 15-05-2013 11:23, Benoit Cousson wrote:
> Hi Eduardo,
>=20
> On 05/15/2013 04:58 PM, Eduardo Valentin wrote:
>> Include bandgap devices for OMAP4460 devices.
>>
>> Cc: "Beno=C3=AEt Cousson" <b-cousson@ti.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Cc: linux-omap@vger.kernel.org
>> Cc: devicetree-discuss@lists.ozlabs.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
>> ---
>>  arch/arm/boot/dts/omap4460.dtsi | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/omap4460.dtsi b/arch/arm/boot/dts/omap4=
460.dtsi
>> index 2cf227c..e5bfbfe 100644
>> --- a/arch/arm/boot/dts/omap4460.dtsi
>> +++ b/arch/arm/boot/dts/omap4460.dtsi
>> @@ -29,4 +29,13 @@
>>  			     <0 55 0x4>;
>>  		ti,hwmods =3D "debugss";
>>  	};
>> +
>> +	bandgap {
>> +		reg =3D <0x4a002260 0x4
>> +			0x4a00232C 0x4
>> +			0x4a002378 0x18>;
>> +		compatible =3D "ti,omap4460-bandgap";
>> +		interrupts =3D <0 126 4>; /* talert */
>> +		ti,tshut-gpio =3D <86>;



>=20
> Why do you need a custom attribute for GPIO? Cannot you use the standar=
d
> one?

I believe it was by your suggestion :-), during the first attempts to
send this driver. But could not find the thread link :-( sorry.


I guess the reasoning to mark it as a ti specific is because it will be
used as IRQ line to treat thermal shutdown (in SW).

>=20
> Where is the gpio controller phandle?
>=20
> Usually it looks like this:
>=20
> 	gpios =3D <&gpio1 8 0>;
>=20
>=20
> Regards,
> Benoit
>=20
>=20
>=20



------enig2AHSMNFSXBHAXNXAONRQT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlGTuaoACgkQCXcVR3XQvP0mewEA80FWDjFHsyjQKn6zoEavUGEw
Y/jcu3nmm1lZFuG3pagBANQBOpLfSHCykCv38SNWdNV6//KxTJCmQuYEDpG+QZ5d
=LBcc
-----END PGP SIGNATURE-----

------enig2AHSMNFSXBHAXNXAONRQT--


--===============6716343872136691422==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6716343872136691422==--
