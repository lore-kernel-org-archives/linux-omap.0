From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3] gpio/omap: fix off-mode bug: clear debounce clock
 enable mask on free/reset
Date: Sat, 27 Oct 2012 18:23:57 +0200
Message-ID: <CACRpkdawKqmBjETy05EiFfOg3D=PxGVz=ZKi_GdCFK1jLR_Afw@mail.gmail.com>
References: <1351182858-14045-1-git-send-email-khilman@deeprootsystems.com>
	<5089C2B6.5020606@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:35721 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756447Ab2J0QX6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 27 Oct 2012 12:23:58 -0400
Received: by mail-ee0-f46.google.com with SMTP id b15so1480871eek.19
        for <linux-omap@vger.kernel.org>; Sat, 27 Oct 2012 09:23:57 -0700 (PDT)
In-Reply-To: <5089C2B6.5020606@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>, Grazvydas Ignotas <notasas@gmail.com>

On Fri, Oct 26, 2012 at 12:52 AM, Jon Hunter <jon-hunter@ti.com> wrote:

> Subject: [PATCH] gpio/omap: fix clearing of debounce settings on gpio
>  free/reset
>
> When a GPIO is freed or shutdown, we need to ensure that any debounce settings
> are cleared and if the GPIO is the only GPIO in the bank that is currently
> using debounce, then disable the debounce clock as well to save power.
>
> Therefore, introduce a new function called _clear_gpio_debounce() to clear
> any debounce settings when the GPIO is freed or shutdown.
>
> Please note that we cannot use _gpio_dbck_disable() to disable the debounce
> clock because this has been specifically created for the gpio suspend path
> and is intended to shutdown the debounce clock while debounce is enabled.
>
> This has been unit tested on an OMAP3430 Beagle board, by requesting a gpio,
> enabling debounce and then freeing the gpio and checking the register contents,
> the saved register context and the debounce clock state.
>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>

I have come to the conclusion that there is consensus to merge this
patch.

However it does *not* apply to my GPIO tree, which for the OMAP
driver is just a clean v3.7-rc1 and nothing else.

I previously reverted Kevin's patch, is this meant to be applied
on top of that one or what?

Jon, can you please submit a patch made against my GPIO
tree or linux-next or v3.7-rc2 or whatever and include the ACKs
you've recieved?

Thanks!
Linus Walleij
