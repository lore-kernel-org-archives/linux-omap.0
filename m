From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP display subsystem - does it work?
Date: Fri, 20 Dec 2013 08:10:27 -0800
Message-ID: <20131220161027.GA27438@atomide.com>
References: <20131218120023.GG4360@n2100.arm.linux.org.uk>
 <52B1A922.6020901@ti.com>
 <20131218180240.GG27438@atomide.com>
 <20131219175644.GE32243@n2100.arm.linux.org.uk>
 <20131219182252.GP27438@atomide.com>
 <20131220112700.GF32243@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:45456 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752840Ab3LTQK5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Dec 2013 11:10:57 -0500
Content-Disposition: inline
In-Reply-To: <20131220112700.GF32243@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [131220 03:28]:
> 
> > BTW, I'm seeing MMC errors with my LDP here though, does that work
> > for you?
> 
> I see no errors there.

OK thanks that's good to hear. I'm seeing them even after changing the
MMC card, need to check that again though. I'm almost certain it worked
just fine a month ago or so when I was playing with it.. Maybe some dirt
in the contacts or something.
 
> Okay, while digging through the changes, I found this - this is the old
> code.  gpio + 15 is the backlight enable GPIO.
> 
>  static int ldp_twl_gpio_setup(struct device *dev, unsigned gpio, unsigned ngpio)
>  {
> -       ldp_panel_data.gpios[0] = gpio + 7;
> -       ldp_panel_data.gpio_invert[0] = true;
> 
> -       ldp_panel_data.gpios[1] = gpio + 15;
> -       ldp_panel_data.gpio_invert[1] = true;
> 
>         return 0;
>  }
> 
> ...
> 
> -static int generic_dpi_panel_power_on(struct omap_dss_device *dssdev)
> -{
> ...
> -       for (i = 0; i < panel_data->num_gpios; ++i) {
> -               gpio_set_value_cansleep(panel_data->gpios[i],
> -                               panel_data->gpio_invert[i] ? 0 : 1);
> -       }
> 
> -static void generic_dpi_panel_power_off(struct omap_dss_device *dssdev)
> -{
> ...
> -       for (i = panel_data->num_gpios - 1; i >= 0; --i) {
> -               gpio_set_value_cansleep(panel_data->gpios[i],
> -                               panel_data->gpio_invert[i] ? 1 : 0);
> -       }
> 
> -static int generic_dpi_panel_probe(struct omap_dss_device *dssdev)
> -{
> -       for (i = 0; i < panel_data->num_gpios; ++i) {
> -               r = devm_gpio_request_one(dssdev->dev, panel_data->gpios[i],
> -                               panel_data->gpio_invert[i] ?
> -                               GPIOF_OUT_INIT_HIGH : GPIOF_OUT_INIT_LOW,
> -                               "panel gpio");
> -               if (r)
> -                       return r;
> -       }
> 
> So, when gpio_invert[] is set, the signal is active low for "on".  What
> does the new code do?
> 
>  static int ldp_twl_gpio_setup(struct device *dev, unsigned gpio, unsigned ngpio)
>  {
> +       /* LCD enable GPIO */
> +       ldp_lcd_pdata.enable_gpio = gpio + 7;
> 
> +       /* Backlight enable GPIO */
> +       ldp_lcd_pdata.backlight_gpio = gpio + 15;
> ...
> 
> static int panel_dpi_enable(struct omap_dss_device *dssdev)
> {
> ...
>         if (gpio_is_valid(ddata->backlight_gpio))
>                 gpio_set_value_cansleep(ddata->backlight_gpio, 1);
> 
> ...
> static void panel_dpi_disable(struct omap_dss_device *dssdev)
> {
> ...
>         if (gpio_is_valid(ddata->backlight_gpio))
>                 gpio_set_value_cansleep(ddata->backlight_gpio, 0);
> 
> ...
> static int panel_dpi_probe(struct platform_device *pdev)
> {
> ...
>         if (gpio_is_valid(ddata->backlight_gpio)) {
>                 r = devm_gpio_request_one(&pdev->dev, ddata->backlight_gpio,
>                                 GPIOF_OUT_INIT_LOW, "panel backlight");
> 
> which is fixed at active-high for "on".
> 
> Would you like to revise whether this works for you... I suspect that
> you're missing configuration which means that the backlight_gpio is
> not valid, and hence it's being left in same default state (maybe by
> the boot loader?)

Nope, my LCD if off from the bootloader and gets enabled by the kernel.
I think the old gpio_invert was inverting the value unnecessarily or
something, the new code does the right thing without a need for the
gpio_invert flags.

Regards,

Tony
