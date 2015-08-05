From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH 1/5] spi: introduce flag for memory mapped read
Date: Wed, 5 Aug 2015 07:21:00 +0200
Message-ID: <CAOMqctThys1C3vw7u8UU6iX8c9EDCWowaWg5F1O3i3X-w7KQhA@mail.gmail.com>
References: <1438072876-16338-1-git-send-email-vigneshr@ti.com>
 <1438072876-16338-2-git-send-email-vigneshr@ti.com> <20150731181745.GM20873@sirena.org.uk>
 <55BEF4AF.5090704@ti.com> <20150804155148.GR20873@sirena.org.uk> <55C0FD98.1090107@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55C0FD98.1090107-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "R, Vignesh" <vigneshr-l0cyMroinI0@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hello,

On 4 August 2015 at 19:59, R, Vignesh <vigneshr-l0cyMroinI0@public.gmane.org> wrote:
>
>
> On 8/4/2015 9:21 PM, Mark Brown wrote:
>> On Mon, Aug 03, 2015 at 10:27:19AM +0530, Vignesh R wrote:
>>
>>> @use_mmap_mode: Some SPI controller chips are optimized for interacting
>>> with serial flash memories. These chips have memory mapped interface,
>>> through which entire serial flash memory slave can be read/written as if
>>> though they are physical memories (like RAM). Using this interface,
>>> flash can be accessed using memcpy() function and the spi controller
>>> hardware will take care of communicating with serial flash over SPI.
>>> Setting this flag will indicate the SPI controller driver that the
>>> spi_message is from mtd layer to read from/write to flash. The SPI
>>> master driver can then appropriately switch the controller to memory
>>> mapped interface to read from/write to flash, based on this flag (See
>>> drivers/spi/spi-ti-qspi.c for example).
>>> NOTE: If the SPI controller chip lacks memory mapped interface, then the
>>> driver will ignore this flag and use normal SPI protocol to read
>>> from/write to flash. Communication with non-flash SPI devices is not
>>> possible using the memory mapped interface.
>>
>> I still can't tell from the above what this interface is supposed to do.
>> It sounds like the use of memory mapped mode is supposed to be
>> transparent to users, it should just affect how the controller interacts
>> with the hardware, but if that's the case why do we need to expose it to
>> users at all?  Shouldn't the driver just use memory mapped mode if it's
>> faster?
>>
>
> TI QSPI controller has two blocks:
> 1. SPI_CORE: This is generic(normal) spi mode. This can be used to
> communicate with any SPI devices (serial flashes as well as non-flash
> devices like touchscreen).
> 2. SFI_MM_IF(SPI memory mapped interface): The SFI_MM_IF block only
> allows reading and writing to an SPI flash device only. Used to speed up
> flash reads. It _cannot_ be used to communicate with non flash devices.
> Now, the spi_message that ti-qspi receives in transfer_one() callback
> can be from mtd device(in which case SFI_MM_IF can be used) or from any
> other non flash SPI device (in which case SFI_MM_IF must not be used
> instead SPI_CORE is to be used) but there is no way(is there?) to
> distinguish where spi_message is from. Therefore I introduced flag
> (use_mmap_mode) to struct spi_message. mtd driver will set flag to true,
> this helps the ti-qspi driver to determine that the user is flash device
> and thus can do read via SFI_MM_IF. If this flag is not set then the
> user is assumed to be non flash SPI driver and will use SPI_CORE block
> to communicate.
>
> On the whole, I just need a way to determine that the user is a flash
> device in order to switch to memory mapped interface.
>

Maybe it can be set on the SPI slave rather than each message.

Thanks

Michal
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
