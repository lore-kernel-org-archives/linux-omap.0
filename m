From: Sourav Poddar <sourav.poddar@ti.com>
Subject: Re: [PATCHv7 1/2] drivers: spi: Add qspi flash controller
Date: Wed, 31 Jul 2013 15:10:40 +0530
Message-ID: <51F8DB98.70709@ti.com>
References: <1375249673-2585-1-git-send-email-sourav.poddar@ti.com> <1375249673-2585-2-git-send-email-sourav.poddar@ti.com> <20130731074952.GA14517@radagast> <51F8D49B.2090307@ti.com> <20130731092008.GC14517@radagast>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45127 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759350Ab3GaJkx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Jul 2013 05:40:53 -0400
In-Reply-To: <20130731092008.GC14517@radagast>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: broonie@kernel.org, spi-devel-general@lists.sourceforge.net, grant.likely@linaro.org, linux-omap@vger.kernel.org, rnayak@ti.com

On Wednesday 31 July 2013 02:50 PM, Felipe Balbi wrote:
> Hi,
>
> On Wed, Jul 31, 2013 at 02:40:51PM +0530, Sourav Poddar wrote:
>>>> +#define	QSPI_FRAME_MAX			0xfff
>>> Frame max is 4096, 0x1000, right ?
>> Yes,
>> this macro was used initially to fill the register bits, where 4095 =
>> 4096 words.
>> Will change it to now.
> you can make this something like:
>
> #define QSPI_FRAME(n)		(((n) - 1)&  0xfff)
>
Yes, but now its only used in a clamp function, where I should
provide the exact value 4096. Will use your previous suggestion.
#define    QSPI_FRAME_MAX            0x1000
>>>> +static int qspi_write_msg(struct ti_qspi *qspi, struct spi_transfer *t)
>>>> +{
>>>> +	const u8 *txbuf;
>>>> +	int wlen, count, ret;
>>>> +
>>>> +	count = t->len;
>>>> +	txbuf = t->tx_buf;
>>>> +	wlen = t->bits_per_word;
>>>> +
>>>> +	while (count--) {
>>> you're decrementing count by one, but in some cases you write 4 bytes or
>>> 2 bytes... This will blow up very soon. I can already see overflows
>>> happening...
>> we write 2 bytes and 4 bytes for 16 bits_per_word and 32 bits_per_word case.
>> count is t->len, which is the total number of words to transfer. This
> t->len is total number of bytes as you can see from the documentation in
> the header:
>
> * @len: size of rx and tx buffers (in bytes)
>
> As I said before, please read the documentation.
>
>> words can be of any length (1, 2 or 4) bytes. So, I think it should be
>> decremented by 1 only.
> this is wrong.
>
hmm..got the point.
I will pass the count address also to ti_qspi_read_data/write_data and make
use of the switch statement to decrement the count.
>>>> +static int qspi_transfer_msg(struct ti_qspi *qspi, struct spi_transfer *t)
>>>> +{
>>>> +	int ret;
>>>> +
>>>> +	if (t->tx_buf) {
>>>> +		ret = qspi_write_msg(qspi, t);
>>>> +		if (ret) {
>>>> +			dev_dbg(qspi->dev, "Error while writing\n");
>>>> +			return -EINVAL;
>>> why do you change the return value from qspi_write_msg() ?
>>>
>> I  was not sure about this, I thought I had signals an ETIMEOUT during
>> timeout, So signal a invalid transfer here.
>> Do you suggest keeping ETIMEOUT here also?
> yeah, so we tell whoever called us that the transfer timed out. If you
> return -EINVAL you're telling your clients they gave you an invalid
> spi_transfer, which is not the case.
>
Ok.
>>>> +static int ti_qspi_start_transfer_one(struct spi_master *master,
>>>> +		struct spi_message *m)
>>>> +{
>>>> +	struct ti_qspi *qspi = spi_master_get_devdata(master);
>>>> +	struct spi_device *spi = m->spi;
>>>> +	struct spi_transfer *t;
>>>> +	int status = 0, ret;
>>>> +	int frame_length;
>>>> +
>>>> +	/* setup device control reg */
>>>> +	qspi->dc = 0;
>>>> +
>>>> +	if (spi->mode&   SPI_CPHA)
>>>> +		qspi->dc |= QSPI_CKPHA(spi->chip_select);
>>>> +	if (spi->mode&   SPI_CPOL)
>>>> +		qspi->dc |= QSPI_CKPOL(spi->chip_select);
>>>> +	if (spi->mode&   SPI_CS_HIGH)
>>>> +		qspi->dc |= QSPI_CSPOL(spi->chip_select);
>>>> +
>>>> +	frame_length = (m->frame_length<<   3) / spi->bits_per_word;
>>>> +
>>>> +	frame_length = clamp(frame_length, 0, QSPI_FRAME_MAX);
>>>> +
>>>> +	/* setup command reg */
>>>> +	qspi->cmd = 0;
>>>> +	qspi->cmd |= QSPI_EN_CS(spi->chip_select);
>>>> +	qspi->cmd |= QSPI_FLEN(frame_length);
>>>> +	qspi->cmd |= QSPI_WC_CMD_INT_EN;
>>>> +
>>>> +	ti_qspi_write(qspi, QSPI_WC_INT_EN, QSPI_INTR_ENABLE_SET_REG);
>>>> +
>>>> +	list_for_each_entry(t,&m->transfers, transfer_list) {
>>> no locking around list traversal ?
>>>
>> hmm..can put a spin_lock around "qspi_transfer_msg" ?
> no dude, you need to protect the access to the list. So it needs to be
> around list_for_each_entry().
>
Ok.
>>>> +static irqreturn_t ti_qspi_isr(int irq, void *dev_id)
>>>> +{
>>>> +	struct ti_qspi *qspi = dev_id;
>>>> +	u16 stat;
>>>> +
>>>> +	irqreturn_t ret = IRQ_HANDLED;
>>>> +
>>>> +	spin_lock(&qspi->lock);
>>>> +
>>>> +	stat = ti_qspi_read(qspi, QSPI_INTR_STATUS_ENABLED_CLEAR);
>>>> +
>>>> +	if (!stat) {
>>>> +		dev_dbg(qspi->dev, "No IRQ triggered\n");
>>>> +		return IRQ_NONE;
>>> leaving lock held.
>>>
>> Will add a unlock before returning.
> there's a very nice C statement, goto, which you can use here.
>
Ok.
>>>> +static irqreturn_t ti_qspi_threaded_isr(int this_irq, void *dev_id)
>>>> +{
>>>> +	struct ti_qspi *qspi = dev_id;
>>>> +	unsigned long flags;
>>>> +
>>>> +	spin_lock_irqsave(&qspi->lock, flags);
>>>> +
>>>> +	complete(&qspi->transfer_complete);
>>> you need to check if your word completion is actually set. Don't assume
>>> it's set because we might want to change the code later.
>>>
>> hmm..something like this.?
>>    if (ti_qspi_read(qspi, QSPI_SPI_STATUS_REG)&  WC)
>>          complete(&qspi->transfer_complete);
> I rather:
>
> stat = ti_qspi_read(qspi, QSPI_SPI_STATUS_REG);
>
> if (stat&  WC)
> 	complete()
>
> then, if we want to add frame interrupt handling later, we don't need to
> read status register again. In fact, to avoid reading the status
> register here, you could even cache the returned value you read in your
> hardirq handler inside your qspi struct.
>
Ok.

