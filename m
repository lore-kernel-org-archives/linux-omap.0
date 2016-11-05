From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 2/4] drivers: iio: ti_am335x_adc: add dma support
Date: Sat, 5 Nov 2016 17:33:12 +0000
Message-ID: <85106d76-7e96-bc82-fef1-247a1793fd18@kernel.org>
References: <20161005090443.24576-1-mugunthanvnm@ti.com>
 <20161005090443.24576-3-mugunthanvnm@ti.com>
 <8ff4af23-9e90-535c-0e25-9373d845caab@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <8ff4af23-9e90-535c-0e25-9373d845caab-l0cyMroinI0@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, "Andrew F . Davis" <afd-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, John Syne <john3909-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 05/10/16 10:26, Peter Ujfalusi wrote:
> On 10/05/16 12:04, Mugunthan V N wrote:
>> This patch adds the required pieces to ti_am335x_adc driver for
>> DMA support
>>
>> Signed-off-by: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
Applied to a special branch in iio.git that I'll pull into togreg and then
push out as testing in a few minutes for the autobuilders to play with it.
(the special branch is incase Lee needs to later pull this into mfd as well).

Jonathan
>> ---
>>  drivers/iio/adc/ti_am335x_adc.c      | 148 ++++++++++++++++++++++++++++++++++-
>>  include/linux/mfd/ti_am335x_tscadc.h |   7 ++
>>  2 files changed, 152 insertions(+), 3 deletions(-)
> 
> Reviewed-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
> 
>>
>> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
>> index c3cfacca..ad9dec3 100644
>> --- a/drivers/iio/adc/ti_am335x_adc.c
>> +++ b/drivers/iio/adc/ti_am335x_adc.c
>> @@ -30,10 +30,28 @@
>>  #include <linux/iio/buffer.h>
>>  #include <linux/iio/kfifo_buf.h>
>>  
>> +#include <linux/dmaengine.h>
>> +#include <linux/dma-mapping.h>
>> +
>> +#define DMA_BUFFER_SIZE		SZ_2K
>> +
>> +struct tiadc_dma {
>> +	struct dma_slave_config	conf;
>> +	struct dma_chan		*chan;
>> +	dma_addr_t		addr;
>> +	dma_cookie_t		cookie;
>> +	u8			*buf;
>> +	int			current_period;
>> +	int			period_size;
>> +	u8			fifo_thresh;
>> +};
>> +
>>  struct tiadc_device {
>>  	struct ti_tscadc_dev *mfd_tscadc;
>> +	struct tiadc_dma dma;
>>  	struct mutex fifo1_lock; /* to protect fifo access */
>>  	int channels;
>> +	int total_ch_enabled;
>>  	u8 channel_line[8];
>>  	u8 channel_step[8];
>>  	int buffer_en_ch_steps;
>> @@ -198,6 +216,67 @@ static irqreturn_t tiadc_worker_h(int irq, void *private)
>>  	return IRQ_HANDLED;
>>  }
>>  
>> +static void tiadc_dma_rx_complete(void *param)
>> +{
>> +	struct iio_dev *indio_dev = param;
>> +	struct tiadc_device *adc_dev = iio_priv(indio_dev);
>> +	struct tiadc_dma *dma = &adc_dev->dma;
>> +	u8 *data;
>> +	int i;
>> +
>> +	data = dma->buf + dma->current_period * dma->period_size;
>> +	dma->current_period = 1 - dma->current_period; /* swap the buffer ID */
>> +
>> +	for (i = 0; i < dma->period_size; i += indio_dev->scan_bytes) {
>> +		iio_push_to_buffers(indio_dev, data);
>> +		data += indio_dev->scan_bytes;
>> +	}
>> +}
>> +
>> +static int tiadc_start_dma(struct iio_dev *indio_dev)
>> +{
>> +	struct tiadc_device *adc_dev = iio_priv(indio_dev);
>> +	struct tiadc_dma *dma = &adc_dev->dma;
>> +	struct dma_async_tx_descriptor *desc;
>> +
>> +	dma->current_period = 0; /* We start to fill period 0 */
>> +	/*
>> +	 * Make the fifo thresh as the multiple of total number of
>> +	 * channels enabled, so make sure that cyclic DMA period
>> +	 * length is also a multiple of total number of channels
>> +	 * enabled. This ensures that no invalid data is reported
>> +	 * to the stack via iio_push_to_buffers().
>> +	 */
>> +	dma->fifo_thresh = rounddown(FIFO1_THRESHOLD + 1,
>> +				     adc_dev->total_ch_enabled) - 1;
>> +	/* Make sure that period length is multiple of fifo thresh level */
>> +	dma->period_size = rounddown(DMA_BUFFER_SIZE / 2,
>> +				    (dma->fifo_thresh + 1) * sizeof(u16));
>> +
>> +	dma->conf.src_maxburst = dma->fifo_thresh + 1;
>> +	dmaengine_slave_config(dma->chan, &dma->conf);
>> +
>> +	desc = dmaengine_prep_dma_cyclic(dma->chan, dma->addr,
>> +					 dma->period_size * 2,
>> +					 dma->period_size, DMA_DEV_TO_MEM,
>> +					 DMA_PREP_INTERRUPT);
>> +	if (!desc)
>> +		return -EBUSY;
>> +
>> +	desc->callback = tiadc_dma_rx_complete;
>> +	desc->callback_param = indio_dev;
>> +
>> +	dma->cookie = dmaengine_submit(desc);
>> +
>> +	dma_async_issue_pending(dma->chan);
>> +
>> +	tiadc_writel(adc_dev, REG_FIFO1THR, dma->fifo_thresh);
>> +	tiadc_writel(adc_dev, REG_DMA1REQ, dma->fifo_thresh);
>> +	tiadc_writel(adc_dev, REG_DMAENABLE_SET, DMA_FIFO1);
>> +
>> +	return 0;
>> +}
>> +
>>  static int tiadc_buffer_preenable(struct iio_dev *indio_dev)
>>  {
>>  	struct tiadc_device *adc_dev = iio_priv(indio_dev);
>> @@ -218,20 +297,30 @@ static int tiadc_buffer_preenable(struct iio_dev *indio_dev)
>>  static int tiadc_buffer_postenable(struct iio_dev *indio_dev)
>>  {
>>  	struct tiadc_device *adc_dev = iio_priv(indio_dev);
>> +	struct tiadc_dma *dma = &adc_dev->dma;
>> +	unsigned int irq_enable;
>>  	unsigned int enb = 0;
>>  	u8 bit;
>>  
>>  	tiadc_step_config(indio_dev);
>> -	for_each_set_bit(bit, indio_dev->active_scan_mask, adc_dev->channels)
>> +	for_each_set_bit(bit, indio_dev->active_scan_mask, adc_dev->channels) {
>>  		enb |= (get_adc_step_bit(adc_dev, bit) << 1);
>> +		adc_dev->total_ch_enabled++;
>> +	}
>>  	adc_dev->buffer_en_ch_steps = enb;
>>  
>> +	if (dma->chan)
>> +		tiadc_start_dma(indio_dev);
>> +
>>  	am335x_tsc_se_set_cache(adc_dev->mfd_tscadc, enb);
>>  
>>  	tiadc_writel(adc_dev,  REG_IRQSTATUS, IRQENB_FIFO1THRES
>>  				| IRQENB_FIFO1OVRRUN | IRQENB_FIFO1UNDRFLW);
>> -	tiadc_writel(adc_dev,  REG_IRQENABLE, IRQENB_FIFO1THRES
>> -				| IRQENB_FIFO1OVRRUN);
>> +
>> +	irq_enable = IRQENB_FIFO1OVRRUN;
>> +	if (!dma->chan)
>> +		irq_enable |= IRQENB_FIFO1THRES;
>> +	tiadc_writel(adc_dev,  REG_IRQENABLE, irq_enable);
>>  
>>  	return 0;
>>  }
>> @@ -239,12 +328,18 @@ static int tiadc_buffer_postenable(struct iio_dev *indio_dev)
>>  static int tiadc_buffer_predisable(struct iio_dev *indio_dev)
>>  {
>>  	struct tiadc_device *adc_dev = iio_priv(indio_dev);
>> +	struct tiadc_dma *dma = &adc_dev->dma;
>>  	int fifo1count, i, read;
>>  
>>  	tiadc_writel(adc_dev, REG_IRQCLR, (IRQENB_FIFO1THRES |
>>  				IRQENB_FIFO1OVRRUN | IRQENB_FIFO1UNDRFLW));
>>  	am335x_tsc_se_clr(adc_dev->mfd_tscadc, adc_dev->buffer_en_ch_steps);
>>  	adc_dev->buffer_en_ch_steps = 0;
>> +	adc_dev->total_ch_enabled = 0;
>> +	if (dma->chan) {
>> +		tiadc_writel(adc_dev, REG_DMAENABLE_CLEAR, 0x2);
>> +		dmaengine_terminate_async(dma->chan);
>> +	}
>>  
>>  	/* Flush FIFO of leftover data in the time it takes to disable adc */
>>  	fifo1count = tiadc_readl(adc_dev, REG_FIFO1CNT);
>> @@ -430,6 +525,41 @@ static const struct iio_info tiadc_info = {
>>  	.driver_module = THIS_MODULE,
>>  };
>>  
>> +static int tiadc_request_dma(struct platform_device *pdev,
>> +			     struct tiadc_device *adc_dev)
>> +{
>> +	struct tiadc_dma	*dma = &adc_dev->dma;
>> +	dma_cap_mask_t		mask;
>> +
>> +	/* Default slave configuration parameters */
>> +	dma->conf.direction = DMA_DEV_TO_MEM;
>> +	dma->conf.src_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
>> +	dma->conf.src_addr = adc_dev->mfd_tscadc->tscadc_phys_base + REG_FIFO1;
>> +
>> +	dma_cap_zero(mask);
>> +	dma_cap_set(DMA_CYCLIC, mask);
>> +
>> +	/* Get a channel for RX */
>> +	dma->chan = dma_request_chan(adc_dev->mfd_tscadc->dev, "fifo1");
>> +	if (IS_ERR(dma->chan)) {
>> +		int ret = PTR_ERR(dma->chan);
>> +
>> +		dma->chan = NULL;
>> +		return ret;
>> +	}
>> +
>> +	/* RX buffer */
>> +	dma->buf = dma_alloc_coherent(dma->chan->device->dev, DMA_BUFFER_SIZE,
>> +				      &dma->addr, GFP_KERNEL);
>> +	if (!dma->buf)
>> +		goto err;
>> +
>> +	return 0;
>> +err:
>> +	dma_release_channel(dma->chan);
>> +	return -ENOMEM;
>> +}
>> +
>>  static int tiadc_parse_dt(struct platform_device *pdev,
>>  			  struct tiadc_device *adc_dev)
>>  {
>> @@ -512,8 +642,14 @@ static int tiadc_probe(struct platform_device *pdev)
>>  
>>  	platform_set_drvdata(pdev, indio_dev);
>>  
>> +	err = tiadc_request_dma(pdev, adc_dev);
>> +	if (err && err == -EPROBE_DEFER)
>> +		goto err_dma;
>> +
>>  	return 0;
>>  
>> +err_dma:
>> +	iio_device_unregister(indio_dev);
>>  err_buffer_unregister:
>>  	tiadc_iio_buffered_hardware_remove(indio_dev);
>>  err_free_channels:
>> @@ -525,8 +661,14 @@ static int tiadc_remove(struct platform_device *pdev)
>>  {
>>  	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>>  	struct tiadc_device *adc_dev = iio_priv(indio_dev);
>> +	struct tiadc_dma *dma = &adc_dev->dma;
>>  	u32 step_en;
>>  
>> +	if (dma->chan) {
>> +		dma_free_coherent(dma->chan->device->dev, DMA_BUFFER_SIZE,
>> +				  dma->buf, dma->addr);
>> +		dma_release_channel(dma->chan);
>> +	}
>>  	iio_device_unregister(indio_dev);
>>  	tiadc_iio_buffered_hardware_remove(indio_dev);
>>  	tiadc_channels_remove(indio_dev);
>> diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
>> index e45a208..b9a53e0 100644
>> --- a/include/linux/mfd/ti_am335x_tscadc.h
>> +++ b/include/linux/mfd/ti_am335x_tscadc.h
>> @@ -23,6 +23,8 @@
>>  #define REG_IRQENABLE		0x02C
>>  #define REG_IRQCLR		0x030
>>  #define REG_IRQWAKEUP		0x034
>> +#define REG_DMAENABLE_SET	0x038
>> +#define REG_DMAENABLE_CLEAR	0x03c
>>  #define REG_CTRL		0x040
>>  #define REG_ADCFSM		0x044
>>  #define REG_CLKDIV		0x04C
>> @@ -36,6 +38,7 @@
>>  #define REG_FIFO0THR		0xE8
>>  #define REG_FIFO1CNT		0xF0
>>  #define REG_FIFO1THR		0xF4
>> +#define REG_DMA1REQ		0xF8
>>  #define REG_FIFO0		0x100
>>  #define REG_FIFO1		0x200
>>  
>> @@ -126,6 +129,10 @@
>>  #define FIFOREAD_DATA_MASK (0xfff << 0)
>>  #define FIFOREAD_CHNLID_MASK (0xf << 16)
>>  
>> +/* DMA ENABLE/CLEAR Register */
>> +#define DMA_FIFO0		BIT(0)
>> +#define DMA_FIFO1		BIT(1)
>> +
>>  /* Sequencer Status */
>>  #define SEQ_STATUS BIT(5)
>>  #define CHARGE_STEP		0x11
>>
> 
> 
