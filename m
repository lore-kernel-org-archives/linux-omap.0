From: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Subject: Re: [PATCH v2 3/4] arm/dts: OMAP4: Add mmc controller nodes and board data
Date: Fri, 24 Feb 2012 16:29:17 +0530
Message-ID: <CANrkHUbUMHjUwW0-O4t0QLhDgnPTAWhRMGNbKcHa+SMODouCDA@mail.gmail.com>
References: <1329998490-27555-1-git-send-email-rnayak@ti.com>
	<1329998490-27555-4-git-send-email-rnayak@ti.com>
	<CANrkHUaP7cV_vSKQYZkeF-aS5CEi2CAp3_9aDJKCVOX-67oNPg@mail.gmail.com>
	<4F4765EC.1000102@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
In-Reply-To: <4F4765EC.1000102@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, svenkatr@ti.com, linaro-dev@lists.linaro.org
List-Id: linux-omap@vger.kernel.org

On Fri, Feb 24, 2012 at 3:56 PM, Rajendra Nayak <rnayak@ti.com> wrote:
> On Friday 24 February 2012 03:46 PM, T Krishnamoorthy, Balaji wrote:
>>>
>>> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4=
=2Edtsi
>>> index 29f4589..9204f60 100644
>>> --- a/arch/arm/boot/dts/omap4.dtsi
>>> +++ b/arch/arm/boot/dts/omap4.dtsi
>>> @@ -25,6 +25,11 @@
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0serial1 =3D&uart2;
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0serial2 =3D&uart3;
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0serial3 =3D&uart4;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc1 =3D&mmc1;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc2 =3D&mmc2;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc3 =3D&mmc3;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc4 =3D&mmc4;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc5 =3D&mmc5;
>>> =A0 =A0 =A0 =A0};
>>>
>>> =A0 =A0 =A0 =A0cpus {
>>> @@ -155,5 +160,31 @@
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#size-cells =3D<0>;
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ti,hwmods =3D "i2c4"=
;
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc1: mmc@1 {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "ti,om=
ap4-hsmmc";
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ti,hwmods =3D "mmc1";
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ti,dual-volt;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc2: mmc@2 {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "ti,om=
ap4-hsmmc";
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ti,hwmods =3D "mmc2";
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
>>
>>
>> Hi Rajendra,
>> Is there a way to control the device registration order,
>> eMMC connected to mmc2 needs to be registered as /dev/mmcblk0p ...
>> irrespective of whether SD card is mount or not on mmc1 card slot.
>> So that bootargs would not have to be modified when filesystem is on=
 eMMC.
>
>
> I don't know if we can, but even if we could, we take care of the sam=
e
> bootargs working on two boards (say sdp and panda) *if* on sdp I have=
 my
> filesystem on eMMC and on panda I have it on external card.
> What happens if I want to use my filesystem on both boards on externa=
l
> card?

While booting if SD card is present in the card slot, SD is detected
as /dev/mmcblk0
and eMMC as /dev/mmcblk1
If SD card is not present, then eMMC is detected as /dev/mmcblk0
When filesystem is in eMMC then bootargs has to switch between mmcblk0
or mmcblk1
depending on whether SD is present or not.

By changing the device order, eMMC will always be mmcblk0 independent
of SD card status.

>
>
>>
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc3: mmc@3 {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "ti,om=
ap4-hsmmc";
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ti,hwmods =3D "mmc3";
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc4: mmc@4 {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "ti,om=
ap4-hsmmc";
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ti,hwmods =3D "mmc4";
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc5: mmc@5 {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "ti,om=
ap4-hsmmc";
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ti,hwmods =3D "mmc5";
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
>>> =A0 =A0 =A0 =A0};
>>> =A0};
>>> --
>>> 1.7.1
>>>
>
