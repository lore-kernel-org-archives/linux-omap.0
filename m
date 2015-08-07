From: Michal Suchanek <hramrach@gmail.com>
Subject: Re: [RFC PATCH 1/5] spi: introduce flag for memory mapped read
Date: Fri, 7 Aug 2015 12:16:38 +0200
Message-ID: <CAOMqctScUybdoZPgqH185qzDxB=TyutDMARextHx0XwC7L3Xmw@mail.gmail.com>
References: <20150805115013.GJ20873@sirena.org.uk> <CAOMqctQXwcHyiWBwtugSDSE_k65qrNfrwnhjQMDJkLoJMmGzUw@mail.gmail.com>
 <20150805124412.GN20873@sirena.org.uk> <CAOMqctS9Y5FxpUCCJew6+cnjH5iTvbzkH3g-8yrXs4OuS2pSGA@mail.gmail.com>
 <20150806090202.GO20873@sirena.org.uk> <CAOMqctQZRZ4zG_yYy=CeX3DX4NVNWN1COP4Q-2YvMun9xYOA7g@mail.gmail.com>
 <20150806102225.GI7576@n2100.arm.linux.org.uk> <55C35233.2000105@ti.com>
 <20150806135129.GJ7576@n2100.arm.linux.org.uk> <CAMuHMdWWDwZ=ziGQXFCnOX8pErXpsEi533J73_Hh=sEqq4hR6Q@mail.gmail.com>
 <20150806213340.GK7576@n2100.arm.linux.org.uk> <55C46B84.3010304@sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55C46B84.3010304@sperl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Sperl <martin@sperl.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Geert Uytterhoeven <geert@linux-m68k.org>, Vignesh R <vigneshr@ti.com>, Mark Brown <broonie@kernel.org>, devicetree <devicetree@vger.kernel.org>, Brian Norris <computersforpeace@gmail.com>, Tony Lindgren <tony@atomide.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-spi <linux-spi@vger.kernel.org>, MTD Maling List <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 7 August 2015 at 10:25, Martin Sperl <martin@sperl.org> wrote:
> On 8/6/2015 23:33, Russell King - ARM Linux wrote:
>>
>> On Thu, Aug 06, 2015 at 06:14:00PM +0200, Geert Uytterhoeven wrote:
>>>
>>>
>>> Irrespective of the dummy bytes.
>>> What if the spi device is not a FLASH ROM, but some other device,
>>> which receives a data packet that accidentally looks like an m25p80 READ
>>> command?
>>
>> Well, for the most part it looks like it should still work, but there
>> could be a gotcha, but first, let's get rid of a myth there.
>>
>> The QSPI is _not_ specific to the M25P80.  The manual says nothing
>> about being specific to that device.  What it says is that it's for
>> SPI NOR memory.  It will work with bus widths of 1, 2 or 4 data lines,
>> so it probably works with non-M25P80 SPI NOR devices too - and the fact
>> that the read and write commands are completely programmable suggests
>> that using it with SPI NOR devices which do not use the M25P80 read
>> command value is intended.
>>
>>
>> The SFI is a state machine based translator which sits behind the SPI
>> interface (look at the manual).  It sequence sthe SPI bus through a
>> series of standard SPI states which happen to be the states I detailed
>> above.
>>
>> Now, the first byte of the SFI-generated SPI message can be programmed
>> to any 8 bit value.  So the first byte of the SPI message is totally
>> under software control.  The next one to four bytes which comprise the
>> "address" can be controlled to by deciding where in the memory map to
>> start reading from.  Hence, the value of those bytes is also totally
>> under software control.  The number of dummy bytes can be programmed
>> too.  So far so good.
>>
>> So, if we know that we have a SPI message which says "send 0x01 0x20
>> 0x30, send one dummy byte, read 32 bytes", if we program the SFI to
>> send a read command as 0x01, program an address length of 2 bytes
>> with one dummy byte, and then read the next 32 bytes at the appropriate
>> offset in the memory mapping to cause the next two bytes to be 0x20,
>> 0x30, then what we end up with on the bus is:
>>
>>         send 0x01, 0x20, 0x30
>>         send one dummy byte
>>
>> That much is good, but now is the problem - how does the SFI know that
>> we're going to require to read 32 bytes?  I think the answer to that
>> is that it doesn't know, so it probably just reads the number of bytes
>> which the access on the SoC bus is asking for, which makes it
>> indeterminant from a software point of view to control how many bytes
>> will be read without provoking another "send 0x01, next address, dummy
>> byte" sequence.
>>
>> So, I'm now on the side of not parsing commands in the SPI driver, and
>> back on the idea that this needs to be handled in some other manner
>> which doesn't involve polluting the SPI core with flag-hacks.
>>
> So I see 2 distinct options:
>
> Have the nor driver modified to run SPI commands and then ask the
> SPI framework (and driver) to switch into mmap mode:
>
> Would probably look something like this inside the nor driver:
>    /* lock spi bus for other activities */
>    spi_bus_lock(spi);
>    /* send the "configuration" for mmap */
>    t[0].tx_buf = flash->command;
>    t[0].len = m25p_cmdsz(nor);
>    spi_message_add_tail(&t[0], &m);
>    t[1].tx_buf = dummy_buffer;
>    t[1].len = dummy;
>    spi_message_add_tail(&t[1], &m);
>    spi_sync(spi, &m);

>    /* switch to mmap mode */
>    spi->mode |= SPI_MMAP;

Presumably you will do this *before* sending the read command so the
SPI driver can reverse-engineer it according to the spi-nor read
pattern.

Then the mmap mode can be set in spi_sync() but you also have to lock
the spi controller to prevent other transfers from resetting it.

Or you can pass the read buffer to the SPI master driver as well to do
the memcpy for you. Which you want to do anyway in case the SPI master
can use DMA to fill the buffer rather than memcpy.

>    spi_setup(spi);
>    /* run the mmapped transfers bypassing the spi-layer */
>    memcpy(...)
>    /* open questions here: which address range
>     * and how to detect if transfer is done
> */

Presumably when the memcpy ends the transfer is done.

> /* restore back to "normal" mode */
>    spi->mode &= ~SPI_MMAP;
>    spi_setup(spi);
>    /* unlock spi bus for other activities */
>    spi_bus_unlock(spi);

Presumably you have to restore to non-mmap mode only when you receive
a command that requires it. If the next command is read with same
configuration you can just keep reading.

>
> The downside is that it requires modification in several places
> (nor-framework, spi-framework plus the driver) and it would not
> be generic enough...

You only need modification to the SPI master driver and m25p80 driver.

The SPI master driver is where the hardware-specific operation is
executed and m25p80 is where you have the information so you can
decide to take advantage of the hardware acceleration.

>
> IMO such a situation is feasible if we only got a single device
> on the spi-bus, but leaves a lot of questions open...
> Alternatively we could create an additional api.

The spi master driver can track what mode is set on the controller and
change it as needed before each transfer. This is what is commonly
done for other SPI master hardware configuration options.

>
> On the other end of spectrum could be a solution where the
> spi-master driverwould have the opportunity to query the
> device-tree for specific propertiesduring the spi_add_device
> phase - in this case querying the followingproperty in the
> device-tree:
>   spi-master-XXX,use-mmap-cmd-mode = <0x08 0x38>;
> to implement mmap-mode for commands 0x08 and 0x38.

This is bogus.

Firstly this is per-slave and not per-master.

Secondly in devicetree you have jedec,spi-nor which says exactly that
the SPI slave is a device that responds to the JEDEC identify command.
Nothing more. The data returned from the identify command is used to
determine what the command opcodes are, what features are supported,
etc. So that is *not* in the dt and there is no place for hardwiring
opcodes in the dt.

> Alternatively we could also introduce generic alternate modes
> for the driver(similar to GPIO - ALT modes), but that would be
> less transparent and more hard-coded...
>
> In the end this would mean that from the nor framework side
> therewould be no change at all - it still would be issuing
> something like this:
>    /* send the "normal" block read command */
>    t[0].tx_buf = flash->command;
>    /* note that the address would be encoded here */
>    t[0].len = m25p_cmdsz(nor);
>    spi_message_add_tail(&t[0], &m);
>    /* dummy bytes could also get added to the above transfer */
>    t[1].tx_buf = dummy_buffer;
>    t[1].len = dummy;
>    spi_message_add_tail(&t[1], &m);
>    /* the real transfer */
>    t[2].rx_buf = read_buffer;
>    t[2].len = transfer_size;
>    spi_message_add_tail(&t[2], &m);
>    spi_sync(spi, &m);
>
> On the spi-master side the driver would need to run:
> *  if the spi-message (in this case the first byte) matches
>    the "allowed" command pattern:

There is no 'allowed' pattern. Any message like 1~7 bytes long can be
interpreted as read command. Unless you can tell the SPI master driver
it cannot know.

And you go the abominable route of the original patch that you compose
a SPI message in m25p80, and then decide in the SPI master driver that
you will in fact not send a SPI message and reverse-engineer what
m25p80 really meant.

On 7 August 2015 at 10:35, Vignesh R <vigneshr@ti.com> wrote:
>
>
> On 08/07/2015 01:08 PM, Michal Suchanek wrote:
>
>> Now since the description is clearer it's obvious that ti-qspi cannot
>> work fully mmapped as fsl-qspi does because the setup has to be done
>> over normal spi access and using non-m25p80 devices on the same bus is
>> a requirement.
>>
>> The place where it is known if a transfer can use the mmap access is m25p80.c
>>
>> So my suggestion is
>>
>>  - add a new method for spi master that gets the read opcode, dummy
>> length, address, address length, buffer, buffer length and performs
>> read from the flash memory in a hardware-specific way
>>
>> - add a check in m25p80.c that the master supports this feature and if
>> so use it (eg check that the method is non-null)
>>
>> Presumably if some new SPI controllers with similar feature are
>> supported in the future they can use the same inteface because you
>> pass on everything the m25p80 read knows.
>>
>
> Ok... Do you mean something like this?
>
> I will take m25p80 as example but can be expanded for any flash.
>
> In include/linux/mtd.h:
>         struct spi_mtd_config_info {
>                 struct spi_device       *spi;
>                 u32                     page_size;
>                 u8                      addr_width;
>                 u8                      erase_opcode;
>                 u8                      read_opcode;
>                 u8                      read_dummy;
>                 u8                      program_opcode;
>                 enum read_mode          flash_read;
>
>         } /* subset of struct spi_nor */
>

I would just pass these as separate arguments to the function but whatver.

> In m25p80.c:
>
>         static int m25p80_read(struct spi_nor *nor, loff_t from,
>                                 size_t len, size_t *retlen,
>                                 u_char *buf)
>         {
>                 struct spi_mtd_config_info info;
>                 struct spi_device *spi;
>
>                 if (spi->master->spi_mtd_mmap_read) {
>                   /* Populate spi_mtd_config_info */
>                   spi->master->spi_mtd_mmap_read(&info, from, len,
>                                                  retlen, buf);
>                 }
>                 else {
>                 /* no mtd specific acceleration supported try normal
>                  * SPI way of communicating with flash
>                  * continue with current code
>                  * set up spi_message and call spi_sync()
>                  */
>         }
>
>       }
>
> In spi-ti-qspi.c:
> Implement spi_mtd_mmap_read while holding master->bus_lock mutex.
>

Thanks

Michal
