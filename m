From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCHv4 11/18] arm: dts: add omap4430 thermal data
Date: Fri, 27 Sep 2013 09:20:31 -0400
Message-ID: <5245861F.7000109@ti.com>
References: <1380251605-3804-1-git-send-email-eduardo.valentin@ti.com>
 <1380251605-3804-12-git-send-email-eduardo.valentin@ti.com>
 <20130927122439.GA8360@kahuna>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6295592945886805334=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130927122439.GA8360@kahuna>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nishanth Menon <nm@ti.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, wni@nvidia.com, durgadoss.r@intel.com, ian.campbell@citrix.com, pawel.moll@arm.com, swarren@wwwdotorg.org, Tony Lindgren <tony@atomide.com>, devicetree-discuss@lists.ozlabs.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, lm-sensors@lm-sensors.org, Eduardo Valentin <eduardo.valentin@ti.com>, linux-arm-kernel@lists.infradead.org, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, grant.likely@linaro.org, Russell King <linux@arm.linux.org.uk>, rui.zhang@intel.com, linux-omap@vger.kernel.org, linux@roeck-us.net
List-Id: linux-omap@vger.kernel.org

--===============6295592945886805334==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1XmnBH6bta5Fi7w00RPEclm3IM4nH8DtB"

--1XmnBH6bta5Fi7w00RPEclm3IM4nH8DtB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 27-09-2013 08:24, Nishanth Menon wrote:
> On 23:13-20130926, Eduardo Valentin wrote:
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
>> @@ -25,9 +25,15 @@
>>  		};
>>  	};
>> =20
>> -	bandgap {
>> +	thermal-zones{
>> +		#include "omap4-cpu-thermal.dtsi"
>> +	};
>> +
>> +	bandgap: bandgap {
>>  		reg =3D <0x4a002260 0x4
>>  		       0x4a00232C 0x4>;
>>  		compatible =3D "ti,omap4430-bandgap";
>> +
>> +		#thermal-sensor-cells =3D <0>;
> 2 cents:
> we might want to move bandgap under ocp?
>=20

Yes, agreed. But I don't think this change is related to this patch or
to this series.

Tks Nishanth

>>  	};
>>  };
>> --=20
>> 1.8.2.1.342.gfa7285d
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--1XmnBH6bta5Fi7w00RPEclm3IM4nH8DtB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlJFhh8ACgkQCXcVR3XQvP3I1gD/TM2JMQH3snFBp+F3rhhYaI0c
cL1CsA6w/FXgJ/kznzUA/12a9HkHD8gpc6UrCJ4T3MvGlhN5+1vzL+xY9UQ3W7+o
=iERc
-----END PGP SIGNATURE-----

--1XmnBH6bta5Fi7w00RPEclm3IM4nH8DtB--


--===============6295592945886805334==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6295592945886805334==--
