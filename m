From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] gpio: omap-gpio: add support for pm_runtime autosuspend
Date: Mon, 29 Oct 2012 10:05:23 +0200
Message-ID: <20121029080523.GC13657@arwen.pp.htv.fi>
References: <20121026114250.GA26342@arwen.pp.htv.fi>
 <1351257553-7896-1-git-send-email-tim.niemeyer@corscience.de>
 <508E266C.6090901@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dkEUBIird37B8yKS"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51103 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757633Ab2J2ILQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Oct 2012 04:11:16 -0400
Content-Disposition: inline
In-Reply-To: <508E266C.6090901@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Tim Niemeyer <tim.niemeyer@corscience.de>, Jon Hunter <jon-hunter@ti.com>, Linux OMAP List <linux-omap@vger.kernel.org>, balbi@ti.com

--dkEUBIird37B8yKS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 29, 2012 at 12:17:08PM +0530, Santosh Shilimkar wrote:
> + Jon,
>=20
> On Friday 26 October 2012 06:49 PM, Tim Niemeyer wrote:
> >Adds support for configuring the omap-gpio driver use autosuspend for
> >runtime power management. This can reduce the latency in using it by
> >not suspending the device immediately on idle. If another access takes
> >place before the autosuspend timeout (2 secs), the call to resume the
> >device can return immediately saving some save/ restore cycles.
> >
> >This removes also the bank->mod_usage counter, because this is already
> >handled in pm_runtime.
> >
> >I use a gpio to monitor a spi transfer which occurs every 250=B5s. The
> >suspend overhead is to high, so almost every second transfer is lost.
> >This patch fixes that.
> >
> >Signed-off-by: Tim Niemeyer <tim.niemeyer@corscience.de>
> >---
> >  drivers/gpio/gpio-omap.c |   81 ++++++++++++++++++++++++--------------=
-------
> >  1 files changed, 43 insertions(+), 38 deletions(-)
> >
> From patch it appears your main motive is to delay the idle kicking in
> with a timeout to avoid GPIO on cpuidle path. Some comments
>=20
> >diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> >index 94cbc84..708d5a9 100644
> >--- a/drivers/gpio/gpio-omap.c
> >+++ b/drivers/gpio/gpio-omap.c
> >@@ -31,6 +31,7 @@
> >  #include <asm/mach/irq.h>
> >
> >  #define OFF_MODE	1
> >+#define GPIO_AUTOSUSPEND_TIMEOUT                2000
> >
> >  static LIST_HEAD(omap_gpio_list);
> >
> >@@ -64,7 +65,6 @@ struct gpio_bank {
> >  	spinlock_t lock;
> >  	struct gpio_chip chip;
> >  	struct clk *dbck;
> >-	u32 mod_usage;
> How have you tested 'mod_suage' change ?
>=20
> >  	u32 dbck_enable_mask;
> >  	bool dbck_enabled;
> >  	struct device *dev;
> >@@ -557,10 +557,9 @@ static int omap_gpio_request(struct gpio_chip *chip=
, unsigned offset)
> >
> >  	/*
> >  	 * If this is the first gpio_request for the bank,
> >-	 * enable the bank module.
> >+	 * resume the bank module.
> Since you removing bank notion, "If this is the first gpio_request
> for the bank," becomes irrelevant from code perspective.
>=20
> [..]
>=20
> >@@ -608,28 +594,15 @@ static void omap_gpio_free(struct gpio_chip *chip,=
 unsigned offset)
> >  			__raw_readl(bank->base + bank->regs->wkup_en);
> >  	}
> >
> >-	bank->mod_usage &=3D ~(1 << offset);
> >-
> >-	if (bank->regs->ctrl && !bank->mod_usage) {
> >-		void __iomem *reg =3D bank->base + bank->regs->ctrl;
> >-		u32 ctrl;
> >-
> >-		ctrl =3D __raw_readl(reg);
> >-		/* Module is disabled, clocks are gated */
> >-		ctrl |=3D GPIO_MOD_CTRL_BIT;
> >-		__raw_writel(ctrl, reg);
> >-		bank->context.ctrl =3D ctrl;
> >-	}
> >-
> >  	_reset_gpio(bank, bank->chip.base + offset);
> >  	spin_unlock_irqrestore(&bank->lock, flags);
> >
> >  	/*
> >  	 * If this is the last gpio to be freed in the bank,
> >-	 * disable the bank module.
> >+	 * put the bank module into suspend.
> >  	 */
> >-	if (!bank->mod_usage)
> >-		pm_runtime_put(bank->dev);
> >+	pm_runtime_mark_last_busy(bank->dev);
> >+	pm_runtime_put_autosuspend(bank->dev);
> Waiting for 2 seconds timeout even on GPIO free
> seems to be wrong.
>=20
> >  }
> >
> >  /*
> >@@ -715,7 +688,8 @@ static void gpio_irq_handler(unsigned int irq, struc=
t irq_desc *desc)
> >  exit:
> >  	if (!unmasked)
> >  		chained_irq_exit(chip, desc);
> >-	pm_runtime_put(bank->dev);
> >+	pm_runtime_mark_last_busy(bank->dev);
> >+	pm_runtime_put_autosuspend(bank->dev);
> This is what is the main change from this patch which helps your
> case.
> >  }
> >
> >  static void gpio_irq_shutdown(struct irq_data *d)
> >@@ -1132,6 +1106,8 @@ static int __devinit omap_gpio_probe(struct platfo=
rm_device *pdev)
> >
> >  	platform_set_drvdata(pdev, bank);
> >
> >+	pm_runtime_use_autosuspend(bank->dev);
> >+	pm_runtime_set_autosuspend_delay(bank->dev, GPIO_AUTOSUSPEND_TIMEOUT);
>=20
> Can you please report how have you tested this change ? What other PM
> tests you have done?
>=20
> Removing mod usage might just break this driver because now individual
> banks which can idle before, can no longer idle.

why's that ?

> Just to expand a bit, Out of 6 GPIO banks, GPIO1 bank is in always ON
> domain where as remaing 5 are in peripheral domain. Letting individual
> banks idle allowed you let the clock domain idle than keeping all the
> 6 banks and hence respective clock/power domain in ON state.
>=20
> So the adding timeout might be reasonable but I am not sure about
> the mod_usage change here.

IMHO that whole mod_usage is broken. I remember sending a big series of
patches getting rid of that long ago. I _did_ break a few things but
just because of omap_gpio_prepare_for_idle() /
omap_gpio_resume_from_idle() hackery to get GPIO suspended early enough.

I still think mod_usage needs to go, so does
omap_gpio_prepare_for_idle() and omap_gpio_resume_from_idle(). To me, it
looks like that needs to be done on ->prepare()/->complete() callbacks
of system suspend and the gpio driver needs to learn proper runtime
suspend.

The way it is today (get() on gpio_request() and put() on gpio_free())
is just wrong and non-optimal.

cheers

--=20
balbi

--dkEUBIird37B8yKS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQjjjDAAoJEIaOsuA1yqREJ3QP/3H+D1jNUDsPDvDU00ydSL3T
3/oldBSrnA2JeZtpXGRjvPOqYC59dWum6rVqa2tXzEWH+Jhdl3V3GmX6LNiVmQl2
+CccUdT+YqAh58HyQHPL/VErPAzhD1kW9IkTvWr87IigV/5cvRW1d96tmc1fZoba
CnLwqNwKBWE10D49wP4ybIOVl7wStmMHwcgPIojPWS2QUm1Uo4hKWYGMbKweC/Ql
xKcP3WazeKVYk/CmRhy5/CRnE9dJzvbnrBxxLfdMbWzyP3IA4Nhq9pNFnbApWANj
UOemDDuy2SxR5GuxBU5DWdMLuAVelWX5XASvvQSRJbaLzPqsLUrF9CYjiI8iZxFg
KP5yDDjFkG+6Rq51jX+n0DhnUjdWtZwKVkSvkw6r0fBwb/aSx/aZDSCZ0SdtyjBw
oKypKevW0fBKHkqIqMsmz9S9rL1VfdIQXWW30k9rKYS3FBIP9fP8p0OeCZ7ucYZt
uGk6U5AB3Z10BfWDB/7RqYtnQWrVG4+szRSbzEIRUwFRxVo5JzWLoOSc14ripZMI
5AndkZXkUe8ehhT24aKsKMl2K+HUFIwHUASw92HHEwqOFwVkiQ7jyvPCpcvqPILj
0S49VRrpMr8mM3FmqtpJ6lrhGIpDSfPaK17t8xkApCMoytW+IJC2m++3hWbl+azk
wYHjy91Tm3G7WWTT3j5D
=Ff9k
-----END PGP SIGNATURE-----

--dkEUBIird37B8yKS--
