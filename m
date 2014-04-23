From: Nishanth Menon <nm@ti.com>
Subject: Re: regressions in linux-next?
Date: Tue, 22 Apr 2014 20:30:22 -0500
Message-ID: <20140423013022.GA18648@kahuna>
References: <53566C20.6000208@ti.com>
 <53568706.1050204@ti.com>
 <5356E5E4.1060509@ti.com>
 <CABxcv=nATX0m8janD=kTZ_Askuy8StNx5r9vJM_Fq+EmQeZ0-g@mail.gmail.com>
 <5356F2A4.6010106@ti.com>
 <CABxcv=kx6zhJqVKcE1cijyOEak+jgXgsFaRAFYcZA4L_zxLRHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43875 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756072AbaDWBaZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Apr 2014 21:30:25 -0400
Content-Disposition: inline
In-Reply-To: <CABxcv=kx6zhJqVKcE1cijyOEak+jgXgsFaRAFYcZA4L_zxLRHg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, linux-omap <linux-omap@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>

On 01:08-20140423, Javier Martinez Canillas wrote:
[...]
> > on AM335x-sk:
> >> So this makes only am335x-sk to fail with the gpiolib irpchip
> >> conversion as reported by Peter and you.
> >>
> >> Do you know what special use of GPIO have this board to behave
> >> differently than the other boards? I've looked at the DTS but didn't
> >> find anything evident.
> >
> > I could not find anything interesting yet. Peter did mention that
> > reverting d04b76626e94 helped make the platform boot fine. I am trying
> > to add a few prints and see which specific line does things go bad..
> > and if so why.. unfortunately, I am using the board remotely as well..
> > Will try to track this down in the next few hours and post back.
> >
> 
> Great, thanks a lot for your help and sorry for the inconvenience!

Yep - If I am correct, and as we all suspected, GPIO0_7 which controls
the VTT regulator for DDR is getting configured as input, instead of
output.
http://slexy.org/raw/s2gReMRZI6 (with diff:
http://slexy.org/view/s20nueCE8H - ignore many of the prints as I was
trying to truncate and isolate - had to switch to non-relaxed versions
of writes to force sequencing with barriers to trace it down..)


Anyways, the key log is [0]:
gpiochip_irq_map -> calls
		irq_set_irq_type(irq, chip->irq_default_type);
	which inturn triggers: gpio-omap.c's gpio_irq_type
	in this, logic:
	if (!LINE_USED(bank->mod_usage, offset)) is invoked prior to
	setting the input type for the GPIO 0_7 (you can see the logic
walks through setting every GPIO to input!).

The original usage as far as I could discern was that this function was
only called after probe got completed as the gpio requests were
triggered.

There are probably many hacks possible, but a cleaner solution might
involve gpio_irqchip knowing when to set the type and knowing which gpios
not to mess with.

Example hack:
Since we call gpiochip_irqchip_add with IRQ_TYPE_NONE,
  in gpio-omap's   gpio_irq_type could do:
       if (type == IRQ_TYPE_NONE) 
	        return 0;
 boots, http://slexy.org/raw/s24M8lHqZX - but ofcourse, there'd be other
 side effects I have'nt thought through..

[0]:
[   25.504976] DONE gpio_irq_type: 533 bank 0xf9e07000, offset 7
[   25.511052] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.15.0-rc2-next-20140422-00003-gd9fc91f-dirty #12
[   25.520811] [<c0014cf0>] (unwind_backtrace) from [<c0011984>] (show_stack+0x10/0x14)
[   25.528870] [<c0011984>] (show_stack) from [<c05421b8>] (dump_stack+0x78/0x94)
[   25.536390] [<c05421b8>] (dump_stack) from [<c03016c8>] (gpio_irq_type+0x1b4/0x218)
[   25.544359] [<c03016c8>] (gpio_irq_type) from [<c008f0d4>] (__irq_set_trigger+0x5c/0xfc)
[   25.552774] [<c008f0d4>] (__irq_set_trigger) from [<c0090888>] (irq_set_irq_type+0x38/0x58)
[   25.561455] [<c0090888>] (irq_set_irq_type) from [<c02fbf4c>] (gpiochip_irq_map+0x60/0x68)
[   25.570047] [<c02fbf4c>] (gpiochip_irq_map) from [<c0092908>] (irq_domain_associate+0x70/0x1b8)
[   25.579087] [<c0092908>] (irq_domain_associate) from [<c0092abc>] (irq_create_mapping+0x6c/0xfc)
[   25.588216] [<c0092abc>] (irq_create_mapping) from [<c02fbe4c>] (gpiochip_irqchip_add+0xa8/0xf0)
[   25.597346] [<c02fbe4c>] (gpiochip_irqchip_add) from [<c0300bb8>] (omap_gpio_probe+0x2bc/0x8a4)
[   25.606386] [<c0300bb8>] (omap_gpio_probe) from [<c0354ee4>] (platform_drv_probe+0x18/0x48)
[   25.615068] [<c0354ee4>] (platform_drv_probe) from [<c03535d0>] (driver_probe_device+0x110/0x224)
[   25.624286] [<c03535d0>] (driver_probe_device) from [<c0351e64>] (bus_for_each_drv+0x5c/0x88)
[   25.633146] [<c0351e64>] (bus_for_each_drv) from [<c035348c>] (device_attach+0x74/0x8c)
[   25.641471] [<c035348c>] (device_attach) from [<c0352b68>] (bus_probe_device+0x88/0xb0)
[   25.649793] [<c0352b68>] (bus_probe_device) from [<c035114c>] (device_add+0x3a8/0x4dc)
[   25.658029] [<c035114c>] (device_add) from [<c045ccb8>] (of_platform_device_create_pdata+0x70/0x94)
[   25.667428] [<c045ccb8>] (of_platform_device_create_pdata) from [<c045cdb8>] (of_platform_bus_create+0xdc/0x184)
[   25.677990] [<c045cdb8>] (of_platform_bus_create) from [<c045ce1c>] (of_platform_bus_create+0x140/0x184)
[   25.687835] [<c045ce1c>] (of_platform_bus_create) from [<c045cec0>] (of_platform_populate+0x60/0x98)
[   25.697323] [<c045cec0>] (of_platform_populate) from [<c07ad190>] (pdata_quirks_init+0x34/0x44)
[   25.706364] [<c07ad190>] (pdata_quirks_init) from [<c07ace64>] (omap_generic_init+0x10/0x1c)
[   25.715136] [<c07ace64>] (omap_generic_init) from [<c079e50c>] (customize_machine+0x1c/0x40)
[   25.723906] [<c079e50c>] (customize_machine) from [<c0008a64>] (do_one_initcall+0x80/0x1c8)
[   25.732591] [<c0008a64>] (do_one_initcall) from [<c079bc94>] (kernel_init_freeable+0xfc/0x1cc)
[   25.741544] [<c079bc94>] (kernel_init_freeable) from [<c053cb1c>] (kernel_init+0x8/0xe4)
[   25.749958] [<c053cb1c>] (kernel_init) from [<c000e708>] (ret_from_fork+0x14/0x2c)
-- 
Regards,
Nishanth Menon
