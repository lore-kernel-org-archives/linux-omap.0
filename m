From: Tim Niemeyer <tim.niemeyer@corscience.de>
Subject: Re: [PATCH] gpio: omap-gpio: add support for pm_runtime autosuspend
Date: Fri, 26 Oct 2012 12:42:35 +0200
Message-ID: <1351248155.2182.26.camel@herbert.er.corscience.de>
References: <1351238130-7158-1-git-send-email-tim.niemeyer@corscience.de>
	 <20121026080342.GA23501@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:59058 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755501Ab2JZKmH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Oct 2012 06:42:07 -0400
In-Reply-To: <20121026080342.GA23501@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Linux OMAP List <linux-omap@vger.kernel.org>

Am Freitag, den 26.10.2012, 11:03 +0300 schrieb Felipe Balbi:
> Hi,
>=20
> On Fri, Oct 26, 2012 at 09:55:30AM +0200, Tim Niemeyer wrote:
> > Adds support for configuring the omap-gpio driver use autosuspend f=
or
> > runtime power management. This can reduce the latency in using it b=
y
> > not suspending the device immediately on idle. If another access ta=
kes
> > place before the autosuspend timeout (2 secs), the call to resume t=
he
> > device can return immediately saving some save/ restore cycles.
> >=20
> > I use a gpio to monitor a spi transfer which occurs every 250=C2=B5=
s. The
> > suspend overhead is to high, so almost every second transfer is los=
t.
> > This patch fixes that.
> >=20
> > Signed-off-by: Tim Niemeyer <tim.niemeyer@corscience.de>
> > ---
> >  drivers/gpio/gpio-omap.c |   23 ++++++++++++++++++-----
> >  1 files changed, 18 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> > index 94cbc84..92f48cb 100644
> > --- a/drivers/gpio/gpio-omap.c
> > +++ b/drivers/gpio/gpio-omap.c
> > @@ -31,6 +31,7 @@
> >  #include <asm/mach/irq.h>
> > =20
> >  #define OFF_MODE	1
> > +#define GPIO_AUTOSUSPEND_TIMEOUT                2000
> > =20
> >  static LIST_HEAD(omap_gpio_list);
> > =20
> > @@ -628,8 +629,10 @@ static void omap_gpio_free(struct gpio_chip *c=
hip, unsigned offset)
> >  	 * If this is the last gpio to be freed in the bank,
> >  	 * disable the bank module.
> >  	 */
> > -	if (!bank->mod_usage)
> > -		pm_runtime_put(bank->dev);
> > +	if (!bank->mod_usage) {
>=20
> while at that I would drop this bank->mod_usage nonsense and let
> power core handle reference counting.
I looked at it, but i'm unsure about the GPIO_MOD_CTRL_BIT. The
bank->mod_usage counter prevents omap_gpio_free() to disable the hole
bank while another gpio is still in use.

> > +		pm_runtime_mark_last_busy(bank->dev);
> > +		pm_runtime_put_autosuspend(bank->dev);
> > +	}
> >  }
> > =20
> >  /*
> > @@ -715,7 +718,8 @@ static void gpio_irq_handler(unsigned int irq, =
struct irq_desc *desc)
> >  exit:
> >  	if (!unmasked)
> >  		chained_irq_exit(chip, desc);
> > -	pm_runtime_put(bank->dev);
> > +	pm_runtime_mark_last_busy(bank->dev);
> > +	pm_runtime_put_autosuspend(bank->dev);
> >  }
> > =20
> >  static void gpio_irq_shutdown(struct irq_data *d)
> > @@ -1132,6 +1136,8 @@ static int __devinit omap_gpio_probe(struct p=
latform_device *pdev)
> > =20
> >  	platform_set_drvdata(pdev, bank);
> > =20
> > +	pm_runtime_use_autosuspend(bank->dev);
> > +	pm_runtime_set_autosuspend_delay(bank->dev, GPIO_AUTOSUSPEND_TIME=
OUT);
> >  	pm_runtime_enable(bank->dev);
> >  	pm_runtime_irq_safe(bank->dev);
> >  	pm_runtime_get_sync(bank->dev);
> > @@ -1146,7 +1152,8 @@ static int __devinit omap_gpio_probe(struct p=
latform_device *pdev)
> >  	if (bank->loses_context)
> >  		bank->get_context_loss_count =3D pdata->get_context_loss_count;
> > =20
> > -	pm_runtime_put(bank->dev);
> > +	pm_runtime_mark_last_busy(bank->dev);
> > +	pm_runtime_put_autosuspend(bank->dev);
> > =20
> >  	list_add_tail(&bank->node, &omap_gpio_list);
> > =20
> > @@ -1333,7 +1340,13 @@ void omap2_gpio_prepare_for_idle(int pwr_mod=
e)
> > =20
> >  		bank->power_mode =3D pwr_mode;
> > =20
> > -		pm_runtime_put_sync_suspend(bank->dev);
> > +		/* direct pm_runtime on pwroff */
> > +		if (pwr_mode)
>=20
> you also need braces here.
Yes. I resend this later.

> > +			pm_runtime_put_sync_suspend(bank->dev);
> > +		else {
> > +			pm_runtime_mark_last_busy(bank->dev);
> > +			pm_runtime_put_sync_autosuspend(bank->dev);
> > +		}
> >  	}
> >  }
> > =20
> > --=20
> > 1.7.2.5
> >=20
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-oma=
p" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Tim Niemeyer

Corscience GmbH & Co. KG
Henkestr. 91
D-91052 Erlangen
Germany

e-mail: tim.niemeyer@corscience.de
Internet: www.corscience.de

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
