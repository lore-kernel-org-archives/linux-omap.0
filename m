From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/5] input: touchscreen: ti_am335x_tsc Interchange touchscreen
 and ADC steps
Date: Sat, 08 Nov 2014 12:29:44 +0000
Message-ID: <545E0CB8.7090906@kernel.org>
References: <1415339350-17679-1-git-send-email-vigneshr@ti.com> <1415339350-17679-2-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1415339350-17679-2-git-send-email-vigneshr-l0cyMroinI0@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Brad Griffis <bgriffis-l0cyMroinI0@public.gmane.org>, Sanjeev Sharma <sanjeev_sharma-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>, Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>, Jan Kardell <jan.kardell-KSZdJiTw9mzQT0dZR+AlfA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 07/11/14 05:49, Vignesh R wrote:
> From: Brad Griffis <bgriffis-l0cyMroinI0@public.gmane.org>
>=20
> This patch makes the initial changes required to workaround TSC-false
> pen-up interrupts. It is required to implement these changes in order=
 to
> remove udelay in the TSC interrupt handler and false pen-up events.
> The charge step is to be executed immediately after sampling X+. Henc=
e
> TSC is made to use higher numbered steps (steps 5 to 16 for 5 co-ordi=
nate
> readouts, 4 wire TSC configuration) and ADC to use lower ones. Furthe=
r
> X co-ordinate readouts must be the last to be sampled, thus co-ordina=
tes
> are sampled in the order Y-Z-X.
>=20
> Signed-off-by: Brad Griffis <bgriffis-l0cyMroinI0@public.gmane.org>
> [vigneshr-l0cyMroinI0@public.gmane.org: Ported the patch from v3.12 to v3.18rc2]
>=20
> Signed-off-by: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
=46or the tiny bit in IIO
Acked-by: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

All yours Lee/Dmitry.

Jonathan
> ---
>  drivers/iio/adc/ti_am335x_adc.c           |  5 ++--
>  drivers/input/touchscreen/ti_am335x_tsc.c | 42 ++++++++++++++++++---=
----------
>  2 files changed, 26 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am3=
35x_adc.c
> index b730864731e8..adba23246474 100644
> --- a/drivers/iio/adc/ti_am335x_adc.c
> +++ b/drivers/iio/adc/ti_am335x_adc.c
> @@ -86,19 +86,18 @@ static void tiadc_step_config(struct iio_dev *ind=
io_dev)
>  {
>  	struct tiadc_device *adc_dev =3D iio_priv(indio_dev);
>  	unsigned int stepconfig;
> -	int i, steps;
> +	int i, steps =3D 0;
> =20
>  	/*
>  	 * There are 16 configurable steps and 8 analog input
>  	 * lines available which are shared between Touchscreen and ADC.
>  	 *
> -	 * Steps backwards i.e. from 16 towards 0 are used by ADC
> +	 * Steps forwards i.e. from 0 towards 16 are used by ADC
>  	 * depending on number of input lines needed.
>  	 * Channel would represent which analog input
>  	 * needs to be given to ADC to digitalize data.
>  	 */
> =20
> -	steps =3D TOTAL_STEPS - adc_dev->channels;
>  	if (iio_buffer_enabled(indio_dev))
>  		stepconfig =3D STEPCONFIG_AVG_16 | STEPCONFIG_FIFO1
>  					| STEPCONFIG_MODE_SWCNT;
> diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/inpu=
t/touchscreen/ti_am335x_tsc.c
> index 2ce649520fe0..1aeac9675fe7 100644
> --- a/drivers/input/touchscreen/ti_am335x_tsc.c
> +++ b/drivers/input/touchscreen/ti_am335x_tsc.c
> @@ -121,7 +121,7 @@ static void titsc_step_config(struct titsc *ts_de=
v)
>  {
>  	unsigned int	config;
>  	int i;
> -	int end_step;
> +	int end_step, first_step, tsc_steps;
>  	u32 stepenable;
> =20
>  	config =3D STEPCONFIG_MODE_HWSYNC |
> @@ -140,9 +140,11 @@ static void titsc_step_config(struct titsc *ts_d=
ev)
>  		break;
>  	}
> =20
> -	/* 1 =E2=80=A6 coordinate_readouts is for X */
> -	end_step =3D ts_dev->coordinate_readouts;
> -	for (i =3D 0; i < end_step; i++) {
> +	tsc_steps =3D ts_dev->coordinate_readouts * 2 + 2;
> +	first_step =3D TOTAL_STEPS - tsc_steps;
> +	/* Steps 16 to 16-coordinate_readouts is for X */
> +	end_step =3D first_step + tsc_steps;
> +	for (i =3D end_step - ts_dev->coordinate_readouts; i < end_step; i+=
+) {
>  		titsc_writel(ts_dev, REG_STEPCONFIG(i), config);
>  		titsc_writel(ts_dev, REG_STEPDELAY(i), STEPCONFIG_OPENDLY);
>  	}
> @@ -164,9 +166,9 @@ static void titsc_step_config(struct titsc *ts_de=
v)
>  		break;
>  	}
> =20
> -	/* coordinate_readouts =E2=80=A6 coordinate_readouts * 2 is for Y *=
/
> -	end_step =3D ts_dev->coordinate_readouts * 2;
> -	for (i =3D ts_dev->coordinate_readouts; i < end_step; i++) {
> +	/* 1 ... coordinate_readouts is for Y */
> +	end_step =3D first_step + ts_dev->coordinate_readouts;
> +	for (i =3D first_step; i < end_step; i++) {
>  		titsc_writel(ts_dev, REG_STEPCONFIG(i), config);
>  		titsc_writel(ts_dev, REG_STEPDELAY(i), STEPCONFIG_OPENDLY);
>  	}
> @@ -179,7 +181,7 @@ static void titsc_step_config(struct titsc *ts_de=
v)
>  	titsc_writel(ts_dev, REG_CHARGECONFIG, config);
>  	titsc_writel(ts_dev, REG_CHARGEDELAY, CHARGEDLY_OPENDLY);
> =20
> -	/* coordinate_readouts * 2 =E2=80=A6 coordinate_readouts * 2 + 2 is=
 for Z */
> +	/* coordinate_readouts + 1 ... coordinate_readouts + 2 is for Z */
>  	config =3D STEPCONFIG_MODE_HWSYNC |
>  			STEPCONFIG_AVG_16 | ts_dev->bit_yp |
>  			ts_dev->bit_xn | STEPCONFIG_INM_ADCREFM |
> @@ -194,8 +196,11 @@ static void titsc_step_config(struct titsc *ts_d=
ev)
>  	titsc_writel(ts_dev, REG_STEPDELAY(end_step),
>  			STEPCONFIG_OPENDLY);
> =20
> -	/* The steps1 =E2=80=A6 end and bit 0 for TS_Charge */
> -	stepenable =3D (1 << (end_step + 2)) - 1;
> +	/* The steps end ... end - readouts * 2 + 2 and bit 0 for TS_Charge=
 */
> +	stepenable =3D 1;
> +	for (i =3D 0; i < tsc_steps; i++)
> +		stepenable |=3D 1 << (first_step + i + 1);
> +
>  	ts_dev->step_mask =3D stepenable;
>  	am335x_tsc_se_set_cache(ts_dev->mfd_tscadc, ts_dev->step_mask);
>  }
> @@ -209,6 +214,7 @@ static void titsc_read_coordinates(struct titsc *=
ts_dev,
>  	unsigned int read, diff;
>  	unsigned int i, channel;
>  	unsigned int creads =3D ts_dev->coordinate_readouts;
> +	unsigned int first_step =3D TOTAL_STEPS - (creads * 2 + 2);
> =20
>  	*z1 =3D *z2 =3D 0;
>  	if (fifocount % (creads * 2 + 2))
> @@ -226,7 +232,7 @@ static void titsc_read_coordinates(struct titsc *=
ts_dev,
> =20
>  		channel =3D (read & 0xf0000) >> 16;
>  		read &=3D 0xfff;
> -		if (channel < creads) {
> +		if (channel > first_step + creads + 2) {
>  			diff =3D abs(read - prev_val_x);
>  			if (diff < prev_diff_x) {
>  				prev_diff_x =3D diff;
> @@ -234,19 +240,19 @@ static void titsc_read_coordinates(struct titsc=
 *ts_dev,
>  			}
>  			prev_val_x =3D read;
> =20
> -		} else if (channel < creads * 2) {
> +		} else if (channel =3D=3D first_step + creads + 1) {
> +			*z1 =3D read;
> +
> +		} else if (channel =3D=3D first_step + creads + 2) {
> +			*z2 =3D read;
> +
> +		} else if (channel > first_step) {
>  			diff =3D abs(read - prev_val_y);
>  			if (diff < prev_diff_y) {
>  				prev_diff_y =3D diff;
>  				*y =3D read;
>  			}
>  			prev_val_y =3D read;
> -
> -		} else if (channel < creads * 2 + 1) {
> -			*z1 =3D read;
> -
> -		} else if (channel < creads * 2 + 2) {
> -			*z2 =3D read;
>  		}
>  	}
>  }
>=20
