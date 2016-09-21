From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: [PATCH 2/4] drivers: iio: ti_am335x_adc: add dma support
Date: Wed, 21 Sep 2016 21:41:32 +0530
Message-ID: <20160921161134.6951-3-mugunthanvnm@ti.com>
References: <20160921161134.6951-1-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160921161134.6951-1-mugunthanvnm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-iio@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Lee Jones <lee.jones@linaro.org>, Vignesh R <vigneshr@ti.com>, "Andrew F . Davis" <afd@ti.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mugunthan V N <mugunthanvnm@ti.com>
List-Id: linux-omap@vger.kernel.org

This patch adds the required pieces to ti_am335x_adc driver for
DMA support

Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
---
 drivers/iio/adc/ti_am335x_adc.c      | 160 ++++++++++++++++++++++++++++++++++-
 include/linux/mfd/ti_am335x_tscadc.h |   7 ++
 2 files changed, 164 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index c3cfacca..89d0b07 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -30,10 +30,32 @@
 #include <linux/iio/buffer.h>
 #include <linux/iio/kfifo_buf.h>
 
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
+
+#define DMA_BUFFER_SIZE		SZ_2K
+
+struct tiadc_dma {
+	/* Filter function */
+	dma_filter_fn		fn;
+	/* Parameter to the filter function */
+	void			*param;
+	struct dma_slave_config	conf;
+	struct dma_chan		*chan;
+	dma_addr_t		addr;
+	dma_cookie_t		cookie;
+	u8			*buf;
+	bool			valid_buf_seg;
+	int			buf_offset;
+	u8			fifo_thresh;
+};
+
 struct tiadc_device {
 	struct ti_tscadc_dev *mfd_tscadc;
+	struct tiadc_dma dma;
 	struct mutex fifo1_lock; /* to protect fifo access */
 	int channels;
+	int total_ch_enabled;
 	u8 channel_line[8];
 	u8 channel_step[8];
 	int buffer_en_ch_steps;
@@ -184,6 +206,7 @@ static irqreturn_t tiadc_worker_h(int irq, void *private)
 	u16 *data = adc_dev->data;
 
 	fifo1count = tiadc_readl(adc_dev, REG_FIFO1CNT);
+
 	for (k = 0; k < fifo1count; k = k + i) {
 		for (i = 0; i < (indio_dev->scan_bytes)/2; i++) {
 			read = tiadc_readl(adc_dev, REG_FIFO1);
@@ -198,6 +221,68 @@ static irqreturn_t tiadc_worker_h(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
+static void tiadc_dma_rx_complete(void *param)
+{
+	struct iio_dev *indio_dev = param;
+	struct tiadc_device *adc_dev = iio_priv(indio_dev);
+	struct tiadc_dma *dma = &adc_dev->dma;
+	u8 *data;
+	int i;
+
+	data = dma->valid_buf_seg ? dma->buf + dma->buf_offset : dma->buf;
+	dma->valid_buf_seg = !dma->valid_buf_seg;
+
+	for (i = 0; i < dma->buf_offset; i += indio_dev->scan_bytes) {
+		iio_push_to_buffers(indio_dev, data);
+		data += indio_dev->scan_bytes;
+	}
+}
+
+static int tiadc_start_dma(struct iio_dev *indio_dev)
+{
+	struct tiadc_device *adc_dev = iio_priv(indio_dev);
+	struct tiadc_dma *dma = &adc_dev->dma;
+	struct dma_async_tx_descriptor *desc;
+
+	dma->valid_buf_seg = false;
+	dma->fifo_thresh = FIFO1_THRESHOLD;
+	/*
+	 * Make the fifo thresh as the multiple of total number of
+	 * channels enabled, so make sure that that cyclic DMA period
+	 * length is also a multiple of total number of channels
+	 * enabled. This ensures that no invalid data is reported
+	 * to the stack via iio_push_to_buffers().
+	 */
+	dma->fifo_thresh -= (dma->fifo_thresh + 1) % adc_dev->total_ch_enabled;
+	dma->buf_offset = DMA_BUFFER_SIZE / 2;
+	/* Make sure that period length is multiple of fifo thresh level */
+	dma->buf_offset -= dma->buf_offset % ((dma->fifo_thresh + 1) *
+					      sizeof(u16));
+
+	dma->conf.src_maxburst = dma->fifo_thresh + 1;
+	dmaengine_slave_config(dma->chan, &dma->conf);
+
+	desc = dmaengine_prep_dma_cyclic(dma->chan, dma->addr,
+					 dma->buf_offset * 2,
+					 dma->buf_offset, DMA_DEV_TO_MEM,
+					 DMA_PREP_INTERRUPT);
+	if (!desc)
+		return -EBUSY;
+
+	desc->callback = tiadc_dma_rx_complete;
+	desc->callback_param = indio_dev;
+
+	dma->cookie = dmaengine_submit(desc);
+
+	dma_async_issue_pending(dma->chan);
+
+	tiadc_writel(adc_dev, REG_FIFO1THR, dma->fifo_thresh);
+	tiadc_writel(adc_dev, REG_DMA1REQ, dma->fifo_thresh);
+	tiadc_writel(adc_dev, REG_DMAENABLE_SET, DMA_FIFO1);
+
+	return 0;
+}
+
 static int tiadc_buffer_preenable(struct iio_dev *indio_dev)
 {
 	struct tiadc_device *adc_dev = iio_priv(indio_dev);
@@ -218,20 +303,30 @@ static int tiadc_buffer_preenable(struct iio_dev *indio_dev)
 static int tiadc_buffer_postenable(struct iio_dev *indio_dev)
 {
 	struct tiadc_device *adc_dev = iio_priv(indio_dev);
+	struct tiadc_dma *dma = &adc_dev->dma;
 	unsigned int enb = 0;
 	u8 bit;
+	u32 irq_enable;
 
 	tiadc_step_config(indio_dev);
-	for_each_set_bit(bit, indio_dev->active_scan_mask, adc_dev->channels)
+	for_each_set_bit(bit, indio_dev->active_scan_mask, adc_dev->channels) {
 		enb |= (get_adc_step_bit(adc_dev, bit) << 1);
+		adc_dev->total_ch_enabled++;
+	}
 	adc_dev->buffer_en_ch_steps = enb;
 
+	if (dma->chan)
+		tiadc_start_dma(indio_dev);
+
 	am335x_tsc_se_set_cache(adc_dev->mfd_tscadc, enb);
 
 	tiadc_writel(adc_dev,  REG_IRQSTATUS, IRQENB_FIFO1THRES
 				| IRQENB_FIFO1OVRRUN | IRQENB_FIFO1UNDRFLW);
-	tiadc_writel(adc_dev,  REG_IRQENABLE, IRQENB_FIFO1THRES
-				| IRQENB_FIFO1OVRRUN);
+
+	irq_enable = IRQENB_FIFO1OVRRUN;
+	if (!dma->chan)
+		irq_enable |= IRQENB_FIFO1THRES;
+	tiadc_writel(adc_dev,  REG_IRQENABLE, irq_enable);
 
 	return 0;
 }
@@ -239,12 +334,18 @@ static int tiadc_buffer_postenable(struct iio_dev *indio_dev)
 static int tiadc_buffer_predisable(struct iio_dev *indio_dev)
 {
 	struct tiadc_device *adc_dev = iio_priv(indio_dev);
+	struct tiadc_dma *dma = &adc_dev->dma;
 	int fifo1count, i, read;
 
 	tiadc_writel(adc_dev, REG_IRQCLR, (IRQENB_FIFO1THRES |
 				IRQENB_FIFO1OVRRUN | IRQENB_FIFO1UNDRFLW));
 	am335x_tsc_se_clr(adc_dev->mfd_tscadc, adc_dev->buffer_en_ch_steps);
 	adc_dev->buffer_en_ch_steps = 0;
+	adc_dev->total_ch_enabled = 0;
+	if (dma->chan) {
+		tiadc_writel(adc_dev, REG_DMAENABLE_CLEAR, 0x2);
+		dmaengine_terminate_async(dma->chan);
+	}
 
 	/* Flush FIFO of leftover data in the time it takes to disable adc */
 	fifo1count = tiadc_readl(adc_dev, REG_FIFO1CNT);
@@ -430,6 +531,50 @@ static const struct iio_info tiadc_info = {
 	.driver_module = THIS_MODULE,
 };
 
+static bool the_no_dma_filter_fn(struct dma_chan *chan, void *param)
+{
+	return false;
+}
+
+static int tiadc_request_dma(struct platform_device *pdev,
+			     struct tiadc_device *adc_dev)
+{
+	struct tiadc_dma	*dma = &adc_dev->dma;
+	dma_cap_mask_t		mask;
+
+	dma->fn = the_no_dma_filter_fn;
+
+	/* Default slave configuration parameters */
+	dma->conf.direction = DMA_DEV_TO_MEM;
+	dma->conf.src_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
+	dma->conf.src_addr = adc_dev->mfd_tscadc->tscadc_phys_base + REG_FIFO1;
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_CYCLIC, mask);
+
+	/* Get a channel for RX */
+	dma->chan = dma_request_slave_channel_compat(mask,
+						     dma->fn, dma->param,
+						     adc_dev->mfd_tscadc->dev,
+						     "fifo1");
+	if (!dma->chan)
+		return -ENODEV;
+
+	/* RX buffer */
+	dma->buf = dma_alloc_coherent(dma->chan->device->dev, DMA_BUFFER_SIZE,
+				      &dma->addr, GFP_KERNEL);
+	if (!dma->buf)
+		goto err;
+
+	dev_dbg_ratelimited(adc_dev->mfd_tscadc->dev, "got dma channel\n");
+
+	return 0;
+err:
+	dma_release_channel(dma->chan);
+
+	return -ENOMEM;
+}
+
 static int tiadc_parse_dt(struct platform_device *pdev,
 			  struct tiadc_device *adc_dev)
 {
@@ -512,8 +657,14 @@ static int tiadc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, indio_dev);
 
+	err = tiadc_request_dma(pdev, adc_dev);
+	if (err && err != -ENODEV)
+		goto err_dma;
+
 	return 0;
 
+err_dma:
+	iio_device_unregister(indio_dev);
 err_buffer_unregister:
 	tiadc_iio_buffered_hardware_remove(indio_dev);
 err_free_channels:
@@ -525,8 +676,11 @@ static int tiadc_remove(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct tiadc_device *adc_dev = iio_priv(indio_dev);
+	struct tiadc_dma *dma = &adc_dev->dma;
 	u32 step_en;
 
+	if (dma->chan)
+		dma_release_channel(dma->chan);
 	iio_device_unregister(indio_dev);
 	tiadc_iio_buffered_hardware_remove(indio_dev);
 	tiadc_channels_remove(indio_dev);
diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
index e45a208..fb9dc99 100644
--- a/include/linux/mfd/ti_am335x_tscadc.h
+++ b/include/linux/mfd/ti_am335x_tscadc.h
@@ -23,6 +23,8 @@
 #define REG_IRQENABLE		0x02C
 #define REG_IRQCLR		0x030
 #define REG_IRQWAKEUP		0x034
+#define REG_DMAENABLE_SET	0x038
+#define REG_DMAENABLE_CLEAR	0x038
 #define REG_CTRL		0x040
 #define REG_ADCFSM		0x044
 #define REG_CLKDIV		0x04C
@@ -36,6 +38,7 @@
 #define REG_FIFO0THR		0xE8
 #define REG_FIFO1CNT		0xF0
 #define REG_FIFO1THR		0xF4
+#define REG_DMA1REQ		0xF8
 #define REG_FIFO0		0x100
 #define REG_FIFO1		0x200
 
@@ -126,6 +129,10 @@
 #define FIFOREAD_DATA_MASK (0xfff << 0)
 #define FIFOREAD_CHNLID_MASK (0xf << 16)
 
+/* DMA ENABLE/CLEAR Register */
+#define DMA_FIFO0		BIT(0)
+#define DMA_FIFO1		BIT(1)
+
 /* Sequencer Status */
 #define SEQ_STATUS BIT(5)
 #define CHARGE_STEP		0x11
-- 
2.10.0.129.g35f6318
