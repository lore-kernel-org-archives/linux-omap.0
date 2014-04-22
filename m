From: Yegor Yefremov <yegor_sub1@visionsystems.de>
Subject: Re: [PATCH v6 1/3] tty/serial: Add GPIOLIB helpers for controlling
 modem lines
Date: Tue, 22 Apr 2014 15:08:43 +0200
Message-ID: <535669DB.8010109@visionsystems.de>
References: <1394469951-21192-1-git-send-email-richard.genoud@gmail.com> <1394469951-21192-2-git-send-email-richard.genoud@gmail.com>
Reply-To: yegor_sub1@visionsystems.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns.visionsystems.de ([62.145.30.242]:54002 "EHLO
	mail.visionsystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754997AbaDVNJI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Apr 2014 09:09:08 -0400
In-Reply-To: <1394469951-21192-2-git-send-email-richard.genoud@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Richard Genoud <noreply.rgenoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Shiyan <shc_work@mail.ru>, Richard Genoud <richard.genoud@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-serial@vger.kernel.org, =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, linux-arm-kernel@lists.infradead.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, mpfj-list@newflow.co.uk, balbi@ti.com

On 10.03.2014 17:45, Richard Genoud wrote:
> This patch add some helpers to control modem lines (CTS/RTS/DSR...) via
> GPIO.
> This will be useful for many boards which have a serial controller that
> only handle CTS/RTS pins (or even just RX/TX).
> 
> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>

....

> +
> +struct mctrl_gpios {
> +	struct gpio_desc *gpio[UART_GPIO_MAX];
> +};
> +
> +static const struct {
> +	const char *name;
> +	unsigned int mctrl;
> +	bool dir_out;
> +} mctrl_gpios_desc[UART_GPIO_MAX] = {
> +	{ "cts", TIOCM_CTS, false, },
> +	{ "dsr", TIOCM_DSR, false, },
> +	{ "dcd", TIOCM_CD, false, },
> +	{ "rng", TIOCM_RNG, false, },
> +	{ "rts", TIOCM_RTS, true, },
> +	{ "dtr", TIOCM_DTR, true, },
> +	{ "out1", TIOCM_OUT1, true, },
> +	{ "out2", TIOCM_OUT2, true, },
> +};
> +
> +void mctrl_gpio_set(struct mctrl_gpios *gpios, unsigned int mctrl)
> +{
> +	enum mctrl_gpio_idx i;
> +
> +	if (IS_ERR_OR_NULL(gpios))
> +		return;
> +
> +	for (i = 0; i < UART_GPIO_MAX; i++)
> +		if (!IS_ERR_OR_NULL(gpios->gpio[i]) &&
> +		    mctrl_gpios_desc[i].dir_out)
> +			gpiod_set_value(gpios->gpio[i],
> +					!!(mctrl & mctrl_gpios_desc[i].mctrl));
> +}
> +EXPORT_SYMBOL_GPL(mctrl_gpio_set);
> +
> +struct gpio_desc *mctrl_gpio_to_gpiod(struct mctrl_gpios *gpios,
> +				      enum mctrl_gpio_idx gidx)
> +{
> +	if (!IS_ERR_OR_NULL(gpios) && !IS_ERR_OR_NULL(gpios->gpio[gidx]))
> +		return gpios->gpio[gidx];
> +	else
> +		return NULL;
> +}
> +EXPORT_SYMBOL_GPL(mctrl_gpio_to_gpiod);
> +
> +unsigned int mctrl_gpio_get(struct mctrl_gpios *gpios, unsigned int *mctrl)
> +{
> +	enum mctrl_gpio_idx i;
> +
> +	/*
> +	 * return it unchanged if the structure is not allocated
> +	 */
> +	if (IS_ERR_OR_NULL(gpios))
> +		return *mctrl;
> +
> +	for (i = 0; i < UART_GPIO_MAX; i++) {
> +		if (!IS_ERR_OR_NULL(gpios->gpio[i]) &&
> +		    !mctrl_gpios_desc[i].dir_out) {
> +			if (gpiod_get_value(gpios->gpio[i]))
> +				*mctrl |= mctrl_gpios_desc[i].mctrl;
> +			else
> +				*mctrl &= ~mctrl_gpios_desc[i].mctrl;
> +		}
> +	}
> +
> +	return *mctrl;
> +}
> +EXPORT_SYMBOL_GPL(mctrl_gpio_get);

Should this routine be renamed to msr_gpio_get() or perhaps better to give all values (inputs and outputs)?

I'm trying to port this approach to omap-serial to implement RS485 switching. I need to know if RTS is already on or not and set it accordingly.

What would be the best solution for this task using this new API?

Yegor
