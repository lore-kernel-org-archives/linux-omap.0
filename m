From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/5] mfd: ti_am335x_tscadc: Remove unwanted reg_se_cache
 save
Date: Mon, 10 Nov 2014 09:26:45 +0000
Message-ID: <20141110092645.GE21424@x1>
References: <1415339350-17679-1-git-send-email-vigneshr@ti.com>
 <1415339350-17679-4-git-send-email-vigneshr@ti.com>
 <20141110091527.GD21424@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141110091527.GD21424@x1>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Brad Griffis <bgriffis-l0cyMroinI0@public.gmane.org>, Sanjeev Sharma <sanjeev_sharma-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>, Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>, Jan Kardell <jan.kardell-KSZdJiTw9mzQT0dZR+AlfA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel@lists.i
List-Id: linux-omap@vger.kernel.org

On Mon, 10 Nov 2014, Lee Jones wrote:

> On Fri, 07 Nov 2014, Vignesh R wrote:
>=20
> > In one shot mode, sequencer automatically disables all enabled step=
s at
> > the end of each cycle. (both ADC steps and TSC steps) Hence these s=
teps
> > need not be saved in reg_se_cache for clearing these steps at a lat=
er
> > stage.
> > Also, when ADC wakes up Sequencer should not be busy executing any =
of the
> > config steps except for the charge step. Previously charge step was=
 1 ADC
> > clock cycle and hence it was ignored.
> >=20
> > Signed-off-by: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
> > ---
> >  drivers/mfd/ti_am335x_tscadc.c       | 7 +++++--
> >  include/linux/mfd/ti_am335x_tscadc.h | 1 +
> >  2 files changed, 6 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x=
_tscadc.c
> > index d877e777cce6..94ef8992f46b 100644
> > --- a/drivers/mfd/ti_am335x_tscadc.c
> > +++ b/drivers/mfd/ti_am335x_tscadc.c
> > @@ -86,8 +86,12 @@ static void am335x_tscadc_need_adc(struct ti_tsc=
adc_dev *tsadc)
> >  		spin_lock_irq(&tsadc->reg_lock);
> >  		finish_wait(&tsadc->reg_se_wait, &wait);
> > =20
> > +		/*
> > +		 * Sequencer should either be idle or
> > +		 * busy applying the charge step.
> > +		 */
> >  		reg =3D tscadc_readl(tsadc, REG_ADCFSM);
> > -		WARN_ON(reg & SEQ_STATUS);
> > +		WARN_ON(reg & SEQ_STATUS & (!CHARGE_STEP));
>=20
> This is almost certainly not correct.
>=20
> Please take another look at the logic.
>=20
> I'm _assuming_ you mean (reg & SEQ_STATUS && !CHARGE_STEP).

So I just saw that CHARGE_STEP is actually the new macro below.

So you're currently ANDing these together.

xxxxxxxx xxxxxxxx xxxxxxxx xxxxxxxx  reg
00000000 00000000 00000000 00100000  #define SEQ_STATUS   BIT(5)
00000000 00000000 00000000 00010001  #define CHARGE_STEP  0x11

=2E.. which will always equate to 0.

> >  		tsadc->adc_waiting =3D false;
> >  	}
> >  	tsadc->adc_in_use =3D true;
> > @@ -96,7 +100,6 @@ static void am335x_tscadc_need_adc(struct ti_tsc=
adc_dev *tsadc)
> >  void am335x_tsc_se_set_once(struct ti_tscadc_dev *tsadc, u32 val)
> >  {
> >  	spin_lock_irq(&tsadc->reg_lock);
> > -	tsadc->reg_se_cache |=3D val;

Didn't you add this line a little over 1 month ago?

Why the change of heart?

> >  	am335x_tscadc_need_adc(tsadc);
> > =20
> >  	tscadc_writel(tsadc, REG_SE, val);
> > diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/m=
fd/ti_am335x_tscadc.h
> > index c99be5dc0f5c..fcce182e4a35 100644
> > --- a/include/linux/mfd/ti_am335x_tscadc.h
> > +++ b/include/linux/mfd/ti_am335x_tscadc.h
> > @@ -128,6 +128,7 @@
> > =20
> >  /* Sequencer Status */
> >  #define SEQ_STATUS BIT(5)
> > +#define CHARGE_STEP		0x11
> > =20
> >  #define ADC_CLK			3000000
> >  #define TOTAL_STEPS		16
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
