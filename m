From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/5] gpio/omap: Add DT support to GPIO driver
Date: Wed, 10 Apr 2013 23:44:52 +0200
Message-ID: <1580096.AHFBPvEqBp@wuerfel>
References: <1329321854-24490-1-git-send-email-b-cousson@ti.com> <CACRpkdYbs4-uudpRUY8e+7icYYkZrfM0kReP3pLL5DMiURJ4dg@mail.gmail.com> <5165CB9D.1090202@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:58226 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765530Ab3DJVoV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Apr 2013 17:44:21 -0400
In-Reply-To: <5165CB9D.1090202@wwwdotorg.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Stephen Warren <swarren@wwwdotorg.org>, Linus Walleij <linus.walleij@linaro.org>, Javier Martinez Canillas <martinez.javier@gmail.com>, Stephen Warren <swarren@nvidia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Grant Likely <grant.likely@secretlab.ca>, Alexandre Courbot <acourbot@nvidia.com>, Jon Hunter <jon-hunter@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tarun Kanti DebBarma <tarun.kanti@ti.com>

On Wednesday 10 April 2013 14:29:17 Stephen Warren wrote:
> 
> > If the information is there, whether to convert from IRQ to GPIO
> > or from GPIO to IRQ is a technicality and any order should be
> > feasible in some way?
> 
> There isn't always a unique 1:1 mapping between GPIOs and IRQs. Put
> another way, a single GPIO would likely only ever trigger a single IRQ,
> but a single IRQ might easily be triggered by any number of GPIOs. This
> is exactly why the function irq_to_gpio() isn't something one should use
> any more.

More importantly, most irqs don't have any GPIO associated with them
at all. The interface made some sense for simple platforms that had
a linear range of GPIO IRQs, but that also isn't true these days,
with arbitrary IRQ domains.

> I think there was an effort to outright remove the API,
> although it doesn't look like that's entirely complete yet.

It's essentially complete. There are a few remnants in areas of the kernel
that we don't like to look at:

* The blackfin architecture provides the interface and uses it in the
  pata_rb532_cf driver.

* MIPS provides it on a few older platforms, and it's used on the alchemy
  pcmcia driver.

* avr32, m68k, sh and unicore32 provide the interface but don't use it.

* On ARM, the interface is provided on iop, gemini, ixp4xx, ks8695
  and w90x900.  None of these use it, and they rarely see any patches
  at all these days.

* ARM/davinci provides a stub but always return -ENOSYS.

* One driver for PXA (tosa_battery) still uses this interface, but PXA stopped
  providing it long ago.

	Arnd
