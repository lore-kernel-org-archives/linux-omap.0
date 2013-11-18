From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 5/8] gpio: twl4030: Fix regression for twl gpio output
Date: Mon, 18 Nov 2013 23:45:53 +0100
Message-ID: <CACRpkdY22=YFjg_OM+c6cs7hAWnGO+ufa6uAGWGK0KexN+0s0Q@mail.gmail.com>
References: <1384396537-3486-1-git-send-email-tony@atomide.com>
	<1384396537-3486-6-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:60883 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751829Ab3KRWpy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Nov 2013 17:45:54 -0500
Received: by mail-ob0-f177.google.com with SMTP id wp4so7645523obc.8
        for <linux-omap@vger.kernel.org>; Mon, 18 Nov 2013 14:45:53 -0800 (PST)
In-Reply-To: <1384396537-3486-6-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

On Thu, Nov 14, 2013 at 3:35 AM, Tony Lindgren <tony@atomide.com> wrote:

> Commit c111feabe2e2 (gpio: twl4030: Cache the direction and output
> states in private data) improved things in general, but caused a
> regression for setting the GPIO output direction.
>
> The change reorganized twl_direction_out() and twl_set() and swapped
> the function names around in the process. While doing that, a bug got
> introduced that's not obvious while reading the patch as it appears
> as no change to the code.
>
> The bug is we now call function twl4030_set_gpio_dataout() twice in
> both twl_direction_out() and twl_set(). Instead, we should first
> call twl_direction_out() in twl_direction_out() followed by
> twl4030_set_gpio_dataout() in twl_set().
>
> This regression probably has gone unnoticed for a long time as the
> bootloader may have set the GPIO direction properly in many cases.
> This fixes at least the LCD panel not turning on omap3 LDP for
> example.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: linux-gpio@vger.kernel.org
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>
> If this looks OK, I'd like to merge this as a fix via arm-soc tree
> along with the other patches in this series as my later patches
> depend on patches in this series.

Sure:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
