From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] gpio: always enable GPIO_OMAP on ARCH_OMAP
Date: Fri, 09 May 2014 10:48:27 +0200
Message-ID: <5419755.pTjp3y9xzp@wuerfel>
References: <5523458.JVZJJObMjC@wuerfel> <CACRpkdYD+mSgkbUM+NXd9LQY+auTQMnvHFf7BZw_PUKbReYNcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:54351 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460AbaEIIsg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 May 2014 04:48:36 -0400
In-Reply-To: <CACRpkdYD+mSgkbUM+NXd9LQY+auTQMnvHFf7BZw_PUKbReYNcQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Linux-OMAP <linux-omap@vger.kernel.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

On Friday 09 May 2014 09:48:00 Linus Walleij wrote:
> On Mon, Apr 28, 2014 at 11:07 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > Commit 4df42de9d3e "gpio: omap: add a GPIO_OMAP option instead of using
> > ARCH_OMAP" made it possible to build OMAP kernels without the GPIO driver,
> > which at least on OMAP2 and OMAP3 causes build errors because of functions
> > used by the platform power management code:
> >
> > arch/arm/mach-omap2/built-in.o: In function `omap_sram_idle':
> > arch/arm/mach-omap2/pm24xx.c:129: undefined reference to `omap2_gpio_prepare_for_idle'
> > arch/arm/mach-omap2/pm24xx.c:129: undefined reference to `omap2_gpio_resume_after_idle'
> >
> > We presumably always want the GPIO driver on OMAP, so this adds a slightly
> > broader dependency and only allows disabling the driver only when no
> > OMAP2PLUS platform is selected.
> >
> > However, it seems entirely reasonable to include the driver in build tests
> > on other platforms, so we should also allow building it for COMPILE_TEST
> > builds and select the required GENERIC_IRQ_CHIP that may not already be
> > enabled on other platforms.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Patch applied to my devel branch, this is not a fix to Torvalds HEAD
> AFAICT, but a fix to v3.16? Else poke me.

Yes, 3.16 is ok.

	Arnd
