From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 3/6] mfd: ti_am335x_tscadc: Remove unwanted
 reg_se_cache save
Date: Tue, 20 Jan 2015 11:53:25 +0000
Message-ID: <20150120115325.GK13701@x1>
References: <1420609779-11156-1-git-send-email-vigneshr@ti.com>
 <1420609779-11156-4-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1420609779-11156-4-git-send-email-vigneshr-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Cc: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Brad Griffis <bgriffis-l0cyMroinI0@public.gmane.org>, Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>, Sanjeev Sharma <sanjeev_sharma-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>, Jan Kardell <jan.kardell-KSZdJiTw9mzQT0dZR+AlfA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap@vger.
List-Id: linux-omap@vger.kernel.org

On Wed, 07 Jan 2015, Vignesh R wrote:

> In one shot mode, sequencer automatically disables all enabled steps =
at
> the end of each cycle. (both ADC steps and TSC steps) Hence these ste=
ps
> need not be saved in reg_se_cache for clearing these steps at a later
> stage.
> Also, when ADC wakes up Sequencer should not be busy executing any of=
 the
> config steps except for the charge step. Previously charge step was 1=
 ADC
> clock cycle and hence it was ignored.
> TSC steps are always disabled at the end of each conversion cycle, he=
nce
> there is no need to explicitly disable TSC steps by writing 0 to REG_=
SE.
>=20
> Signed-off-by: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
> ---
>=20
> v5:
>  - Remove unnecessary clearing of REG_SE
>=20
>  drivers/mfd/ti_am335x_tscadc.c       | 13 +++++--------
>  include/linux/mfd/ti_am335x_tscadc.h |  1 +
>  2 files changed, 6 insertions(+), 8 deletions(-)

Looks fine.

=46or my own reference:
  Acked-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Can this patch be applied on its own?

> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_t=
scadc.c
> index 467c80e1c4ae..e4e4b22eebc9 100644
> --- a/drivers/mfd/ti_am335x_tscadc.c
> +++ b/drivers/mfd/ti_am335x_tscadc.c
> @@ -68,12 +68,6 @@ static void am335x_tscadc_need_adc(struct ti_tscad=
c_dev *tsadc)
>  	DEFINE_WAIT(wait);
>  	u32 reg;
> =20
> -	/*
> -	 * disable TSC steps so it does not run while the ADC is using it. =
If
> -	 * write 0 while it is running (it just started or was already runn=
ing)
> -	 * then it completes all steps that were enabled and stops then.
> -	 */
> -	tscadc_writel(tsadc, REG_SE, 0);
>  	reg =3D tscadc_readl(tsadc, REG_ADCFSM);
>  	if (reg & SEQ_STATUS) {
>  		tsadc->adc_waiting =3D true;
> @@ -86,8 +80,12 @@ static void am335x_tscadc_need_adc(struct ti_tscad=
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
> +		WARN_ON((reg & SEQ_STATUS) && !(reg & CHARGE_STEP));
>  		tsadc->adc_waiting =3D false;
>  	}
>  	tsadc->adc_in_use =3D true;
> @@ -96,7 +94,6 @@ static void am335x_tscadc_need_adc(struct ti_tscadc=
_dev *tsadc)
>  void am335x_tsc_se_set_once(struct ti_tscadc_dev *tsadc, u32 val)
>  {
>  	spin_lock_irq(&tsadc->reg_lock);
> -	tsadc->reg_se_cache |=3D val;
>  	am335x_tscadc_need_adc(tsadc);
> =20
>  	tscadc_writel(tsadc, REG_SE, val);
> diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd=
/ti_am335x_tscadc.h
> index 3f4e994ace2b..1fd50dcfe47c 100644
> --- a/include/linux/mfd/ti_am335x_tscadc.h
> +++ b/include/linux/mfd/ti_am335x_tscadc.h
> @@ -128,6 +128,7 @@
> =20
>  /* Sequencer Status */
>  #define SEQ_STATUS BIT(5)
> +#define CHARGE_STEP		0x11
> =20
>  #define ADC_CLK			3000000
>  #define TOTAL_STEPS		16

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
