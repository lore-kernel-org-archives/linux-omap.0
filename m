From: Jagan Teki <jteki-oRp2ZoJdM/RWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 1/5] spi: introduce mmap read support for spi flash devices
Date: Fri, 4 Sep 2015 16:55:33 +0530
Message-ID: <CAD6G_RT8Q+Uyp1ZjzHf54Tno1wHm0SmLKEwRAe2gkdp772FD9A@mail.gmail.com>
References: <1441355402-6837-1-git-send-email-vigneshr@ti.com>
	<1441355402-6837-2-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441355402-6837-2-git-send-email-vigneshr-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Cc: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 4 September 2015 at 13:59, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org> wrote:
> In addition to providing direct access to SPI bus, some spi controller
> hardwares (like ti-qspi) provide special memory mapped port
> to accesses SPI flash devices in order to increase read performance.
> This means the controller can automatically send the SPI signals
> required to read data from the SPI flash device.
> For this, spi controller needs to know flash specific information like
> read command to use, dummy bytes and address width. Once these settings
> are populated in hardware registers, any read accesses to flash's memory
> map region(SoC specific) through memcpy or mem-to-mem DMA copy will be
> handled by controller hardware. The hardware will automatically generate
> spi signals required to read data from flash and present it to CPU or
> DMA engine.
>
> Introduce spi_mtd_mmap_read() method to support memory mapped read
> over SPI flash devices. SPI master drivers can implement this method to
> support memory mapped read interfaces. m25p80 flash driver and other
> flash drivers can call this to request memory mapped read. The interface
> should only be used mtd flashes and cannot be used with other spi devices.
>
> Signed-off-by: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
> ---
>  include/linux/spi/spi.h | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index d673072346f2..b74a3f169fc2 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -293,6 +293,23 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
>   * @handle_err: the subsystem calls the driver to handle an error that occurs
>   *             in the generic implementation of transfer_one_message().
>   * @unprepare_message: undo any work done by prepare_message().
> + * @spi_mtd_mmap_read: some spi-controller hardwares provide memory
> + *                     mapped interface to communicate with mtd flashes.
> + *                     For this, spi  controller needs to know flash
> + *                     memory settings like read command to use, dummy
> + *                     bytes and address width. Once these settings are
> + *                     populated in hardware registers, any read
> + *                     accesses to flash's memory map region(as defined
> + *                     by SoC) through memcpy or mem-to-mem DMA copy
> + *                     will be handled by controller hardware. The
> + *                     hardware will automatically generate spi signals
> + *                     required to read data from flash and present it
> + *                     to CPU or DMA. SPI master drivers can use this
> + *                     callback to implement memory mapped read
> + *                     interface. Flash driver (like m25p80) requests
> + *                     memory mapped read via this method. The interface
> + *                     should  only be used mtd flashes and cannot be
> + *                     used with other spi devices.
>   * @cs_gpios: Array of GPIOs to use as chip select lines; one per CS
>   *     number. Any individual value may be -ENOENT for CS lines that
>   *     are not GPIOs (driven by the SPI controller itself).
> @@ -438,6 +455,10 @@ struct spi_master {
>                                struct spi_message *message);
>         int (*unprepare_message)(struct spi_master *master,
>                                  struct spi_message *message);
> +       int (*spi_mtd_mmap_read)(struct  spi_device *spi,
> +                                loff_t from, size_t len, size_t *retlen,
> +                                u_char *buf, u8 read_opcode,
> +                                u8 addr_width, u8 dummy_bytes);

This looks un-manageable to know spi core or master knows what are the
command or opcode used by spi-nor flash and also I think mmap support
seems to be flash related or any justification this is spi bus
master/controller feature?

thanks!
-- 
Jagan | openedev.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
