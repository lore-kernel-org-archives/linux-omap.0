From: Sourav Poddar <sourav.poddar@ti.com>
Subject: Re: [PATCHv6 1/2] drivers: spi: Add qspi flash controller
Date: Mon, 29 Jul 2013 16:34:41 +0530
Message-ID: <51F64C49.4080606@ti.com>
References: <1375082550-30544-1-git-send-email-sourav.poddar@ti.com> <1375082550-30544-2-git-send-email-sourav.poddar@ti.com> <20130729093128.GE23710@radagast> <51F63FF3.5070304@ti.com> <20130729102038.GK23710@radagast>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55231 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751150Ab3G2LE5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Jul 2013 07:04:57 -0400
In-Reply-To: <20130729102038.GK23710@radagast>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: broonie@kernel.org, spi-devel-general@lists.sourceforge.net, grant.likely@linaro.org, linux-omap@vger.kernel.org, rnayak@ti.com

On Monday 29 July 2013 03:50 PM, Felipe Balbi wrote:
> Hi,
>
> On Mon, Jul 29, 2013 at 03:42:03PM +0530, Sourav Poddar wrote:
>>>> +	frame_length = (m->frame_length<<   3) / spi->bits_per_word;
>>> there's another way to optimize this. If you assume bits_per_word to
>>> always be power of two you can:
>>>
>>> 	frame_length = (m->frame_length<<   3)>>   __ffs(spi->bits_per_word);
>>>
>>> but that would need a comment stating that you're assuming bits_per_word
>>> to always be a power of two. Not sure if this is a correct assumption.
>>>
>> I dont think it will be a correct assumption, since our controller is
>> flexible to
>> handle anything from 1 to 128 as bits_per_word.
> right, but can the framework handle non-power-of-two bits_per_word ?
>
The only limitation I see is the max bits_per_word, which is 32.
Though,  I did set "master->bits_per_word_mask" as power of 2
in my probe.
>>>> +	spin_unlock(&qspi->lock);
>>> You should, before releasing the lock, mask your IRQs, so that you can
>>> get rid of IRQF_ONESHOT. Unmask them before returning from the IRQ
>>> thread.
>>>
>> Sorry, did not get  you here?
>>   I am reading interrupt status register before and clearing them in
>> the threaded irq.
> you need to mask the IRQs, clear WC and FIRQ in IRQENABLE register...
> set them back at the end of the thread handler.
>
Ok
>>>> +static int ti_qspi_probe(struct platform_device *pdev)
>>>> +{
>>>> +	struct  ti_qspi *qspi;
>>>> +	struct spi_master *master;
>>>> +	struct resource         *r;
>>>> +	struct device_node *np = pdev->dev.of_node;
>>>> +	u32 max_freq;
>>>> +	int ret = 0, num_cs, irq;
>>>> +
>>>> +	master = spi_alloc_master(&pdev->dev, sizeof(*qspi));
>>>> +	if (!master)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	master->mode_bits = SPI_CPOL | SPI_CPHA;
>>>> +
>>>> +	master->num_chipselect = 1;
>>> again with the num_chipselect = 1 ? IIRC this controller has 4
>>> chipselects, just read 24.5.1 on your TRM.
>>>
>> this is unnecessary. I intended to configure chip selects through
>> dt)as done below).
>> Will remove.
> which brings me to the point of:
>
> Do you review your own code before sending it out ? Doesn't look like...
>
>>>> +	irq = platform_get_irq(pdev, 0);
>>>> +	if (irq<   0) {
>>>> +		dev_err(&pdev->dev, "no irq resource?\n");
>>>> +		return irq;
>>>> +	}
>>>> +
>>>> +	spin_lock_init(&qspi->lock);
>>>> +
>>>> +	qspi->base = devm_ioremap_resource(&pdev->dev, r);
>>>> +	if (IS_ERR(qspi->base)) {
>>>> +		ret = PTR_ERR(qspi->base);
>>>> +		goto free_master;
>>>> +	}
>>>> +
>>>> +	ret = devm_request_threaded_irq(&pdev->dev, irq, ti_qspi_isr,
>>>> +			ti_qspi_threaded_isr, IRQF_NO_SUSPEND | IRQF_ONESHOT,
>>> why do you need IRQF_NO_SUSPEND ?
>>>
>> I should get away with this.
> why ? Do you need or do you *not* need it ? And in either case, why ?
>
I was thinking, this will keep the irqs up even when we are
hitting suspend, we will not be prepared to handle it. ?

