From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH 2/5] spi: spi-ti-qspi: add mmap mode read support
Date: Wed, 16 Sep 2015 15:37:37 +0530
Message-ID: <55F93F69.3000901@ti.com>
References: <1441355402-6837-1-git-send-email-vigneshr@ti.com>
 <1441355402-6837-3-git-send-email-vigneshr@ti.com>
 <20150914182600.GC12027@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150914182600.GC12027@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, hramrach@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 09/14/2015 11:56 PM, Mark Brown wrote:
> On Fri, Sep 04, 2015 at 01:59:59PM +0530, Vignesh R wrote:
> 
>> +static int ti_qspi_spi_mtd_mmap_read(struct  spi_device *spi,
>> +				     loff_t from, size_t len,
>> +				     size_t *retlen, u_char *buf,
>> +				     u8 read_opcode, u8 addr_width,
>> +				     u8 dummy_bytes)
>> +{
>> +	struct ti_qspi *qspi = spi_master_get_devdata(spi->master);
>> +	int ret = 0;
>> +
>> +	spi_bus_lock(qspi->master);
> 
> I suspect I'm going to see the answer to this in another patch but the
> fact that we're having to take this lock in a driver when it's an op the
> core should be calling.
>

Agree..

>> +	ret = pm_runtime_get_sync(qspi->dev);
>> +	if (ret < 0) {
>> +		dev_err(qspi->dev, "pm_runtime_get_sync() failed\n");
>> +		return ret;
>> +	}
> 
> This would be better outside the lock, there's no need to have the lock
> before we power on and this fixes the fact that you don't release the
> lock here.

Will take care of this in SPI core API

> 
>> +	memcpy(buf, (__force void *)(qspi->mmap_base + from), len);
> 
> The fact that you're having to cast here should be a warning that
> there's someting wrong here.  I think you're looking for
> memcpy_fromio().

Ok, will change to memcpy_fromio()

> 
>> @@ -479,6 +576,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
>>  	master->setup = ti_qspi_setup;
>>  	master->auto_runtime_pm = true;
>>  	master->transfer_one_message = ti_qspi_start_transfer_one;
>> +	master->spi_mtd_mmap_read = ti_qspi_spi_mtd_mmap_read;
>>  	master->dev.of_node = pdev->dev.of_node;
>>  	master->bits_per_word_mask = SPI_BPW_MASK(32) | SPI_BPW_MASK(16) |
>>  				     SPI_BPW_MASK(8);
> 
> Don't we need to map a resource somewhere?
> 

The current driver code already does the resource mapping:

	res_mmap = platform_get_resource_byname(pdev,
			IORESOURCE_MEM, "qspi_mmap");


-- 
Thanks,
Vignesh
