From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Subject: Re: [PATCH] ARM: OMAP: Fix GPIO switch initial output state
	handling
Date: Wed, 11 Mar 2009 11:03:33 +0200
Message-ID: <1236762213.2365.64.camel@jani-desktop>
References: <1236677181-16601-1-git-send-email-ext-jani.1.nikula@nokia.com>
	 <c236f0530903100725jf214fa3m7f4063e727366eb4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:27199 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752346AbZCKJEc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Mar 2009 05:04:32 -0400
In-Reply-To: <c236f0530903100725jf214fa3m7f4063e727366eb4@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kainan Cha <thezha@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, juha.yrjola@solidboot.com

On Tue, 2009-03-10 at 15:25 +0100, ext Kainan Cha wrote:
> Jani,
> 
> Please see my comments below.
> 
> On Tue, Mar 10, 2009 at 4:26 AM, Jani Nikula
> <ext-jani.1.nikula@nokia.com> wrote:
> > The switchover to cross-platform GPIO interface unexpectedly caused all
> > output GPIO switches to be set to high state by default, unlike the
> > original OMAP code. Introduce a new GPIO switch flag to define the
> > initial state. Unless the flag is set, the default is now low state.
> >
> > Also store the state of output switches directly into the switch struct
> > instead of trying to read an output GPIO.
> >
> > Signed-off-by: Jani Nikula <ext-jani.1.nikula@nokia.com>
> > ---
> >  arch/arm/plat-omap/gpio-switch.c              |   13 +++++++++----
> >  arch/arm/plat-omap/include/mach/gpio-switch.h |    1 +
> >  2 files changed, 10 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/arm/plat-omap/gpio-switch.c b/arch/arm/plat-omap/gpio-switch.c
> > index 2b5665d..b278024 100644
> > --- a/arch/arm/plat-omap/gpio-switch.c
> > +++ b/arch/arm/plat-omap/gpio-switch.c
> > @@ -286,12 +286,17 @@ static int __init new_switch(struct gpio_switch *sw)
> >
> >        /* input: 1, output: 0 */
> >        direction = !(sw->flags & OMAP_GPIO_SWITCH_FLAG_OUTPUT);
> > -       if (direction)
> > +       if (direction) {
> >                gpio_direction_input(sw->gpio);
> > -       else
> > -               gpio_direction_output(sw->gpio, true);
> > +               sw->state = gpio_sw_get_state(sw);
> > +       } else {
> > +               int state = sw->state =
> > +                       !!(sw->flags & OMAP_GPIO_SWITCH_FLAG_OUTPUT_INIT_HIGH);
> >
> > -       sw->state = gpio_sw_get_state(sw);
> > +               if (sw->flags & OMAP_GPIO_SWITCH_FLAG_INVERTED)
> > +                       state = !state;
> 
> Using OMAP_GPIO_SWITCH_FLAG_INVERTED along with
> OMAP_GPIO_SWITCH_FLAG_OUTPUT_INIT_HIGH here is somewhat confusing to
> me.
> 
> INIT_HIGH indicates the state of the gpio, not the state of the
> switch. Why not ignore the OMAP_GPIO_SWITCH_FLAG_INVERTED all together
> when setting up the switch. This way, the user does not have to think
> twice. :)

The INVERTED flag can't be ignored, since sw->state must be the opposite
of the GPIO if the flag is set. The only question is, should INIT_HIGH
flag refer to the GPIO or the switch.

I did think about this, and the patch is as I intended it to be, i.e.
INIT_HIGH refers to the switch. I thought this would be less confusing.
If INVERTED is set, it's inverted *everywhere* - why not also when
setting the initial value?

BR,
Jani.

> 
> > +               gpio_direction_output(sw->gpio, state);
> > +       }
> >
> >        r = 0;
> >        r |= device_create_file(&sw->pdev.dev, &dev_attr_state);
> > diff --git a/arch/arm/plat-omap/include/mach/gpio-switch.h b/arch/arm/plat-omap/include/mach/gpio-switch.h
> > index a143253..107d23f 100644
> > --- a/arch/arm/plat-omap/include/mach/gpio-switch.h
> > +++ b/arch/arm/plat-omap/include/mach/gpio-switch.h
> > @@ -29,6 +29,7 @@
> >  #define OMAP_GPIO_SWITCH_TYPE_ACTIVITY         0x0002
> >  #define OMAP_GPIO_SWITCH_FLAG_INVERTED         0x0001
> >  #define OMAP_GPIO_SWITCH_FLAG_OUTPUT           0x0002
> > +#define OMAP_GPIO_SWITCH_FLAG_OUTPUT_INIT_HIGH 0x0004
> >
> >  struct omap_gpio_switch {
> >        const char *name;
> > --
> > 1.6.0.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >

