From: Jarkko Nikula <jhnikula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c-omap: Double clear of ARDY status in IRQ handler
Date: Fri, 11 Feb 2011 12:50:59 +0200
Message-ID: <20110211125059.04f17162.jhnikula@gmail.com>
References: <1297406718-24147-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1297406718-24147-1-git-send-email-j-keerthy-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Cc: ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Richard woodruff <r-woodruff2-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, 11 Feb 2011 12:15:18 +0530
Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org> wrote:

> From: Richard woodruff <r-woodruff2-l0cyMroinI0@public.gmane.org>
> 
> ProDB00017052 - ARDY interrupt reasserted after being cleared.
> This errata caused intermittent i2c instabilty(1 error per 3 hours) on several
> customer platforms. After applying the workaround the intermittent errors were
> not seen. This is not captured in the usual errata documents.
> 
> The workaround is to have a double clear of ARDY status in
> irq handler.
> 
> Signed-off-by: Richard woodruff <r-woodruff2-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-omap.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 445de08..9bcefae 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -851,7 +851,8 @@ complete:
>  					OMAP_I2C_STAT_AL)) {
>  			omap_i2c_ack_stat(dev, stat &
>  				(OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR |
> -				OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR));
> +				OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR |
> +				OMAP_I2C_STAT_ARDY));

Most probably this is correct but I was just wondering are there any use
for ARDY interrupt (register access ready) anyway and is the ARDY here
caused by omap_i2c_write_reg for STAT_NACK in a few lines above.

Just my 2 cents about possible further patches (while this having the
priority as fixes the issue).

-- 
Jarkko
