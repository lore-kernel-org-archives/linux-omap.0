From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH] ARM: OMAP2+: Fix serial init for device tree based booting
Date: Fri, 07 Jun 2013 15:20:55 -0700
Message-ID: <87fvwtlfzs.fsf@linaro.org>
References: <20130607215503.GK3331@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:35081 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752999Ab3FGWU7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jun 2013 18:20:59 -0400
Received: by mail-pd0-f175.google.com with SMTP id 4so5339749pdd.20
        for <linux-omap@vger.kernel.org>; Fri, 07 Jun 2013 15:20:59 -0700 (PDT)
In-Reply-To: <20130607215503.GK3331@atomide.com> (Tony Lindgren's message of
	"Fri, 7 Jun 2013 14:55:04 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> We don't want to call omap_serial_early_init() for device
> tree based booting as the ports are initialized based on
> the .dts entries.
>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Reviewed-by: Kevin Hilman <khilman@linaro.org>


> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -176,6 +176,9 @@ static char *cmdline_find_option(char *str)
>  
>  static int __init omap_serial_early_init(void)
>  {
> +	if (of_have_populated_dt())
> +		return -ENODEV;
> +
>  	do {
>  		char oh_name[MAX_UART_HWMOD_NAME_LEN];
>  		struct omap_hwmod *oh;
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
