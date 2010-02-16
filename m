From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/4 RFC]OMAP2: Fix compile errors
Date: Tue, 16 Feb 2010 17:15:11 -0600
Message-ID: <87y6isixhc.fsf@deeprootsystems.com>
References: <1265981851-11970-1-git-send-email-charu@ti.com>
	<1265981851-11970-2-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f185.google.com ([209.85.223.185]:36088 "EHLO
	mail-iw0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933531Ab0BPXPQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Feb 2010 18:15:16 -0500
Received: by iwn15 with SMTP id 15so5820034iwn.19
        for <linux-omap@vger.kernel.org>; Tue, 16 Feb 2010 15:15:15 -0800 (PST)
In-Reply-To: <1265981851-11970-2-git-send-email-charu@ti.com> (Charulatha Varadarajan's message of "Fri\, 12 Feb 2010 19\:07\:28 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>

"Varadarajan, Charulatha" <charu@ti.com> writes:

> From: Rajendra Nayak <rnayak@ti.com>
>
> There are few compile errors for OMAP2 which are fixed by this patch
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Charulatha V <charu@ti.com>
> ---
>  arch/arm/mach-omap2/board-2430sdp.c |    2 +-
>  arch/arm/mach-omap2/serial.c        |    1 +
>  arch/arm/plat-omap/i2c.c            |    2 ++
>  3 files changed, 4 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
> index d6f55ef..3f45d4b 100644
> --- a/arch/arm/mach-omap2/board-2430sdp.c
> +++ b/arch/arm/mach-omap2/board-2430sdp.c
> @@ -146,7 +146,7 @@ static void __init omap_2430sdp_init_irq(void)
>  {
>  	omap_board_config = sdp2430_config;
>  	omap_board_config_size = ARRAY_SIZE(sdp2430_config);
> -	omap2_init_common_hw(NULL, NULL);
> +	omap2_init_common_hw(NULL, NULL, NULL, NULL, NULL);

This change is only needed in the PM branch.  Please base this series
on mainline. 

With our new OPP layer, the changes to init_common_hw() will be dropped 
so this change will no longer be necessary.

Kevin


>  	omap_init_irq();
>  	omap_gpio_init();
>  }
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index e7b874f..a686948 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -570,6 +570,7 @@ DEVICE_ATTR(sleep_timeout, 0644, sleep_timeout_show, sleep_timeout_store);
>  #define DEV_CREATE_FILE(dev, attr) WARN_ON(device_create_file(dev, attr))
>  #else
>  static inline void omap_uart_idle_init(struct omap_uart_state *uart) {}
> +static void omap_uart_block_sleep(struct omap_uart_state *uart) {}
>  #define DEV_CREATE_FILE(dev, attr)
>  #endif /* CONFIG_PM */
>  
> diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
> index fcb515d..6a617ca 100644
> --- a/arch/arm/plat-omap/i2c.c
> +++ b/arch/arm/plat-omap/i2c.c
> @@ -99,6 +99,8 @@ static void omap_i2c_set_wfc_mpu_wkup_lat(struct device *dev, int val)
>  {
>  	omap_pm_set_max_mpu_wakeup_lat(dev, val);
>  }
> +#else
> +static void omap_i2c_set_wfc_mpu_wkup_lat(struct device *dev, int val) {}
>  #endif
>  
>  static void __init omap_set_i2c_constraint_func(
> -- 
> 1.6.3.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
