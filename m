From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [RFC PATCH 1/3] i2c: add 'actual' field to struct i2c_msg
Date: Mon, 2 Jul 2012 15:27:10 +0200
Message-ID: <20120702152710.37af312a@endymion.delvare>
References: <1340967927-27354-1-git-send-email-shubhrajyoti@ti.com>
	<1340967927-27354-2-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1340967927-27354-2-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, 29 Jun 2012 16:35:25 +0530, Shubhrajyoti D wrote:
> In case of a NACK, it's wise to tell our clients
> drivers about how many bytes were actually transferred.
> 
> Support this by adding an extra field to the struct
> i2c_msg which gets incremented the amount of bytes
> actually transferred.
> 
> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> ---
>  include/linux/i2c.h |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index ddfa041..0cb6b83 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -547,6 +547,7 @@ struct i2c_msg {
>  #define I2C_M_NO_RD_ACK		0x0800	/* if I2C_FUNC_PROTOCOL_MANGLING */
>  #define I2C_M_RECV_LEN		0x0400	/* length will be first received byte */
>  	__u16 len;		/* msg length				*/
> +	__u16 actual;		/* actual bytes transferred             */
>  	__u8 *buf;		/* pointer to msg data			*/
>  };
>  

Oh, as a side note: I don't much like the name "actual". It's not
really clear what it means. I don't have a perfect name to propose as a
replacement, but maybe "transferred" or even just "done" would do.

-- 
Jean Delvare
