From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 1/5] spi: introduce mmap read support for spi flash
 devices
Date: Wed, 11 Nov 2015 11:24:41 -0800
Message-ID: <20151111192441.GG12143@google.com>
References: <1447133399-25658-1-git-send-email-vigneshr@ti.com>
 <1447133399-25658-2-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1447133399-25658-2-git-send-email-vigneshr-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

In addition to my other comments:

On Tue, Nov 10, 2015 at 10:59:55AM +0530, Vignesh R wrote:
> In addition to providing direct access to SPI bus, some spi controller
> hardwares (like ti-qspi) provide special memory mapped port
> to accesses SPI flash devices in order to increase read performance.
> This means the controller can automatically send the SPI signals
> required to read data from the SPI flash device.
> For this, spi controller needs to know flash specific information like
> read command to use, dummy bytes and address width. Once these settings
> are populated in hardware registers, any read accesses to flash's memory
> map region(SoC specific) through memcpy (or mem-to mem DMA copy) will be
> handled by controller hardware. The hardware will automatically generate
> SPI signals required to read data from flash and present it to CPU/DMA.
> 
> Introduce spi_mtd_mmap_read() interface to support memory mapped read
> over SPI flash devices. SPI master drivers can implement this callback to
> support memory mapped read interfaces. m25p80 flash driver and other
> flash drivers can call this to request memory mapped read. The interface
> should only be used MTD flashes and cannot be used with other SPI devices.
> 
> Signed-off-by: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
> ---
...
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

This is seeming to be a longer and longer list of arguments. I know MTD
has a bad habit of long argument lists (which then cause a ton of
unnecessary churn when things need changed in the API), but perhaps we
can limit the damage to the SPI layer. Perhaps this deserves a struct to
encapsulate all the flash read arguments? Like:

struct spi_flash_read_message {
	loff_t from;
	size_t len;
	size_t *retlen;
	void *buf;
	u8 read_opcode;
	u8 addr_width;
	u8 dummy_bits;
	// additional fields to describe rx_nbits for opcode/addr/data
};

struct spi_master {
	...
	int (*spi_flash_read)(struct spi_device *spi,
			      struct spi_flash_message *msg);
};

>  
>  	/*
>  	 * These hooks are for drivers that use a generic implementation

...

Brian
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
