From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: [RFC][BUG] arm/dts: OMAP3: set #interrupt-cells to two
Date: Mon, 01 Apr 2013 18:41:48 +0200
Message-ID: <1364834508.3939.74.camel@mars>
References: <1364631689.3767.7.camel@mars>
	 <CAAwP0s35J-edpvFv08xjjpwaezQBYNvMNhhXL-UacsuUtSt4ZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f50.google.com ([209.85.214.50]:58860 "EHLO
	mail-bk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758963Ab3DAQly (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Apr 2013 12:41:54 -0400
Received: by mail-bk0-f50.google.com with SMTP id jg1so981916bkc.9
        for <linux-omap@vger.kernel.org>; Mon, 01 Apr 2013 09:41:52 -0700 (PDT)
In-Reply-To: <CAAwP0s35J-edpvFv08xjjpwaezQBYNvMNhhXL-UacsuUtSt4ZA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: =?ISO-8859-1?Q?Beno=EEt?= Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Daniel Mack <daniel@zonque.org>, "Hans J. Koch" <hjk@hansjkoch.de>, Jon Hunter <jon-hunter@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Hi Javier

On Sat, 2013-03-30 at 14:18 +0100, Javier Martinez Canillas wrote:
> A call to gpio_request() to enable the GPIO bank is needed before
> using a GPIO as an IRQ source, otherwise accesses to the GPIO bank
> registers fails making the kernel to hang.

Yes, that is exactly my problem here. I'm using the GPIO as an IRQ
source.

> Jon's (added as cc)"gpio/omap: warn if bank is not enabled on setting
> irq type" patch [1] fixes the issue by warning and returning -EINVAL.
> 
> This patch will make the kernel to boot but the call to request_irq()
> will fail of course. For now, the only solution is to call
> gpio_request() before request_irq() in your platform code or device
> driver. There is an on going discussion about what's the better way to
> address this but we still haven't found a good solution to this
> problem, you can see the last email for this discussion here [2]
> 
> Also, even when calling gpio_request() before request_irq() this won't
> work. When specifying the trigger/level flags on the second cell for
> an GPIO-IRQ, this is not set on the IORESOURCE_IRQ struct resource.
> The IRQ flag is set on of_irq_to_resource() but it just does:
> 
> r->flags = IORESOURCE_IRQ;
> 
> and then the call stack is irq_to_parse_and_map() ->
> irq_set_irq_type() ->  __irq_set_trigger() -> chip->irq_set_type() ->
> (drivers/gpio/gpio-omap.c) gpio_irq_type().
> 
> So, even when gpio_irq_type() receive the correct flags, this are not
> returned neither stored on the flags member of the IORESOURCE_IRQ
> struct resource that passed to the drivers in their struct
> platform_device.

As a quick-fix (hack) I wrote directly to the registers in gpio_probe()
to enable GPIO banks. I now geht this:

> > [    0.214630] omap_gpio_probe, 1133, CM_CLKSEL_PER 0x48005040: 0x000000ff
> > [    0.214660] omap_gpio_probe, 1136, CM_ICLKEN_PER 0x48005010: 0x0007ffff
> > [    0.214660] omap_gpio_probe, 1139, CM_FCLKEN_PER 0x48005000: 0x0007ffff

And it works for me. _But_ when I do enable regulator twl4030
(CONFIG_REGULATOR_TWL4030=y) in my config these registers get reset:

[    2.935455] smsc911x_open, 1537, CM_CLKSEL_PER 0x48005040: 0x000000ff
[    2.942291] smsc911x_open, 1540, CM_ICLKEN_PER 0x48005010: 0x00040fff
[    2.949066] smsc911x_open, 1543, CM_FCLKEN_PER 0x48005000: 0x00000000

And the IRQ source for the network chip (smsc911x) is disabled :-(

Do you have any idea how to ("quick") fix this?

 Thanks
  -- Christoph

