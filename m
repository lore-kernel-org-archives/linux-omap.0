From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree
 support
Date: Fri, 16 May 2014 08:59:57 -0700
Message-ID: <20140516155957.GC22031@atomide.com>
References: <20140507150343.GA9502@atomide.com>
 <536A5920.1020908@ti.com>
 <20140507175919.GH9502@atomide.com>
 <20140508233300.GI2198@atomide.com>
 <536C924E.5000307@ti.com>
 <20140509153008.GC17814@atomide.com>
 <20140513212639.GA18001@atomide.com>
 <53747DD5.2030406@ti.com>
 <20140515182548.GD23659@atomide.com>
 <5375A713.7030409@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:40844 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757361AbaEPQAF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 May 2014 12:00:05 -0400
Content-Disposition: inline
In-Reply-To: <5375A713.7030409@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [140515 22:51]:
> On 15/05/14 21:25, Tony Lindgren wrote:
> > * Tomi Valkeinen <tomi.valkeinen@ti.com> [140515 01:42]:
> >> On 14/05/14 00:26, Tony Lindgren wrote:
> >>
> >>> +	/* lcd MO */
> >>> +	ddata->mo_gpio = sharp_ls_get_gpio_of(&pdev->dev, 0, 1, "mode");
> >>> +	if (PTR_ERR(ddata->mo_gpio) == -EPROBE_DEFER)
> >>> +		return -EPROBE_DEFER;
> >>> +
> >>> +	if (!IS_ERR(ddata->mo_gpio))
> >>> +		if (gpiod_get_raw_value_cansleep(ddata->mo_gpio))
> >>> +			ddata->flags |= SHARP_LS_QVGA;
> >>
> >> Shouldn't there be an explicit flag in the DT data for this? If the
> >> panel's MO pin is hardwired to, say, pull up, then the mode-gpios won't
> >> have MO gpio, right? So something like:
> >>
> >>
> >> mode-gpios = <0					/* high, lcd MO */
> >> 	      &gpio1 2 GPIO_ACTIVE_HIGH		/* gpio2, lcd LR */
> >> 	      &gpio1 3 GPIO_ACTIVE_HIGH>;	/* gpio3, lcd UD */
> >>
> >> vga-mode;	/* MO hardwired high */
> >  
> > Yeah holes there are just fine. I figured let's keep the custom
> > vga-mode property out of the way until we actually run into a panel
> > that's not using a GPIO for mode.
> 
> Ok, I'm fine with that, but in that case I think we have to use all the
> panels in the same mode, i.e. the driver either sets the MO gpio always
> low and uses VGA mode, or sets the MO always high and uses QVGA mode.

OK let's default to VGA mode for now.
 
> In your omap3-evm.dts patch, you set the MO gpio ACTIVE_LOW in order to
> change the mode, even if it really should be ACTIVE_HIGH. But if you do
> that, and we later add the support to the panel driver to manage the MO
> gpio dynamically (i.e. the user can select VGA/QVGA at runtime), then
> the panel won't work as the driver uses wrong polarity for the pin.

Getting the configured value seemed to work just fine with
gpiod_get_raw_value_cansleep(ddata->mo_gpio). But yeah I agree the
lack and confusion between polarity and desired default value for
a GPIO is is sucky. The ACTIVE_HIGH probably should mean polarity. 

I don't know if there's an easy solution to that short of adding a
new GPIO binding that contains both the polarity and the desired
default value.

Regards,

Tony
