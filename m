From: Tony Lindgren <tony@atomide.com>
Subject: Re: Problem specifying which gpio_126 to use on omap353x
Date: Thu, 18 Feb 2010 09:43:57 -0800
Message-ID: <20100218174357.GR21755@atomide.com>
References: <738b3f7e1002180839x62a17dct381eed020642b91d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:50834 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757762Ab0BRRnH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 12:43:07 -0500
Content-Disposition: inline
In-Reply-To: <738b3f7e1002180839x62a17dct381eed020642b91d@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Barada <peter.barada@gmail.com>
Cc: linux-omap@vger.kernel.org

* Peter Barada <peter.barada@gmail.com> [100218 08:36]:
> On my board I have an isp1760 hooked up using gpio_126 (pin P27 -
> MMC1_DAT4/SIM_IO/GPIO_126).  From the schematics (and TRM), there is a
> 2nd gpio_126 on pin D25 (CAM_STROBE/GPIO_126).
> 
> I tried to use:
> 
> #define ISP1760_IRQ 126
> 
> omap_mux_init_gpio(ISP1760_IRQ, OMAP_PIN_INPUT_PULLUP);
> if (gpio_request(ISP1760_IRQ, "isp1760 IRQ") < 0) {
>     printk(KERN_ERR "Failed to request GPIO%d for isp1760IRQ\n", ISP1760_IRQ);
>     return;
> }
> 
> And in the log I see:
> 
> mux: Multiple gpio paths for gpio126
> mux: Multiple gpio paths for gpio126
> Failed to request GPIO126 for isp1760 IRQ
> 
> How do I tell gpio_request()and friends that I want to use GPIO_126 on
> pin P27, not GPIO_126 on pin D25?

For omap_mux_init_signal you need to use the full signal name.
So something like "sdmmc1_dat4.gpio_126" should work with
omap_mux_init_signal.

I guess at some point we could patch to omap_mux_init_gpio to call
omap_mux_init_signal if the full path is specified.

I guess you already know this, but you also need to check the packaging
you're using as the pin numbering is package specific. If you have the
system booting, it's easiest to look under omap_mux under debugfs. Or 
search in mux34xx.c.

Also, the data is generated from TRMs, and there may be some errors in
the data too.

Regards,

Tony
