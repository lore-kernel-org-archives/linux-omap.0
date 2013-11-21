From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCHv5 10/20] arm: dts: add omap4430 thermal data
Date: Thu, 21 Nov 2013 11:36:13 -0400
Message-ID: <528E286D.50100@ti.com>
References: <1384285582-16933-1-git-send-email-eduardo.valentin@ti.com>
 <1384285582-16933-11-git-send-email-eduardo.valentin@ti.com>
 <20131120123245.GA3242@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0656805260706730323=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20131120123245.GA3242@amd.pavel.ucw.cz>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pavel Machek <pavel@ucw.cz>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, wni@nvidia.com, durgadoss.r@intel.com, ian.campbell@citrix.com, pawel.moll@arm.com, swarren@wwwdotorg.org, Tony Lindgren <tony@atomide.com>, devicetree-discuss@lists.ozlabs.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, lm-sensors@lm-sensors.org, Eduardo Valentin <eduardo.valentin@ti.com>, linux-arm-kernel@lists.infradead.org, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, grant.likely@linaro.org, Russell King <linux@arm.linux.org.uk>, rui.zhang@intel.com, linux-omap@vger.kernel.org, linux@roeck-us.net
List-Id: linux-omap@vger.kernel.org

--===============0656805260706730323==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OQGHXilJNQEKWhIDtwI8TunGQ1jD8Fk8k"

--OQGHXilJNQEKWhIDtwI8TunGQ1jD8Fk8k
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 20-11-2013 08:32, Pavel Machek wrote:
> HI!
>=20
>> This patch changes the dtsi entry on omap4430 to contain
>> the thermal data. This data will enable the passive
>> cooling with CPUfreq cooling device at 100C and the
>> system will do a thermal shutdown at 125C.
>>
>> Cc: "Beno=EEt Cousson" <bcousson@baylibre.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Cc: linux-omap@vger.kernel.org
>> Cc: devicetree-discuss@lists.ozlabs.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
>> ---
>>  arch/arm/boot/dts/omap443x.dtsi | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/omap443x.dtsi b/arch/arm/boot/dts/omap4=
43x.dtsi
>> index bcf455e..e9c97d6 100644
>> --- a/arch/arm/boot/dts/omap443x.dtsi
>> +++ b/arch/arm/boot/dts/omap443x.dtsi
>> @@ -12,7 +12,7 @@
>> =20
>>  / {
>>  	cpus {
>> -		cpu@0 {
>> +		cpu0: cpu@0 {
>>  			/* OMAP443x variants OPP50-OPPNT */
>>  			operating-points =3D <
>>  				/* kHz    uV */
>=20
> I see you also add labels to various other entries...

I think I didn't quite get your point here. Can you please elaborate?

This label has been added because it will be used in thermal zone while
referencing the cooling device.

>=20
>> @@ -25,9 +25,15 @@
>>  		};
>>  	};
>> =20
>> -	bandgap {
>> +	thermal-zones{
>=20
> You may want to include space here.

OK.

>=20
>> +		#include "omap4-cpu-thermal.dtsi"
>> +	};
>> +
>> +	bandgap: bandgap {
>>  		reg =3D <0x4a002260 0x4
>>  		       0x4a00232C 0x4>;
>>  		compatible =3D "ti,omap4430-bandgap";
>> +
>> +		#thermal-sensor-cells =3D <0>;
>>  	};
>>  };
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--OQGHXilJNQEKWhIDtwI8TunGQ1jD8Fk8k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlKOKG0ACgkQCXcVR3XQvP2npgEAxbfIMuRDvRE62RLB0vNNBJZi
h70ppZC7HXSQYLS9an4A/1/i5UmTN/9oMYPgz4cCiwNsCLAgWpwHm44gDmu7sspq
=ysce
-----END PGP SIGNATURE-----

--OQGHXilJNQEKWhIDtwI8TunGQ1jD8Fk8k--


--===============0656805260706730323==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0656805260706730323==--
