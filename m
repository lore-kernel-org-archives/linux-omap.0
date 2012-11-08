From: =?UTF-8?B?UMOpdGVyIFVqZmFsdXNp?= <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 3/3] pwm: New driver to support PWM driven LEDs on TWL4030/6030
 series of PMICs
Date: Thu, 8 Nov 2012 13:55:52 +0100
Message-ID: <509BABD8.5080600@ti.com>
References: <1352299488-11351-1-git-send-email-peter.ujfalusi@ti.com> <1352299488-11351-4-git-send-email-peter.ujfalusi@ti.com> <CANOLnONc29=cDZE=UXubs7DYOUWbgLJspPPVT2Hfq9E3zXkgVQ@mail.gmail.com> <509B6087.2040004@ti.com> <CANOLnONQf6HH4GbVo2M9RbMytS4GfihypU5grOvDRs8LyP+M6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANOLnONQf6HH4GbVo2M9RbMytS4GfihypU5grOvDRs8LyP+M6Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Thierry Reding <thierry.reding@avionic-design.de>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 11/08/2012 01:29 PM, Grazvydas Ignotas wrote:
>> But I want to note that I'm currently trying to clean up the mess ar=
ound
>> twl-core. In my view we have quite a bit of redundancy in there. The=
 PWM A/B
>> is for driving the LED A/B outputs. We should have only these module=
s for
>> PWM/LED in twl-core:
>> TWL_MODULE_PWM - offset for PWM0ON register in twl4030 and PWM1ON fo=
r twl6030
>> TWL_MODULE_LED - offset for LEDEN register in twl4030 and LED_PWM_CT=
RL1
>>                  for twl6030
>>
>> From here the driver can figure out what to do IMHO.
>>
>> There's no need to have separate TWL 'modules' for:
>> TWL4030_BASEADD_PWM0
>> TWL4030_BASEADD_PWM1
>> TWL4030_BASEADD_PWMA
>> TWL4030_BASEADD_PWMB
>=20
> Well all these seem to come from TRM, no hard feelings here too but i=
f
> you are going to remove them, probably worth adding a comment.

=46rom the 'outside' of twl4030 we have: LEDA, LEDB, PWM0 and PWM1 pins=
=2E This is
more important from system integration point of view than what name the=
 TRM
calls the PWM (PWMA) behind of the LEDA terminal for example.

At the end in the board file you will have to use something like this:

static struct pwm_lookup zoom_pwm_lookup[] =3D {
	PWM_LOOKUP("twl-pwm", 0, "leds_pwm", "zoom::keypad"),       /* PWM0 */
	PWM_LOOKUP("twl-pwm", 1, "pwm-backlight", "backlight"),     /* PWM1 */
	PWM_LOOKUP("twl-pwm-led", 0, "leds_pwm", "zoom::blinking"), /* LEDA */
};

I'll add comment to both the pwm-twl and pwm-twl-led driver for clarifi=
cation.

--=20
P=C3=A9ter
