From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCHv2 3/3] arm: dts: add bandgap entry for OMAP4460 devices
Date: Thu, 16 May 2013 08:27:27 -0400
Message-ID: <5194D0AF.3010407@ti.com>
References: <1368629928-6723-1-git-send-email-eduardo.valentin@ti.com>
 <1368629928-6723-4-git-send-email-eduardo.valentin@ti.com>
 <5193A875.1020000@ti.com> <5193B9AA.7020507@ti.com> <519488D3.5070003@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5730588031658618725=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <519488D3.5070003@ti.com>
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

--===============5730588031658618725==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="----enig2WPGVVWNXVXLSNVGIKHOK"

------enig2WPGVVWNXVXLSNVGIKHOK
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 16-05-2013 03:20, Benoit Cousson wrote:
> Hi Eduardo,
>=20
> On 05/15/2013 06:36 PM, Eduardo Valentin wrote:
>> On 15-05-2013 11:23, Benoit Cousson wrote:
>>> Hi Eduardo,
>>>
>>> On 05/15/2013 04:58 PM, Eduardo Valentin wrote:
>>>> Include bandgap devices for OMAP4460 devices.
>>>>
>>>> Cc: "Beno=C3=AEt Cousson" <b-cousson@ti.com>
>>>> Cc: Tony Lindgren <tony@atomide.com>
>>>> Cc: Russell King <linux@arm.linux.org.uk>
>>>> Cc: linux-omap@vger.kernel.org
>>>> Cc: devicetree-discuss@lists.ozlabs.org
>>>> Cc: linux-arm-kernel@lists.infradead.org
>>>> Cc: linux-kernel@vger.kernel.org
>>>> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
>>>> ---
>>>>  arch/arm/boot/dts/omap4460.dtsi | 9 +++++++++
>>>>  1 file changed, 9 insertions(+)
>>>>
>>>> diff --git a/arch/arm/boot/dts/omap4460.dtsi b/arch/arm/boot/dts/oma=
p4460.dtsi
>>>> index 2cf227c..e5bfbfe 100644
>>>> --- a/arch/arm/boot/dts/omap4460.dtsi
>>>> +++ b/arch/arm/boot/dts/omap4460.dtsi
>>>> @@ -29,4 +29,13 @@
>>>>  			     <0 55 0x4>;
>>>>  		ti,hwmods =3D "debugss";
>>>>  	};
>>>> +
>>>> +	bandgap {
>>>> +		reg =3D <0x4a002260 0x4
>>>> +			0x4a00232C 0x4
>>>> +			0x4a002378 0x18>;
>>>> +		compatible =3D "ti,omap4460-bandgap";
>>>> +		interrupts =3D <0 126 4>; /* talert */
>>>> +		ti,tshut-gpio =3D <86>;
>>
>>
>>
>>>
>>> Why do you need a custom attribute for GPIO? Cannot you use the stand=
ard
>>> one?
>>
>> I believe it was by your suggestion :-), during the first attempts to
>> send this driver. But could not find the thread link :-( sorry.
>=20
> Ooops :-) I do not remember that... maybe it was long time ago, before
> we had any decent binding available for GPIO and IRQ...
>=20


Probably it was because by that time we didnt have GPIO binding ready, ye=
ah.

>> I guess the reasoning to mark it as a ti specific is because it will b=
e
>> used as IRQ line to treat thermal shutdown (in SW).
>=20
> Mmm, ok, so in that case, it is not even a gpio, but an interrupt entry=

> that is needed like that:
>=20
> 	interrupt-parent =3D <&gpio3>;
> 	interrupts =3D <22>; /* gpio line 86 */
>=20
> Except that we already have an IRQ line connected to GIC for the
> Talert... I'm not sure we can have 2 different IRQ controllers for one
> device :-(
>=20
> We need to check.
>=20


Yeah, I also dont think this will work, because we will reparent the
interrupt, setting to a different controller. That will break the TALERT
signal already defined at GIC (check original patch).

I propose keeping the way I sent. Unless there is a way to set two
different controllers to same device.

> Regards,
> Benoit
>=20
>=20
>>> Where is the gpio controller phandle?
>>>
>>> Usually it looks like this:
>>>
>>> 	gpios =3D <&gpio1 8 0>;
>>>
>>>
>>> Regards,
>>> Benoit
>>>
>>>
>>>
>>
>>
>=20
>=20
>=20



------enig2WPGVVWNXVXLSNVGIKHOK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlGU0K8ACgkQCXcVR3XQvP3STgEA3qVqjYpu0sXO/xLYF2jcIQAO
k2rSR8Wr7+SFbbuNmmgA/25JHmBHftgHR19NSqadmsQKq8SQ8iUookOvkC9bm4zV
=s5/6
-----END PGP SIGNATURE-----

------enig2WPGVVWNXVXLSNVGIKHOK--


--===============5730588031658618725==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5730588031658618725==--
