From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP3: GPIO: Added dynamic control logic for pad
 wakeups
Date: Tue, 9 Mar 2010 11:01:25 -0800
Message-ID: <20100309190125.GA2900@atomide.com>
References: <1255695824-17523-1-git-send-email-tero.kristo@nokia.com>
 <873a0awxoj.fsf@deeprootsystems.com>
 <1F18D6510CF0474A8C9500565A7E41A224FCDB832F@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56614 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752552Ab0CITAK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Mar 2010 14:00:10 -0500
Content-Disposition: inline
In-Reply-To: <1F18D6510CF0474A8C9500565A7E41A224FCDB832F@NOK-EUMSG-02.mgdnok.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero.Kristo@nokia.com
Cc: khilman@deeprootsystems.com, linux-omap@vger.kernel.org

* Tero.Kristo@nokia.com <Tero.Kristo@nokia.com> [100309 00:20]:
> >
> >Changes in wakeup state should not be directly correlated to interrupt
> >enabled GPIOs.  Rather, this should only be done for GPIOs that are
> >explicitly wakeup enabled (via enable_irq_wake(), which in turn
> >calls gpio_wake_enable()).
> 
> This logic somehow escapes me... I would guess drivers should not care during dynamic idle whether the device is in off/ret/ina and interrupts should just work. This is done to make this happen. Also, I understood that gpio wakeup logic is needed for the suspend wakeup, which is quite different from dynamic idle wakeup.
> 
> However, if this is intended behavior for the kernel, then I will accept it. You are saying the code below should be moved into the gpio_wake_enable() / disable() calls?

I agree. I'd assume during the idle modes we want everything to
automatically wake the system up. Otherwise we again have non-standard
Linux behaviour that's mysterious to track down. The enable_irq_wake
should only be needed for suspend states.
 
> >This change isn't explained in the changelog and appears unrelated to
> >this patch.
> 
> The reason for this change is that we need the gpio->pad mapping early now to enable wakeups properly. Otherwise some components can enable gpio interrupts early in the boot cycle and they will miss their wakeup setting because the map does not exist yet. I think another way to do this would be to enable wakeups for all enabled interrupts during the omap3_gpio_pads_init().

Don't have the original patch, but it smells like you're trying
to do gpio to mux register mapping?

If so, your already have that available via omap_mux_get/set_gpio()
for 34xx in the new muxcode already in mainline. Those work even
if you don't have CONFIG_OMAP_MUX set.

And I still need to convert 24xx to the new mux code so we can
get rid of the old omap1 style code..

Regards,

Tony
