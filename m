From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: DISPC: Fix to disable also interface clocks.
Date: Wed, 20 Aug 2008 14:58:49 +0300
Message-ID: <20080820115848.GG29374@atomide.com>
References: <20080703113329.GZ14276@atomide.com> <1218790563-23248-1-git-send-email-jouni.hogander@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:52406 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753302AbYHTL65 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Aug 2008 07:58:57 -0400
Content-Disposition: inline
In-Reply-To: <1218790563-23248-1-git-send-email-jouni.hogander@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jouni Hogander <jouni.hogander@nokia.com>
Cc: linux-omap@vger.kernel.org

* Jouni Hogander <jouni.hogander@nokia.com> [080815 11:57]:
> Leaving interface clocks enabled causes dss pwrdm to stay in active
> state when mpu is in active state. This fix puts dss to sleep state
> when it is not needed.
> 
> Earlier version broke framebuffer on 24xx. This is fixed by enabling
> clocks before trying to access DISPC_IRQSTATUS register.

Pushing today. BTW, here we could use the virtual clock to combine
the needed clocks instead of enable_interface_clocks().

Tony

> Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
> ---
>  drivers/video/omap/dispc.c |   23 ++++++++++-------------
>  1 files changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/video/omap/dispc.c b/drivers/video/omap/dispc.c
> index 3d64314..99bf355 100644
> --- a/drivers/video/omap/dispc.c
> +++ b/drivers/video/omap/dispc.c
> @@ -858,8 +858,11 @@ EXPORT_SYMBOL(omap_dispc_free_irq);
>  
>  static irqreturn_t omap_dispc_irq_handler(int irq, void *dev)
>  {
> -	u32 stat = dispc_read_reg(DISPC_IRQSTATUS);
> +	u32 stat;
>  
> +	enable_lcd_clocks(1);
> +
> +	stat = dispc_read_reg(DISPC_IRQSTATUS);
>  	if (stat & DISPC_IRQ_FRAMEMASK)
>  		complete(&dispc.frame_done);
>  
> @@ -875,6 +878,8 @@ static irqreturn_t omap_dispc_irq_handler(int irq, void *dev)
>  
>  	dispc_write_reg(DISPC_IRQSTATUS, stat);
>  
> +	enable_lcd_clocks(0);
> +
>  	return IRQ_HANDLED;
>  }
>  
> @@ -915,18 +920,13 @@ static void put_dss_clocks(void)
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
> @@ -1362,7 +1362,6 @@ static int omap_dispc_init(struct omapfb_device *fbdev, int ext_mode,
>  	if ((r = get_dss_clocks()) < 0)
>  		return r;
>  
> -	enable_interface_clocks(1);
>  	enable_lcd_clocks(1);
>  
>  #ifdef CONFIG_FB_OMAP_BOOTLOADER_INIT
> @@ -1466,7 +1465,6 @@ fail2:
>  	free_irq(INT_24XX_DSS_IRQ, fbdev);
>  fail1:
>  	enable_lcd_clocks(0);
> -	enable_interface_clocks(0);
>  	put_dss_clocks();
>  
>  	return r;
> @@ -1483,7 +1481,6 @@ static void omap_dispc_cleanup(void)
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
