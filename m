From: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv2 04/10] spi/qspi: configure set up register for memory
 map.
Date: Tue, 10 Dec 2013 22:43:21 +0530
Message-ID: <52A74BB1.20504@ti.com>
References: <1386339891-32717-1-git-send-email-sourav.poddar@ti.com> <1386339891-32717-5-git-send-email-sourav.poddar@ti.com> <201312101357.54874.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201312101357.54874.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 10 December 2013 06:27 PM, Marek Vasut wrote:
> On Friday, December 06, 2013 at 03:24:45 PM, Sourav Poddar wrote:
>> These add api to configure set up registers which will be used
>> for memory mapped operations.
>>
>> These was provided as a pointer in the earlier patch and can be
>> used by the slave devices to configure the master controller as an
>> when required according to the usecases.
>>
>> Signed-off-by: Sourav Poddar<sourav.poddar-l0cyMroinI0@public.gmane.org>
>> ---
>>   drivers/spi/spi-ti-qspi.c |   29 +++++++++++++++++++++++++++++
>>   1 files changed, 29 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
>> index 48294d1..e4a8afc 100644
>> --- a/drivers/spi/spi-ti-qspi.c
>> +++ b/drivers/spi/spi-ti-qspi.c
>> @@ -117,6 +117,10 @@ struct ti_qspi {
>>   #define MEM_CS		(1<<  8)
>>   #define MEM_CS_DIS	(0<<  8)
>>
>> +#define QSPI_SETUP0_RD_NORMAL   (0x0<<  12)
>> +#define QSPI_SETUP0_RD_DUAL     (0x1<<  12)
>> +#define QSPI_SETUP0_RD_QUAD     (0x3<<  12)
>> +
>>   #define	QSPI_FRAME			4096
>>
>>   #define QSPI_AUTOSUSPEND_TIMEOUT         2000
>> @@ -220,6 +224,30 @@ static int ti_qspi_setup(struct spi_device *spi)
>>   	return 0;
>>   }
>>
>> +static void ti_qspi_configure_from_slave(struct spi_device *spi)
>> +{
>> +	struct ti_qspi  *qspi = spi_master_get_devdata(spi->master);
>> +	struct slave_info info = spi->info;
>> +	u32 memval, mode;
>> +
>> +	mode = spi->mode&  (SPI_RX_DUAL | SPI_RX_QUAD);
>> +	memval =  (info.read_opcode<<  0) | (info.program_opcode<<  16) |
>> +		((info.addr_width - 1)<<  8) | (info.dummy_cycles<<  10);
>> +
>> +	switch (mode) {
>> +	case SPI_RX_DUAL:
>> +		memval |= QSPI_SETUP0_RD_DUAL;
>> +		break;
>> +	case SPI_RX_QUAD:
>> +		memval |= QSPI_SETUP0_RD_QUAD;
>> +		break;
>> +	default:
> You want to catch invalid/unsupported mode here instead, so please add 'case 0:'
> for 1-bit transfer and treat default: as an error .
>
Ok. make sense. will change that in v3.
>> +		memval |= QSPI_SETUP0_RD_NORMAL;
>> +		break;
>> +	}
>> +	ti_qspi_write(qspi, memval, QSPI_SPI_SETUP0_REG);
>> +}
>> +
>>   static void ti_qspi_restore_ctx(struct ti_qspi *qspi)
>>   {
>>   	struct ti_qspi_regs *ctx_reg =&qspi->ctx_reg;
>> @@ -488,6 +516,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
>>   	master->dev.of_node = pdev->dev.of_node;
>>   	master->bits_per_word_mask = BIT(32 - 1) | BIT(16 - 1) | BIT(8 - 1);
>>   	master->mmap = true;
>> +	master->configure_from_slave = ti_qspi_configure_from_slave;
>>
>>   	if (!of_property_read_u32(np, "num-cs",&num_cs))
>>   		master->num_chipselect = num_cs;
> Best regards,
> Marek Vasut
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
