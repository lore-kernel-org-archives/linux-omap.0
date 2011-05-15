From: mike@compulab.co.il
Subject: Re: [RESEND PATCH 2/4] omap: igep0020: minor refactoring
Date: Sun, 15 May 2011 21:50:43 +0300
Message-ID: <20110515185043.GA24785@gentoodev.compulab.local>
References: <cover.1305235542.git.mike@compulab.co.il>
 <91dd03e6af514a628fc4d797066f3ef0d971b802.1305235542.git.mike@compulab.co.il>
 <201105132044.39163.arnd@arndb.de>
Reply-To: mike@compulab.co.il
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:54793
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750863Ab1EOSuw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 15 May 2011 14:50:52 -0400
Content-Disposition: inline
In-Reply-To: <201105132044.39163.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Tony.Lindgren.tony@atomide.com, Enric Balletb??? i Serra <eballetbo@gmail.com>, linux-omap@vger.kernel.org

On Fri, May 13, 2011 at 08:44:38PM +0200, Arnd Bergmann wrote:
> On Thursday 12 May 2011, Mike Rapoport wrote:
> > @@ -299,17 +299,14 @@ static struct omap2_hsmmc_info mmc[] = {
> >  static struct gpio_led igep_gpio_leds[] = {
> >         [0] = {
> >                 .name                   = "gpio-led:red:d0",
> > -               .gpio                   = IGEP2_GPIO_LED0_RED,
> >                 .default_trigger        = "default-off"
> >         },
> >         [1] = {
> >                 .name                   = "gpio-led:green:d0",
> > -               .gpio                   = IGEP2_GPIO_LED0_GREEN,
> >                 .default_trigger        = "default-off",
> >         },
> >         [2] = {
> >                 .name                   = "gpio-led:red:d1",
> > -               .gpio                   = IGEP2_GPIO_LED1_RED,
> >                 .default_trigger        = "default-off",
> >         },
> >         [3] = {
> > @@ -335,6 +332,10 @@ static struct platform_device igep_led_device = {
> >  
> >  static void __init igep_leds_init(void)
> >  {
> > +       igep_gpio_leds[0].gpio = IGEP2_GPIO_LED0_RED;
> > +       igep_gpio_leds[1].gpio = IGEP2_GPIO_LED0_GREEN;
> > +       igep_gpio_leds[2].gpio = IGEP2_GPIO_LED1_RED;
> > +
> >         platform_device_register(&igep_led_device);
> >  }
> 
> Hi Mike,
> 
> Overall, the series looks great, but I'm somewhat worried by the fact that you
> have to replace data structures with code in order to get there. Are there any
> other options to do this?
 
We can keep all the data structures that differ between IGEP2 and IGEP3.
However, this significantly reduces the benifit of the series.
There's already code in the IGEP2 that differentiates between HW
revisions, so anyway the board support will require some work for
devicetree transition. Eventually, when devicetree will be usable on
OMAPs, most of the code currently found in arch/arm/mach-omap2/board*
will require some work and I hardly believe that the transition can be
automated...

> 	Arnd
> 
--
Sincerely yours,
Mike.

