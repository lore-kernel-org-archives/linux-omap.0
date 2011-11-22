From: Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3] OMAP: I2C: Fix the interrupt clearing in OMAP4
Date: Tue, 22 Nov 2011 11:37:11 +0530
Message-ID: <4ECB3C0F.7000204@ti.com>
References: <1321941716-4505-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1321941716-4505-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tuesday 22 November 2011 11:31 AM, Shubhrajyoti D wrote:
> However on OMAP4 we were writing 1 to  IRQENABLE_CLR which clears only
> the arbitration lost interrupt. The patch intends to fix the same by writing 
> 0 to the IE register.
Please ignore this patch I will send another one in a while.
> Signed-off-by: Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-omap.c |    6 ++----
>  1 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 2dfb631..4220949 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -308,10 +308,8 @@ static void omap_i2c_idle(struct omap_i2c_dev *dev)
>  	pdata = pdev->dev.platform_data;
>  
>  	dev->iestate = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
> -	if (dev->rev >= OMAP_I2C_REV_ON_4430)
> -		omap_i2c_write_reg(dev, OMAP_I2C_IRQENABLE_CLR, 1);
> -	else
> -		omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, 0);
> +
> +	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, 0);
>  
>  	if (dev->rev < OMAP_I2C_REV_2) {
>  		iv = omap_i2c_read_reg(dev, OMAP_I2C_IV_REG); /* Read clears */
