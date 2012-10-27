From: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 7/7] i2c: omap: implement handling for 'transferred'
 bytes
Date: Sat, 27 Oct 2012 18:55:53 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210271852330.18535@utopia.booyaka.com>
References: <1350899218-13624-1-git-send-email-balbi@ti.com> <1351167915-15079-1-git-send-email-balbi@ti.com> <1351167915-15079-8-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1351167915-15079-8-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Shubhrajyoti Datta <shubhrajyoti-l0cyMroinI0@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi

On Thu, 25 Oct 2012, Felipe Balbi wrote:

> this is important in cases where client driver
> wants to know how many bytes were actually
> transferred.
> 
> There is one trick here: if transfer is completed,
> meaning I2C_CNT reaches zero, then ARDY will be
> asserted to let SW know that it can program a
> new transfer.
> 
> When ARDY is asserted, I2C_CNT is reset to the
> original value (msg->len), which means that
> for a successful message, msg->transferred = msg->len
> and we don't need to spend time with a register
> read.
> 
> In case of NACK condition, however, I2C_CNT will
> remain with the end value which is the amount of
> data transferred until NACK condition found on the
> bus inclusive. In this situation, msg->transferred
> needs to be initialized with:
> 
> msg->len - read(I2C_CNT) - 1;
> 
> This patch implements exactly that handling.
> 
> Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-omap.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 699fa12..d268e92 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -588,6 +588,9 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
>  		goto out;
>  	}
>  
> +	msg->transferred = msg->len;
> +	wmb();

If this barrier is being used to ensure that the compiler doesn't move 
this store past the point at which the I2C interrupt handler can be 
entered, then please consider the same comments as on the other 
patch that adds a barrier:

http://marc.info/?l=linux-omap&m=135129247524136&w=2

http://marc.info/?l=linux-omap&m=135135357305794&w=2


- Paul
