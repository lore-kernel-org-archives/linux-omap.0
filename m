From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: Re: [PATCH 2/3] DT: EVM: add LEDs
Date: Thu, 29 Sep 2016 07:20:04 +0200
Message-ID: <10DBAA54-0F86-4B52-BFB3-DA05F59D3860@goldelico.com>
References: <cover.1474953969.git.hns@goldelico.com> <d68619a23d642eacf12fd0a3c51f19d006436cbe.1474953969.git.hns@goldelico.com> <CAL_Jsq+hVD2TCubk8vGf8cS7dyLQj1o0ChnQ=MobKkV352uCSQ@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAL_Jsq+hVD2TCubk8vGf8cS7dyLQj1o0ChnQ=MobKkV352uCSQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org


> Am 29.09.2016 um 07:14 schrieb Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
>=20
> On Tue, Sep 27, 2016 at 12:26 AM, H. Nikolaus Schaller
> <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org> wrote:
>=20
> The subject gives no indication this is for OMAP. Please follow
> standard patterns.
>=20
>> Signed-off-by: H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
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

This needs to be fixed. Goes to v3.

BR and thanks,
Nikolaus

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
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
