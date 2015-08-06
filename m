From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC PATCH 1/5] spi: introduce flag for memory mapped read
Date: Thu, 6 Aug 2015 17:55:23 +0530
Message-ID: <55C35233.2000105@ti.com>
References: <20150731181745.GM20873@sirena.org.uk> <55BEF4AF.5090704@ti.com> <20150804155148.GR20873@sirena.org.uk> <55C0FD98.1090107@ti.com> <20150805115013.GJ20873@sirena.org.uk> <CAOMqctQXwcHyiWBwtugSDSE_k65qrNfrwnhjQMDJkLoJMmGzUw@mail.gmail.com> <20150805124412.GN20873@sirena.org.uk> <CAOMqctS9Y5FxpUCCJew6+cnjH5iTvbzkH3g-8yrXs4OuS2pSGA@mail.gmail.com> <20150806090202.GO20873@sirena.org.uk> <CAOMqctQZRZ4zG_yYy=CeX3DX4NVNWN1COP4Q-2YvMun9xYOA7g@mail.gmail.com> <20150806102225.GI7576@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150806102225.GI7576-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org



On 08/06/2015 03:52 PM, Russell King - ARM Linux wrote:
> On Thu, Aug 06, 2015 at 12:01:37PM +0200, Michal Suchanek wrote:
>> Disclaimer: I am not familiar with the hardware for which this patch
>> adds support.
>>
>> However, I am familiar m25p80.c and as I understand it the controller
>> is basically supposed to implement m25p80.c in hardware when this flag
>> is set.
> 
> That, to me, sounds like what you have is:
> 
> ---m25p80 specific interface--->SPI bus--->m25p80 device
> 
> Where the m25p80 specific interface does not expose direct access to the
> SPI bus?
> 

Let me give overview of ti-qspi controller:

There are two interfaces in the controller, one exposes direct access to
SPI bus and the other doesn't. It is possible to dynamically switch
between these ports by writing to QSPI_SPI_SWITCH_REG.

The two interface are [1]:
1) Generic SPI interface: (config port): with this interface, ti-qspi
controller can communicate with *any* spi device (flash and non-flash).
This interface is provides direct access to SPI bus.

2) SPI memory mapped interface (memory mapped port): This is m25p80
specific interface which can be use to read data from flash.
But if the flash has to be configured to some particular mode like QUAD
READ MODE, then the controller needs to be put in to config port to read
and modify serial flash's config register and then switch to memory
mapped port in order to read data stored on flash.

For example on DRA74 evm, if a 64 MB flash is connected as a slave,
entire flash memory is visible from 0x5C000000 to 0x5FFFFFFF L3_MAIN
address. In order to read using memory mapped port following will be the
sequence:

1.Write to flash config register via config port to switch to QUAD MODE
(or any mode that flash supports).
2. Populate QSPI_SPI_SETUP_REGx with flash read command, number of
address bytes to use and dummy bytes required.
3. Switch to memory mapped port by writing to QSPI_SPI_SWITCH_REG.
4. Now, its possible to perform read from 0x5C000000 to 0x5FFFFFFF using
memcpy. The qspi controller hardware will communicate over SPI bus and
get the data. This data is directly sent to RAM via SoC's interconnect.

Advantages of memory mapped port are: improved read performance,
MEM_TO_MEM DMA support can be added (ti-qspi hardware as such does not
provide DMA events).

Advantages of config port: can be used to communicate with *any* SPI
device, provides direct read/write access to SPI bus.

On the whole following are my requirements:
1. to be able to communicate with non -flash SPI devices via config port
( this functionality is supported by current driver, I dont want to
break it). Or pump any spi_message on to SPI bus directly.
2. take advantage of memory mapped port in order to increase read
throughput( and use dma in future) when the slave is a m25p80 type flash.
3. handle m25p80 as well as other slave on multiple chipselects.

I just need to know whether the user that requested the transfer is
m25p80 driver. If yes, ti-qspi driver can take advantage of memory
mapped interface, else just use config port to access SPI bus directly.

Writing separate driver based on spi-nor framework to interface with
m25p80 is not an option because, I would lose the ability to interface
with non-flash devices.

The spi_message that is received in transfer_one_message() is too
generic to imply the slave device that is on the other side of the wire.
IMO, the read command does not imply that the slave is m25p80 flash
(besides the read opcodes vary across vendors of m25p80 and across modes).

As Michal suggested, adding a flag to spi_device to distinguish whether
the slave is a m25p80 flash type will help spi master to handle
optimizations specific to m25p80s while being generic enough to handle
all other spi devices. Is that ok? Is there any other way to imply what
slave as at the other end?

[1] TRM: http://www.ti.com/lit/ug/spruhz6/spruhz6.pdf 24.5.4 QSPI
Functional Description
-- 
Regards
Vignesh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
