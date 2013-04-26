From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/3] ARM: dts: Add muxing for wl12xx on the SDIO bus
 for pandaboard
Date: Fri, 26 Apr 2013 08:58:44 -0700
Message-ID: <20130426155844.GC29360@atomide.com>
References: <20130426034858.26065.65118.stgit@muffinssi.local>
 <20130426035213.26065.63243.stgit@muffinssi.local>
 <1366982603.4029.42.camel@cumari.coelho.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61508 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756964Ab3DZP6u (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Apr 2013 11:58:50 -0400
Content-Disposition: inline
In-Reply-To: <1366982603.4029.42.camel@cumari.coelho.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Luciano Coelho <coelho@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>

* Luciano Coelho <coelho@ti.com> [130426 06:29]:
> On Thu, 2013-04-25 at 20:52 -0700, Tony Lindgren wrote:
> > This is needed to get wl12xx working with device tree based
> > booting.
> > 
> > Note that we claim the various GPIO inputs in the regulator
> > as the proper muxing is needed to enable and disable the
> > regulator.
> > 
> > Also, we want to use non-removable instead of ti,non-removable
> > as the ti,non-removable also sets no_regulator_off_init which
> > is really not what we want as then wl12xx won't get powered
> > up and down which is needed for resetting it.
> > 
> > Cc: Luciano Coelho <coelho@ti.com>
> > Cc: Benoit Cousson <b-cousson@ti.com>
> > Cc: Rajendra Nayak <rnayak@ti.com>
> > Cc: devicetree-discuss@lists.ozlabs.org
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> 
> I tried this now and it seems to work fine too.  So:
> 
> Tested-by: Luciano Coelho <coelho@ti.com>
> 
> Except that with linux-next I'm getting some problems with the
> interrupts when trying to use wl12xx.  It's not related to this patch
> though, and I'm investigating it right now.

One thing I was worried is the early use of gpio_to_irq()
that's probably not safe always. We could fix that by moving the
gpio_to_irq() call to the driver if that's a problem.

But if the gpio_to_irq() is not the issue, can you please just
add a minimal binding to the wl12xx code so we can get rid of the
pdata init for the DT booting?

We can pass the clock reference the same way as we've discussed
already regarding the USB transceiver patch. Or you might be able
to find it out in the driver probe just by doing clk_get() and
clk_get_rate() on the source clock.

And the GPIO is just a standard resource that already has a
binding.
 
> Also, I found one small whitespace problem in this patch:
> 
> [...]
> > +	/* wl12xx GPIO inputs and SDIO pins */
> > +	wl12xx_pins: pinmux_wl12xx_pins {
> > +		pinctrl-single,pins = <
> > +			0x38 0x103	/* gpmc_ncs2.gpio_52 INPUT | MODE3 */
> > +			0x3a 0x103	/* gpmc_ncs3.gpio_53 INPUT | MODE3 */
> > +			0x108 0x118	/* sdmmc5_clk.sdmmc5_clk INPUT_PULLUP | MODE0 */
> > +			0x10a 0x118	/* sdmmc5_cmd.sdmmc5_cmd INPUT_PULLUP | MODE0 */
> > +			0x10c 0x118	/* sdmmc5_dat0.sdmmc5_dat0 INPUT_PULLUP | MODE0 */
> > +			0x10e 0x118	/* sdmmc5_dat1.sdmmc5_dat1 INPUT_PULLUP | MODE0 */
> > +			0x110 0x118	/* sdmmc5_dat2.sdmmc5_dat2 INPUT_PULLUP | MODE0 */
> > +			0x112 0x118	/* sdmmc5_dat3.sdmmc5_dat3 INPUT_PULLUP | MODE0 */
> > +      		>;
> 
> git am reports a "space before tab in indent" here.

OK thanks, will fix.

Regards,

Tony
