From: Tim Niemeyer <tim.niemeyer@corscience.de>
Subject: Re: [PATCH] gpio: omap-gpio: add support for pm_runtime autosuspend
Date: Mon, 29 Oct 2012 09:43:49 +0100
Message-ID: <1351500229.2194.61.camel@herbert.er.corscience.de>
References: <20121026114250.GA26342@arwen.pp.htv.fi>
	 <1351257553-7896-1-git-send-email-tim.niemeyer@corscience.de>
	 <508E266C.6090901@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:54059 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756787Ab2J2InQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Oct 2012 04:43:16 -0400
In-Reply-To: <508E266C.6090901@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Jon Hunter <jon-hunter@ti.com>, Linux OMAP List <linux-omap@vger.kernel.org>, balbi@ti.com

Am Montag, den 29.10.2012, 12:17 +0530 schrieb Santosh Shilimkar:
> + Jon,
>=20
> On Friday 26 October 2012 06:49 PM, Tim Niemeyer wrote:
> > Adds support for configuring the omap-gpio driver use autosuspend f=
or
> > runtime power management. This can reduce the latency in using it b=
y
> > not suspending the device immediately on idle. If another access ta=
kes
> > place before the autosuspend timeout (2 secs), the call to resume t=
he
> > device can return immediately saving some save/ restore cycles.
> >
> > This removes also the bank->mod_usage counter, because this is alre=
ady
> > handled in pm_runtime.
> >
> > I use a gpio to monitor a spi transfer which occurs every 250=C2=B5=
s. The
> > suspend overhead is to high, so almost every second transfer is los=
t.
> > This patch fixes that.
> >
> > Signed-off-by: Tim Niemeyer <tim.niemeyer@corscience.de>
> > ---
> >   drivers/gpio/gpio-omap.c |   81 ++++++++++++++++++++++++---------=
------------
> >   1 files changed, 43 insertions(+), 38 deletions(-)
> >
>  From patch it appears your main motive is to delay the idle kicking =
in
> with a timeout to avoid GPIO on cpuidle path. Some comments
cpuidle? I set 'CPU_IDLE=3Dn' in my .config..

> > diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> > index 94cbc84..708d5a9 100644
> > --- a/drivers/gpio/gpio-omap.c
> > +++ b/drivers/gpio/gpio-omap.c
> > @@ -31,6 +31,7 @@
> >   #include <asm/mach/irq.h>
> >
> >   #define OFF_MODE	1
> > +#define GPIO_AUTOSUSPEND_TIMEOUT                2000
> >
> >   static LIST_HEAD(omap_gpio_list);
> >
> > @@ -64,7 +65,6 @@ struct gpio_bank {
> >   	spinlock_t lock;
> >   	struct gpio_chip chip;
> >   	struct clk *dbck;
> > -	u32 mod_usage;
> How have you tested 'mod_suage' change ?
Nothing special, just applied the patch to a 3.4.14 kernel and used one
gpio to show the status of my spi communication.

> >   	u32 dbck_enable_mask;
> >   	bool dbck_enabled;
> >   	struct device *dev;
> > @@ -557,10 +557,9 @@ static int omap_gpio_request(struct gpio_chip =
*chip, unsigned offset)
> >
> >   	/*
> >   	 * If this is the first gpio_request for the bank,
> > -	 * enable the bank module.
> > +	 * resume the bank module.
> Since you removing bank notion, "If this is the first gpio_request
> for the bank," becomes irrelevant from code perspective.
Hu, i thought pm_runtime_get_sync(bank->dev) handles the use counting
per bank?

> > @@ -608,28 +594,15 @@ static void omap_gpio_free(struct gpio_chip *=
chip, unsigned offset)
> >   			__raw_readl(bank->base + bank->regs->wkup_en);
> >   	}
> >
> > -	bank->mod_usage &=3D ~(1 << offset);
> > -
> > -	if (bank->regs->ctrl && !bank->mod_usage) {
> > -		void __iomem *reg =3D bank->base + bank->regs->ctrl;
> > -		u32 ctrl;
> > -
> > -		ctrl =3D __raw_readl(reg);
> > -		/* Module is disabled, clocks are gated */
> > -		ctrl |=3D GPIO_MOD_CTRL_BIT;
> > -		__raw_writel(ctrl, reg);
> > -		bank->context.ctrl =3D ctrl;
> > -	}
> > -
> >   	_reset_gpio(bank, bank->chip.base + offset);
> >   	spin_unlock_irqrestore(&bank->lock, flags);
> >
> >   	/*
> >   	 * If this is the last gpio to be freed in the bank,
> > -	 * disable the bank module.
> > +	 * put the bank module into suspend.
> >   	 */
> > -	if (!bank->mod_usage)
> > -		pm_runtime_put(bank->dev);
> > +	pm_runtime_mark_last_busy(bank->dev);
> > +	pm_runtime_put_autosuspend(bank->dev);
> Waiting for 2 seconds timeout even on GPIO free
> seems to be wrong.
Yes, you are right, if something frees the gpio it should suspend
immediately.=20

> >   }
> >
> >   /*
> > @@ -715,7 +688,8 @@ static void gpio_irq_handler(unsigned int irq, =
struct irq_desc *desc)
> >   exit:
> >   	if (!unmasked)
> >   		chained_irq_exit(chip, desc);
> > -	pm_runtime_put(bank->dev);
> > +	pm_runtime_mark_last_busy(bank->dev);
> > +	pm_runtime_put_autosuspend(bank->dev);
> This is what is the main change from this patch which helps your
> case.
> >   }
> >
> >   static void gpio_irq_shutdown(struct irq_data *d)
> > @@ -1132,6 +1106,8 @@ static int __devinit omap_gpio_probe(struct p=
latform_device *pdev)
> >
> >   	platform_set_drvdata(pdev, bank);
> >
> > +	pm_runtime_use_autosuspend(bank->dev);
> > +	pm_runtime_set_autosuspend_delay(bank->dev, GPIO_AUTOSUSPEND_TIME=
OUT);
>=20
> Can you please report how have you tested this change ? What other PM
> tests you have done?
My main goal isn't to have a good power-saving, i need a small latency.
The runtime-pm disturbed that. I tested to disable CONFIG_PM_RUNTIME,
but than the gptimer couldn't be initialized.

My scenario: gptimer triggers every 250=C2=B5s and starts an async_spi
transfer while it sets one gpio line to high. The spi_complete then put=
s
this gpio to low again.
Every second interrupt was lost and i wanted to know why so i removed
the spi stuff and just turned a gpio on and off in the timer-isr. It
turned out that the system wasn't able to tick with 4kHz. I then
disabled the CONFIG_PM_RUNTIME and fiddled the gptimer to start without
runtime-pm. Then i was able to use gpio with up to 100kHz. I enabled
CONFIG_PM_RUNTIME again and disabled the gpio runtime_pm via sysfs (ech=
o
on > /sys/...) which got me same results.

I have to admit, i didn't completely understand all of this.. :( It's
even possible that my testresult is only a nice side effect of this
patch.

> Removing mod usage might just break this driver because now individua=
l
> banks which can idle before, can no longer idle.
>=20
> Just to expand a bit, Out of 6 GPIO banks, GPIO1 bank is in always ON
> domain where as remaing 5 are in peripheral domain. Letting individua=
l
> banks idle allowed you let the clock domain idle than keeping all the
> 6 banks and hence respective clock/power domain in ON state.
I first had also some problems with the mod_usage change, but after
asking Felipe again, i thought i understood it. Maybe Felipe can clear
this up as this was his idea?

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
