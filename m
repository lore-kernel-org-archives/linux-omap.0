From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 15/26] ARM: omap4-panda.dts: add display information
Date: Tue, 10 Dec 2013 14:10:59 +0200
Message-ID: <52A704D3.7020405@ti.com>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com>	<1386160133-24026-16-git-send-email-tomi.valkeinen@ti.com>	<CABxcv=m+-9V2qwvuQgJavQ3qOb2+fBcAoW9G_Mi33BTHCWE85g@mail.gmail.com>	<52A5BDF4.2070304@ti.com>	<CABxcv==-aknRfzybA6ify5JSHeiquS9bqAEXumJwhnS6PT0MfA@mail.gmail.com>	<52A5E230.4010901@ti.com>	<CABxcv==2TS00WJduP0EUCmOgLT9x-qzTO+GzyE=R+yooGAmPEA@mail.gmail.com> <CAFqH_517U6vUz7adwaF4h78wvvwPf3v0CYMw93_aFY7_=an1Xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="JL9iw0US2PjGN7Js0QsxSutFxo62U3iT8"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45373 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752387Ab3LJMLG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Dec 2013 07:11:06 -0500
In-Reply-To: <CAFqH_517U6vUz7adwaF4h78wvvwPf3v0CYMw93_aFY7_=an1Xg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Enric Balletbo Serra <eballetbo@gmail.com>, Javier Martinez Canillas <javier@dowhile0.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-fbdev@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>

--JL9iw0US2PjGN7Js0QsxSutFxo62U3iT8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2013-12-10 12:56, Enric Balletbo Serra wrote:
> Hi all,
>=20
> 2013/12/9 Javier Martinez Canillas <javier@dowhile0.org>:
>> Hi Tomi,
>>
>> On Mon, Dec 9, 2013 at 4:30 PM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
>>> On 2013-12-09 17:09, Javier Martinez Canillas wrote:
>>>> Hi Tomi,
>>>>
>>>> On Mon, Dec 9, 2013 at 1:56 PM, Tomi Valkeinen <tomi.valkeinen@ti.co=
m> wrote:
>>>>> On 2013-12-06 10:57, Javier Martinez Canillas wrote:
>>>>>
>>>>>>> +       tfp410: encoder@0 {
>>>>>>> +               compatible =3D "ti,tfp410";
>>>>>>> +               gpios =3D <&gpio1 0 0>;   /* 0, power-down */
>>>>>>> +
>>>>>>
>>>>>> Please use the constants from include/dt-bindings/ instead of magi=
c
>>>>>> numbers, i.e:
>>>>>>
>>>>>> gpios =3D <&gpio1 0 GPIO_ACTIVE_HIGH>;   /* 0, power-down */
>>>>>
>>>>> Thanks, fixed now (for all .dts files)
>>>>>
>>>>> However... The TFP410 gpio is "power-down". I think we should actua=
lly
>>>>> mark it as GPIO_ACTIVE_LOW, as setting it to 0 powers down the devi=
ce.
>>>>>
>>>>
>>>> yes, I looked at the TFP410 datasheet [0] and the Power Down pin is
>>>> indeed an active-low, I just replaced to GPIO_ACTIVE_HIGH since you
>>>> were using a constant 0 and include/dt-bindings/gpio/gpio.h defines
>>>> GPIO_ACTIVE_HIGH  as 0.
>>>>
>>>> I just asked to Enric why we use GPIO_ACTIVE_HIGH for the PD pin on
>>>> the IGEPv2 DTS instad and is because the IGEP board uses a hardware
>>>> signal inverter but that is a special case. I don't know about the
>>>> Panda board since I haven't looked at its datasheet.
>>>
>>> Oh. Does it work on igep? The TFP410 driver always handles the PD GPI=
O
>>> as it were active-low. The flag is ignored.
>>>
>>
>> How weird, it does work on the IGEPv2 but you are right I just looked
>> at  at drivers/video/omap2/displays-new/encoder-tfp410.c and I see
>> that it indeed just does:
>>
>> r =3D devm_gpio_request_one(&pdev->dev, ddata->pd_gpio,
>> GPIOF_OUT_INIT_LOW, "tfp410 PD");
>>
>> So I don't know how it is working... I'm on the road and won't have
>> access to my IGEPv2 to dig further on this. Maybe Enric can shed more
>> light on this.
>>
>=20
> On IGEPv2 the GPIO that controls the power-down pin is connected
> through a dual/buffer driver [1]. This driver is only a buffer, not
> inverts the signal (I had told you wrong, sorry Javier ), so the pin
> continues being active low.
>=20
> As both of you pointed the driver ignores the flag to handle the PD
> GPIO, so doesn't matter if in the device tree we put GPIO_ACTIVE_HIGH
> or GPIO_ACTIVE_LOW, so simply it works. About the patch to support
> display for IGEP, to be coherent, the gpio should be defined as
> GPIO_ACTIVE_LOW not GPIO_ACTIVE_HIGH. I have tested, and of course,
> works.
>=20
>=20
> diff --git a/arch/arm/boot/dts/omap3-igep0020.dts
> b/arch/arm/boot/dts/omap3-igep0020.dts
> index 2569d60..d185e06 100644
> --- a/arch/arm/boot/dts/omap3-igep0020.dts
> +++ b/arch/arm/boot/dts/omap3-igep0020.dts
> @@ -233,7 +233,7 @@
>=20
>         tfp410: encoder@0 {
>                 compatible =3D "ti,tfp410";
> -               gpios =3D <&gpio6 10 GPIO_ACTIVE_HIGH>; /* 170, power-d=
own */
> +               gpios =3D <&gpio6 10 GPIO_ACTIVE_LOW>; /* 170, power-do=
wn */
>=20
>                 ports {
>                         #address-cells =3D <1>;
>=20
>=20
> [1] http://www.ti.com/product/sn74lvc2g07

Ok, looks good. I have changed the TFP gpios to active-low in my series
for all .dts files, which includes the igep0020.dts.

 Tomi



--JL9iw0US2PjGN7Js0QsxSutFxo62U3iT8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSpwTTAAoJEPo9qoy8lh71cJEP/jsdVGoHta3xnX7tqkHrT8/J
VuG2oE+khVbMHditgNBAlrwWC+rGNC6RbibvVjc+NDoscRHROSKOaCfnixqWVD2r
CUmwvZamz0Uppjzpuu8S0eYURlD9J7KYHkag0jGYdzveHwZOPfG0wwUHDS0Xe4Ln
FXY08kavlyCVoF17N4wkse6+GAp2IZ4DI39x3qGSzwMnQ2/yMSEidCqPpHvrVevT
q6YYiW1+wB1p6VM8rsq8YbKspH1RZ+rdxE4AtIfOCfPxy1Rzn2ks2ywweefVB4ku
4nNeTFQ5GjjXNj+PEkTd8rnx+edZySEAqqTgRuR5gAMnlc0q6vn7izC2crq5o4ap
5gp+HvQ/9T/yYX2Qz9xT5M0p6cS9BqwW1XzWQKi6fWT7mvxMpCInnoz/ErPGcoaU
snVI0VRLmxzP5YwJzwuzSMPQuJn6jjr4EKurpm+6K/TTDaYwQaffYjh1yXUi8f/A
8OHLbCufqvxKNf59cJaj1tVMpDaYFweE4IfRHbjI6C5Za/6FofmLfnEZGCG13kP4
1iGBqUpgQzgXnR/8c2apMig48wvOrfso87rLTyhrugHohf62m5tAabuPp8xpMAEQ
8cYZQyb1v5gFFbTzgKeh7xPo1bjeGsxTcnNvUNPRftxkTAhKPNRNdaWdL1Zsjb9Q
PrjjAoFp7ouRTkaHHzDS
=DwSx
-----END PGP SIGNATURE-----

--JL9iw0US2PjGN7Js0QsxSutFxo62U3iT8--
