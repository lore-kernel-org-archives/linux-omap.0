From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v2 2/2] dts: omap5: baord-common: enable twl6040 headset jack detection
Date: Tue, 25 Oct 2016 19:18:46 +0200
Message-ID: <7F106936-5748-432F-B602-59B890D5396A@goldelico.com>
References: <cover.1477414105.git.hns@goldelico.com> <7771a9fb3b9133fc361c87970444c1a3918891d0.1477414105.git.hns@goldelico.com> <105a8b87-69d0-19c7-8337-7d32fd6e997a@ti.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <105a8b87-69d0-19c7-8337-7d32fd6e997a@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org, letux-kernel@openphoenux.org, linux-kernel@vger.kernel.org, ldewangan@nvidia.com, kernel@pyra-handheld.com, marek@goldelico.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


> Am 25.10.2016 um 18:51 schrieb Peter Ujfalusi <peter.ujfalusi@ti.com>:
>=20
> On 10/25/2016 07:48 PM, H. Nikolaus Schaller wrote:
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>> arch/arm/boot/dts/omap5-board-common.dtsi | 1 +
>> 1 file changed, 1 insertion(+)
>>=20
>> diff --git a/arch/arm/boot/dts/omap5-board-common.dtsi =
b/arch/arm/boot/dts/omap5-board-common.dtsi
>> index b04adee..91456b4 100644
>> --- a/arch/arm/boot/dts/omap5-board-common.dtsi
>> +++ b/arch/arm/boot/dts/omap5-board-common.dtsi
>> @@ -124,6 +124,7 @@
>> 		compatible =3D "ti,abe-twl6040";
>> 		ti,model =3D "omap5-uevm";
>>=20
>> +		ti,jack_detection;
>=20
> ti,jack-detection

Hm. Looks as if we have found another bug:
which one is correct?

=
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Docum=
entation/devicetree/bindings/sound/omap-abe-twl6040.txt#n15

=
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/sound=
/soc/omap/omap-abe-twl6040.c#n289

Should I add another patch?

>=20
>> 		ti,mclk-freq =3D <19200000>;
>>=20
>> 		ti,mcpdm =3D <&mcpdm>;
>>=20
>=20
>=20
> --=20
> P=C3=A9ter
