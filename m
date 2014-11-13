From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 3/6] mfd: ti_am335x_tscadc: Remove unwanted
 reg_se_cache save
Date: Thu, 13 Nov 2014 10:25:40 +0000
Message-ID: <20141113102540.GJ24004@x1>
References: <1415694844-11230-1-git-send-email-vigneshr@ti.com>
 <1415694844-11230-4-git-send-email-vigneshr@ti.com>
 <20141111122623.GA24004@x1>
 <71C24A547111EA4E84AE759B748D9EAE4B976C@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <71C24A547111EA4E84AE759B748D9EAE4B976C-yXqyApvAXouIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "R, Vignesh" <vigneshr-l0cyMroinI0@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, "richardcochran-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <richardcochran-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, "Griffis, Brad" <bgriffis-l0cyMroinI0@public.gmane.org>, Sanjeev Sharma <sanjeev_sharma-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>, Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>, Jan Kardell <jan.kardell-KSZdJiTw9mzQT0dZR+AlfA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, 11 Nov 2014, R, Vignesh wrote:
> On Tue, 11 Nov 2014, Vignesh R wrote:
> > In one shot mode, sequencer automatically disables all enabled step=
s=20
> > at the end of each cycle. (both ADC steps and TSC steps) Hence thes=
e=20
> > steps need not be saved in reg_se_cache for clearing these steps at=
 a=20
> > later stage.
> > Also, when ADC wakes up Sequencer should not be busy executing any =
of=20
> > the config steps except for the charge step. Previously charge step=
=20
> > was 1 ADC clock cycle and hence it was ignored.
> >=20
> > Signed-off-by: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
> > ---

[...]

> > -	tsadc->reg_se_cache |=3D val;
>=20
> You didn't answer my question about this?
> I did reply to the question in the previous thread. =20
>=20
> Previously, TSC did not reliably re-enable its steps as the TSC irq h=
andler received=20
> false pen up events. Hence, in order to use TSC after ADC operation, =
it was necessary to
>  save and re-enable TSC steps (basically, to keep TSC steps enabled a=
lways).
> The change was more of a workaround to overcome limitation of TSC irq=
 handler. With=20
> this series of patches, TSC irq handler is very reliable and the work=
around is no longer required.

Okay, thanks for the explanation.

By the way, your mailer doesn't appear to quote previous messages.  Is
there any way to fix that?

> >  	am335x_tscadc_need_adc(tsadc);
> > =20
> >  	tscadc_writel(tsadc, REG_SE, val);
> > diff --git a/include/linux/mfd/ti_am335x_tscadc.h=20
> > b/include/linux/mfd/ti_am335x_tscadc.h
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
