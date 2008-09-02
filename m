From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 12/33] Add tsc2005 touchscreen driver
Date: Tue, 2 Sep 2008 22:33:36 +0100
Message-ID: <20080902213336.GB32575@flint.arm.linux.org.uk>
References: <1220116593-862-4-git-send-email-me@felipebalbi.com> <1220116593-862-5-git-send-email-me@felipebalbi.com> <1220116593-862-6-git-send-email-me@felipebalbi.com> <1220116593-862-7-git-send-email-me@felipebalbi.com> <1220116593-862-8-git-send-email-me@felipebalbi.com> <1220116593-862-9-git-send-email-me@felipebalbi.com> <1220116593-862-10-git-send-email-me@felipebalbi.com> <1220116593-862-11-git-send-email-me@felipebalbi.com> <1220116593-862-12-git-send-email-me@felipebalbi.com> <1220116593-862-13-git-send-email-me@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:45665 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677AbYIBVdu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Sep 2008 17:33:50 -0400
Content-Disposition: inline
In-Reply-To: <1220116593-862-13-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>

On Sat, Aug 30, 2008 at 08:16:12PM +0300, Felipe Balbi wrote:
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/input.h>
> +#include <linux/interrupt.h>
> +#include <linux/delay.h>
> +#include <linux/spi/spi.h>
> +
> +#ifdef CONFIG_ARCH_OMAP
> +#include <mach/gpio.h>
> +#endif

#include <linux/gpio.h> ?

If this driver depends on having gpio, shouldn't that be reflected in the
Kconfig entry?  ...

> +static int __devinit tsc2005_ts_init(struct tsc2005 *ts,
> +				     struct tsc2005_platform_data *pdata)
> +{
> +	struct input_dev *idev;
> +	int dav_gpio, r;
> +	int x_max, y_max;
> +	int x_fudge, y_fudge, p_fudge;
> +
> +	if (pdata->dav_gpio < 0) {
> +		dev_err(&ts->spi->dev, "need DAV GPIO");
> +		return -EINVAL;
> +	}
> +	dav_gpio = pdata->dav_gpio;
> +	ts->dav_gpio = dav_gpio;
> +	dev_dbg(&ts->spi->dev, "TSC2005: DAV GPIO = %d\n", dav_gpio);
> +
> +#ifdef CONFIG_ARCH_OMAP
> +	r = omap_request_gpio(dav_gpio);
> +	if (r < 0) {
> +		dev_err(&ts->spi->dev, "unable to get DAV GPIO");
> +		goto err1;
> +	}
> +	omap_set_gpio_direction(dav_gpio, 1);
> +	ts->irq = OMAP_GPIO_IRQ(dav_gpio);

In fact, this driver requires ARCH_OMAP to set ts->irq, otherwise
it's uninitialized.

> +	dev_dbg(&ts->spi->dev, "TSC2005: DAV IRQ = %d\n", ts->irq);
> +#endif

Can this be converted to the generic gpio stuff?

> +	init_timer(&ts->penup_timer);
> +	setup_timer(&ts->penup_timer, tsc2005_ts_penup_timer_handler,
> +			(unsigned long)ts);

setup_timer() does init_timer() so the first line is redundant.
