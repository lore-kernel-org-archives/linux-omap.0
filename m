From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] gpio: always enable GPIO_OMAP on ARCH_OMAP
Date: Tue, 29 Apr 2014 12:26:17 +0200
Message-ID: <13943940.Yb2C7lPSBy@wuerfel>
References: <5523458.JVZJJObMjC@wuerfel> <535EEB58.60809@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:54456 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754763AbaD2K0w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Apr 2014 06:26:52 -0400
In-Reply-To: <535EEB58.60809@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Tuesday 29 April 2014 01:59:20 Javier Martinez Canillas wrote:
> This driver is also used by OMAP1. Even when disabling GPIO_OMAP on that
> platform doesn't cause a build error since no function defined in the driver is
> used directly by platform code, I think that we always want this driver on OMAP1
> too.
> 
> > However, it seems entirely reasonable to include the driver in build tests
> > on other platforms, so we should also allow building it for COMPILE_TEST
> > builds and select the required GENERIC_IRQ_CHIP that may not already be
> > enabled on other platforms.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> > index c58b828..c8c42be 100644
> > --- a/drivers/gpio/Kconfig
> > +++ b/drivers/gpio/Kconfig
> > @@ -244,9 +244,10 @@ config GPIO_OCTEON
> >         family of SOCs.
> >  
> >  config GPIO_OMAP
> > -     bool "TI OMAP GPIO support"
> > +     bool "TI OMAP GPIO support" if COMPILE_TEST && !ARCH_OMAP2PLUS
> 
> So this should be:
> 
> +       bool "TI OMAP GPIO support" if COMPILE_TEST && !ARCH_OMAP2PLUS &&
> !ARCH_OMAP1
> 

Well, if COMPILE_TEST is disabled on OMAP1, the option is already
hidden and enabled in my version. It seems reasonable to me to 
allow compile-testing OMAP1 without the GPIO driver, while a kernel
running on OMAP1 should always have COMPILE_TEST disabled.

	Arnd
