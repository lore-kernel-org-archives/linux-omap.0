From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2] OMAP3: I2C: Errata ID i207: Clear wrong RDR interrupt
Date: Tue, 13 Apr 2010 09:48:09 -0700
Message-ID: <4BC4A049.1090702@ti.com>
References: <1271167302-17776-1-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1271167302-17776-1-git-send-email-manjugk-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "G, Manjunath Kondaiah" <manjugk-l0cyMroinI0@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "Kalliguddi, Hema" <hemahk-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 04/13/2010 07:01 AM, G, Manjunath Kondaiah wrote:
> Under certain rare conditions, I2C_STAT[13].RDR bit may be set
> and the corresponding interrupt fire, even there is no data in
> the receive FIFO, or the I2C data transfer is still ongoing.
> These spurious RDR events must be ignored by the software.
>
> This patch handles and ignores RDR spurious interrupts.
>
> Patch tested on OMAP zoom3 board.
>
> Signed-off-by: Manjunatha GK<manjugk-l0cyMroinI0@public.gmane.org>
> Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
> Cc: Kalliguddi, Hema<hemahk-l0cyMroinI0@public.gmane.org>
> Cc: Nishanth Menon<nm-l0cyMroinI0@public.gmane.org>
> ---
> Review comments for earlier post can be found at:
> https://patchwork.kernel.org/patch/90122/
Overall, the comments have not been implemented, so my NAK continues 
unfortunately. please review the comments again.

>
>   drivers/i2c/busses/i2c-omap.c |   32 +++++++++++++++++++++++++++++++-
>   1 files changed, 31 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index ae6f5c1..d4ec886 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -733,10 +733,40 @@ complete:
>   		}
>   		if (stat&  (OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR)) {
>   			u8 num_bytes = 1;
> +
> +			/*
> +			 * I2C Errata(Errata Nos. OMAP2: 1.67, OMAP3: 1.8)
> +			 * Not applicable for OMAP4.
> +			 * Under certain rare conditions, RDR could be set again
> +			 * when the bus is busy, then ignore the interrupt and
> +			 * clear the interrupt.
> +			 */
> +			if ((stat&  OMAP_I2C_STAT_RDR)&&  !cpu_is_omap44xx()) {
> +				/* Step 1: If RDR is set, clear it */
> +				omap_i2c_ack_stat(dev, stat&  OMAP_I2C_STAT_RDR);
> +
> +				/* Step 2: */
> +				if(!(omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG)
> +							&  OMAP_I2C_STAT_BB)) {
> +					/* Step 3: */
> +					while(omap_i2c_read_reg(dev,
> +						OMAP_I2C_STAT_REG)
> +							&  OMAP_I2C_STAT_RDR) {
> +						omap_i2c_ack_stat(dev, stat
> +							&  OMAP_I2C_STAT_RDR);
> +						dev_err(dev->dev,
> +						"I2C : RDR when the bus is busy.\n");
> +						continue;
continue in the inner while loop? NAK. should have been an if condition 
here.

> +					}
> +
> +				}
> +				else
> +					return IRQ_HANDLED;
using a continue is better as commented for patch v1.

> +			}
>   			if (dev->fifo_size) {
>   				if (stat&  OMAP_I2C_STAT_RRDY)
>   					num_bytes = dev->fifo_size;
> -				else    /* read RXSTAT on RDR interrupt */
> +				else  /* Step4: read RXSTAT on RDR interrupt */
dont really need this..
>   					num_bytes = (omap_i2c_read_reg(dev,
>   							OMAP_I2C_BUFSTAT_REG)
>   							>>  8)&  0x3F;

Regards,
Nishanth Menon
