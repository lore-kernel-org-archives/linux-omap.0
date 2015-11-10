From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 1/5] spi: introduce mmap read support for spi flash
 devices
Date: Tue, 10 Nov 2015 15:23:41 -0800
Message-ID: <20151110232341.GU12143@google.com>
References: <1447133399-25658-1-git-send-email-vigneshr@ti.com>
 <1447133399-25658-2-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1447133399-25658-2-git-send-email-vigneshr-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Vignesh,

Sorry for the late review. I did not have time to review much back when
you submitted your first RFCs for this.

On Tue, Nov 10, 2015 at 10:59:55AM +0530, Vignesh R wrote:
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index cce80e6dc7d1..2f2c431b8917 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -361,6 +361,11 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
>   * @handle_err: the subsystem calls the driver to handle an error that occurs
>   *		in the generic implementation of transfer_one_message().
>   * @unprepare_message: undo any work done by prepare_message().
> + * @spi_mtd_mmap_read: some spi-controller hardwares provide memory.
> + *                     Flash drivers (like m25p80) can request memory
> + *                     mapped read via this method. This interface
> + *                     should only be used by mtd flashes and cannot be
> + *                     used by other spi devices.
>   * @cs_gpios: Array of GPIOs to use as chip select lines; one per CS
>   *	number. Any individual value may be -ENOENT for CS lines that
>   *	are not GPIOs (driven by the SPI controller itself).
> @@ -507,6 +512,11 @@ struct spi_master {
>  			       struct spi_message *message);
>  	int (*unprepare_message)(struct spi_master *master,
>  				 struct spi_message *message);
> +	int (*spi_mtd_mmap_read)(struct  spi_device *spi,
> +				 loff_t from, size_t len,
> +				 size_t *retlen, u_char *buf,
> +				 u8 read_opcode, u8 addr_width,
> +				 u8 dummy_bytes);

Is this API really sufficient? There are actually quite a few other
flash-related parameters that might be relevant to a controller. I
presume you happen not hit them because of the particular cases you're
using this for right now, but:

 * How many I/O lines are being used? These can vary depending on the
   type of flash and the number of I/O lines supported by the controller
   and connected on the board.

 * The previous point can vary across parts of the message. There are
   various combinations of 1/2/4 lines used for opcode/address/data. We
   only support a few of those combinations in m25p80 right now, but
   you're not specifying any of that in this API. I guess you're just
   making assumptions? (BTW, I think there are others having problems
   with the difference between different "quad" modes on Micron flash; I
   haven't sorted through all the discussion there.)

   There are typically both flash device and SPI controller constraints
   on this question, so there needs to be some kind of negotiation
   involved, I expect. Or at least, the SPI master needs to expose which
   modes it can support with this flash-read API.

Also, this API doesn't actually have anything to do with memory mapping.
It has to do with the de facto standard flash protocol. So I don't think
mmap belongs in the name; it should be something about flash. (I know of
at least one other controller that could probably use this API, excpet
it doesn't use memory mapping to accomplish the accelerated flash read.)

>  
>  	/*
>  	 * These hooks are for drivers that use a generic implementation

Brian
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
