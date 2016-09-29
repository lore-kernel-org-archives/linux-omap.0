From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH 2/3] DT: EVM: add LEDs
Date: Thu, 29 Sep 2016 07:18:23 +0200
Message-ID: <B8233FFD-C7CE-4F3A-957F-0715BDF02D44@goldelico.com>
References: <cover.1474953969.git.hns@goldelico.com> <d68619a23d642eacf12fd0a3c51f19d006436cbe.1474953969.git.hns@goldelico.com> <CAL_Jsq+hVD2TCubk8vGf8cS7dyLQj1o0ChnQ=MobKkV352uCSQ@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_Jsq+hVD2TCubk8vGf8cS7dyLQj1o0ChnQ=MobKkV352uCSQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org


> Am 29.09.2016 um 07:14 schrieb Rob Herring <robh+dt@kernel.org>:
>=20
> On Tue, Sep 27, 2016 at 12:26 AM, H. Nikolaus Schaller
> <hns@goldelico.com> wrote:
>=20
> The subject gives no indication this is for OMAP. Please follow
> standard patterns.

Already fixed. Please see v2.

>=20
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>> arch/arm/boot/dts/omap5-uevm.dts | 60 =
++++++++++++++++++++++++++++++++++++++++
>> 1 file changed, 60 insertions(+)
>>=20
>> diff --git a/arch/arm/boot/dts/omap5-uevm.dts =
b/arch/arm/boot/dts/omap5-uevm.dts
>> index be659e8..19f5f0a 100644
>> --- a/arch/arm/boot/dts/omap5-uevm.dts
>> +++ b/arch/arm/boot/dts/omap5-uevm.dts
>> @@ -17,6 +17,66 @@
>>                device_type =3D "memory";
>>                reg =3D <0x80000000 0x7F000000>; /* 2032 MB */
>>        };
>> +
>> +       evm_leds {
>> +               compatible =3D "gpio-leds";
>> +
>> +               led@1 {
>=20
> Drop the unit address. There's no reg property.
>=20
>> +                       label =3D "omap5:red:led";
>> +                       gpios =3D <&gpio9 17 GPIO_ACTIVE_HIGH>;
>> +                       linux,default-trigger =3D "mmc0";
>> +                       default-state =3D "off";
>> +               };
>> +
>> +               led@2 {
>> +                       label =3D "omap5:green:led";
>> +                       gpios =3D <&gpio9 18 GPIO_ACTIVE_HIGH>;
>> +                       linux,default-trigger =3D "mmc1";
>> +                       default-state =3D "off";
>> +               };
>> +
>> +               led@3 {
>> +                       label =3D "omap5:blue:led";
>> +                       gpios =3D <&gpio9 19 GPIO_ACTIVE_HIGH>;
>> +                       linux,default-trigger =3D "mmc2";
>> +                       default-state =3D "off";
>> +               };
>> +
>> +               led@4 {
>> +                       label =3D "omap5:green:led1";
>> +                       gpios =3D <&gpio9 2 GPIO_ACTIVE_HIGH>;
>> +                       linux,default-trigger =3D "default-on";
>> +                       default-state =3D "off";
>> +               };
>> +
>> +               led@5 {
>> +                       label =3D "omap5:green:led2";
>> +                       gpios =3D <&gpio9 3 GPIO_ACTIVE_HIGH>;
>> +                       linux,default-trigger =3D "default-on";
>> +                       default-state =3D "off";
>> +               };
>> +
>> +               led@6 {
>> +                       label =3D "omap5:green:led3";
>> +                       gpios =3D <&gpio9 4 GPIO_ACTIVE_HIGH>;
>> +                       linux,default-trigger =3D "heartbeat";
>> +                       default-state =3D "off";
>> +               };
>> +
>> +               led@7 {
>> +                       label =3D "omap5:green:led4";
>> +                       gpios =3D <&gpio9 5 GPIO_ACTIVE_HIGH>;
>> +                       linux,default-trigger =3D "heartbeat";
>> +                       default-state =3D "off";
>> +               };
>> +
>> +               led@8 {
>> +                       label =3D "omap5:green:led5";
>> +                       gpios =3D <&gpio9 6 GPIO_ACTIVE_HIGH>;
>> +                       linux,default-trigger =3D "heartbeat";
>> +                       default-state =3D "off";
>> +               };
>> +       };
>> };
>>=20
>> &hdmi {
>> --
>> 2.7.3
>>=20
>> --
>> To unsubscribe from this list: send the line "unsubscribe devicetree" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
