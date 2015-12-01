From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH v4 2/5] spi: spi-ti-qspi: add mmap mode read support
Date: Tue, 1 Dec 2015 13:14:33 +0530
Message-ID: <565D4FE1.50704@ti.com>
References: <1448860515-28336-1-git-send-email-vigneshr@ti.com>
 <1448860515-28336-3-git-send-email-vigneshr@ti.com>
 <87lh9f15fh.fsf@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87lh9f15fh.fsf@saruman.tx.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Brian Norris <computersforpeace@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Russell King <linux@arm.linux.org.uk>, "hramrach@gmail.com" <hramrach@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Felipe,

On 12/01/2015 04:05 AM, Balbi, Felipe wrote:
> 
> Hi,
> 
> Vignesh R <vigneshr@ti.com> writes:
[...]
>> +}
>> +
>> +static int ti_qspi_spi_flash_read(struct  spi_device *spi,
>> +				  struct spi_flash_read_message *msg)
>> +{
>> +	struct ti_qspi *qspi = spi_master_get_devdata(spi->master);
>> +	int ret = 0;
>> +
>> +	mutex_lock(&qspi->list_lock);
>> +
>> +	if (!qspi->mmap_enabled)
>> +		ti_qspi_enable_memory_map(spi);
>> +	ti_qspi_setup_mmap_read(spi, msg);
>> +	memcpy_fromio(msg->buf, qspi->mmap_base + msg->from, msg->len);
>> +	msg->retlen = msg->len;
> 
> the way I have always expected this to work was that spi controller
> would setup the mmap region (using ranges?) and pass the base address to
> the SPI NOR flash instead, so that could call standard
> write[bwl]/read[bwl] functions.
> 
> I mean, when we're dealing with AXI, AHB, PCI, OCP, whatever we
> completely ignore these details, why should SPI be different ? If it's
> memory mapped, the SW view of the thing is a piece of memory and that
> should be accessible with standard {read,write}[bwl]() calls.
> 

This is just an acceleration provided to improve flash read speeds.
Whenever there is an access to QSPI memory map region, there is a
SFI_MM_IF block in QSPI IP that generates SPI bus signals in order fetch
the data from flash. This SFI_MM_IF must first be configured with flash
specific information like read opcode, read mode, dummy bytes etc (which
may vary from flash to flash), by writing to QSPI_SPI_SETUP*_REG also,
SFI_MM_IF needs to be selected by writing to QSPI_SPI_SWITCH_REG.
IMO, there has to be a call from spi-nor to ti-qspi before using
standard {read,write}[bwl]() calls for populating flash info, power mgmt
and locking SPI bus.

> I really think $subject is not a good way forward because it gives too
> much responsibility to the SPI controller driver; note that this driver
> is the one actually accessing the memory map region, instead of simply
> setting it up and passing it along.
> 

How would you propose to setup mmap transfers while taking care of SPI
bus locking and passing of flash info to ti-qspi?


> So the way I see it, the DTS should be like so:
> 
> qspi@XYZ {
>          reg = <XYZ foo>;
>          [...]
>          ranges = <0 0 0x30000000 $size>;
> 
>          flash@0,0 {
>                    compatible = "mp2580";
>                    reg = <0 0 $flash_size>;
>          };
> };
> 
> 
> if you have more than one device sitting on this SPI bus using different
> chip selects, that's easy too, just change your ranges property:
> 
> qspi@XYZ {
>          reg = <XYZ foo>;
>          [...]
>          ranges = <0 0 0x30000000 0x1000
>                    1 0 0x30001000 0x1000
>                    2 0 0x30002000 0x1000>;
> 
>          flash@0,0 {
>                  [...]
>          };
> 
>          flash@1,0 {
>                    [...]
>          };
> 
>          flash@2,0 {
>                    [...]
> 	};
> };
> 

No, even if there are multiple slaves, all slaves map to the same start
address (0x30000000 in above example). Based on the chip-select line
that is asserted (selected by writing to a particular CTRL_MODULE
register field), the corresponding slave responds. Different slaves
cannot be mapped to different address ranges inside mmap address space.
The ranges property will always be the same for all slaves and all
chip-selects.

> and so on. From ti-qspi perspective, you should just setup the memory
> map and from mp25p80 you would check if your reg property pointed to an
> address that looks like memory, then ioremap it and use tradicional
> {read,write}[bwl]() accessors. Any reasons why that wasn't done the way
> pointed out above ?
> 

There might be a SPI controller that provides accelerated interface for
SPI flash read not as a memory mapping but some-other way. Brian Norris
has pointed out that there is at least one other controller which
provides such acceleration w/o memory mapping[1] May be Brian can
explain that better?


[1]https://lkml.org/lkml/2015/11/10/618

-- 
Regards
Vignesh
