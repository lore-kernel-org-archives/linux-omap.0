From: Milo Kim <milo.kim-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 4/6] regulator: lp872x: Add enable GPIO pin support
Date: Wed, 30 Dec 2015 09:22:15 +0900
Message-ID: <568323B7.7080101@ti.com>
References: <1450868319-20513-1-git-send-email-contact@paulk.fr>
 <1450868319-20513-5-git-send-email-contact@paulk.fr>
 <20151223115632.GS16023@sirena.org.uk> <568088B4.6090207@ti.com>
 <1451342963.14631.13.camel@collins> <5681D7A8.2030101@ti.com>
 <1451387613.18148.9.camel@collins>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1451387613.18148.9.camel@collins>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Paul,

On 29/12/15 20:13, Paul Kocialkowski wrote:
> Hi Milo,
>
> Le mardi 29 d=C3=A9cembre 2015 =C3=A0 09:45 +0900, Milo Kim a =C3=A9c=
rit :
>> Hi Paul,
>>
>> On 29/12/15 07:49, Paul Kocialkowski wrote:
>>> Hi Milo, thanks for the review,
>>>
>>> Le lundi 28 d=C3=A9cembre 2015 =C3=A0 09:56 +0900, Milo Kim a =C3=A9=
crit :
>>>> Hi Paul,
>>>>
>>>> On 23/12/15 20:56, Mark Brown wrote:
>>>>> On Wed, Dec 23, 2015 at 11:58:37AM +0100, Paul Kocialkowski wrote=
:
>>>>>
>>>>>> +	gpio =3D lp->pdata->enable_gpio;
>>>>>> +	if (!gpio_is_valid(gpio))
>>>>>> +		return 0;
>>>>>> +
>>>>>> +	/* Always set enable GPIO high. */
>>>>>> +	ret =3D devm_gpio_request_one(lp->dev, gpio, GPIOF_OUT_INIT_HI=
GH, "LP872X EN");
>>>>>> +	if (ret) {
>>>>>> +		dev_err(lp->dev, "gpio request err: %d\n", ret);
>>>>>> +		return ret;
>>>>>> +	}
>>>>>
>>>>> This isn't really adding support for the enable GPIO as the chang=
elog
>>>>> suggests, it's requesting but not managing the GPIO.  Since there=
 is
>>>>> core support for manging enable GPIOs this seems especially silly=
,
>>>>> please tell the core about the GPIO and then it will work at runt=
ime
>>>>> too.
>>>>>
>>>>
>>>> With reference to my previous mail, external GPIOs for LDO3 and BU=
CK2 in
>>>> LP8725 can be specified through regulator_config.ena_gpio. BUCK2 o=
nly
>>>> can be controlled by external pin when CONFIG pin is grounded.
>>>>
>>>> Please see the description at page 5 of the datasheet.
>>>>
>>>> 	http://www.ti.com/lit/ds/symlink/lp8725.pdf
>>>
>>> After reading the datasheets thoroughly, it seems to me that for th=
e
>>> lp8720, the EN pin is used to enable the regulators output, which i=
s a
>>> good fit for the core regulator GPIO framework, as there is no reas=
on to
>>> keep it on when no regulator is in use. The serial interface is alr=
eady
>>> available when EN=3D0 and regulators can be configured in that stat=
e. The
>>> lp8725 seems seems to behave the same when CONFIG=3D0 (the datashee=
t
>>> clearly states: "CONFIG=3D0: EN=3D1 turns on outputs or standby mod=
e if
>>> EN=3D0"). On the other hand, it is indeed used as a power-on pin wh=
en
>>> CONFIG=3D1.
>>
>> I think it's different use case. LP8720/5 are designed for system PM=
U,
>> so some regulators are enabled by default after the device is on. EN=
 pin
>> is used for turning on/off the chip. This pin does not control regul=
ator
>> outputs directly. It's separate functional block in the silicon.
>
> Well, I really don't understand why the EN pin would turn on/off the
> chip. All it does it enable the regulators outputs (by entering IDLE
> mode), the serial block is already available in STANDBY state.
>
> If we want some regulators enabled at boot, the best thing to do seem=
s
> to be to request the GPIO with the GPIOF_INIT_HIGH flag, as done in e=
=2Eg.
> the max8952 regulator driver:
>
> 	if (pdata->reg_data->constraints.boot_on)
> 		config.ena_gpio_flags |=3D GPIOF_OUT_INIT_HIGH;

According to MAX8952 datasheet, output regulator is enabled/disabled=20
using EN pin, so ena_gpio is used correctly.
However, LP8720/5 regulators are enabled/disabled through I2C command.=20
Only few regulators of LP8725 can be on/off by separate external pins.=20
(B2_EN and LDO3_EN)
Please note that EN pin in LP8720/5 is not the control pin for=20
enabling/disabling regulators.

Best regards,
Milo
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
