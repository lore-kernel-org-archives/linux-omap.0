From: "andrzej zaborowski" <balrogg@gmail.com>
Subject: Re: [PATCH] ARM: OMAP: Fix building with CONFIG_OMAP_GPIO_SWITCH
	off.
Date: Sun, 27 May 2007 14:57:35 +0200
Message-ID: <fb249edb0705270557r5e6b912en994e04d35830aae@mail.gmail.com>
References: <fb249edb0705221025s4447c7e1s2119e5a62ebb2198@mail.gmail.com>
	<20070525003430.GE19506@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070525003430.GE19506@atomide.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP ML <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

On 25/05/07, Tony Lindgren <tony@atomide.com> wrote:
> * andrzej zaborowski <balrogg@gmail.com> [070522 10:26]:
> > Define omap_register_gpio_switches when CONFIG_OMAP_GPIO_SWITCH is
> > off. This will prevent adding a CONFIG_OMAP_GPIO_SWITCH check in the
> > board files and enable building board-palmte.c with gpio-switch off.
> > Also add __initdata to the two variables in gpio-switch that are used only
> > during init.
> >
> > Signed-off-by: Andrzej Zaborowski <balrog@zabor.org>
>
> > @@ -48,7 +49,12 @@ struct omap_gpio_switch {
> >  };
> >
> >  /* Call at init time only */
> > -extern void omap_register_gpio_switches(const struct omap_gpio_switch *tbl,
> > -                                     int count);
> > +#ifdef CONFIG_OMAP_GPIO_SWITCH
> > +extern void omap_register_gpio_switches(
> > +             const struct omap_gpio_switch *tbl, int count);
> > +#else
> > +static inline void omap_register_gpio_switches(
> > +             const struct omap_gpio_switch *tbl, int count) {}
> > +#endif
> >
> >  #endif
> > --
> > 1.4.4.3
> >
>
> Can you please put the extern functions into a header file?
> We got some comments on that on LKML few weeks ago.

Sorry, not sure which functions/header you mean?

Andrzej
