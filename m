From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v3 3/3] pwm: New driver to support PWM driven LEDs on
 TWL4030/6030 series of PMICs
Date: Mon, 26 Nov 2012 09:30:03 +0100
Message-ID: <50B3288B.5020500@ti.com>
References: <1353405382-9226-1-git-send-email-peter.ujfalusi@ti.com> <1353405382-9226-4-git-send-email-peter.ujfalusi@ti.com> <20121123150412.GB16810@avionic-0098.adnet.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121123150412.GB16810@avionic-0098.adnet.avionic-design.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Tero Kristo <t-kristo@ti.com>, Grazvydas Ignotas <notasas@gmail.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-omap@vger.kernel.org

On 11/23/2012 04:04 PM, Thierry Reding wrote:
> On Tue, Nov 20, 2012 at 10:56:22AM +0100, Peter Ujfalusi wrote:
>> The driver supports the following LED outputs as generic PWM driver:
>> TWL4030 LEDA and LEDB (PWMA and PWMB)
>> TWL6030 Charging indicator LED (PWM LED)
>>
>> On TWL6030 when the PWM requested LED is configured to be controlled=
 by SW.
>> In this case the user can enable/disable and set the duty period fre=
ely.
>> When the PWM has been freed, the LED driver is put back to HW contro=
l.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  drivers/pwm/Kconfig       |  10 ++
>>  drivers/pwm/Makefile      |   1 +
>>  drivers/pwm/pwm-twl-led.c | 303 +++++++++++++++++++++++++++++++++++=
+++++++++++
>>  3 files changed, 314 insertions(+)
>>  create mode 100644 drivers/pwm/pwm-twl-led.c
>=20
> Doesn't this belong in the drivers/leds subsystem? Besides that, the
> same comments as for the previous patch apply. One additional note
> below.

The PINs itself are called as LED but they are PWMs at the end. If we
represent them as PWMs they can be used for different purposes which is=
 going
to be needed for example in BeagleBoard, where the LEDA (PWMA) is used =
as a
GPO to enable/disable the USB host power.
Also the removed 'twl6030-pwm' driver was only controlled the LED part =
of twl6030.
With this series I enable the use of the PWMs and the PWMs behind of th=
e LED
functions to give us flexibility on how we are using them.

>=20
>> +static struct platform_driver twl_pwmled_driver =3D {
>> +	.driver =3D {
>> +		.name =3D "twl-pwmled",
>> +		.of_match_table =3D of_match_ptr(twl_pwmled_of_match),
>> +	},
>> +	.probe =3D twl_pwmled_probe,
>> +	.remove =3D __devexit_p(twl_pwmled_remove),
>=20
> You didn't annotate twl_pwmled_remove() with __devexit, so __devexit_=
p
> isn't needed here either.

Oh yes, I have also received patches from a series which removes the
_devexit_p() from the kernel.
But should the __devexit need to be added to the remove function?

--=20
P=E9ter
