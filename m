From: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] i2c-omap: Double clear of ARDY status in IRQ handler
Date: Mon, 14 Feb 2011 16:05:00 -0800
Message-ID: <877hd2xivn.fsf@ti.com>
References: <1297406718-24147-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1297406718-24147-1-git-send-email-j-keerthy-l0cyMroinI0@public.gmane.org> (Keerthy's
	message of "Fri, 11 Feb 2011 12:15:18 +0530")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Cc: ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Richard woodruff <r-woodruff2-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org> writes:

> From: Richard woodruff <r-woodruff2-l0cyMroinI0@public.gmane.org>
>
> ProDB00017052 - ARDY interrupt reasserted after being cleared.

> This errata caused intermittent i2c instabilty(1 error per 3 hours) on several
> customer platforms. After applying the workaround the intermittent errors were
> not seen. This is not captured in the usual errata documents.

This (presumably internal) ProDB number above is meaningless in the
public changelog.  In lieu of a public erratum number, just summarize
the erratum/instability seen, references to other relevant public
errata (if any) would be useful too.   IOW, "instability" isn't quite
accurate enough.  A more detailed description of the problem/instability
is needed.

Thanks,

Kevin

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
>  			omap_i2c_complete_cmd(dev, err);
>  			return IRQ_HANDLED;
>  		}
