From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [PATCH 1/1] arm: omap: gpio: define .disable callback for gpio
 irq chip
Date: Fri, 7 Jan 2011 11:56:09 +0200
Message-ID: <20110107095609.GC6137@besouro.research.nokia.com>
References: <1294250283-18182-1-git-send-email-eduardo.valentin@nokia.com>
 <20110105181918.GB8717@n2100.arm.linux.org.uk>
 <20110105192425.GA24729@besouro.research.nokia.com>
 <87aajfvstw.fsf@ti.com>
 <20110106062404.GA14141@besouro.research.nokia.com>
 <878vyxx697.fsf@ti.com>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mgw-da02.ext.nokia.com ([147.243.128.26]:31102 "EHLO
	mgw-da02.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754470Ab1AGKBr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 05:01:47 -0500
Content-Disposition: inline
In-Reply-To: <878vyxx697.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kevin Hilman <khilman@ti.com>
Cc: eduardo.valentin@nokia.com, ext Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Linux-OMAP <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

Hello Kevin,

On Thu, Jan 06, 2011 at 09:59:48AM -0800, ext Kevin Hilman wrote:
> Eduardo Valentin <eduardo.valentin@nokia.com> writes:
> 
> > On Wed, Jan 05, 2011 at 03:22:51PM -0800, ext Kevin Hilman wrote:
> >> Eduardo Valentin <eduardo.valentin@nokia.com> writes:
> >>
> >> > Hello Russell,
> >> >
> >> > On Wed, Jan 05, 2011 at 06:19:18PM +0000, Russell King wrote:
> >> >> On Wed, Jan 05, 2011 at 07:58:03PM +0200, Eduardo Valentin wrote:
> >> >> > Currently, if one calls disable_irq(gpio_irq), the irq
> >> >> > won't get disabled.
> >> >> >
> >> >> > This is happening because the omap gpio code defines only
> >> >> > a .mask callback. And the default_disable function is just
> >> >> > a stub. The result is that, when someone calls disable_irq
> >> >> > for an irq in a gpio line, it will be kept enabled.
> >> >> >
> >> >> > This patch solves this issue by setting the .disable
> >> >> > callback to point to the same .mask callback.
> >> >>
> >> >> Amd this is a problem because?
> >> >
> >> > errr.. because the interrupt is enabled when it was supposed to be disabled?
> >> >
> >>
> >> As Russell pointed out, it's not actually "supposed" to be.
> >>
> >> With lazy disable, what disable_irq() does is prevent the *handler* from
> >> ever being called.  If another interrupt arrives, it will be caught by
> >> the genirq core, marked as IRQ_PENDING and then masked.  This "don't
> >> disable unless we really have to" is the desired behavior of the lazy
> >> disable feature.
> >
> > Right. I'm convinced that the handler won't be called because of the lazy
> > disable mechanism.
> >
> >>
> >> >>
> >> >> The way this works is that although it isn't disabled at that point,
> >> >> if it never triggers, then everything remains happy.  However, if it
> >> >> does trigger, the genirq code will then mask the interrupt and won't
> >> >> call the handler.
> >> >
> >> > Right.. I didn't see from this point. I will check how that gets unmasked.
> >> > But even so, if I understood correctly what you described, it would still
> >> > open a time window which the system would see at least 1 interrupt during
> >> > the time it was not suppose to. And that can wakeup a system which  is in
> >> > deep sleep mode, either via dynamic idle or static suspend.
> >> >
> >> > It is unlikely, I know. But it can still happen. And can be avoided.
> >>
> >> If the GPIO is configured as a wakeup source, then wouldn't you want
> >> activity on that GPIO to wake up the system?
> >
> > Yes I would want it.. of course, if the interrupt is enabled though..
> >
> > I'm still trying to find a valid situation where someone disables an irq
> > but still wants its activity to be a wakeup source. I couldn't find so far..
> >
> >
> >>
> >> If you don't want wakeups on that GPIO, then the driver should probably
> >> be using disable_irq_wake().
> >
> > Yes. Let's take this situation. Let's assume a driver, at its suspend callback,
> > explicitly reports to the system that its irq can be disabled and also should
> > not be seen as a wakeup source, by calling disable_irq(gpio_irq) and
> > disable_irq_wake(gpio_irq).
> >
> > What should be the expected system behavior when the user says echo mem > /sys/power/state?
> >
> > From the point we are done with devices suspend, that gpio will still
> > be marked as an irq, at the bank level. But its corresponding pad will
> > have its wakeup bit disabled. Would that work? I think yes, in most cases.
> >
> > Now let's take the WFI instruction as a divisor for 2 situations:
> >
> > A - common / working case: an interrupt on that gpio still happens after the WFI instruction.
> > Since the system is in sleep mode and the pad for that gpio is not wakeup
> > capable, then nothing would happen and the system won't wakeup. Then, I think
> > everyone is happy here.
> >
> > B - corner case: an interrupt on that gpio happens before the WFI instruction.
> > Since the system is active, the gpio bank can still report this interrupt
> > and will do it. The suspend won't happen due to a irq which has been
> > explicitly marked as disabled and wakeup incapable.
> > Then, would that be the expected behavior? Assuming that the driver
> > has explicitly said to the system, you should not bother about this at all.
> 
> Well, expected behaviour would be that GPIO bank should not be reporting
> the this interrupt at all since it has been disabled.
> 
> However, since you're asking, I assume that you're not seeing this
> expected behavior.

Yeah that's right. But it is rather difficult to reproduce.

> 
> Ignoring wakeups for a second, if this corner case happens on a
> non-wakeup capable GPIO using lazy disable, I would not expect suspend
> to be prevented.  The genirq core would see the IRQ, mark it as
> IRQ_PENDING, mask it and return.  and suspend should continue.

True.

> 
> hmm... however, if the IRQ happens after interrupts are disabled, the
> genirq core won't handle it, and our PM core will see a pending
> interrupt and abort idle/suspend.

True again. And that's what think it is happening.

> 
> Are you seeing this corner case for a wakeup-enable GPIO or a non
> wakeup-enabled GPIO?


It is in wakeup-enable gpio. But the driver removes the wakeup
flag from the gpio on its suspend function right after disabling the irq.
 disable_irq(gpio_irq);
 disable_irq_wake(gpio_irq);

In this case, the device uses gpio 61 as its irq line.

> 
> /me looks at code
> 
> I'm assuming now it's for a wakeup-enabled GPIO.

Right..

> 
> Another more likely possibility is that the IRQ arrives between the time
> the driver does its disable_irq_wake() and when the GPIO driver actually
> suspends.  We currently defer disalbing the bank-level IRQ wakeup
> capabilities until the suspend method of the GPIO driver is run (which
> is very late in the suspend cycle, since it is a sysdev.)  Thinking
> about this some more, I'm not sure exactly why we do this.  The current
> code seems to only manage GPIO wakeups for suspend/resume but not for
> idle, so it defers the actual register writes until the suspend hook.
> Since we presumably also want wakeup-enabled GPIOs to wake up from idle,
> we probably shouldn't be deferring the wakeup enable/disable.

I'm not sure if this is related to wakeup at all. Problem that I see
is that the suspend is aborted due to an interrupt. And that interrupt
has been disabled and marked as non-wakeup in the previous device suspend step.

I've checked that by verifying the gpio bank irqenable1 register and the
pad conf for the gpio in use, right before entering omap_sram_idle in the suspend path.
[   10.360321] GPIO BANK2 - 0x0 0x60200800
[   10.360321] GPIO61 PAD conf 0x11C

The line starting with GPIO BANK2 tells me that GPIO_IRQSTATUS1 is 0x0 at
that point. And GPIO_IRQENABLE1 is 0x60200800. Meaning, channel of GPIO 61
is still enabled at that point. The second line tells me that wakeup bit
for GPIO61 is off. And of course, the suspend fails when we have a match
of IRQSTATUS1 with IRQENABLE1, in this case for GPIO 61, which is my trigger here.
But on this specific printing I didn't see the issue. However, just the
fact that we reach this point with GPIO bank still seeing the IRQ for GPIO 61
enabled is already an indication that something is asking for failure.

So, that's the problematic situation. The gpio is still seen as an interrupt,
although it has been set to be disabled.

The wakeup is not an issue here I'd say. Mainly because the system is still
active, in the process to enter sleep, so no need to wakeup in order to see
that interrupt coming from bank2.

After applying the patch I sent here, I see then the interrupts getting disabled
by the time we are entering the omap_sram_idle.

[   13.671142] GPIO BANK2 - 0x0 0x0
[   13.671142] GPIO61 PAD conf 0x11C

The fact that no interrupts are enabled after this patch points that
not only gpio 61 could be triggering the suspend failure. I still
couldn't reproduce it on dynamic idle, but I can imagine that it
is actually possible to reach this issue also in dyn. idle.

> 
> Here's an expirement.  If you have a use case that is
> preventing a suspend in this corner case, let's try to immediately
> enable/disable wakeups instead of waiting for the suspend/resume hooks.
> 
> Below is a test patch only briefly tested on Zoom3 which has it's
> network interface on a GPIO IRQ.  It does not have wakeups enabled, and
> under ping flood from a host (ping -f), it suspended just fine.  I added
> an enable_irq_wake() the driver and it was still able to suspend during
> ping flood.
> 
> If you suspect the above might be happening in your corner case, can you
> give this a try to see if it changes?


Yes sure. I will try to test that, even though I still think the wakeups are
not the problem. And another issue is that, as you probably have noticed,
it is a very rare situation. Since it's rather difficult to reproduce I might
take some time to give you some feedback here.

> 
> It's also worth noting that we are currently not managing IO pad wakeups
> in the GPIO core.  We are only mananging GPIO module level wakeups,
> which only are in effect if CORE is active.  Now that we have a mux
> framework that can probably handle this, we need a mapping of GPIO lines
> to pads so we can also manage IO pad level wakeups from the GPIO core
> code.  However, if your corner case is arriving before WFI, than I
> suspect CORE is active, and module level wakeups is what you're running into.
> 
> Kevin
> 
> commit 3af8a1051a44462c62c5a5d47a8256626e32fbba
> Author: Kevin Hilman <khilman@ti.com>
> Date:   Thu Jan 6 09:45:24 2011 -0800
> 
>     GPIO: enable/disable wakeups immediately
> 
> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> index ccf2660..1418423 100644
> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c
> @@ -977,34 +977,39 @@ static inline void _set_gpio_irqenable(struct gpio_bank *bank, int gpio, int ena
>  static int _set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
>  {
>         unsigned long uninitialized_var(flags);
> +       void __iomem *wake_status;
> +       void __iomem *wake_clear;
> +       void __iomem *wake_set;
> +
> +       printk("KJH: %s: bank IRQ %d, GPIO %d enable=%d\n", __func__,
> +              bank->irq, gpio, enable);
> 
>         switch (bank->method) {
>  #ifdef CONFIG_ARCH_OMAP16XX
>         case METHOD_MPUIO:
>         case METHOD_GPIO_1610:
> -               spin_lock_irqsave(&bank->lock, flags);
> -               if (enable)
> -                       bank->suspend_wakeup |= (1 << gpio);
> -               else
> -                       bank->suspend_wakeup &= ~(1 << gpio);
> -               spin_unlock_irqrestore(&bank->lock, flags);
> +               wake_status = bank->base + OMAP1610_GPIO_WAKEUPENABLE;
> +               wake_clear = bank->base + OMAP1610_GPIO_CLEAR_WAKEUPENA;
> +               wake_set = bank->base + OMAP1610_GPIO_SET_WAKEUPENA;
>                 return 0;
>  #endif
>  #ifdef CONFIG_ARCH_OMAP2PLUS
>         case METHOD_GPIO_24XX:
> -       case METHOD_GPIO_44XX:
> +               wake_status = bank->base + OMAP24XX_GPIO_WAKE_EN;
> +               wake_clear = bank->base + OMAP24XX_GPIO_CLEARWKUENA;
> +               wake_set = bank->base + OMAP24XX_GPIO_SETWKUENA;
> +
>                 if (bank->non_wakeup_gpios & (1 << gpio)) {
>                         printk(KERN_ERR "Unable to modify wakeup on "
>                                         "non-wakeup GPIO%d\n",
>                                         (bank - gpio_bank) * 32 + gpio);
>                         return -EINVAL;
>                 }
> -               spin_lock_irqsave(&bank->lock, flags);
> -               if (enable)
> -                       bank->suspend_wakeup |= (1 << gpio);
> -               else
> -                       bank->suspend_wakeup &= ~(1 << gpio);
> -               spin_unlock_irqrestore(&bank->lock, flags);
> +               break;
> +       case METHOD_GPIO_44XX:
> +               wake_status = bank->base + OMAP4_GPIO_IRQWAKEN0;
> +               wake_clear = bank->base + OMAP4_GPIO_IRQWAKEN0;
> +               wake_set = bank->base + OMAP4_GPIO_IRQWAKEN0;
>                 return 0;
>  #endif
>         default:
> @@ -1012,6 +1017,16 @@ static int _set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
>                        bank->method);
>                 return -EINVAL;
>         }
> +
> +       spin_lock_irqsave(&bank->lock, flags);
> +       if (enable)
> +               __raw_writel((1 << gpio), wake_set);
> +       else
> +               __raw_writel((1 << gpio), wake_clear);
> +
> +       spin_unlock_irqrestore(&bank->lock, flags);
> +
> +       return 0;
>  }
> 
>  static void _reset_gpio(struct gpio_bank *bank, int gpio)
> @@ -1755,105 +1770,9 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
>  }
> 
>  #if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2PLUS)
> -static int omap_gpio_suspend(struct sys_device *dev, pm_message_t mesg)
> -{
> -       int i;
> -
> -       if (!cpu_class_is_omap2() && !cpu_is_omap16xx())
> -               return 0;
> -
> -       for (i = 0; i < gpio_bank_count; i++) {
> -               struct gpio_bank *bank = &gpio_bank[i];
> -               void __iomem *wake_status;
> -               void __iomem *wake_clear;
> -               void __iomem *wake_set;
> -               unsigned long flags;
> -
> -               switch (bank->method) {
> -#ifdef CONFIG_ARCH_OMAP16XX
> -               case METHOD_GPIO_1610:
> -                       wake_status = bank->base + OMAP1610_GPIO_WAKEUPENABLE;
> -                       wake_clear = bank->base + OMAP1610_GPIO_CLEAR_WAKEUPENA;
> -                       wake_set = bank->base + OMAP1610_GPIO_SET_WAKEUPENA;
> -                       break;
> -#endif
> -#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
> -               case METHOD_GPIO_24XX:
> -                       wake_status = bank->base + OMAP24XX_GPIO_WAKE_EN;
> -                       wake_clear = bank->base + OMAP24XX_GPIO_CLEARWKUENA;
> -                       wake_set = bank->base + OMAP24XX_GPIO_SETWKUENA;
> -                       break;
> -#endif
> -#ifdef CONFIG_ARCH_OMAP4
> -               case METHOD_GPIO_44XX:
> -                       wake_status = bank->base + OMAP4_GPIO_IRQWAKEN0;
> -                       wake_clear = bank->base + OMAP4_GPIO_IRQWAKEN0;
> -                       wake_set = bank->base + OMAP4_GPIO_IRQWAKEN0;
> -                       break;
> -#endif
> -               default:
> -                       continue;
> -               }
> -
> -               spin_lock_irqsave(&bank->lock, flags);
> -               bank->saved_wakeup = __raw_readl(wake_status);
> -               __raw_writel(0xffffffff, wake_clear);
> -               __raw_writel(bank->suspend_wakeup, wake_set);
> -               spin_unlock_irqrestore(&bank->lock, flags);
> -       }
> -
> -       return 0;
> -}
> -
> -static int omap_gpio_resume(struct sys_device *dev)
> -{
> -       int i;
> -
> -       if (!cpu_class_is_omap2() && !cpu_is_omap16xx())
> -               return 0;
> -
> -       for (i = 0; i < gpio_bank_count; i++) {
> -               struct gpio_bank *bank = &gpio_bank[i];
> -               void __iomem *wake_clear;
> -               void __iomem *wake_set;
> -               unsigned long flags;
> -
> -               switch (bank->method) {
> -#ifdef CONFIG_ARCH_OMAP16XX
> -               case METHOD_GPIO_1610:
> -                       wake_clear = bank->base + OMAP1610_GPIO_CLEAR_WAKEUPENA;
> -                       wake_set = bank->base + OMAP1610_GPIO_SET_WAKEUPENA;
> -                       break;
> -#endif
> -#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
> -               case METHOD_GPIO_24XX:
> -                       wake_clear = bank->base + OMAP24XX_GPIO_CLEARWKUENA;
> -                       wake_set = bank->base + OMAP24XX_GPIO_SETWKUENA;
> -                       break;
> -#endif
> -#ifdef CONFIG_ARCH_OMAP4
> -               case METHOD_GPIO_44XX:
> -                       wake_clear = bank->base + OMAP4_GPIO_IRQWAKEN0;
> -                       wake_set = bank->base + OMAP4_GPIO_IRQWAKEN0;
> -                       break;
> -#endif
> -               default:
> -                       continue;
> -               }
> -
> -               spin_lock_irqsave(&bank->lock, flags);
> -               __raw_writel(0xffffffff, wake_clear);
> -               __raw_writel(bank->saved_wakeup, wake_set);
> -               spin_unlock_irqrestore(&bank->lock, flags);
> -       }
> -
> -       return 0;
> -}
> 
>  static struct sysdev_class omap_gpio_sysclass = {
>         .name           = "gpio",
> -       .suspend        = omap_gpio_suspend,
> -       .resume         = omap_gpio_resume,
>  };
> 
>  static struct sys_device omap_gpio_device = {

-- 
Eduardo Valentin
