From: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv2] OMAP4: I2C: Enable the wakeup in I2C_WE
Date: Tue, 02 Aug 2011 16:05:54 -0700
Message-ID: <87mxfr8ld9.fsf@ti.com>
References: <1311953092-12506-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1311953092-12506-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
	(Shubhrajyoti D.'s message of "Fri, 29 Jul 2011 20:54:52 +0530")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org> writes:

> Currently for OMAP4 the I2C_WE is not programmed.
> This patch enables the programming for OMAP4.
>
> This patch fixes a bad conflict resolution.

...by me I guess, sorry about that.

> This effectively restores the following commit
>
> Commit 120bdaa47[i2c-omap: Program I2C_WE on OMAP4 to enable i2c wakeup] 
>
> which got changed by
>
> Commit a3a7acbc[I2C: OMAP2+: address confused probed version naming] 
>
> Reviewed-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> Reported-by: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>

Thanks, adding to my wip/i2c branch.  I'll shortly be breaking that
branch up into fixes for v3.1 (like this one) and stuff proposed for
3.2.  The branch names will be something like for_3.1/i2c-fixes and
for_3.2/i2c

Kevin




> ---
> TODO:
> Currently all the wakeup sources are enabled.
> There is scope of optimising the same. Will revisit it.
> Rebased on Kevin's wip/i2c branch
> Tested on OMAP4430.
>
>  drivers/i2c/busses/i2c-omap.c |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index d05efe7..18cc0af 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -313,9 +313,8 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
>  		 * REVISIT: Some wakeup sources might not be needed.
>  		 */
>  		dev->westate = OMAP_I2C_WE_ALL;
> -		if (dev->rev < OMAP_I2C_REV_ON_3530_4430)
> -			omap_i2c_write_reg(dev, OMAP_I2C_WE_REG,
> -							dev->westate);
> +		omap_i2c_write_reg(dev, OMAP_I2C_WE_REG,
> +						dev->westate);
>  	}
>  	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
