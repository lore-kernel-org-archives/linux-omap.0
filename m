From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH] gpio: gpio-omap: take pm_runtime usage while IRQs are
 claimed
Date: Wed, 10 Apr 2019 22:27:02 +0100
Message-ID: <20190410212702.5of6k4q5diudlnqk@shell.armlinux.org.uk>
References: <20190408194506.25821-1-tony@atomide.com>
 <f32435a8-7b1d-30f6-83d5-2d0ccec5c173@ti.com>
 <4915fcdd-fb07-28c4-e530-d2559b8518ad@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <4915fcdd-fb07-28c4-e530-d2559b8518ad@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, Apr 10, 2019 at 09:16:28PM +0300, Grygorii Strashko wrote:
> =

> =

> On 09.04.19 07:36, Keerthy wrote:
> > =

> > =

> > On 09/04/19 1:15 AM, Tony Lindgren wrote:
> >> From: Russell King <rmk+kernel@armlinux.org.uk>
> >>
> >> Commit b764a5863fd8 ("gpio: omap: Remove custom PM calls and use cpu_pm
> >> instead") moved interrupt using GPIO banks to idle with cpu_pm in order
> >> to drop the use of pm_runtime_irq_safe() in a later patch. The GPIO
> >> banks with no interrupts claimed are still being idled based on PM
> >> runtime calls. However this caused a regression for am437x suspend for
> >> rtc+ddr idle mode as reported by Keerthy <j-keerthy@ti.com>. The fix
> >> to this is:
> >>
> >> Bump the pm_runtime usage count while interrupts are in use, rather
> >> than failing the pm_runtime callbacks.=A0 The logic here is a little
> >> non-obvious - the calling order will be:
> >>
> >> =A0=A0 omap_gpio_irq_bus_lock()
> >> (optionally) raw_spin_lock_irqsave(desc->lock)
> >> =A0=A0 omap_gpio_irq_startup()
> >> (optionally) raw_spin_unlock_irqrestore(desc->lock)
> >> =A0=A0 gpio_irq_bus_sync_unlock()
> >>
> >> As the irq_startup method may be called with interrupts disabled, we
> >> must not use pm_runtime_get() here, so as the bus lock takes an initial
> >> pm reference count us, use pm_runtime_get_if_in_use() which will merely
> >> increment the use count.
> > =

> > Tony,
> > =

> > Applied cleanly on linux-next. I had to manually apply this on your for=
-next branch. Tested for AM4 RTC+DDR and DS0 back and forth.
> =

> I'm very sorry, but what was the regression exactly?
> Can't enter RTC+DDR state? some crash?
> =

> =

> > =

> > Regards,
> > Keerthy
> >>
> >> Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
> >> Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> >> Cc: Keerthy <j-keerthy@ti.com>
> >> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> >> Cc: Tero Kristo <t-kristo@ti.com>
> >> Fixes: b764a5863fd8 ("gpio: omap: Remove custom PM calls and use cpu_p=
m instead")
> >> Reported-by: Keerthy <j-keerthy@ti.com>
> >> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> >> [tony@atomide.com: updated patch description for regression fix]
> >> Signed-off-by: Tony Lindgren <tony@atomide.com>
> >> ---
> >>
> >> AFAIK this is only needed with patches heading to v5.2, so this is bas=
ed on
> >> Linux next. We can always backport as needed.
> >>
> >> ---
> >> =A0 drivers/gpio/gpio-omap.c | 23 +++++++----------------
> >> =A0 1 file changed, 7 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> >> --- a/drivers/gpio/gpio-omap.c
> >> +++ b/drivers/gpio/gpio-omap.c
> >> @@ -811,6 +811,9 @@ static unsigned int omap_gpio_irq_startup(struct i=
rq_data *d)
> >> =A0=A0=A0=A0=A0 unsigned long flags;
> >> =A0=A0=A0=A0=A0 unsigned offset =3D d->hwirq;
> >> =A0 +=A0=A0=A0 /* Take a reference on the runtime PM to prevent RPM su=
spends */
> >> +=A0=A0=A0 WARN_ON(pm_runtime_get_if_in_use(bank->chip.parent) =3D=3D =
0);
> >> +
> =

> =

> =

> We have in driver:
>  irqc->parent_device =3D dev;
> =

> which means:
>  request_threaded_irq()
>    irq_chip_pm_get()
> 	if (IS_ENABLED(CONFIG_PM) && data->chip->parent_device) {
> 		retval =3D pm_runtime_get_sync(data->chip->parent_device);
> =

> and power.usage_count will be incremented every time GPIO irq is requeste=
d.
> =

> only in free_irq() (or in case of error) power.usage_count is decremented.
> =

> Now above change will introduce just another incrementation of power.usag=
e_count
> How is it helping?

I really don't remember - too long ago, but I guess there _was_ a reason
for the patch.  It seems that the patch was created with your:

  commit 467480738d0b33335032652b29776d82200db41a
  Author: Grygorii Strashko <grygorii.strashko@ti.com>
  Date:   Fri Sep 28 16:39:50 2018 -0500

change which added the setting of parent_device.

So, in short, I've no idea about the background behind the patch now.

> =

> >> =A0=A0=A0=A0=A0 raw_spin_lock_irqsave(&bank->lock, flags);
> >> =A0 =A0=A0=A0=A0=A0 if (!LINE_USED(bank->mod_usage, offset))
> >> @@ -844,6 +847,8 @@ static void omap_gpio_irq_shutdown(struct irq_data=
 *d)
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0 omap_clear_gpio_debounce(bank, offset);
> >> =A0=A0=A0=A0=A0 omap_disable_gpio_module(bank, offset);
> >> =A0=A0=A0=A0=A0 raw_spin_unlock_irqrestore(&bank->lock, flags);
> >> +
> >> +=A0=A0=A0 pm_runtime_put(bank->chip.parent);
> >> =A0 }
> >> =A0 =A0 static void omap_gpio_irq_bus_lock(struct irq_data *data)
> >> @@ -1719,40 +1724,26 @@ static int __maybe_unused omap_gpio_runtime_su=
spend(struct device *dev)
> >> =A0 {
> >> =A0=A0=A0=A0=A0 struct gpio_bank *bank =3D dev_get_drvdata(dev);
> >> =A0=A0=A0=A0=A0 unsigned long flags;
> >> -=A0=A0=A0 int error =3D 0;
> >> =A0 =A0=A0=A0=A0=A0 raw_spin_lock_irqsave(&bank->lock, flags);
> >> -=A0=A0=A0 /* Must be idled only by CPU_CLUSTER_PM_ENTER? */
> >> -=A0=A0=A0 if (bank->irq_usage) {
> >> -=A0=A0=A0=A0=A0=A0=A0 error =3D -EBUSY;
> >> -=A0=A0=A0=A0=A0=A0=A0 goto unlock;
> >> -=A0=A0=A0 }
> >> =A0=A0=A0=A0=A0 omap_gpio_idle(bank, true);
> >> =A0=A0=A0=A0=A0 bank->is_suspended =3D true;
> >> -unlock:
> >> =A0=A0=A0=A0=A0 raw_spin_unlock_irqrestore(&bank->lock, flags);
> >> =A0 -=A0=A0=A0 return error;
> >> +=A0=A0=A0 return 0;
> >> =A0 }
> >> =A0 =A0 static int __maybe_unused omap_gpio_runtime_resume(struct devi=
ce *dev)
> >> =A0 {
> >> =A0=A0=A0=A0=A0 struct gpio_bank *bank =3D dev_get_drvdata(dev);
> >> =A0=A0=A0=A0=A0 unsigned long flags;
> >> -=A0=A0=A0 int error =3D 0;
> >> =A0 =A0=A0=A0=A0=A0 raw_spin_lock_irqsave(&bank->lock, flags);
> >> -=A0=A0=A0 /* Must be unidled only by CPU_CLUSTER_PM_ENTER? */
> >> -=A0=A0=A0 if (bank->irq_usage) {
> >> -=A0=A0=A0=A0=A0=A0=A0 error =3D -EBUSY;
> >> -=A0=A0=A0=A0=A0=A0=A0 goto unlock;
> >> -=A0=A0=A0 }
> >> =A0=A0=A0=A0=A0 omap_gpio_unidle(bank);
> >> =A0=A0=A0=A0=A0 bank->is_suspended =3D false;
> >> -unlock:
> >> =A0=A0=A0=A0=A0 raw_spin_unlock_irqrestore(&bank->lock, flags);
> >> =A0 -=A0=A0=A0 return error;
> >> +=A0=A0=A0 return 0;
> >> =A0 }
> >> =A0 =A0 static const struct dev_pm_ops gpio_pm_ops =3D {
> >>
> =

> -- =

> Best regards,
> grygorii
> =


-- =

RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps =
up
According to speedtest.net: 11.9Mbps down 500kbps up
