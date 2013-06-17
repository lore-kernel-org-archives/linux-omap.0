From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] gpio/omap: omap_gpio_init_context stub must be inline
Date: Mon, 17 Jun 2013 08:27:30 +0200
Message-ID: <CACRpkdYUXAgK24aUkCXR1wdPNTDvJ6c-i7tqYUQ=6EZPY2a-WQ@mail.gmail.com>
References: <2942784.trumtc2GjZ@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52]:49204 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750Ab3FQG1a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jun 2013 02:27:30 -0400
Received: by mail-oa0-f52.google.com with SMTP id g12so2899207oah.39
        for <linux-omap@vger.kernel.org>; Sun, 16 Jun 2013 23:27:30 -0700 (PDT)
In-Reply-To: <2942784.trumtc2GjZ@wuerfel>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Walleij <linus.ml.walleij@gmail.com>, linux-gpio@vger.kernel.org, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, Jon Hunter <jon-hunter@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>

On Fri, May 31, 2013 at 5:59 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> The bug fix 352a2d5bf "gpio/omap: ensure gpio context is initialised"
> has caused a new warning for omap1_defconfig:
>
> drivers/gpio/gpio-omap.c:1465:13: warning: 'omap_gpio_init_context' defined but not used [-Wunused-function]
>  static void omap_gpio_init_context(struct gpio_bank *p) {}
>              ^
>
> The solution is to mark the stub function as 'static inline' so
> it gets left out of the build when unused.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch applied with Tony's and Santosh's ACKs.

Yours,
Linus Walleij
