From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH 3/3] spi: omap2-mcspi: Add slave mode support
Date: Mon, 15 Oct 2018 15:12:38 +0530
Message-ID: <28333ef8-22ca-e95f-b9d5-c0aeece20603@ti.com>
References: <20181015063829.26978-1-vigneshr@ti.com>
 <20181015063829.26978-4-vigneshr@ti.com>
 <2bef1218-ef43-cdc1-303f-b85863887a6b@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2bef1218-ef43-cdc1-303f-b85863887a6b@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>, Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Sekhar,

On Monday 15 October 2018 01:53 PM, Sekhar Nori wrote:

[...]
>>  
>> +static irqreturn_t omap2_mcspi_irq_handler(int irq, void *data)
>> +{
>> +	struct omap2_mcspi *mcspi = data;
>> +	u32 irqstat;
>> +
>> +	irqstat	= mcspi_read_reg(mcspi->master, OMAP2_MCSPI_IRQSTATUS);
>> +	if (!irqstat)
>> +		return IRQ_NONE;
>> +
>> +	/* Disable IRQ and wakeup slave xfer task */
>> +	mcspi_write_reg(mcspi->master, OMAP2_MCSPI_IRQENABLE, 0);
>> +	if (irqstat & OMAP2_MCSPI_IRQSTATUS_EOW)
>> +		complete(&mcspi->txdone);
>> +
>> +	return IRQ_HANDLED;
> 
> You need to have the:
> 
> pm_runtime_get_sync();
> 
> /* access registers */
> 
> pm_runtime_mark_last_busy();
> pm_runtime_put_autosuspend();
> 
> sequence here. I think thats also missing from the dma callbacks.
> Probably working by chance today.
> 

This is taken care of by the SPI core as part of __spi_pump_messages():
pm_runtime_get_sync()
...
spi_transfer_one_message
...
	omap2_mcspi_transfer_one
	...
		omap2_mcspi_txrx_dma

So, both in dma callbacks and in IRQ handler, SPI controller is in
active state.


-- 
Regards
Vignesh
