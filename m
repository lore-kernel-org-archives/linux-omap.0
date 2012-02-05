From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH v9 01/25] gpio/omap: remove dependency on gpio_bank_count
Date: Sun, 5 Feb 2012 12:37:55 +0530
Message-ID: <CA+HSevqvHAgA+PPLm8BH5vfWkc8yY8W+fRpqjT2urq2EWtSYiA@mail.gmail.com>
References: <1328203851-20435-2-git-send-email-tarun.kanti@ti.com>
 <20120202184106.GC29215@legolas.emea.dhcp.ti.com> <20120202191630.GT15343@ponder.secretlab.ca>
 <20120202194545.GA29351@legolas.emea.dhcp.ti.com> <4F2AF68D.1000505@ti.com>
 <20120202214907.GA22888@legolas.emea.dhcp.ti.com> <20120202215350.GB22888@legolas.emea.dhcp.ti.com>
 <4F2B078B.1040709@ti.com> <20120202220744.GA23092@legolas.emea.dhcp.ti.com>
 <87liojajs4.fsf@ti.com> <20120204160802.GA10818@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120204160802.GA10818@legolas.emea.dhcp.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: Kevin Hilman <khilman@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

=46elipe,

On Sat, Feb 4, 2012 at 21:38, Felipe Balbi <balbi@ti.com> wrote:
>
> Hi,
>
> On Fri, Feb 03, 2012 at 09:50:19AM -0800, Kevin Hilman wrote:
> > Felipe Balbi <balbi@ti.com> writes:
> >
> > [...]
> >
> > >> >This question remains. Why do we need those funtions ?
> > >>
> > >> These functions are called from the CPUIdle path so outside the =
scope
> > >> of the GPIO driver. These are part of a bunch of nasty PM hacks =
we
> > >> are doing in the CPU idle loop. We are in the process of getting=
 rid
> > >> of most of them, but it looks like some are still needed.
> > >
> > > Too bad. I can see that the gpio pm implementation seems a bit
> > > "peculiar". I mean, pm does reference counting and yet the driver=
 has
> > > checks to prevent multiple gets and puts on a single bank (meanin=
g that
> > > pm counter will be either 0 or 1 at any point in time).
> > >
> > > To me it looks like those functions are there in order to forcefu=
lly put
> > > PER power domain in OFF because drivers are always holding a refe=
rence
> > > to their gpios (drivers generally gpio_request() on probe() and
> > > gpio_free() on remove()).
> > >
> > > Looks like the entire pm implementation on OMAP gpio driver has a=
lways
> > > considered only the fact that gpios can be requested and freed, b=
ut
> > > never that we want the system to go to OFF even while gpios are
> > > requested, because we have I/O PAD wakeups. At some point that ha=
s to be
> > > sorted out because that HACK is quite ugly :-)
> > >
> > > I'll see if I find some time to go over the interactions between
> > > gpio-omap.c and pm24x.c and pm34xx.c any of these days, but I can=
't
> > > promise anything ;-)
> >
> > If you look at the state of these prepare/resume hacks at the end o=
f
> > this series, you'll see that they are significantly cleaner and do
> > nothing but call the runtime PM hooks.
>
> sure, definitely.
>
> > We have explored several ways to get rid of them completely in the =
idle
> > path but have not yet come up with a clean way, but this series get=
s us
> > a long ways towards that goal.
>
> have you thought about being a bit more aggressive at when to
> runtime_get and runtime_put ?
>
> I didn't test below (will do probably on monday), but I think this wi=
ll
> help keeping GPIO block always suspended, and only wake it up when tr=
uly
> needed. That way, you could, at some point, remove that list_head
> because by the time you reach CPUIdle path, GPIO module is already
> suspended. That's the theory at least, gotta run it first on silicon =
to
> be sure
>
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 4273401..2dd9ced 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -537,12 +537,7 @@ static int omap_gpio_request(struct gpio_chip *c=
hip, unsigned offset)
> =A0 =A0 =A0 =A0struct gpio_bank *bank =3D container_of(chip, struct g=
pio_bank, chip);
> =A0 =A0 =A0 =A0unsigned long flags;
>
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* If this is the first gpio_request for the bank,
> - =A0 =A0 =A0 =A0* enable the bank module.
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 if (!bank->mod_usage)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_get_sync(bank->dev);
> + =A0 =A0 =A0 pm_runtime_get_sync(bank->dev);

bank->mod_usage check is used to take care of doing pm_runtime_get*/put=
* only
if all the GPIOs in a particular bank are enabled or disabled respectiv=
ely.

With the above change, pm_runtime_put*/get* would be called for every
gpio_request()
/_free() (that is, for upto 32 pins in OMAP3/4) in a bank irrespective
of whether other
GPIO pins are enabled or disabled in the same bank. Hence it is
required to have a
check based on mod_usage.

I agree with your approach of aggressively doing pm_runtime* calls and =
this
was discussed internally sometime ago.

-V Charulatha

>
> =A0 =A0 =A0 =A0spin_lock_irqsave(&bank->lock, flags);
> =A0 =A0 =A0 =A0/* Set trigger to none. You need to enable the desired=
 trigger with
> @@ -572,6 +567,8 @@ static int omap_gpio_request(struct gpio_chip *ch=
ip, unsigned offset)
>
> =A0 =A0 =A0 =A0spin_unlock_irqrestore(&bank->lock, flags);
>
> + =A0 =A0 =A0 pm_runtime_put(bank->dev);
> +
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> @@ -581,6 +578,8 @@ static void omap_gpio_free(struct gpio_chip *chip=
, unsigned offset)
> =A0 =A0 =A0 =A0void __iomem *base =3D bank->base;
> =A0 =A0 =A0 =A0unsigned long flags;
>
> + =A0 =A0 =A0 pm_runtime_get_sync(bank->dev);
> +
> =A0 =A0 =A0 =A0spin_lock_irqsave(&bank->lock, flags);
>
> =A0 =A0 =A0 =A0if (bank->regs->wkup_en) {
> @@ -606,12 +605,7 @@ static void omap_gpio_free(struct gpio_chip *chi=
p, unsigned offset)
> =A0 =A0 =A0 =A0_reset_gpio(bank, bank->chip.base + offset);
> =A0 =A0 =A0 =A0spin_unlock_irqrestore(&bank->lock, flags);
>
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* If this is the last gpio to be freed in the bank,
> - =A0 =A0 =A0 =A0* disable the bank module.
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 if (!bank->mod_usage)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put(bank->dev);
> + =A0 =A0 =A0 pm_runtime_put(bank->dev);
> =A0}
>
> =A0/*
> @@ -707,9 +701,11 @@ static void gpio_irq_shutdown(struct irq_data *d=
)
> =A0 =A0 =A0 =A0struct gpio_bank *bank =3D irq_data_get_irq_chip_data(=
d);
> =A0 =A0 =A0 =A0unsigned long flags;
>
> + =A0 =A0 =A0 pm_runtime_get_sync(bank->dev);
> =A0 =A0 =A0 =A0spin_lock_irqsave(&bank->lock, flags);
> =A0 =A0 =A0 =A0_reset_gpio(bank, gpio);
> =A0 =A0 =A0 =A0spin_unlock_irqrestore(&bank->lock, flags);
> + =A0 =A0 =A0 pm_runtime_put(bank->dev);
> =A0}
>
> =A0static void gpio_ack_irq(struct irq_data *d)
> @@ -717,7 +713,9 @@ static void gpio_ack_irq(struct irq_data *d)
> =A0 =A0 =A0 =A0unsigned int gpio =3D d->irq - IH_GPIO_BASE;
> =A0 =A0 =A0 =A0struct gpio_bank *bank =3D irq_data_get_irq_chip_data(=
d);
>
> + =A0 =A0 =A0 pm_runtime_get_sync(bank->dev);
> =A0 =A0 =A0 =A0_clear_gpio_irqstatus(bank, gpio);
> + =A0 =A0 =A0 pm_runtime_put(bank->dev);
> =A0}
>
> =A0static void gpio_mask_irq(struct irq_data *d)
> @@ -726,10 +724,12 @@ static void gpio_mask_irq(struct irq_data *d)
> =A0 =A0 =A0 =A0struct gpio_bank *bank =3D irq_data_get_irq_chip_data(=
d);
> =A0 =A0 =A0 =A0unsigned long flags;
>
> + =A0 =A0 =A0 pm_runtime_get_sync(bank->dev);
> =A0 =A0 =A0 =A0spin_lock_irqsave(&bank->lock, flags);
> =A0 =A0 =A0 =A0_set_gpio_irqenable(bank, gpio, 0);
> =A0 =A0 =A0 =A0_set_gpio_triggering(bank, GPIO_INDEX(bank, gpio), IRQ=
_TYPE_NONE);
> =A0 =A0 =A0 =A0spin_unlock_irqrestore(&bank->lock, flags);
> + =A0 =A0 =A0 pm_runtime_put(bank->dev);
> =A0}
>
> =A0static void gpio_unmask_irq(struct irq_data *d)
> @@ -740,6 +740,7 @@ static void gpio_unmask_irq(struct irq_data *d)
> =A0 =A0 =A0 =A0u32 trigger =3D irqd_get_trigger_type(d);
> =A0 =A0 =A0 =A0unsigned long flags;
>
> + =A0 =A0 =A0 pm_runtime_get_sync(bank->dev);
> =A0 =A0 =A0 =A0spin_lock_irqsave(&bank->lock, flags);
> =A0 =A0 =A0 =A0if (trigger)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0_set_gpio_triggering(bank, GPIO_INDEX(=
bank, gpio), trigger);
> @@ -753,6 +754,7 @@ static void gpio_unmask_irq(struct irq_data *d)
>
> =A0 =A0 =A0 =A0_set_gpio_irqenable(bank, gpio, 1);
> =A0 =A0 =A0 =A0spin_unlock_irqrestore(&bank->lock, flags);
> + =A0 =A0 =A0 pm_runtime_put(bank->dev);
> =A0}
>
> =A0static struct irq_chip gpio_irq_chip =3D {
> @@ -836,17 +838,26 @@ static int gpio_input(struct gpio_chip *chip, u=
nsigned offset)
> =A0 =A0 =A0 =A0unsigned long flags;
>
> =A0 =A0 =A0 =A0bank =3D container_of(chip, struct gpio_bank, chip);
> + =A0 =A0 =A0 pm_runtime_get_sync(bank->dev);
> +
> =A0 =A0 =A0 =A0spin_lock_irqsave(&bank->lock, flags);
> =A0 =A0 =A0 =A0_set_gpio_direction(bank, offset, 1);
> =A0 =A0 =A0 =A0spin_unlock_irqrestore(&bank->lock, flags);
> + =A0 =A0 =A0 pm_runtime_put(bank->dev);
> +
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> =A0static int gpio_is_input(struct gpio_bank *bank, int mask)
> =A0{
> =A0 =A0 =A0 =A0void __iomem *reg =3D bank->base + bank->regs->directi=
on;
> + =A0 =A0 =A0 u32 val;
>
> - =A0 =A0 =A0 return __raw_readl(reg) & mask;
> + =A0 =A0 =A0 pm_runtime_get_sync(bank->dev);
> + =A0 =A0 =A0 val =3D __raw_readl(reg) & mask;
> + =A0 =A0 =A0 pm_runtime_put(bank->dev);
> +
> + =A0 =A0 =A0 return val;
> =A0}
>
> =A0static int gpio_get(struct gpio_chip *chip, unsigned offset)
> @@ -856,15 +867,20 @@ static int gpio_get(struct gpio_chip *chip, uns=
igned offset)
> =A0 =A0 =A0 =A0int gpio;
> =A0 =A0 =A0 =A0u32 mask;
>
> + =A0 =A0 =A0 int val;
> =A0 =A0 =A0 =A0gpio =3D chip->base + offset;
> =A0 =A0 =A0 =A0bank =3D container_of(chip, struct gpio_bank, chip);
> =A0 =A0 =A0 =A0reg =3D bank->base;
> =A0 =A0 =A0 =A0mask =3D GPIO_BIT(bank, gpio);
>
> + =A0 =A0 =A0 pm_runtime_get_sync(bank->dev);
> =A0 =A0 =A0 =A0if (gpio_is_input(bank, mask))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return _get_gpio_datain(bank, gpio);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D _get_gpio_datain(bank, gpio);
> =A0 =A0 =A0 =A0else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return _get_gpio_dataout(bank, gpio);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D _get_gpio_dataout(bank, gpio);
> + =A0 =A0 =A0 pm_runtime_put(bank->dev);
> +
> + =A0 =A0 =A0 return val;
> =A0}
>
> =A0static int gpio_output(struct gpio_chip *chip, unsigned offset, in=
t value)
> @@ -873,10 +889,14 @@ static int gpio_output(struct gpio_chip *chip, =
unsigned offset, int value)
> =A0 =A0 =A0 =A0unsigned long flags;
>
> =A0 =A0 =A0 =A0bank =3D container_of(chip, struct gpio_bank, chip);
> +
> + =A0 =A0 =A0 pm_runtime_get_sync(bank->dev);
> =A0 =A0 =A0 =A0spin_lock_irqsave(&bank->lock, flags);
> =A0 =A0 =A0 =A0bank->set_dataout(bank, offset, value);
> =A0 =A0 =A0 =A0_set_gpio_direction(bank, offset, 0);
> =A0 =A0 =A0 =A0spin_unlock_irqrestore(&bank->lock, flags);
> + =A0 =A0 =A0 pm_runtime_put(bank->dev);
> +
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> @@ -894,9 +914,11 @@ static int gpio_debounce(struct gpio_chip *chip,=
 unsigned offset,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(bank->dev, "Co=
uld not get gpio dbck\n");
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 pm_runtime_get_sync(bank->dev);
> =A0 =A0 =A0 =A0spin_lock_irqsave(&bank->lock, flags);
> =A0 =A0 =A0 =A0_set_gpio_debounce(bank, offset, debounce);
> =A0 =A0 =A0 =A0spin_unlock_irqrestore(&bank->lock, flags);
> + =A0 =A0 =A0 pm_runtime_put(bank->dev);
>
> =A0 =A0 =A0 =A0return 0;
> =A0}
> @@ -907,9 +929,12 @@ static void gpio_set(struct gpio_chip *chip, uns=
igned offset, int value)
> =A0 =A0 =A0 =A0unsigned long flags;
>
> =A0 =A0 =A0 =A0bank =3D container_of(chip, struct gpio_bank, chip);
> +
> + =A0 =A0 =A0 pm_runtime_get_sync(bank->dev);
> =A0 =A0 =A0 =A0spin_lock_irqsave(&bank->lock, flags);
> =A0 =A0 =A0 =A0bank->set_dataout(bank, offset, value);
> =A0 =A0 =A0 =A0spin_unlock_irqrestore(&bank->lock, flags);
> + =A0 =A0 =A0 pm_runtime_put(bank->dev);
> =A0}
>
> =A0static int gpio_2irq(struct gpio_chip *chip, unsigned offset)
> @@ -1330,7 +1355,8 @@ void omap2_gpio_prepare_for_idle(int pwr_mode)
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bank->power_mode =3D pwr_mode;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put_sync_suspend(bank->dev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!pm_runtime_suspended(bank->dev))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_suspend(bank=
->dev);
> =A0 =A0 =A0 =A0}
> =A0}
>
> @@ -1342,7 +1368,8 @@ void omap2_gpio_resume_after_idle(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!bank->mod_usage || !bank->loses_c=
ontext)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_get_sync(bank->dev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pm_runtime_suspended(bank->dev))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_resume(bank-=
>dev);
> =A0 =A0 =A0 =A0}
> =A0}
>
>
> --
> balbi
