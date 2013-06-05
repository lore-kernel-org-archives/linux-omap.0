From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] gpio/omap: omap_gpio_init_context stub must be inline
Date: Wed, 5 Jun 2013 12:04:27 -0400
Message-ID: <51AF618B.9090605@ti.com>
References: <2942784.trumtc2GjZ@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60312 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754639Ab3FEQE4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Jun 2013 12:04:56 -0400
In-Reply-To: <2942784.trumtc2GjZ@wuerfel>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Walleij <linus.ml.walleij@gmail.com>, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@linaro.org>

On Friday 31 May 2013 11:59 AM, Arnd Bergmann wrote:
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
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

