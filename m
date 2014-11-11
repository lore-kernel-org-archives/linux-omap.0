From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 3/6] mfd: ti_am335x_tscadc: Remove unwanted
 reg_se_cache save
Date: Tue, 11 Nov 2014 12:26:24 +0000
Message-ID: <20141111122623.GA24004@x1>
References: <1415694844-11230-1-git-send-email-vigneshr@ti.com>
 <1415694844-11230-4-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1415694844-11230-4-git-send-email-vigneshr@ti.com>
Sender: linux-input-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, richardcochran@gmail.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>, Samuel Ortiz <sameo@linux.intel.com>, Felipe Balbi <balbi@ti.com>, Brad Griffis <bgriffis@ti.com>, Sanjeev Sharma <sanjeev_sharma@mentor.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Jan Kardell <jan.kardell@telliq.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, 11 Nov 2014, Vignesh R wrote:

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
>=20
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---

You need to provide a changelog here when submitting new versions.

>  drivers/mfd/ti_am335x_tscadc.c       | 7 +++++--
>  include/linux/mfd/ti_am335x_tscadc.h | 1 +
>  2 files changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_t=
scadc.c
> index d877e777cce6..110038859a8d 100644
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
> +		WARN_ON((reg & SEQ_STATUS) && !(reg & CHARGE_STEP));
>  		tsadc->adc_waiting =3D false;
>  	}
>  	tsadc->adc_in_use =3D true;
> @@ -96,7 +100,6 @@ static void am335x_tscadc_need_adc(struct ti_tscad=
c_dev *tsadc)
>  void am335x_tsc_se_set_once(struct ti_tscadc_dev *tsadc, u32 val)
>  {
>  	spin_lock_irq(&tsadc->reg_lock);
> -	tsadc->reg_se_cache |=3D val;

You didn't answer my question about this?

>  	am335x_tscadc_need_adc(tsadc);
> =20
>  	tscadc_writel(tsadc, REG_SE, val);
> diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd=
/ti_am335x_tscadc.h
> index c99be5dc0f5c..fcce182e4a35 100644
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
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
