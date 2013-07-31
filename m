From: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv7 1/2] drivers: spi: Add qspi flash controller
Date: Wed, 31 Jul 2013 14:40:51 +0530
Message-ID: <51F8D49B.2090307@ti.com>
References: <1375249673-2585-1-git-send-email-sourav.poddar@ti.com>
	<1375249673-2585-2-git-send-email-sourav.poddar@ti.com>
	<20130731074952.GA14517@radagast>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20130731074952.GA14517@radagast>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

HI,
On Wednesday 31 July 2013 01:19 PM, Felipe Balbi wrote:
> Hi,
>
> On Wed, Jul 31, 2013 at 11:17:52AM +0530, Sourav Poddar wrote:
>> diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
>> new file mode 100644
>> index 0000000..3d10b69
>> --- /dev/null
>> +++ b/drivers/spi/spi-ti-qspi.c
>> @@ -0,0 +1,545 @@
> <snip>
>
>> +/* Device Control */
>> +#define QSPI_DD(m, n)			(m<<  (3 + n*8))
>> +#define QSPI_CKPHA(n)			(1<<  (2 + n*8))
>> +#define QSPI_CSPOL(n)			(1<<  (1 + n*8))
>> +#define QSPI_CKPOL(n)			(1<<  (n*8))
> add spaces around the * operator
>
Ok.
>> +#define	QSPI_FRAME_MAX			0xfff
> Frame max is 4096, 0x1000, right ?
Yes,
this macro was used initially to fill the register bits, where 4095 = 
4096 words.
Will change it to now.
>> +static inline void ti_qspi_read_data(struct ti_qspi *qspi,
>> +		unsigned long reg, int wlen, u8 **rxbuf)
>> +{
>> +	switch (wlen) {
>> +	case 8:
>> +		**rxbuf = readb(qspi->base + reg);
>> +		dev_vdbg(qspi->dev, "rx done, read %02x\n", *(*rxbuf));
>> +		*rxbuf += 1;
>> +		break;
>> +	case 16:
>> +		**rxbuf = readw(qspi->base + reg);
>> +		dev_vdbg(qspi->dev, "rx done, read %04x\n", *(*rxbuf));
>> +		*rxbuf += 2;
>> +		break;
>> +	case 32:
>> +		**rxbuf = readl(qspi->base + reg);
>> +		dev_vdbg(qspi->dev, "rx done, read %04x\n", *(*rxbuf));
> %08x, this was commented before.
>
Yes, My bad, will change.
>> +static int ti_qspi_setup(struct spi_device *spi)
>> +{
>> +	struct ti_qspi	*qspi = spi_master_get_devdata(spi->master);
>> +	struct ti_qspi_regs *ctx_reg =&qspi->ctx_reg;
>> +	int clk_div = 0, ret;
>> +	u32 clk_ctrl_reg, clk_rate, clk_mask;
>> +
>> +	clk_rate = clk_get_rate(qspi->fclk);
>> +
>> +	if (!qspi->spi_max_frequency) {
>> +		dev_err(qspi->dev, "spi max frequency not defined\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	clk_div = DIV_ROUND_UP(clk_rate, qspi->spi_max_frequency) - 1;
>> +
>> +	dev_dbg(qspi->dev, "%s: hz: %d, clock divider %d\n", __func__,
>> +			qspi->spi_max_frequency, clk_div);
>> +
>> +	ret = pm_runtime_get_sync(qspi->dev);
>> +	if (ret) {
>> +		dev_err(qspi->dev, "pm_runtime_get_sync() failed\n");
>> +		return ret;
>> +	}
>> +
>> +	clk_ctrl_reg = ti_qspi_read(qspi, QSPI_SPI_CLOCK_CNTRL_REG);
>> +
>> +	clk_ctrl_reg&= ~QSPI_CLK_EN;
>> +
>> +	if (spi->master->busy) {
>> +		dev_dbg(qspi->dev, "master busy doing other trasnfers\n");
>> +		return -EBUSY;
>> +	}
> this check can be done before pm_runtime_get_sync(), you're also leaking
> pm_runtime reference here.
>
true. Will shift.
>> +	/* disable SCLK */
>> +	ti_qspi_write(qspi, clk_ctrl_reg, QSPI_SPI_CLOCK_CNTRL_REG);
>> +
>> +	if (clk_div<  0) {
>> +		dev_dbg(qspi->dev, "%s: clock divider<  0, using /1 divider\n",
>> +				__func__);
>> +		pm_runtime_put_sync(qspi->dev);
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (clk_div>  QSPI_CLK_DIV_MAX) {
>> +		dev_dbg(qspi->dev, "%s: clock divider>%d , using /%d divider\n",
>> +			__func__, QSPI_CLK_DIV_MAX, QSPI_CLK_DIV_MAX + 1);
>> +		pm_runtime_put_sync(qspi->dev);
>> +		return -EINVAL;
>> +	}
> why don't you move all checks to clk_div before pm_runtime_get_sync()
> call ?
>
Make sense. Will move.
>> +static int qspi_write_msg(struct ti_qspi *qspi, struct spi_transfer *t)
>> +{
>> +	const u8 *txbuf;
>> +	int wlen, count, ret;
>> +
>> +	count = t->len;
>> +	txbuf = t->tx_buf;
>> +	wlen = t->bits_per_word;
>> +
>> +	while (count--) {
> you're decrementing count by one, but in some cases you write 4 bytes or
> 2 bytes... This will blow up very soon. I can already see overflows
> happening...
we write 2 bytes and 4 bytes for 16 bits_per_word and 32 bits_per_word case.
count is t->len, which is the total number of words to transfer. This
words can be of any length (1, 2 or 4) bytes. So, I think it should be
decremented by 1 only.
>> +static int qspi_read_msg(struct ti_qspi *qspi, struct spi_transfer *t)
>> +{
>> +	u8 *rxbuf;
>> +	int wlen, count, ret;
>> +
>> +	count = t->len;
>> +	rxbuf = t->rx_buf;
>> +	wlen = t->bits_per_word;
>> +
>> +	while (count--) {
> ditto
>
>> +static int qspi_transfer_msg(struct ti_qspi *qspi, struct spi_transfer *t)
>> +{
>> +	int ret;
>> +
>> +	if (t->tx_buf) {
>> +		ret = qspi_write_msg(qspi, t);
>> +		if (ret) {
>> +			dev_dbg(qspi->dev, "Error while writing\n");
>> +			return -EINVAL;
> why do you change the return value from qspi_write_msg() ?
>
I  was not sure about this, I thought I had signals an ETIMEOUT during
timeout, So signal a invalid transfer here.
Do you suggest keeping ETIMEOUT here also?

>> +		}
>> +	}
>> +
>> +	if (t->rx_buf) {
>> +		ret = qspi_read_msg(qspi, t);
>> +		if (ret) {
>> +			dev_dbg(qspi->dev, "Error while writing\n");
>> +			return -EINVAL;
> why do you change the return value from qspi_read_msg() ?
>
>> +static int ti_qspi_start_transfer_one(struct spi_master *master,
>> +		struct spi_message *m)
>> +{
>> +	struct ti_qspi *qspi = spi_master_get_devdata(master);
>> +	struct spi_device *spi = m->spi;
>> +	struct spi_transfer *t;
>> +	int status = 0, ret;
>> +	int frame_length;
>> +
>> +	/* setup device control reg */
>> +	qspi->dc = 0;
>> +
>> +	if (spi->mode&  SPI_CPHA)
>> +		qspi->dc |= QSPI_CKPHA(spi->chip_select);
>> +	if (spi->mode&  SPI_CPOL)
>> +		qspi->dc |= QSPI_CKPOL(spi->chip_select);
>> +	if (spi->mode&  SPI_CS_HIGH)
>> +		qspi->dc |= QSPI_CSPOL(spi->chip_select);
>> +
>> +	frame_length = (m->frame_length<<  3) / spi->bits_per_word;
>> +
>> +	frame_length = clamp(frame_length, 0, QSPI_FRAME_MAX);
>> +
>> +	/* setup command reg */
>> +	qspi->cmd = 0;
>> +	qspi->cmd |= QSPI_EN_CS(spi->chip_select);
>> +	qspi->cmd |= QSPI_FLEN(frame_length);
>> +	qspi->cmd |= QSPI_WC_CMD_INT_EN;
>> +
>> +	ti_qspi_write(qspi, QSPI_WC_INT_EN, QSPI_INTR_ENABLE_SET_REG);
>> +
>> +	list_for_each_entry(t,&m->transfers, transfer_list) {
> no locking around list traversal ?
>
hmm..can put a spin_lock around "qspi_transfer_msg" ?
                 spin_lock_irqsave(&qspi->lock, flags);
                 ret = qspi_transfer_msg(qspi, t);
                 if (ret) {
                         dev_dbg(qspi->dev, "transfer message failed\n");
                         return -EINVAL;
                 }
                 spin_unlock_irqrestore(&qspi->lock, flags);
>> +static irqreturn_t ti_qspi_isr(int irq, void *dev_id)
>> +{
>> +	struct ti_qspi *qspi = dev_id;
>> +	u16 stat;
>> +
>> +	irqreturn_t ret = IRQ_HANDLED;
>> +
>> +	spin_lock(&qspi->lock);
>> +
>> +	stat = ti_qspi_read(qspi, QSPI_INTR_STATUS_ENABLED_CLEAR);
>> +
>> +	if (!stat) {
>> +		dev_dbg(qspi->dev, "No IRQ triggered\n");
>> +		return IRQ_NONE;
> leaving lock held.
>
Will add a unlock before returning.
>> +static irqreturn_t ti_qspi_threaded_isr(int this_irq, void *dev_id)
>> +{
>> +	struct ti_qspi *qspi = dev_id;
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&qspi->lock, flags);
>> +
>> +	complete(&qspi->transfer_complete);
> you need to check if your word completion is actually set. Don't assume
> it's set because we might want to change the code later.
>
hmm..something like this.?
   if (ti_qspi_read(qspi, QSPI_SPI_STATUS_REG) & WC)
         complete(&qspi->transfer_complete);
>> +static int ti_qspi_probe(struct platform_device *pdev)
>> +{
>> +	struct  ti_qspi *qspi;
>> +	struct spi_master *master;
>> +	struct resource         *r;
>> +	struct device_node *np = pdev->dev.of_node;
>> +	u32 max_freq;
>> +	int ret = 0, num_cs, irq;
>> +
>> +	master = spi_alloc_master(&pdev->dev, sizeof(*qspi));
>> +	if (!master)
>> +		return -ENOMEM;
>> +
>> +	master->mode_bits = SPI_CPOL | SPI_CPHA;
>> +
>> +	master->bus_num = -1;
>> +	master->flags = SPI_MASTER_HALF_DUPLEX;
>> +	master->setup = ti_qspi_setup;
>> +	master->auto_runtime_pm = true;
>> +	master->transfer_one_message = ti_qspi_start_transfer_one;
>> +	master->dev.of_node = pdev->dev.of_node;
>> +	master->bits_per_word_mask = BIT(32 - 1) | BIT(16 - 1) | BIT(8 - 1);
>> +
>> +	if (!of_property_read_u32(np, "num-cs",&num_cs))
>> +		master->num_chipselect = num_cs;
>> +
>> +	platform_set_drvdata(pdev, master);
>> +
>> +	qspi = spi_master_get_devdata(master);
>> +	qspi->master = master;
>> +	qspi->dev =&pdev->dev;
>> +
>> +	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +
>> +	irq = platform_get_irq(pdev, 0);
>> +	if (irq<  0) {
>> +		dev_err(&pdev->dev, "no irq resource?\n");
>> +		return irq;
>> +	}
>> +
>> +	spin_lock_init(&qspi->lock);
>> +
>> +	qspi->base = devm_ioremap_resource(&pdev->dev, r);
>> +	if (IS_ERR(qspi->base)) {
>> +		ret = PTR_ERR(qspi->base);
>> +		goto free_master;
>> +	}
>> +
>> +	ret = devm_request_threaded_irq(&pdev->dev, irq, ti_qspi_isr,
>> +			ti_qspi_threaded_isr, 0,
>> +			dev_name(&pdev->dev), qspi);
>> +	if (ret<  0) {
>> +		dev_err(&pdev->dev, "Failed to register ISR for IRQ %d\n",
>> +				irq);
>> +		goto free_master;
>> +	}
>> +
>> +	qspi->fclk = devm_clk_get(&pdev->dev, "fck");
>> +	if (IS_ERR(qspi->fclk)) {
>> +		ret = PTR_ERR(qspi->fclk);
>> +		dev_err(&pdev->dev, "could not get clk: %d\n", ret);
>> +	}
>> +
>> +	init_completion(&qspi->transfer_complete);
>> +
>> +	pm_runtime_use_autosuspend(&pdev->dev);
>> +	pm_runtime_set_autosuspend_delay(&pdev->dev, QSPI_AUTOSUSPEND_TIMEOUT);
>> +	pm_runtime_enable(&pdev->dev);
>> +
>> +	if (!of_property_read_u32(np, "spi-max-frequency",&max_freq))
>> +		qspi->spi_max_frequency = max_freq;
>> +
>> +	ret = spi_register_master(master);
>> +	if (ret)
>> +		goto free_master;
>> +
>> +	return ret;
> you only get here with success, so return 0 is alright.
>
Ok.


------------------------------------------------------------------------------
Get your SQL database under version control now!
Version control is standard for application code, but databases havent 
caught up. So what steps can you take to put your SQL databases under 
version control? Why should you start doing it? Read more to find out.
http://pubads.g.doubleclick.net/gampad/clk?id=49501711&iu=/4140/ostg.clktrk
