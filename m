From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: Fix for dispc's error "omapfb omapfb: irq error status 4020"
Date: Mon, 10 Nov 2008 10:30:38 +0200
Message-ID: <1226305838.7185.5.camel@tubuntu>
References: <E1KyYMw-0003Ob-5e@amazonia.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:37920 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750815AbYKJIbQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Nov 2008 03:31:16 -0500
In-Reply-To: <E1KyYMw-0003Ob-5e@amazonia.comcast.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rick@efn.org
Cc: imre.deak@nokia.com, aam@ridgerun.com, juha.yrjola@nokia.com, dirk.behme@de.bosch.com, linux-omap@vger.kernel.org

Hi,

On Fri, 2008-11-07 at 12:55 -0800, ext Rick Bronson wrote:
> Folks,
> 
>   Please take a look at this change to drivers/video/omap/dispc.c.  It
> addresses a problem seen on some boots of OMAP's.  On about 1 in 30
> boots one gets an endless stream of interrupts from the
> DISPC_IRQ_SYNC_LOST bit in the DISPC_IRQSTATUS register.  The
> following messages are printed.
> 
>  omapfb omapfb: irq error status 4020
> 
>   The correct solution to this problem is to perform a "soft reset"
> but that requires a bit of re-architecturing of the code as the init
> routine would have to be split up, etc.  See the OMAP pdf, search for
> "To clear a synchronization lost interrupt".
> 
>   This patch allows the above error message to get printed once and
> then disables further DISPC_IRQ_SYNC_LOST interrups.
> 
>   Comments?

I think the correct solution would be to find out why we get sync lost
errors and fix that. Your patch just hides the problem. 

However, I agree that it's not good to just keep spamming the error,
possibly making the board freeze. The new DSS turns the display off
after 100 error messages. But I don't think just hiding the interrupt is
a good change.

> 
>   Thanks,
> 
>  Rick

Tomi


> 
> --- linux-omap-2.6/drivers/video/omap/dispc.c.~1~	2008-11-04 14:23:38.000000000 -0800
> +++ linux-omap-2.6/drivers/video/omap/dispc.c	2008-11-07 12:34:54.000000000 -0800
> @@ -157,7 +157,7 @@ struct resmap {
>  
>  #define MAX_IRQ_HANDLERS            4
>  
> -static struct {
> +static struct omapfb_dispc {
>  	void __iomem	*base;
>  
>  	struct omapfb_mem_desc	mem_desc;
> @@ -169,6 +169,7 @@ static struct {
>  
>  	int		ext_mode;
>  
> +	u32	irq_error_mask;  /* mask used for errors */
>  	struct {
>  		u32	irq_mask;
>  		void	(*callback)(void *);
> @@ -812,16 +813,16 @@ static void set_lcd_timings(void)
>  	panel->pixel_clock = fck / lck_div / pck_div / 1000;
>  }
>  
> -static void recalc_irq_mask(void)
> +static void recalc_irq_mask(struct omapfb_dispc *p_dispc)
>  {
>  	int i;
> -	unsigned long irq_mask = DISPC_IRQ_MASK_ERROR;
> +	unsigned long irq_mask = p_dispc->irq_error_mask;
>  
>  	for (i = 0; i < MAX_IRQ_HANDLERS; i++) {
> -		if (!dispc.irq_handlers[i].callback)
> +		if (!p_dispc->irq_handlers[i].callback)
>  			continue;
>  
> -		irq_mask |= dispc.irq_handlers[i].irq_mask;
> +		irq_mask |= p_dispc->irq_handlers[i].irq_mask;
>  	}
>  
>  	enable_lcd_clocks(1);
> @@ -843,7 +844,7 @@ int omap_dispc_request_irq(unsigned long
>  		dispc.irq_handlers[i].irq_mask = irq_mask;
>  		dispc.irq_handlers[i].callback = callback;
>  		dispc.irq_handlers[i].data = data;
> -		recalc_irq_mask();
> +		recalc_irq_mask(&dispc);
>  
>  		return 0;
>  	}
> @@ -863,7 +864,7 @@ void omap_dispc_free_irq(unsigned long i
>  			dispc.irq_handlers[i].irq_mask = 0;
>  			dispc.irq_handlers[i].callback = NULL;
>  			dispc.irq_handlers[i].data = NULL;
> -			recalc_irq_mask();
> +			recalc_irq_mask(&dispc);
>  			return;
>  		}
>  	}
> @@ -884,6 +885,10 @@ static irqreturn_t omap_dispc_irq_handle
>  		complete(&dispc.frame_done);
>  
>  	if (stat & DISPC_IRQ_MASK_ERROR) {
> +		if (stat & DISPC_IRQ_SYNC_LOST) {  /* only allow sync lost once or we end up... */
> +			dispc.irq_error_mask &= ~DISPC_IRQ_SYNC_LOST;  /* with a barrage of interrupts */
> +			recalc_irq_mask(&dispc);
> +			}
>  		if (printk_ratelimit()) {
>  			dev_err(dispc.fbdev->dev, "irq error status %04x\n",
>  				stat & 0x7fff);
> @@ -897,6 +902,7 @@ static irqreturn_t omap_dispc_irq_handle
>  	}
>  
>  	dispc_write_reg(DISPC_IRQSTATUS, stat);
> +	stat = dispc_read_reg(DISPC_IRQSTATUS);
>  
>  	enable_lcd_clocks(0);
>  
> @@ -1432,7 +1438,8 @@ static int omap_dispc_init(struct omapfb
>  	l = dispc_read_reg(DISPC_IRQSTATUS);
>  	dispc_write_reg(DISPC_IRQSTATUS, l);
>  
> -	recalc_irq_mask();
> +	dispc.irq_error_mask = DISPC_IRQ_MASK_ERROR;  /* init error mask */
> +	recalc_irq_mask(&dispc);
>  
>  	if ((r = request_irq(INT_24XX_DSS_IRQ, omap_dispc_irq_handler,
>  			   0, MODULE_NAME, fbdev)) < 0) {
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

