From: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Subject: Re: [RFC PATCH 1/5] spi: introduce flag for memory mapped read
Date: Fri, 07 Aug 2015 10:25:40 +0200
Message-ID: <55C46B84.3010304@sperl.org>
References: <20150805115013.GJ20873@sirena.org.uk> <CAOMqctQXwcHyiWBwtugSDSE_k65qrNfrwnhjQMDJkLoJMmGzUw@mail.gmail.com> <20150805124412.GN20873@sirena.org.uk> <CAOMqctS9Y5FxpUCCJew6+cnjH5iTvbzkH3g-8yrXs4OuS2pSGA@mail.gmail.com> <20150806090202.GO20873@sirena.org.uk> <CAOMqctQZRZ4zG_yYy=CeX3DX4NVNWN1COP4Q-2YvMun9xYOA7g@mail.gmail.com> <20150806102225.GI7576@n2100.arm.linux.org.uk> <55C35233.2000105@ti.com> <20150806135129.GJ7576@n2100.arm.linux.org.uk> <CAMuHMdWWDwZ=ziGQXFCnOX8pErXpsEi533J73_Hh=sEqq4hR6Q@mail.gmail.com> <20150806213340.GK7576@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150806213340.GK7576-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 8/6/2015 23:33, Russell King - ARM Linux wrote:
> On Thu, Aug 06, 2015 at 06:14:00PM +0200, Geert Uytterhoeven wrote:
>>
>> Irrespective of the dummy bytes.
>> What if the spi device is not a FLASH ROM, but some other device,
>> which receives a data packet that accidentally looks like an m25p80 READ
>> command?
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
>
> The SFI is a state machine based translator which sits behind the SPI
> interface (look at the manual).  It sequence sthe SPI bus through a
> series of standard SPI states which happen to be the states I detailed
> above.
>
> Now, the first byte of the SFI-generated SPI message can be programmed
> to any 8 bit value.  So the first byte of the SPI message is totally
> under software control.  The next one to four bytes which comprise the
> "address" can be controlled to by deciding where in the memory map to
> start reading from.  Hence, the value of those bytes is also totally
> under software control.  The number of dummy bytes can be programmed
> too.  So far so good.
>
> So, if we know that we have a SPI message which says "send 0x01 0x20
> 0x30, send one dummy byte, read 32 bytes", if we program the SFI to
> send a read command as 0x01, program an address length of 2 bytes
> with one dummy byte, and then read the next 32 bytes at the appropriate
> offset in the memory mapping to cause the next two bytes to be 0x20,
> 0x30, then what we end up with on the bus is:
>
> 	send 0x01, 0x20, 0x30
> 	send one dummy byte
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
>
So I see 2 distinct options:

Have the nor driver modified to run SPI commands and then ask the
SPI framework (and driver) to switch into mmap mode:

Would probably look something like this inside the nor driver:
    /* lock spi bus for other activities */
    spi_bus_lock(spi);
    /* send the "configuration" for mmap */
    t[0].tx_buf = flash->command;
    t[0].len = m25p_cmdsz(nor);
    spi_message_add_tail(&t[0], &m);
    t[1].tx_buf = dummy_buffer;
    t[1].len = dummy;
    spi_message_add_tail(&t[1], &m);
    spi_sync(spi, &m);
    /* switch to mmap mode */
    spi->mode |= SPI_MMAP;
    spi_setup(spi);
    /* run the mmapped transfers bypassing the spi-layer */
    memcpy(...)
    /* open questions here: which address range
     * and how to detect if transfer is done
*/
/* restore back to "normal" mode */
    spi->mode &= ~SPI_MMAP;
    spi_setup(spi);
    /* unlock spi bus for other activities */
    spi_bus_unlock(spi);

The downside is that it requires modification in several places
(nor-framework, spi-framework plus the driver) and it would not
be generic enough...

IMO such a situation is feasible if we only got a single device
on the spi-bus, but leaves a lot of questions open...
Alternatively we could create an additional api.

On the other end of spectrum could be a solution where the
spi-master driverwould have the opportunity to query the
device-tree for specific propertiesduring the spi_add_device
phase - in this case querying the followingproperty in the
device-tree:
   spi-master-XXX,use-mmap-cmd-mode = <0x08 0x38>;
to implement mmap-mode for commands 0x08 and 0x38.

Maybe we would want to also encode the number of address bytes
to send per command without hardcoding those values explicitly:
so maybe something like:
   spi-master-XXX,use-mmap-cmd-mode = <0x08 2> <0x38 3>;

Obviously these would need to get documented in the bindings
documentation of that driver.

Alternatively we could also introduce generic alternate modes
for the driver(similar to GPIO - ALT modes), but that would be
less transparent and more hard-coded...

In the end this would mean that from the nor framework side
therewould be no change at all - it still would be issuing
something like this:
    /* send the "normal" block read command */
    t[0].tx_buf = flash->command;
    /* note that the address would be encoded here */
    t[0].len = m25p_cmdsz(nor);
    spi_message_add_tail(&t[0], &m);
    /* dummy bytes could also get added to the above transfer */
    t[1].tx_buf = dummy_buffer;
    t[1].len = dummy;
    spi_message_add_tail(&t[1], &m);
    /* the real transfer */
    t[2].rx_buf = read_buffer;
    t[2].len = transfer_size;
    spi_message_add_tail(&t[2], &m);
    spi_sync(spi, &m);

On the spi-master side the driver would need to run:
*  if the spi-message (in this case the first byte) matches
    the "allowed" command pattern:
   * "setup" device in normal mode preparing the transfer engine
   * mode-switch to "mmapped" mode
   * copy via mmapped mode (via DMA to avoid blocking the CPU?)
   * return to "normal" mode
* else
   * run in "normal" spi mode.
(obviously it would be a bit more complicated that that).

Note that a discussion in regards to spi-master methods called
duringspi_add_device has just come up a few days ago in a
slightly differentcontext - forcing to always/never use DMA mode
for a specific spi-device on the bus (as well as tuning other
parameters per device).

Obviously the additional properties should describe required
HW behaviour and not tune the driver parameters - sys should be
used for those, but also for implementing those sys parameters we
would need those above "hooks"...

Just an idea.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
