From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4] OMAP2: Fix compile breaks
Date: Tue, 5 Jan 2010 16:17:05 -0800
Message-ID: <20100106001705.GJ14533@atomide.com>
References: <1260781959-28050-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:58257 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754508Ab0AFARF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jan 2010 19:17:05 -0500
Content-Disposition: inline
In-Reply-To: <1260781959-28050-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

Hi,

* Rajendra Nayak <rnayak@ti.com> [091214 01:11]:
> Fixes a couple of implicit function definition errors
> for functions defined only for omap3 and called in omap2/3
> common code, and one function argument mismatch.

Looks like this needs to be refreshed to apply. Also
please fix the few cosmetic issues below :)
 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/mach-omap2/board-2430sdp.c |    2 +-
>  arch/arm/mach-omap2/serial.c        |    1 +
>  arch/arm/plat-omap/i2c.c            |    2 ++
>  3 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
> index db9374b..dea1425 100644
> --- a/arch/arm/mach-omap2/board-2430sdp.c
> +++ b/arch/arm/mach-omap2/board-2430sdp.c
> @@ -147,7 +147,7 @@ static void __init omap_2430sdp_init_irq(void)
>  {
>  	omap_board_config = sdp2430_config;
>  	omap_board_config_size = ARRAY_SIZE(sdp2430_config);
> -	omap2_init_common_hw(NULL, NULL);
> +	omap2_init_common_hw(NULL, NULL, NULL, NULL, NULL);
>  	omap_init_irq();
>  	omap_gpio_init();
>  }
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index c067416..5c65d2d 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -500,6 +500,7 @@ DEVICE_ATTR(sleep_timeout, 0644, sleep_timeout_show, sleep_timeout_store);
>  #define DEV_CREATE_FILE(dev, attr) WARN_ON(device_create_file(dev, attr))
>  #else
>  static inline void omap_uart_idle_init(struct omap_uart_state *uart) {}
> +static inline void omap_uart_block_sleep(struct omap_uart_state *uart){}

Should be like this for new entries:

static inline void omap_uart_block_sleep(struct omap_uart_state *uart)
{
}

Maybe also update the omap_uart_idle_init the same way?

  
> diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
> index fb447c1..f8eb3a0 100644
> --- a/arch/arm/plat-omap/i2c.c
> +++ b/arch/arm/plat-omap/i2c.c
> @@ -117,6 +117,8 @@ static void omap_i2c_set_wfc_mpu_wkup_lat(struct device *dev, int val)
>  {
>  	omap_pm_set_max_mpu_wakeup_lat(dev, val);
>  }
> +#else
> +static inline void omap_i2c_set_wfc_mpu_wkup_lat(struct device *dev, int val){}
>  #endif

Here too.

Regards,

Tony
