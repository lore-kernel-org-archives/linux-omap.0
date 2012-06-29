From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [RFC PATCH 1/3] i2c: add 'actual' field to struct i2c_msg
Date: Fri, 29 Jun 2012 14:33:20 +0200
Message-ID: <20120629143320.42f51c0a@endymion.delvare>
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

David Brownell discussed this a long time ago:
http://marc.info/?l=linux-i2c&m=121103523020494&w=2

This structure is exported to user-space through i2c-dev, so changing
it is tough if possible at all. You first have to ensure that the
change doesn't alter the structure size. In other words, the field you
add must fit in a padding hole the structure had previously. This
appears to be the case here, but I'm not sure how to prove it for all
supported architectures.

Then, as you are inserting a field in the middle of the structure, you
must ensure that every initialization follows C99. And you have to do
that _before_ the above change, not after as you did in patch 3/3. This
needs to be done in both the whole kernel tree and as many user-space
applications as possible. At least i2c-tools is clean, but there must
be other (possibly unpublished) tools using this API, which your change
may break. We can't fix them all, but at least we will have to document
the change clearly and explain how to fix in case of breakage. The i2c
wiki might be the right place for that.

-- 
Jean Delvare
