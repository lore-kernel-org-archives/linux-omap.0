From: =?UTF-8?B?UMOpdGVyIFVqZmFsdXNp?= <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 3/3] pwm: New driver to support PWM driven LEDs on TWL4030/6030
 series of PMICs
Date: Thu, 8 Nov 2012 08:34:31 +0100
Message-ID: <509B6087.2040004@ti.com>
References: <1352299488-11351-1-git-send-email-peter.ujfalusi@ti.com> <1352299488-11351-4-git-send-email-peter.ujfalusi@ti.com> <CANOLnONc29=cDZE=UXubs7DYOUWbgLJspPPVT2Hfq9E3zXkgVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANOLnONc29=cDZE=UXubs7DYOUWbgLJspPPVT2Hfq9E3zXkgVQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Thierry Reding <thierry.reding@avionic-design.de>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 11/07/2012 07:12 PM, Grazvydas Ignotas wrote:
>> +static int twl4030_pwmled_config(struct pwm_chip *chip, struct pwm_=
device *pwm,
>> +                             int duty_ns, int period_ns)
>> +{
>> +       int duty_cycle =3D (duty_ns * TWL4030_LED_MAX) / period_ns;
>> +       u8 on_time;
>> +       u8 pwm_config[2];
>> +       int base, ret;
>> +
>> +       if (duty_cycle >=3D TWL4030_LED_MAX)
>> +               on_time =3D TWL4030_LED_MAX;
>> +       else if (!duty_cycle)
>> +               on_time =3D TWL4030_LED_MAX - 1;
>> +       else
>> +               on_time =3D TWL4030_LED_MAX - duty_cycle;
>> +
>> +       base =3D pwm->hwpwm * 2 + TWL4030_PWMA_REG;
>> +
>> +       pwm_config[0] =3D on_time;
>> +       pwm_config[1] =3D TWL4030_LED_MAX;
>> +
>> +       ret =3D twl_i2c_write(TWL4030_MODULE_LED, pwm_config, base, =
2);
>=20
> Shouldn't this use TWL4030_MODULE_PWMA and TWL4030_MODULE_PWMB as
> first argument? I can guess it works your way too, but
> TWL4030_MODULE_PWMx would match the TRM better.

I don't have strong opinion regarding to this. You mean changing from:

base =3D pwm->hwpwm * 2 + TWL4030_PWMA_REG;
ret =3D twl_i2c_write(TWL4030_MODULE_LED, pwm_config, base, 2);

to:

if (pwm->hwpwm)
	module =3D TWL4030_MODULE_PWMB;
else
	module =3D TWL4030_MODULE_PWMA;
ret =3D twl_i2c_write(module, pwm_config, 0, 2);

But I want to note that I'm currently trying to clean up the mess aroun=
d
twl-core. In my view we have quite a bit of redundancy in there. The PW=
M A/B
is for driving the LED A/B outputs. We should have only these modules f=
or
PWM/LED in twl-core:
TWL_MODULE_PWM - offset for PWM0ON register in twl4030 and PWM1ON for t=
wl6030
TWL_MODULE_LED - offset for LEDEN register in twl4030 and LED_PWM_CTRL1
		 for twl6030

=46rom here the driver can figure out what to do IMHO.

There's no need to have separate TWL 'modules' for:
TWL4030_BASEADD_PWM0
TWL4030_BASEADD_PWM1
TWL4030_BASEADD_PWMA
TWL4030_BASEADD_PWMB

--=20
P=C3=A9ter
