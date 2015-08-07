From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH 1/5] spi: introduce flag for memory mapped read
Date: Fri, 7 Aug 2015 09:38:48 +0200
Message-ID: <CAOMqctRBW230fA4AEhK7MyqkZY==6ENNNHE-LVm7-mHKA_VzRw@mail.gmail.com>
References: <20150805115013.GJ20873@sirena.org.uk> <CAOMqctQXwcHyiWBwtugSDSE_k65qrNfrwnhjQMDJkLoJMmGzUw@mail.gmail.com>
 <20150805124412.GN20873@sirena.org.uk> <CAOMqctS9Y5FxpUCCJew6+cnjH5iTvbzkH3g-8yrXs4OuS2pSGA@mail.gmail.com>
 <20150806090202.GO20873@sirena.org.uk> <CAOMqctQZRZ4zG_yYy=CeX3DX4NVNWN1COP4Q-2YvMun9xYOA7g@mail.gmail.com>
 <20150806102225.GI7576@n2100.arm.linux.org.uk> <55C35233.2000105@ti.com>
 <20150806135129.GJ7576@n2100.arm.linux.org.uk> <CAMuHMdWWDwZ=ziGQXFCnOX8pErXpsEi533J73_Hh=sEqq4hR6Q@mail.gmail.com>
 <20150806213340.GK7576@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150806213340.GK7576-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 6 August 2015 at 23:33, Russell King - ARM Linux
<linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org> wrote:
> On Thu, Aug 06, 2015 at 06:14:00PM +0200, Geert Uytterhoeven wrote:
>> On Thu, Aug 6, 2015 at 3:51 PM, Russell King - ARM Linux
>> <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org> wrote:
>> > On Thu, Aug 06, 2015 at 05:55:23PM +0530, Vignesh R wrote:
>> >> On the whole following are my requirements:
>> >> 1. to be able to communicate with non -flash SPI devices via config port
>> >> ( this functionality is supported by current driver, I dont want to
>> >> break it). Or pump any spi_message on to SPI bus directly.
>> >> 2. take advantage of memory mapped port in order to increase read
>> >> throughput( and use dma in future) when the slave is a m25p80 type flash.
>> >> 3. handle m25p80 as well as other slave on multiple chipselects.
>> >>
>> >> I just need to know whether the user that requested the transfer is
>> >> m25p80 driver. If yes, ti-qspi driver can take advantage of memory
>> >> mapped interface, else just use config port to access SPI bus directly.
>> >
>> > The problem with this approach is that it's an abomination.  It's adding
>> > a SPI-user specific hack which is detected by a specific driver.  That's
>> > really not sane - what happens when we have lots of these kinds of "I'm
>> > an X SPI-user" with drivers detecting that?  It's not maintainable in the
>> > long term.
>> >
>> > Yes, your requirements _today_ seem simple and easy, but you're only
>> > thinking about today, not tomorrow when you've moved on and someone else
>> > has to maintain the mess left behind (or delete it from mainline because
>> > they're sick of dealing with a hack.)
>> >
>> >> The spi_message that is received in transfer_one_message() is too
>> >> generic to imply the slave device that is on the other side of the wire.
>> >> IMO, the read command does not imply that the slave is m25p80 flash
>> >> (besides the read opcodes vary across vendors of m25p80 and across modes).
>> >
>> > I can see both sides of the argument.
>> >
>> > Mark is saying: if the SPI driver detects that the message to be transmitted
>> > is a read command followed by the appropriate number of dummy bytes, and
>> > then the data being read _and_ it's using quad-mode access, and the hardware
>> > generates _exactly_ that in hardware using the memory mapped mode, there is
>> > no reason _not_ to use the hardware to achieve that SPI transaction.  The
>> > bus activity will be identical to what happens when the SPI controller is
>> > used manually to achieve that bus sequence.
>> >
>> > You're saying: but the documentation says you can't use it for anything
>> > except m25p80.  If you look at 24.5.4.1.2, it tells you what the SFI
>> > generates on the bus, which is:
>> >
>> > 1. CS active
>> > 2. Read command byte sent
>> > 3. 1-4 address bytes sent
>> > 4. 0-3 dummy bytes sent
>> > 5. data bytes read from bus
>> > 6. CS inactive
>> >
>> > So, Mark's point is "if we can detect a transaction which fits _that_
>> > bus activity, there's no reason not to use this acceleration for the
>> > transaction."
>> >
>> > What you're failing to counter with is: we don't have enough information
>> > in the SPI driver to know how many dummy bytes there are between the
>> > address bytes and the data read from the bus.
>>
>> Irrespective of the dummy bytes.
>> What if the spi device is not a FLASH ROM, but some other device,
>> which receives a data packet that accidentally looks like an m25p80 READ
>> command?
>
> Well, for the most part it looks like it should still work, but there
> could be a gotcha, but first, let's get rid of a myth there.
>
> The QSPI is _not_ specific to the M25P80.  The manual says nothing
> about being specific to that device.  What it says is that it's for
> SPI NOR memory.  It will work with bus widths of 1, 2 or 4 data lines,
> so it probably works with non-M25P80 SPI NOR devices too - and the fact
> that the read and write commands are completely programmable suggests
> that using it with SPI NOR devices which do not use the M25P80 read
> command value is intended.
>
...
>
> That much is good, but now is the problem - how does the SFI know that
> we're going to require to read 32 bytes?  I think the answer to that
> is that it doesn't know, so it probably just reads the number of bytes
> which the access on the SoC bus is asking for, which makes it
> indeterminant from a software point of view to control how many bytes
> will be read without provoking another "send 0x01, next address, dummy
> byte" sequence.
>
> So, I'm now on the side of not parsing commands in the SPI driver, and
> back on the idea that this needs to be handled in some other manner
> which doesn't involve polluting the SPI core with flag-hacks.

OK, so we can agree that using this hardware acceleration for any kind
of transfer indiscriminately is not a very good idea.

Now since the description is clearer it's obvious that ti-qspi cannot
work fully mmapped as fsl-qspi does because the setup has to be done
over normal spi access and using non-m25p80 devices on the same bus is
a requirement.

The place where it is known if a transfer can use the mmap access is m25p80.c

So my suggestion is

 - add a new method for spi master that gets the read opcode, dummy
length, address, address length, buffer, buffer length and performs
read from the flash memory in a hardware-specific way

- add a check in m25p80.c that the master supports this feature and if
so use it (eg check that the method is non-null)

Presumably if some new SPI controllers with similar feature are
supported in the future they can use the same inteface because you
pass on everything the m25p80 read knows.

Thanks

Michal
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
