From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [PATCH] ARM: dts: igep0033: Add mmc1 node for SDCARD support.
Date: Tue, 22 Oct 2013 11:01:51 +0200
Message-ID: <CAFqH_528TfOMZBfjYM4LzzbhJ5r7KnkX845zkPhP-1xxOy0HXg@mail.gmail.com>
References: <1382216119-14125-1-git-send-email-eballetbo@gmail.com>
	<52663DF5.5020401@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:52229 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988Ab3JVJBw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Oct 2013 05:01:52 -0400
Received: by mail-wi0-f180.google.com with SMTP id ey11so5285443wid.13
        for <linux-omap@vger.kernel.org>; Tue, 22 Oct 2013 02:01:51 -0700 (PDT)
In-Reply-To: <52663DF5.5020401@baylibre.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <martinez.javier@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Benoit

2013/10/22 Benoit Cousson <bcousson@baylibre.com>:
> Hi Enric,
>
>
> On 19/10/2013 22:55, Enric Balletbo i Serra wrote:
>>
>> Add mmc1 dt node to IGEP COM AQUILA board.
>
>
> I've just applied it.
>
> Please note that since we are already at -rc6 and since all the maint=
ainers
> are actually visiting Edinburgh for KS and ELCE, I doubt all the late=
st
> patches will reach 3.13 :-(
>

No problem, I understand.

Thanks,
    Enric

> Thanks,
> Benoit
>
>
>
>> Signed-off-by: Enric Balletbo i Serra <eballetbo@gmail.com>
>> ---
>>   arch/arm/boot/dts/am335x-igep0033.dtsi | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/am335x-igep0033.dtsi
>> b/arch/arm/boot/dts/am335x-igep0033.dtsi
>> index 06eba07..6196244 100644
>> --- a/arch/arm/boot/dts/am335x-igep0033.dtsi
>> +++ b/arch/arm/boot/dts/am335x-igep0033.dtsi
>> @@ -44,6 +44,13 @@
>>                 regulator-max-microvolt =3D <5000000>;
>>                 regulator-boot-on;
>>         };
>> +
>> +       vmmc: fixedregulator@0 {
>> +               compatible =3D "regulator-fixed";
>> +               regulator-name =3D "vmmc";
>> +               regulator-min-microvolt =3D <3300000>;
>> +               regulator-max-microvolt =3D <3300000>;
>> +       };
>>   };
>>
>>   &am33xx_pinmux {
>> @@ -180,6 +187,12 @@
>>         };
>>   };
>>
>> +&mmc1 {
>> +       status =3D "okay";
>> +       vmmc-supply =3D <&vmmc>;
>> +       bus-width =3D <4>;
>> +};
>> +
>>   &uart0 {
>>         status =3D "okay";
>>         pinctrl-names =3D "default";
>>
>
>
> --
> Beno=C4=ABt Cousson
> BayLibre
> Embedded Linux Technology Lab
> www.baylibre.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
