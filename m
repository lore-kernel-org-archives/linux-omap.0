From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: touchscreen: ti_am335x_tsc: Fix HWPEN interrupt
 handling
Date: Thu, 7 Jan 2016 11:14:00 -0800
Message-ID: <20160107191400.GC12332@dtor-ws>
References: <1442334489-3645-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1442334489-3645-1-git-send-email-d-gerlach@ti.com>
Sender: linux-input-owner@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: linux-input@vger.kernel.org, linux-omap@vger.kernel.org, Vignesh R <vigneshr@ti.com>, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 15, 2015 at 11:28:09AM -0500, Dave Gerlach wrote:
> Remove write to REG_IRQCLR and REG_IRQWAKEUP in interrupt handler for
> IRQENB_HW_PEN as the resume handler should and does clear REG_IRQWAKEUP.
> IRQENB_HW_PEN bit is set in irqclr so that all interrupts get cleared
> later so let IRQENB_HW_PEN be cleared by that.
> 
> Without this patch wakeup events from TSC_ADC do not work because pending
> interrupts in TSC_ADC were causing HW_PEN interrupt, needed for wake from
> suspend modes, to get disabled immediately by IRQ handler after being
> enabled and preventing wake from happening.
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>

Applied, thank you.

> ---
>  drivers/input/touchscreen/ti_am335x_tsc.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
> index 191a1b8..a21a07c 100644
> --- a/drivers/input/touchscreen/ti_am335x_tsc.c
> +++ b/drivers/input/touchscreen/ti_am335x_tsc.c
> @@ -273,8 +273,6 @@ static irqreturn_t titsc_irq(int irq, void *dev)
>  	status = titsc_readl(ts_dev, REG_RAWIRQSTATUS);
>  	if (status & IRQENB_HW_PEN) {
>  		ts_dev->pen_down = true;
> -		titsc_writel(ts_dev, REG_IRQWAKEUP, 0x00);
> -		titsc_writel(ts_dev, REG_IRQCLR, IRQENB_HW_PEN);
>  		irqclr |= IRQENB_HW_PEN;
>  	}
>  
> -- 
> 2.4.6
> 

-- 
Dmitry
