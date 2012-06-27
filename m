From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] gpio/omap: fix irq loss while in idle with debounce on
Date: Tue, 26 Jun 2012 21:11:08 -0500
Message-ID: <87y5n9tsg3.fsf@ti.com>
References: <1339873285-8700-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:60668 "EHLO
	na3sys009aog133.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751087Ab2F0CLM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Jun 2012 22:11:12 -0400
Received: by gglu4 with SMTP id u4so553089ggl.19
        for <linux-omap@vger.kernel.org>; Tue, 26 Jun 2012 19:11:00 -0700 (PDT)
In-Reply-To: <1339873285-8700-1-git-send-email-notasas@gmail.com> (Grazvydas
	Ignotas's message of "Sat, 16 Jun 2012 22:01:25 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-omap@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@stericsson.com>

Grazvydas Ignotas <notasas@gmail.com> writes:

> It seems that currently GPIO module is not working correctly during idle
> when debounce is enabled - the system almost never responds to button
> presses (observed on OMAP3530 ES2.1 and OMAP3630 ES1.2 pandora boards).
> Even though wakeups are probably working, it seems that the GPIO module
> itself is unable to detect input events and generate interrupts.
> OMAP35x TRM also states that:
>   "If the debounce clock is inactive, the debounce cell gates all
>    input signals and thus cannot be used."
>
> So whenever we are disabling debounce clocks (for PM or other reasons),
> be sure the module's debounce feature is disabled too.
>
> Cc: Kevin Hilman <khilman@ti.com>
> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>

This looks right, thanks for the patch.

I will queue it up for v3.6 and get it some broader testing before
sending to Grant.

Kevin

> ---
>  drivers/gpio/gpio-omap.c |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index c4ed172..ff213e7 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -174,12 +174,22 @@ static inline void _gpio_dbck_enable(struct gpio_bank *bank)
>  	if (bank->dbck_enable_mask && !bank->dbck_enabled) {
>  		clk_enable(bank->dbck);
>  		bank->dbck_enabled = true;
> +
> +		__raw_writel(bank->dbck_enable_mask,
> +			     bank->base + bank->regs->debounce_en);
>  	}
>  }
>  
>  static inline void _gpio_dbck_disable(struct gpio_bank *bank)
>  {
>  	if (bank->dbck_enable_mask && bank->dbck_enabled) {
> +		/*
> +		 * Disable debounce before cutting it's clock. If debounce is
> +		 * enabled but the clock is not, GPIO module seems to be unable
> +		 * to detect events and generate interrupts at least on OMAP3.
> +		 */
> +		__raw_writel(0, bank->base + bank->regs->debounce_en);
> +
>  		clk_disable(bank->dbck);
>  		bank->dbck_enabled = false;
>  	}
