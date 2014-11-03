From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/4] input: touchscreen: ti_am335x_tsc: Remove udelay in
 interrupt handler
Date: Mon, 3 Nov 2014 15:05:26 +0000
Message-ID: <20141103150526.GI4538@x1>
References: <1414408111-2631-1-git-send-email-vigneshr@ti.com>
 <1414408111-2631-3-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1414408111-2631-3-git-send-email-vigneshr-l0cyMroinI0@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jan Kardell <jan.kardell-KSZdJiTw9mzQT0dZR+AlfA@public.gmane.org>, Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>, Brad Griffis <bgriffis-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.orgli
List-Id: linux-omap@vger.kernel.org

On Mon, 27 Oct 2014, Vignesh R wrote:
> From: Brad Griffis <bgriffis-l0cyMroinI0@public.gmane.org>
>=20
> TSC interrupt handler had udelay to avoid reporting of false pen-up
> interrupt to user space. This patch implements workaround suggesting =
in
> Advisory 1.0.31 of silicon errata for am335x, thus eliminating udelay
> and touchscreen lag. This also improves performance of touchscreen an=
d
> eliminates sudden jump of cursor at touch release.
>=20
> IDLECONFIG and CHARGECONFIG registers are to be configured
> with same values in order to eliminate false pen-up events. This
> workaround may result in false pen-down to be detected, hence conside=
rable
> charge step delay needs to be added. The charge delay is set to 0xB00=
0
> (in terms of ADC clock cycles) by default.
>=20
> TSC steps are disabled at the end of every sampling cycle and EOS bit=
 is
> set. Once the EOS bit is set, the TSC steps need to be re-enabled to =
begin
> next sampling cycle.
>=20
> In one shot mode, sequencer automatically disables all enabled steps =
at
> the end of each cycle. (both ADC steps and TSC steps) Hence these ste=
ps
> need not be saved in reg_se_cache for clearing these steps at a later
> stage.
>=20
> Signed-off-by: Brad Griffis <bgriffis-l0cyMroinI0@public.gmane.org>
> [vigneshr-l0cyMroinI0@public.gmane.org: Ported patch from v3.12 to v3.18rc2]
> Signed-off-by: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/input/touchscreen/ti_am335x_tsc.c | 56 ++++++++++++---------=
----------
>  drivers/mfd/ti_am335x_tscadc.c            |  7 ++--
>  include/linux/mfd/ti_am335x_tscadc.h      |  4 ++-
>  3 files changed, 30 insertions(+), 37 deletions(-)

[...]

> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_t=
scadc.c
> index d877e777cce6..94ef8992f46b 100644
> --- a/drivers/mfd/ti_am335x_tscadc.c
> +++ b/drivers/mfd/ti_am335x_tscadc.c
> @@ -86,8 +86,12 @@ static void am335x_tscadc_need_adc(struct ti_tscad=
c_dev *tsadc)
>  		spin_lock_irq(&tsadc->reg_lock);
>  		finish_wait(&tsadc->reg_se_wait, &wait);
> =20
> +		/*
> +		 * Sequencer should either be idle or
> +		 * busy applying the charge step.
> +		 */
>  		reg =3D tscadc_readl(tsadc, REG_ADCFSM);
> -		WARN_ON(reg & SEQ_STATUS);
> +		WARN_ON(reg & SEQ_STATUS & (!CHARGE_STEP));
>  		tsadc->adc_waiting =3D false;
>  	}
>  	tsadc->adc_in_use =3D true;
> @@ -96,7 +100,6 @@ static void am335x_tscadc_need_adc(struct ti_tscad=
c_dev *tsadc)
>  void am335x_tsc_se_set_once(struct ti_tscadc_dev *tsadc, u32 val)
>  {
>  	spin_lock_irq(&tsadc->reg_lock);
> -	tsadc->reg_se_cache |=3D val;
>  	am335x_tscadc_need_adc(tsadc);
> =20
>  	tscadc_writel(tsadc, REG_SE, val);

I believe all of these changes can, and therefor should live in a
separate patch.

> diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd=
/ti_am335x_tscadc.h
> index e2e70053470e..fcce182e4a35 100644
> --- a/include/linux/mfd/ti_am335x_tscadc.h
> +++ b/include/linux/mfd/ti_am335x_tscadc.h
> @@ -52,6 +52,7 @@
> =20
>  /* IRQ enable */
>  #define IRQENB_HW_PEN		BIT(0)
> +#define IRQENB_EOS		BIT(1)
>  #define IRQENB_FIFO0THRES	BIT(2)
>  #define IRQENB_FIFO0OVRRUN	BIT(3)
>  #define IRQENB_FIFO0UNDRFLW	BIT(4)
> @@ -107,7 +108,7 @@
>  /* Charge delay */
>  #define CHARGEDLY_OPEN_MASK	(0x3FFFF << 0)
>  #define CHARGEDLY_OPEN(val)	((val) << 0)
> -#define CHARGEDLY_OPENDLY	CHARGEDLY_OPEN(1)
> +#define CHARGEDLY_OPENDLY	CHARGEDLY_OPEN(0xB000)
> =20
>  /* Control register */
>  #define CNTRLREG_TSCSSENB	BIT(0)
> @@ -127,6 +128,7 @@
> =20
>  /* Sequencer Status */
>  #define SEQ_STATUS BIT(5)
> +#define CHARGE_STEP		0x11
> =20
>  #define ADC_CLK			3000000
>  #define TOTAL_STEPS		16

The header changes should be split between the two Input and MFD
patches.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
