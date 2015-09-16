From: Jagan Teki <jteki-oRp2ZoJdM/RWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 1/5] spi: introduce mmap read support for spi flash devices
Date: Wed, 16 Sep 2015 18:16:55 +0530
Message-ID: <CAD6G_RQOazkS7KHrG75wgMXx1cH_pKjx43Mve6fz1qOJGPpq9w@mail.gmail.com>
References: <1441355402-6837-1-git-send-email-vigneshr@ti.com>
	<1441355402-6837-2-git-send-email-vigneshr@ti.com>
	<CAD6G_RT8Q+Uyp1ZjzHf54Tno1wHm0SmLKEwRAe2gkdp772FD9A@mail.gmail.com>
	<20150914183553.GE12027@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150914183553.GE12027-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 15 September 2015 at 00:05, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Fri, Sep 04, 2015 at 04:55:33PM +0530, Jagan Teki wrote:
>> On 4 September 2015 at 13:59, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org> wrote:
>
>> > + * @spi_mtd_mmap_read: some spi-controller hardwares provide memory
>> > + *                     mapped interface to communicate with mtd flashes.
>> > + *                     For this, spi  controller needs to know flash
>> > + *                     memory settings like read command to use, dummy
>> > + *                     bytes and address width. Once these settings are
>> > + *                     populated in hardware registers, any read
>> > + *                     accesses to flash's memory map region(as defined
>> > + *                     by SoC) through memcpy or mem-to-mem DMA copy
>> > + *                     will be handled by controller hardware. The
>> > + *                     hardware will automatically generate spi signals
>> > + *                     required to read data from flash and present it
>> > + *                     to CPU or DMA. SPI master drivers can use this
>> > + *                     callback to implement memory mapped read
>> > + *                     interface. Flash driver (like m25p80) requests
>> > + *                     memory mapped read via this method. The interface
>> > + *                     should  only be used mtd flashes and cannot be
>> > + *                     used with other spi devices.
>
> This comment is *way* too verbose - probably you just need up to the
> "Once" here.
>
>> > +       int (*spi_mtd_mmap_read)(struct  spi_device *spi,
>> > +                                loff_t from, size_t len, size_t *retlen,
>> > +                                u_char *buf, u8 read_opcode,
>> > +                                u8 addr_width, u8 dummy_bytes);
>
>> This looks un-manageable to know spi core or master knows what are the
>> command or opcode used by spi-nor flash and also I think mmap support
>> seems to be flash related or any justification this is spi bus
>> master/controller feature?
>
> There seem to be a reasonable number of SPI controllers out there which
> have as an extension the ability to do memory mapped reads but are
> otherwise perfectly normal SPI controllers and which rely on that for
> everything except reads.

This is true, but exposing direct spi-nor arguments or features like
read_opcode, addr_width or dummy_byte to spi layer isn't fine? because
for spi layer there is a spi to flash transition mtd m25p80.c is there
to handle is it?

thanks!
-- 
Jagan | openedev.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
