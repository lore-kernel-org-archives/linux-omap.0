From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 1/3] TCA6416 keypad : Implement keypad driver for keys
 interfaced to TCA6416
Date: Thu, 25 Feb 2010 20:47:03 +0200
Message-ID: <20100225184702.GA5125@gandalf>
References: <1267103701-23823-1-git-send-email-srk@ti.com>
 <1267103701-23823-2-git-send-email-srk@ti.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:41686 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759052Ab0BYSrK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Feb 2010 13:47:10 -0500
Content-Disposition: inline
In-Reply-To: <1267103701-23823-2-git-send-email-srk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sriramakrishnan <srk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-input@vger.kernel.org

Hi,

On Thu, Feb 25, 2010 at 06:44:59PM +0530, Sriramakrishnan wrote:
> This patch implements a simple Keypad driver that functions
> as an I2C client. It handles key press events for keys
> connected to TCA6416 I2C based IO expander.

what's wrong with gpio-keys ??

> + * Implementation based on drivers/input/keyboard/gpio_keys.c

I see,

shouldn't you instead provide a gpiolib driver for tca6416 and use the
generic gpio_keys driver ??

> +	if (!chip->use_polling) {

IMO, you should only use polling if the irq line isn't connected.

> +		if (pdata->irq_is_gpio)
> +			chip->irqnum = gpio_to_irq(pdata->irqnum);

you can pass the irq number via i2c_board_info. Use it.

> +		else
> +			chip->irqnum = pdata->irqnum;
> +
> +		ret = request_irq(chip->irqnum, tca6416_keys_isr,

it's an i2c driver!!! this should be request_threaded_irq()

-- 
balbi
