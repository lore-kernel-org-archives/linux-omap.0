From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] gpio: always enable GPIO_OMAP on ARCH_OMAP
Date: Fri, 9 May 2014 09:48:00 +0200
Message-ID: <CACRpkdYD+mSgkbUM+NXd9LQY+auTQMnvHFf7BZw_PUKbReYNcQ@mail.gmail.com>
References: <5523458.JVZJJObMjC@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:34956 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754574AbaEIHsB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 May 2014 03:48:01 -0400
Received: by mail-oa0-f49.google.com with SMTP id eb12so4414888oac.36
        for <linux-omap@vger.kernel.org>; Fri, 09 May 2014 00:48:00 -0700 (PDT)
In-Reply-To: <5523458.JVZJJObMjC@wuerfel>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>

On Mon, Apr 28, 2014 at 11:07 AM, Arnd Bergmann <arnd@arndb.de> wrote:

> Commit 4df42de9d3e "gpio: omap: add a GPIO_OMAP option instead of using
> ARCH_OMAP" made it possible to build OMAP kernels without the GPIO driver,
> which at least on OMAP2 and OMAP3 causes build errors because of functions
> used by the platform power management code:
>
> arch/arm/mach-omap2/built-in.o: In function `omap_sram_idle':
> arch/arm/mach-omap2/pm24xx.c:129: undefined reference to `omap2_gpio_prepare_for_idle'
> arch/arm/mach-omap2/pm24xx.c:129: undefined reference to `omap2_gpio_resume_after_idle'
>
> We presumably always want the GPIO driver on OMAP, so this adds a slightly
> broader dependency and only allows disabling the driver only when no
> OMAP2PLUS platform is selected.
>
> However, it seems entirely reasonable to include the driver in build tests
> on other platforms, so we should also allow building it for COMPILE_TEST
> builds and select the required GENERIC_IRQ_CHIP that may not already be
> enabled on other platforms.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch applied to my devel branch, this is not a fix to Torvalds HEAD
AFAICT, but a fix to v3.16? Else poke me.

Yours,
Linus Walleij
