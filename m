From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC 1/2] i2c: omap: fix buffer overruns during RX/TX data
 processing
Date: Mon, 1 Dec 2014 11:58:42 -0800
Message-ID: <20141201195841.GD2817@atomide.com>
References: <1417294803-14729-1-git-send-email-al.kochet@gmail.com>
 <1417294803-14729-2-git-send-email-al.kochet@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1417294803-14729-2-git-send-email-al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [141129 13:02]:
> commit dd74548ddece4b9d68e5528287a272fa552c81d0 ("i2c: omap:
> resize fifos before each message") dropped check for dev->buf_len.
> As result, data processing loop cause dev->buf overruns for
> devices with 16-bit data register (omap2420).
> 
> In the dd74548ddece4b9d68 code, for each loop iteration if the
> flag OMAP_I2C_FLAG_16BIT_DATA_REG is set (omap2420), dev->buf
> is incremented twice, and dev->buf_len decremented twice.
> 
> Also buffer overrun could happen (in theory) due to wrong
> ISR handling (bug).
> 
> The commit fix data processing for omap2420 and add guard checks
> in the data processing loops do disallow accesses to the buffer,
> when dev->buf_len is zero. Also added warnings to unhide the bug.
> 
> Found by code review.
> 
> Signed-off-by: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Fixes: dd74548ddece4b9d68e5528287a272fa552c81d0 "i2c: omap: resize fifos before each message"
> Reported-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

I think this is a different issue than what I'm seeing.

Not sure if I've seen what you're describing.. The $subject patch
should be reviewed by Felipe and Aaro, but this does not help
things on 2430.

Regards,

Tony


>  drivers/i2c/busses/i2c-omap.c |   36 ++++++++++++++++++++++++++++--------
>  1 file changed, 28 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 4563200..e890295 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -938,20 +938,30 @@ static int errata_omap3_i462(struct omap_i2c_dev *dev)
>  static void omap_i2c_receive_data(struct omap_i2c_dev *dev, u8 num_bytes,
>  		bool is_rdr)
>  {
> -	u16		w;
> +	u16 w;
> +
> +	if (unlikely(num_bytes > dev->buf_len)) {
> +		dev_err(dev->dev, "%s interrupt can't receive %u byte(s)\n",
> +			is_rdr ? "RDR" : "RRDY", (num_bytes - dev->buf_len));
> +		num_bytes = dev->buf_len;
> +	}
>  
> -	while (num_bytes--) {
> +	while (num_bytes) {
>  		w = omap_i2c_read_reg(dev, OMAP_I2C_DATA_REG);
>  		*dev->buf++ = w;
>  		dev->buf_len--;
> +		num_bytes--;
>  
>  		/*
>  		 * Data reg in 2430, omap3 and
>  		 * omap4 is 8 bit wide
>  		 */
>  		if (dev->flags & OMAP_I2C_FLAG_16BIT_DATA_REG) {
> -			*dev->buf++ = w >> 8;
> -			dev->buf_len--;
> +			if (num_bytes) {
> +				*dev->buf++ = w >> 8;
> +				dev->buf_len--;
> +				num_bytes--;
> +			}
>  		}
>  	}
>  }
> @@ -959,19 +969,29 @@ static void omap_i2c_receive_data(struct omap_i2c_dev *dev, u8 num_bytes,
>  static int omap_i2c_transmit_data(struct omap_i2c_dev *dev, u8 num_bytes,
>  		bool is_xdr)
>  {
> -	u16		w;
> +	u16 w;
> +
> +	if (unlikely(num_bytes > dev->buf_len)) {
> +		dev_err(dev->dev, "%s interrupt can't transmit %u byte(s)\n",
> +			is_xdr ? "XDR" : "XRDY", (num_bytes - dev->buf_len));
> +		num_bytes = dev->buf_len;
> +	}
>  
> -	while (num_bytes--) {
> +	while (num_bytes) {
>  		w = *dev->buf++;
>  		dev->buf_len--;
> +		num_bytes--;
>  
>  		/*
>  		 * Data reg in 2430, omap3 and
>  		 * omap4 is 8 bit wide
>  		 */
>  		if (dev->flags & OMAP_I2C_FLAG_16BIT_DATA_REG) {
> -			w |= *dev->buf++ << 8;
> -			dev->buf_len--;
> +			if (num_bytes) {
> +				w |= *dev->buf++ << 8;
> +				dev->buf_len--;
> +				num_bytes--;
> +			}
>  		}
>  
>  		if (dev->errata & I2C_OMAP_ERRATA_I462) {
> -- 
> 1.7.9.5
> 
