From: Tony Lindgren <tony@atomide.com>
Subject: Re: [4.2-rc1][PATCH] gpio: omap: add missed spin_unlock_irqrestore
 in omap_gpio_irq_type
Date: Thu, 6 Aug 2015 20:36:42 -0700
Message-ID: <20150807033642.GI4215@atomide.com>
References: <1435157657-17843-1-git-send-email-grygorii.strashko@ti.com>
 <CACRpkdZeBYrff4ZwVyzSKk9Gcy_57WK-3FcfwbzbD8DY06Adng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdZeBYrff4ZwVyzSKk9Gcy_57WK-3FcfwbzbD8DY06Adng@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Alexandre Courbot <gnurou@gmail.com>, Sekhar Nori <nsekhar@ti.com>, Javier Martinez Canillas <javier@dowhile0.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Grygorii Strashko <grygorii.strashko@linaro.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: linux-omap@vger.kernel.org

* Linus Walleij <linus.walleij@linaro.org> [150716 01:38]:
> On Wed, Jun 24, 2015 at 4:54 PM, Grygorii Strashko
> <grygorii.strashko@ti.com> wrote:
>=20
> > From: Grygorii Strashko <grygorii.strashko@linaro.org>
> >
> > Add missed spin_unlock_irqrestore in omap_gpio_irq_type when
> > omap_set_gpio_triggering() is failed.
> >
> > It fixes static checker warning:
> >
> >         drivers/gpio/gpio-omap.c:523 omap_gpio_irq_type()
> >         warn: inconsistent returns 'spin_lock:&bank->lock'.
> >
> > This fixes commit:
> > 1562e4618ded ('gpio: omap: fix error handling in omap_gpio_irq_type=
')
> >
> > Reported-by: Javier Martinez Canillas <javier@dowhile0.org>
> > Signed-off-by: Grygorii Strashko <grygorii.strashko@linaro.org>
>=20
> Patch applied for fixes.

Linus, looks like we now have a new build warning in Linux next
with the fixes and raw_spinlock_t change, so a merge or a commit
is needed. If you prefer a patch, here's one below.

Regards,

Tony

8< ---------------
=46rom: Tony Lindgren <tony@atomide.com>
Date: Thu, 6 Aug 2015 20:32:24 -0700
Subject: [PATCH] gpio: omap: Fix build warning for raw_spinlock_t conve=
rsion
 and unlock fix
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Looks like we now have a new build warning in Linux next with fix
977bd8a94c40 ("gpio: omap: add missed spin_unlock_irqrestore in
omap_gpio_irq_type") and raw_spinlock changes done in commit
4dbada2be460 ("gpio: omap: use raw locks for locking"):

drivers/gpio/gpio-omap.c: In function =E2=80=98omap_gpio_irq_type=E2=80=
=99:
drivers/gpio/gpio-omap.c:504:26: warning: passing argument 1 of
=E2=80=98spin_unlock_irqrestore=E2=80=99 from incompatible pointer type
[-Wincompatible-pointer-types]
   spin_unlock_irqrestore(&bank->lock, flags);
                          ^
In file included from include/linux/seqlock.h:35:0,
                 from include/linux/time.h:5,
                 from include/linux/stat.h:18,
                 from include/linux/module.h:10,
                 from drivers/gpio/gpio-omap.c:16:
include/linux/spinlock.h:370:122: note: expected
=E2=80=98spinlock_t * {aka struct spinlock *}=E2=80=99 but argument is =
of type
=E2=80=98raw_spinlock_t * {aka struct raw_spinlock *}=E2=80=99

=46ix the issue with using raw_spinlock_t instead.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -501,7 +501,7 @@ static int omap_gpio_irq_type(struct irq_data *d, u=
nsigned type)
 	raw_spin_lock_irqsave(&bank->lock, flags);
 	retval =3D omap_set_gpio_triggering(bank, offset, type);
 	if (retval) {
-		spin_unlock_irqrestore(&bank->lock, flags);
+		raw_spin_unlock_irqrestore(&bank->lock, flags);
 		goto error;
 	}
 	omap_gpio_init_irq(bank, offset);
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
