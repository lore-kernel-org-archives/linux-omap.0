From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v6 3/6] mfd: ti_am335x_tscadc: Remove unwanted
 reg_se_cache save
Date: Tue, 20 Jan 2015 16:04:10 +0000
Message-ID: <20150120160410.GL13701@x1>
References: <1420609779-11156-1-git-send-email-vigneshr@ti.com>
 <1420609779-11156-4-git-send-email-vigneshr@ti.com>
 <20150120115325.GK13701@x1>
 <54BE4CD1.1020709@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54BE4CD1.1020709@ti.com>
Sender: linux-input-owner@vger.kernel.org
To: "R, Vignesh" <vigneshr@ti.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>, Samuel Ortiz <sameo@linux.intel.com>, Brad Griffis <bgriffis@ti.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Sanjeev Sharma <sanjeev_sharma@mentor.com>, Jan Kardell <jan.kardell@telliq.com>, Felipe Balbi <balbi@ti.com>, Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.
List-Id: linux-omap@vger.kernel.org

On Tue, 20 Jan 2015, R, Vignesh wrote:
> On 1/20/2015 5:23 PM, Lee Jones wrote:
> > On Wed, 07 Jan 2015, Vignesh R wrote:
> >=20
> >> In one shot mode, sequencer automatically disables all enabled ste=
ps at
> >> the end of each cycle. (both ADC steps and TSC steps) Hence these =
steps
> >> need not be saved in reg_se_cache for clearing these steps at a la=
ter
> >> stage.
> >> Also, when ADC wakes up Sequencer should not be busy executing any=
 of the
> >> config steps except for the charge step. Previously charge step wa=
s 1 ADC
> >> clock cycle and hence it was ignored.
> >> TSC steps are always disabled at the end of each conversion cycle,=
 hence
> >> there is no need to explicitly disable TSC steps by writing 0 to R=
EG_SE.
> >>
> >> Signed-off-by: Vignesh R <vigneshr@ti.com>
> >> ---
> >>
> >> v5:
> >>  - Remove unnecessary clearing of REG_SE
> >>
> >>  drivers/mfd/ti_am335x_tscadc.c       | 13 +++++--------
> >>  include/linux/mfd/ti_am335x_tscadc.h |  1 +
> >>  2 files changed, 6 insertions(+), 8 deletions(-)
> >=20
> > Looks fine.
> >=20
> > For my own reference:
> >   Acked-by: Lee Jones <lee.jones@linaro.org>
> >=20
> > Can this patch be applied on its own?
> >=20
>=20
> I prefer to wait until input patches are picked up.

I have no problem with that, but is there a technical reason why?

> >> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335=
x_tscadc.c
> >> index 467c80e1c4ae..e4e4b22eebc9 100644
> >> --- a/drivers/mfd/ti_am335x_tscadc.c
> >> +++ b/drivers/mfd/ti_am335x_tscadc.c
> >> @@ -68,12 +68,6 @@ static void am335x_tscadc_need_adc(struct ti_ts=
cadc_dev *tsadc)
> >>  	DEFINE_WAIT(wait);
> >>  	u32 reg;
> >> =20
> >> -	/*
> >> -	 * disable TSC steps so it does not run while the ADC is using i=
t. If
> >> -	 * write 0 while it is running (it just started or was already r=
unning)
> >> -	 * then it completes all steps that were enabled and stops then.
> >> -	 */
> >> -	tscadc_writel(tsadc, REG_SE, 0);
> >>  	reg =3D tscadc_readl(tsadc, REG_ADCFSM);
> >>  	if (reg & SEQ_STATUS) {
> >>  		tsadc->adc_waiting =3D true;
> >> @@ -86,8 +80,12 @@ static void am335x_tscadc_need_adc(struct ti_ts=
cadc_dev *tsadc)
> >>  		spin_lock_irq(&tsadc->reg_lock);
> >>  		finish_wait(&tsadc->reg_se_wait, &wait);
> >> =20
> >> +		/*
> >> +		 * Sequencer should either be idle or
> >> +		 * busy applying the charge step.
> >> +		 */
> >>  		reg =3D tscadc_readl(tsadc, REG_ADCFSM);
> >> -		WARN_ON(reg & SEQ_STATUS);
> >> +		WARN_ON((reg & SEQ_STATUS) && !(reg & CHARGE_STEP));
> >>  		tsadc->adc_waiting =3D false;
> >>  	}
> >>  	tsadc->adc_in_use =3D true;
> >> @@ -96,7 +94,6 @@ static void am335x_tscadc_need_adc(struct ti_tsc=
adc_dev *tsadc)
> >>  void am335x_tsc_se_set_once(struct ti_tscadc_dev *tsadc, u32 val)
> >>  {
> >>  	spin_lock_irq(&tsadc->reg_lock);
> >> -	tsadc->reg_se_cache |=3D val;
> >>  	am335x_tscadc_need_adc(tsadc);
> >> =20
> >>  	tscadc_writel(tsadc, REG_SE, val);
> >> diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/=
mfd/ti_am335x_tscadc.h
> >> index 3f4e994ace2b..1fd50dcfe47c 100644
> >> --- a/include/linux/mfd/ti_am335x_tscadc.h
> >> +++ b/include/linux/mfd/ti_am335x_tscadc.h
> >> @@ -128,6 +128,7 @@
> >> =20
> >>  /* Sequencer Status */
> >>  #define SEQ_STATUS BIT(5)
> >> +#define CHARGE_STEP		0x11
> >> =20
> >>  #define ADC_CLK			3000000
> >>  #define TOTAL_STEPS		16
> >=20

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
