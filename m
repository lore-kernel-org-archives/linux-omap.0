From: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv4 2/3] drivers: spi: Add qspi flash controller
Date: Thu, 18 Jul 2013 17:15:45 +0530
Message-ID: <51E7D569.2010709@ti.com>
References: <1374141687-10790-1-git-send-email-sourav.poddar@ti.com>
	<1374141687-10790-3-git-send-email-sourav.poddar@ti.com>
	<20130718104233.GG22506@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20130718104233.GG22506-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: rnayak-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thursday 18 July 2013 04:12 PM, Mark Brown wrote:
> On Thu, Jul 18, 2013 at 03:31:26PM +0530, Sourav Poddar wrote:
>
>> QSPI is a kind of spi module that allows single,
>> dual and quad read access to external spi devices. The module
>> has a memory mapped interface which provide direct interface
>> for accessing data form external spi devices.
> Have you seen the ongoing thread about SPI buses with extra data lines?
> How does this driver fit in with that?
>
I have tried using it in my patch3 of this series..
>> --- a/drivers/spi/Makefile
>> +++ b/drivers/spi/Makefile
>> @@ -46,6 +46,7 @@ obj-$(CONFIG_SPI_OCTEON)		+= spi-octeon.o
>>   obj-$(CONFIG_SPI_OMAP_UWIRE)		+= spi-omap-uwire.o
>>   obj-$(CONFIG_SPI_OMAP_100K)		+= spi-omap-100k.o
>>   obj-$(CONFIG_SPI_OMAP24XX)		+= spi-omap2-mcspi.o
>> +obj-$(CONFIG_QSPI_DRA7xxx)              += spi-ti-qspi.o
>>   obj-$(CONFIG_SPI_ORION)			+= spi-orion.o
>>   obj-$(CONFIG_SPI_PL022)			+= spi-pl022.o
>>   obj-$(CONFIG_SPI_PPC4xx)		+= spi-ppc4xx.o
> Please use SPI_ like the other drivers.
>
Ok.
>> +static int ti_qspi_prepare_xfer(struct spi_master *master)
>> +{
>> +	struct ti_qspi *qspi = spi_master_get_devdata(master);
>> +	int ret;
>> +
>> +	ret = pm_runtime_get_sync(qspi->dev);
>> +	if (ret<  0) {
>> +		dev_err(qspi->dev, "pm_runtime_get_sync() failed\n");
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
> This is a very common pattern, it should probably be factored out into
> the core, probably not even as ops but rather as an actual feature.
>
May be yes.
>> +	list_for_each_entry(t,&m->transfers, transfer_list) {
>> +		qspi->cmd |= QSPI_WLEN(t->bits_per_word);
>> +		qspi->cmd |= QSPI_WC_CMD_INT_EN;
>> +
>> +		ret = qspi_transfer_msg(qspi, t);
>> +		if (ret) {
>> +			dev_dbg(qspi->dev, "transfer message failed\n");
>> +			return -EINVAL;
>> +		}
>> +
>> +		m->actual_length += t->len;
>> +
>> +		if (list_is_last(&t->transfer_list,&m->transfers))
>> +			goto out;
>> +	}
> The use of list_is_last() here is *realy* strange - what's going on
> there?
>
We are checking if there is any transfer left, if no we are signalling the
flash device about the end of transfer.
>> +static irqreturn_t ti_qspi_isr(int irq, void *dev_id)
>> +{
>> +	struct ti_qspi *qspi = dev_id;
>> +	u16 mask, stat;
>> +
>> +	irqreturn_t ret = IRQ_HANDLED;
>> +
>> +	spin_lock(&qspi->lock);
>> +
>> +	stat = ti_qspi_readl(qspi, QSPI_SPI_STATUS_REG);
>> +	mask = ti_qspi_readl(qspi, QSPI_INTR_ENABLE_SET_REG);
>> +
>> +	if (stat&&  mask)
>> +		ret = IRQ_WAKE_THREAD;
>> +
>> +	spin_unlock(&qspi->lock);
>> +
>> +	return ret;
> According to the above code we might interrupt for masked events...
> that's a bit worrying isn't it?
>
Yes, there is WC interrupt enable bit which enables the interrupt. This 
interrupt
gets disabled by writing to the CLEAR reg in the threaded irq.
>> +	ret = devm_request_threaded_irq(&pdev->dev, irq, ti_qspi_isr,
>> +			ti_qspi_threaded_isr, IRQF_NO_SUSPEND | IRQF_ONESHOT,
>> +			dev_name(&pdev->dev), qspi);
>> +	if (ret<  0) {
>> +		dev_err(&pdev->dev, "Failed to register ISR for IRQ %d\n",
>> +				irq);
>> +		goto free_master;
>> +	}
> Standard question about devm_request_threaded_irq() - how can we be
> certain it's safe to use during removal?
I am not sure about the exact flow. If we see the api description, it 
says about irq getting
freed automatically.
Practically, I will check that on removing the driver, cat 
/proc/interrupts  should not show
the required interrupt getting registered.
Though, I see an api also existing "devm_free_irq", which explicitly un 
allocate your irq requested
through devm_* variants.



------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
