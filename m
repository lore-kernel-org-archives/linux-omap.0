From: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4] OMAP: I2C: Fix the interrupt clearing in OMAP4
Date: Fri, 02 Dec 2011 14:42:58 -0800
Message-ID: <8739d2mw7h.fsf@ti.com>
References: <1322491212-8657-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1322491212-8657-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
	(Shubhrajyoti D.'s message of "Mon, 28 Nov 2011 20:10:12 +0530")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org> writes:

> On OMAP4 we were writing 1 to  IRQENABLE_CLR which cleared only
> the arbitration lost interrupt however for other ips (not OMAP_I2C_IP_VERSION_2)
> we clear all the interrupts at idle. The patch intends to fix the same by writing 0 to the
> IE register.

Please also explain why you're using a different register to clear interrupts.

IMO, you don't need to explain how it works on other IPs.   

The changelog should just explain what's broken in the handling of the
v2 interrupts (only arbitration lost interrupt is cleared) and how
you're fixing it (writing zero to IE REG, which clears all interrupts.)

> Signed-off-by: Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>

Has Vikram really signed off on this?  This is a different
implementation from his original version.  Unless he is on the delivery
path, there should not be a signed-off from him.  Instead, as I've
suggested already, I'd like to see a comment in the changelog mentioning
that this patch is based on an original patch from Vikram, and then
ideally a reply from Vikram on the list with his Acked-by or Reviewed-by.

Kevin

> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-omap.c |    6 ++----
>  1 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index a43d002..abadc13 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -297,10 +297,8 @@ static void omap_i2c_idle(struct omap_i2c_dev *dev)
>  	pdata = dev->dev->platform_data;
>  
>  	dev->iestate = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
> -	if (pdata->rev == OMAP_I2C_IP_VERSION_2)
> -		omap_i2c_write_reg(dev, OMAP_I2C_IP_V2_IRQENABLE_CLR, 1);
> -	else
> -		omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, 0);
> +
> +	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, 0);
>  
>  	if (dev->rev < OMAP_I2C_OMAP1_REV_2) {
>  		iv = omap_i2c_read_reg(dev, OMAP_I2C_IV_REG); /* Read clears */
