From: Thomas Weber <thomas.weber.linux@googlemail.com>
Subject: Re: [PATCH] arm: omap2plus: fix ads7846 pendown gpio request
Date: Wed, 04 May 2011 19:22:44 +0200
Message-ID: <4DC18B64.2020903@gmail.com>
References: <1304521495-20578-1-git-send-email-grinberg@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43049 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752717Ab1EDRWM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 May 2011 13:22:12 -0400
Received: by bwz15 with SMTP id 15so1167789bwz.19
        for <linux-omap@vger.kernel.org>; Wed, 04 May 2011 10:22:11 -0700 (PDT)
In-Reply-To: <1304521495-20578-1-git-send-email-grinberg@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>, Mike Rapoport <mike@compulab.co.il>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Am 04.05.2011 17:04, schrieb Igor Grinberg:
> introduced by: 96974a24
> (omap: consolidate touch screen initialization among different boards)
>
> ads7846 driver can use either gpio_pendown or get_pendown_state()
> callback. In case of gpio_pendown, it requests the provided gpio_pendown
> thus resulting in double requesting that gpio:
>
> ads7846 spi1.0: failed to request pendown GPIO57
> ads7846: probe of spi1.0 failed with error -16
>
> Fix this by restricting the gpio request to the case of
> get_pendown_state() callback is used.
>
> Signed-off-by: Igor Grinberg<grinberg@compulab.co.il>
> ---
>   arch/arm/mach-omap2/common-board-devices.c |   20 ++++++++++----------
>   1 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/common-board-devices.c b/arch/arm/mach-omap2/common-board-devices.c
> index d57c71d..61fee80 100644
> --- a/arch/arm/mach-omap2/common-board-devices.c
> +++ b/arch/arm/mach-omap2/common-board-devices.c
> @@ -83,17 +83,17 @@ void __init omap_ads7846_init(int bus_num, int gpio_pendown, int gpio_debounce,
>   	struct spi_board_info *spi_bi =&ads7846_spi_board_info;
>   	int err;
>
> -	err = gpio_request(gpio_pendown, "TS PenDown");
> -	if (err) {
> -		pr_err("Could not obtain gpio for TS PenDown: %d\n", err);
> -		return;
> -	}
> -
> -	gpio_direction_input(gpio_pendown);
> -	gpio_export(gpio_pendown, 0);
> +	if (board_pdata&&  board_pdata->get_pendown_state) {
> +		err = gpio_request_one(gpio_pendown, GPIOF_IN, "TSPenDown");
> +		if (err) {
> +			pr_err("Couldn't obtain gpio for TSPenDown: %d\n", err);
> +			return;
> +		}
> +		gpio_export(gpio_pendown, 0);
>
> -	if (gpio_debounce)
> -		gpio_set_debounce(gpio_pendown, gpio_debounce);
> +		if (gpio_debounce)
> +			gpio_set_debounce(gpio_pendown, gpio_debounce);
> +	}
>
>   	ads7846_config.gpio_pendown = gpio_pendown;
>
Tested-by: Thomas Weber <weber@corscience.de>

On Devkit8000.

Thanks.

Thomas
