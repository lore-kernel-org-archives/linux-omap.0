From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH 1/4] input: touchscreen: ti_am335x_tsc Interchange touchscreen
 and ADC steps
Date: Fri, 7 Nov 2014 11:18:13 +0530
Message-ID: <545C5D1D.9010305@ti.com>
References: <1414408111-2631-1-git-send-email-vigneshr@ti.com> <1414408111-2631-2-git-send-email-vigneshr@ti.com> <5453F935.10007@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5453F935.10007@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Hartmut Knaack <knaack.h@gmx.de>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Jonathan Cameron <jic23@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Felipe Balbi <balbi@ti.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Jan Kardell <jan.kardell@telliq.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Brad Griffis <bgriffis@ti.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On Saturday 01 November 2014 02:33 AM, Hartmut Knaack wrote:
> Vignesh R schrieb am 27.10.2014 12:08:
>> From: Brad Griffis <bgriffis@ti.com>
>>
>> This patch makes the initial changes required to workaround TSC-fals=
e
>> pen-up interrupts. It is required to implement these changes in orde=
r to
>> remove udelay in the TSC interrupt handler and false pen-up events.
>> The charge step is to be executed immediately after sampling X+. Hen=
ce
>> TSC is made to use higher numbered steps (steps 5 to 16 for 5 co-ord=
inate
>> readouts, 4 wire TSC configuration) and ADC to use lower ones. Furth=
er
>> X co-ordinate readouts must be the last to be sampled, thus co-ordin=
ates
>> are sampled in the order Y-Z-X.
>>
>> Signed-off-by: Brad Griffis <bgriffis@ti.com>
>> [vigneshr@ti.com: Ported the patch from v3.12 to v3.18rc2]
>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>> ---
>>  drivers/iio/adc/ti_am335x_adc.c           |  2 +-
>>  drivers/input/touchscreen/ti_am335x_tsc.c | 42 ++++++++++++++++++--=
-----------
>>  2 files changed, 25 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am=
335x_adc.c
>> index b730864731e8..3f530ed6bd80 100644
>> --- a/drivers/iio/adc/ti_am335x_adc.c
>> +++ b/drivers/iio/adc/ti_am335x_adc.c
>> @@ -98,7 +98,7 @@ static void tiadc_step_config(struct iio_dev *indi=
o_dev)
>>  	 * needs to be given to ADC to digitalize data.
>>  	 */
>> =20
>> -	steps =3D TOTAL_STEPS - adc_dev->channels;
>> +	steps =3D 0;
> You could even initialize it with zero during variable definition. An=
d I think the above comment could need an update now.

Ok, Will update the comment and initialization

>>  	if (iio_buffer_enabled(indio_dev))
>>  		stepconfig =3D STEPCONFIG_AVG_16 | STEPCONFIG_FIFO1
>>  					| STEPCONFIG_MODE_SWCNT;
>> diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/inp=
ut/touchscreen/ti_am335x_tsc.c
>> index 2ce649520fe0..1aeac9675fe7 100644
>> --- a/drivers/input/touchscreen/ti_am335x_tsc.c
>> +++ b/drivers/input/touchscreen/ti_am335x_tsc.c
>> @@ -121,7 +121,7 @@ static void titsc_step_config(struct titsc *ts_d=
ev)
>>  {
>>  	unsigned int	config;
>>  	int i;
>> -	int end_step;
>> +	int end_step, first_step, tsc_steps;
>>  	u32 stepenable;
>> =20
>>  	config =3D STEPCONFIG_MODE_HWSYNC |
>> @@ -140,9 +140,11 @@ static void titsc_step_config(struct titsc *ts_=
dev)
>>  		break;
>>  	}
>> =20
>> -	/* 1 =E2=80=A6 coordinate_readouts is for X */
>> -	end_step =3D ts_dev->coordinate_readouts;
>> -	for (i =3D 0; i < end_step; i++) {
>> +	tsc_steps =3D ts_dev->coordinate_readouts * 2 + 2;
>> +	first_step =3D TOTAL_STEPS - tsc_steps;
>> +	/* Steps 16 to 16-coordinate_readouts is for X */
>> +	end_step =3D first_step + tsc_steps;
>> +	for (i =3D end_step - ts_dev->coordinate_readouts; i < end_step; i=
++) {
>>  		titsc_writel(ts_dev, REG_STEPCONFIG(i), config);
>>  		titsc_writel(ts_dev, REG_STEPDELAY(i), STEPCONFIG_OPENDLY);
>>  	}
>> @@ -164,9 +166,9 @@ static void titsc_step_config(struct titsc *ts_d=
ev)
>>  		break;
>>  	}
>> =20
>> -	/* coordinate_readouts =E2=80=A6 coordinate_readouts * 2 is for Y =
*/
>> -	end_step =3D ts_dev->coordinate_readouts * 2;
>> -	for (i =3D ts_dev->coordinate_readouts; i < end_step; i++) {
>> +	/* 1 ... coordinate_readouts is for Y */
>> +	end_step =3D first_step + ts_dev->coordinate_readouts;
>> +	for (i =3D first_step; i < end_step; i++) {
>>  		titsc_writel(ts_dev, REG_STEPCONFIG(i), config);
>>  		titsc_writel(ts_dev, REG_STEPDELAY(i), STEPCONFIG_OPENDLY);
>>  	}
>> @@ -179,7 +181,7 @@ static void titsc_step_config(struct titsc *ts_d=
ev)
>>  	titsc_writel(ts_dev, REG_CHARGECONFIG, config);
>>  	titsc_writel(ts_dev, REG_CHARGEDELAY, CHARGEDLY_OPENDLY);
>> =20
>> -	/* coordinate_readouts * 2 =E2=80=A6 coordinate_readouts * 2 + 2 i=
s for Z */
>> +	/* coordinate_readouts + 1 ... coordinate_readouts + 2 is for Z */
>>  	config =3D STEPCONFIG_MODE_HWSYNC |
>>  			STEPCONFIG_AVG_16 | ts_dev->bit_yp |
>>  			ts_dev->bit_xn | STEPCONFIG_INM_ADCREFM |
>> @@ -194,8 +196,11 @@ static void titsc_step_config(struct titsc *ts_=
dev)
>>  	titsc_writel(ts_dev, REG_STEPDELAY(end_step),
>>  			STEPCONFIG_OPENDLY);
>> =20
>> -	/* The steps1 =E2=80=A6 end and bit 0 for TS_Charge */
>> -	stepenable =3D (1 << (end_step + 2)) - 1;
>> +	/* The steps end ... end - readouts * 2 + 2 and bit 0 for TS_Charg=
e */
>> +	stepenable =3D 1;
>> +	for (i =3D 0; i < tsc_steps; i++)
>> +		stepenable |=3D 1 << (first_step + i + 1);
>> +
>>  	ts_dev->step_mask =3D stepenable;
>>  	am335x_tsc_se_set_cache(ts_dev->mfd_tscadc, ts_dev->step_mask);
>>  }
>> @@ -209,6 +214,7 @@ static void titsc_read_coordinates(struct titsc =
*ts_dev,
>>  	unsigned int read, diff;
>>  	unsigned int i, channel;
>>  	unsigned int creads =3D ts_dev->coordinate_readouts;
>> +	unsigned int first_step =3D TOTAL_STEPS - (creads * 2 + 2);
>> =20
>>  	*z1 =3D *z2 =3D 0;
>>  	if (fifocount % (creads * 2 + 2))
>> @@ -226,7 +232,7 @@ static void titsc_read_coordinates(struct titsc =
*ts_dev,
>> =20
>>  		channel =3D (read & 0xf0000) >> 16;
>>  		read &=3D 0xfff;
>> -		if (channel < creads) {
>> +		if (channel > first_step + creads + 2) {
>>  			diff =3D abs(read - prev_val_x);
>>  			if (diff < prev_diff_x) {
>>  				prev_diff_x =3D diff;
>> @@ -234,19 +240,19 @@ static void titsc_read_coordinates(struct tits=
c *ts_dev,
>>  			}
>>  			prev_val_x =3D read;
>> =20
>> -		} else if (channel < creads * 2) {
>> +		} else if (channel =3D=3D first_step + creads + 1) {
>> +			*z1 =3D read;
>> +
>> +		} else if (channel =3D=3D first_step + creads + 2) {
>> +			*z2 =3D read;
>> +
>> +		} else if (channel > first_step) {
>>  			diff =3D abs(read - prev_val_y);
>>  			if (diff < prev_diff_y) {
>>  				prev_diff_y =3D diff;
>>  				*y =3D read;
>>  			}
>>  			prev_val_y =3D read;
>> -
>> -		} else if (channel < creads * 2 + 1) {
>> -			*z1 =3D read;
>> -
>> -		} else if (channel < creads * 2 + 2) {
>> -			*z2 =3D read;
>>  		}
>>  	}
>>  }
>>
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
