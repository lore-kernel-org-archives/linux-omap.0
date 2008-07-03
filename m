From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] OMAP: DISPC: Fix to disable also interface clocks.
	2nd.
Date: Thu, 3 Jul 2008 14:04:42 +0300
Message-ID: <20080703110440.GX14276@atomide.com>
References: <1214896361-3220-1-git-send-email-jouni.hogander@nokia.com> <1214905046-7358-1-git-send-email-jouni.hogander@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:59060 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756728AbYGCMVt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jul 2008 08:21:49 -0400
Content-Disposition: inline
In-Reply-To: <1214905046-7358-1-git-send-email-jouni.hogander@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jouni Hogander <jouni.hogander@nokia.com>
Cc: linux-omap@vger.kernel.org

* Jouni Hogander <jouni.hogander@nokia.com> [080701 12:39]:
> Leaving interface clocks enabled causes dss pwrdm to stay in active
> state when mpu is in active state. This fix puts dss to sleep state
> when it is not needed.

Pushing today.

Tony

> 
> Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
> ---
>  drivers/video/omap/dispc.c |   16 ++++------------
>  1 files changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/video/omap/dispc.c b/drivers/video/omap/dispc.c
> index 6aff476..d82588c 100644
> --- a/drivers/video/omap/dispc.c
> +++ b/drivers/video/omap/dispc.c
> @@ -914,18 +914,13 @@ static void put_dss_clocks(void)
>  
>  static void enable_lcd_clocks(int enable)
>  {
> -	if (enable)
> +	if (enable) {
> +		clk_enable(dispc.dss_ick);
>  		clk_enable(dispc.dss1_fck);
> -	else
> +	} else {
>  		clk_disable(dispc.dss1_fck);
> -}
> -
> -static void enable_interface_clocks(int enable)
> -{
> -	if (enable)
> -		clk_enable(dispc.dss_ick);
> -	else
>  		clk_disable(dispc.dss_ick);
> +	}
>  }
>  
>  static void enable_digit_clocks(int enable)
> @@ -1361,7 +1356,6 @@ static int omap_dispc_init(struct omapfb_device *fbdev, int ext_mode,
>  	if ((r = get_dss_clocks()) < 0)
>  		return r;
>  
> -	enable_interface_clocks(1);
>  	enable_lcd_clocks(1);
>  
>  #ifdef CONFIG_FB_OMAP_BOOTLOADER_INIT
> @@ -1465,7 +1459,6 @@ fail2:
>  	free_irq(INT_24XX_DSS_IRQ, fbdev);
>  fail1:
>  	enable_lcd_clocks(0);
> -	enable_interface_clocks(0);
>  	put_dss_clocks();
>  
>  	return r;
> @@ -1482,7 +1475,6 @@ static void omap_dispc_cleanup(void)
>  	cleanup_fbmem();
>  	free_palette_ram();
>  	free_irq(INT_24XX_DSS_IRQ, dispc.fbdev);
> -	enable_interface_clocks(0);
>  	put_dss_clocks();
>  }
>  
> -- 
> 1.5.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
