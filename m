From: Huang Shijie <shijie8-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv2 07/10] drivers: mtd: m25p80: Adapt driver to support
 memory mapped read.
Date: Thu, 12 Dec 2013 15:55:37 +0800
Message-ID: <20131212075536.GA1596@gmail.com>
References: <1386339891-32717-1-git-send-email-sourav.poddar@ti.com>
 <1386339891-32717-8-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1386339891-32717-8-git-send-email-sourav.poddar-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, Dec 06, 2013 at 07:54:48PM +0530, Sourav Poddar wrote:
> Adapt driver to do a memory mapped read.
> @@ -109,6 +109,7 @@ struct m25p {
>  	u8			program_opcode;
>  	u8			*command;
>  	enum read_type		flash_read;
> +	void __iomem *mem_addr;

I think we can remove this field.
You can use a local variable in the m25p80_read.

>  };
>  
>  static inline struct m25p *mtd_to_m25p(struct mtd_info *mtd)
> @@ -515,6 +516,7 @@ static int m25p80_read(struct mtd_info *mtd, loff_t from, size_t len,
>  	size_t *retlen, u_char *buf)
>  {
>  	struct m25p *flash = mtd_to_m25p(mtd);
> +	struct spi_master *master = flash->spi->master;
>  	struct spi_transfer t[2];
>  	struct spi_message m;
>  	uint8_t opcode;
> @@ -523,6 +525,20 @@ static int m25p80_read(struct mtd_info *mtd, loff_t from, size_t len,
>  	pr_debug("%s: %s from 0x%08x, len %zd\n", dev_name(&flash->spi->dev),
>  			__func__, (u32)from, len);
>  
> +	if (master->mmap) {
> +		mutex_lock(&flash->lock);
> +		/* Wait till previous write/erase is done. */
> +		if (wait_till_ready(flash)) {
> +			mutex_unlock(&flash->lock);
> +			return 1;
> +		}
> +		flash->mem_addr = master->get_buf(master);
> +		memcpy(buf, flash->mem_addr + from, len);
> +		master->put_buf(master);
> +		*retlen = len;
> +		goto out;
> +	}
> +
>  	spi_message_init(&m);
>  	memset(t, 0, (sizeof t));
>  
> @@ -558,6 +574,7 @@ static int m25p80_read(struct mtd_info *mtd, loff_t from, size_t len,
>  
>  	*retlen = m.actual_length - m25p_cmdsz(flash) - dummy;
>  
> +out:
>  	mutex_unlock(&flash->lock);
>  
>  	return 0;
> @@ -1286,6 +1303,9 @@ static int m25p_probe(struct spi_device *spi)
>  		flash->addr_width = 3;
>  	}
>  
> +	if (spi->master->configure_from_slave)
> +		m25p80_fill_flash_information(flash);
> +
You have add a configure_from_slave hook in the SPI, why you also need 
a same hook in the SPI-NOR framework?

And i think the enable_mmap/disable_mmap is not needed too.

All the three hooks are used to set the SPI bus controller.

And the SPI-NOR framework only handles the issues between the 
SPI bus controller and the SPI-NOR, or the SPI-NOR controller and the
SPI-NOR.

thanks
Huang Shijie


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
