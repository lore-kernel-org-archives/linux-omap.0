From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v3 3/3] pwm: New driver to support PWM driven LEDs on
 TWL4030/6030 series of PMICs
Date: Mon, 26 Nov 2012 10:33:55 +0100
Message-ID: <50B33783.80704@ti.com>
References: <1353405382-9226-1-git-send-email-peter.ujfalusi@ti.com> <1353405382-9226-4-git-send-email-peter.ujfalusi@ti.com> <20121123150412.GB16810@avionic-0098.adnet.avionic-design.de> <50B3288B.5020500@ti.com> <20121126091756.GA8602@avionic-0098.adnet.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121126091756.GA8602@avionic-0098.adnet.avionic-design.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Tero Kristo <t-kristo@ti.com>, Grazvydas Ignotas <notasas@gmail.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-omap@vger.kernel.org

On 11/26/2012 10:17 AM, Thierry Reding wrote:
>>> Doesn't this belong in the drivers/leds subsystem? Besides that, th=
e
>>> same comments as for the previous patch apply. One additional note
>>> below.
>>
>> The PINs itself are called as LED but they are PWMs at the end. If w=
e
>> represent them as PWMs they can be used for different purposes which=
 is going
>> to be needed for example in BeagleBoard, where the LEDA (PWMA) is us=
ed as a
>> GPO to enable/disable the USB host power.
>=20
> Heh, that's an interesting use-case for a PWM. =3D)

You should have seen the expression on my face when I saw this on the
schematics ;)

>> Also the removed 'twl6030-pwm' driver was only controlled the LED pa=
rt of twl6030.
>> With this series I enable the use of the PWMs and the PWMs behind of=
 the LED
>> functions to give us flexibility on how we are using them.
>=20
> Alright, we can keep it in the PWM subsystem then.

Thank you.

>>>> +static struct platform_driver twl_pwmled_driver =3D {
>>>> +	.driver =3D {
>>>> +		.name =3D "twl-pwmled",
>>>> +		.of_match_table =3D of_match_ptr(twl_pwmled_of_match),
>>>> +	},
>>>> +	.probe =3D twl_pwmled_probe,
>>>> +	.remove =3D __devexit_p(twl_pwmled_remove),
>>>
>>> You didn't annotate twl_pwmled_remove() with __devexit, so __devexi=
t_p
>>> isn't needed here either.
>>
>> Oh yes, I have also received patches from a series which removes the
>> _devexit_p() from the kernel.
>> But should the __devexit need to be added to the remove function?
>=20
> __devexit_p without a corresponding __devexit doesn't make sense. But=
 as
> all of __devinit, __devexit and __devexit_p will be removed sooner or
> later, new code just shouldn't bother adding it. In this case, just d=
rop
> __devexit_p.

I'll get rid of them.

Thank you,
P=E9ter
