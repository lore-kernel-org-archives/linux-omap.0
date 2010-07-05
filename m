From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] [omap1] Bluetooth device code common to HTC smartphones
Date: Mon, 5 Jul 2010 16:25:40 +0300
Message-ID: <20100705132539.GB15951@atomide.com>
References: <1275431571-28547-1-git-send-email-darkstar6262@gmail.com>
 <1275431571-28547-3-git-send-email-darkstar6262@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:58542 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755757Ab0GENZr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Jul 2010 09:25:47 -0400
Content-Disposition: inline
In-Reply-To: <1275431571-28547-3-git-send-email-darkstar6262@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cory Maccarrone <darkstar6262@gmail.com>
Cc: linux-omap@vger.kernel.org, linwizard-devel@lists.sf.net

* Cory Maccarrone <darkstar6262@gmail.com> [100602 01:27]:
> This change adds in a bluetooth controld driver/rfkill
> interface to the serial bluetooth controller found on many
> HTC smartphones such as the HTC Herald and HTC Wizard.

<snip>
 
> +static void htc_bt_on(struct htc_bt_data *data)
> +{
> +	gpio_set_value(data->gpio_pwr, 1);
> +
> +	if (uart_ck)
> +		clk_enable(uart_ck);
> +
> +	mdelay(1000);
> +
> +	if (data->gpio_enable)
> +		gpio_set_value(data->gpio_enable, 1);
> +}

Maybe you can use msleep here instead? Otherwise the whole system
will hang for a second..

> +static void htc_bt_off(struct htc_bt_data *data)
> +{
> +	gpio_set_value(data->gpio_pwr, 0);
> +
> +	if (uart_ck)
> +		clk_disable(uart_ck);
> +
> +	mdelay(1000);
> +
> +	if (data->gpio_enable)
> +		gpio_set_value(data->gpio_enable, 0);
> +}

Here too.

Regards,

Tony
