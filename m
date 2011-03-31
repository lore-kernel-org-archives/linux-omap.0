From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] omap: rx51: Platform support for lp5523 led chip
Date: Thu, 31 Mar 2011 15:27:00 +0300
Message-ID: <20110331122659.GT2267@legolas.emea.dhcp.ti.com>
References: <1301573877-26010-1-git-send-email-ameya.palande@nokia.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:52383 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751823Ab1CaM1F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 Mar 2011 08:27:05 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so705814eyx.19
        for <linux-omap@vger.kernel.org>; Thu, 31 Mar 2011 05:27:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1301573877-26010-1-git-send-email-ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>
Cc: linux-omap@vger.kernel.org, mathias.nyman@nokia.com, linux-arm-kernel@lists.infradead.org

Hi,

On Thu, Mar 31, 2011 at 03:17:57PM +0300, Ameya Palande wrote:
> +static int rx51_lp5523_setup(void)
> +{
> +	int err;
> +
> +	err = gpio_request(RX51_LP5523_CHIP_EN_GPIO, "lp5523_enable");
> +	if (err < 0) {
> +		pr_err("Unable to get lp5523_enable GPIO\n");
> +		return err;
> +	}
> +
> +	err = gpio_direction_output(RX51_LP5523_CHIP_EN_GPIO, 1);
> +	if (err < 0) {
> +		pr_err("Failed to change direction for %d GPIO\n",
> +				RX51_LP5523_CHIP_EN_GPIO);
> +	}

you can combine these two into

gpio_request_one(RX51_LP5523_CHIP_EN_GPIO, GPIOF_DIR_OUT,
		"lp5523_enable");

> +	return err;
> +}
> +
> +static void rx51_lp5523_release(void)
> +{
> +	gpio_free(RX51_LP5523_CHIP_EN_GPIO);
> +}
> +
> +static void rx51_lp5523_enable(bool state)
> +{
> +	if (state)
> +		gpio_set_value(RX51_LP5523_CHIP_EN_GPIO, 1);
> +	else
> +		gpio_set_value(RX51_LP5523_CHIP_EN_GPIO, 0);

how about:

gpio_set_value(RX51_LP5523_CHIP_EN_GPIO, !!state); ??

you drop a useless branch.

> +}
> +
> +static struct lp5523_platform_data rx51_lp5523_platform_data = {

should this be const ??

> +	.led_config		= rx51_lp5523_led_config,
> +	.num_channels		= ARRAY_SIZE(rx51_lp5523_led_config),
> +	.clock_mode		= LP5523_CLOCK_AUTO,
> +	.setup_resources	= rx51_lp5523_setup,
> +	.release_resources 	= rx51_lp5523_release,
			  ^ trailing whitespace

-- 
balbi
