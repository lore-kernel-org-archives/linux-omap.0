From: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv2] drivers: spi: Add qspi flash controller
Date: Tue, 2 Jul 2013 16:09:19 +0530
Message-ID: <51D2ADD7.4020408@ti.com>
References: <1372755399-21769-1-git-send-email-sourav.poddar@ti.com>
	<20130702092458.GI3352@arwen.pp.htv.fi> <51D2A4CA.5030804@ti.com>
	<20130702101608.GO3352@arwen.pp.htv.fi> <51D2AA35.2070002@ti.com>
	<20130702103122.GP3352@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20130702103122.GP3352-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: rnayak-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 02 July 2013 04:01 PM, Felipe Balbi wrote:
> Hi,
>
> On Tue, Jul 02, 2013 at 03:53:49PM +0530, Sourav Poddar wrote:
>> On Tuesday 02 July 2013 03:46 PM, Felipe Balbi wrote:
>>> Hi,
>>>
>>> On Tue, Jul 02, 2013 at 03:30:42PM +0530, Sourav Poddar wrote:
>>>>>> +static int dra7xxx_qspi_setup(struct spi_device *spi)
>>>>>> +{
>>>>>> +	struct dra7xxx_qspi	*qspi =
>>>>>> +			spi_master_get_devdata(spi->master);
>>>>>> +
>>>>>> +	int clk_div;
>>>>>> +
>>>>>> +	if (!qspi->spi_max_frequency)
>>>>>> +		clk_div = 0;
>>>>> won't this generate division by zero ?
>>>>>
>>>> Yes, Probably only an error should be thrown here. ?
>>>> since min clk_div should be kept at 1.
>>> right, if spi_max_frequency isn't passed, this is a broken DT binding.
>>> Bail out.
>>>
>>>>>> +	pm_runtime_get_sync(qspi->dev);
>>>>>> +
>>>>>> +	/* disable SCLK */
>>>>>> +	dra7xxx_writel(qspi, dra7xxx_readl(qspi, QSPI_SPI_CLOCK_CNTRL_REG)
>>>>>> +			&    ~QSPI_CLK_EN, QSPI_SPI_CLOCK_CNTRL_REG);
>>>>>> +
>>>>>> +	if (clk_div<    0) {
>>> btw, add a space between clk_div and<
>>>
>>>>>> +			dra7xxx_writel(qspi, *txbuf++, QSPI_SPI_DATA_REG);
>>>>>> +			dra7xxx_writel(qspi, qspi->dc, QSPI_SPI_DC_REG);
>>>>>> +			dra7xxx_writel(qspi, qspi->cmd | QSPI_WR_SNGL,
>>>>>> +					QSPI_SPI_CMD_REG);
>>>>>> +			status = dra7xxx_readl(qspi, QSPI_SPI_STATUS_REG);
>>>>>> +			timeout = QSPI_TIMEOUT;
>>>>>> +			while ((status&    QSPI_WC_BUSY) != QSPI_XFER_DONE) {
>>>>> do you really need to poll ? No IRQ available ?
>>>>>
>>>> There is an interrupt available, I will try using that.
>>> look at how i2c-omap.c synchronizes interrupt with the transfer_msg
>>> code. It just uses a wait_for_completion().
>>>
>> Ok.
>>>>>> +static int dra7xxx_qspi_start_transfer_one(struct spi_master *master,
>>>>>> +		struct spi_message *m)
>>>>>> +{
>>>>>> +	struct dra7xxx_qspi *qspi = spi_master_get_devdata(master);
>>>>>> +	struct spi_device *spi = m->spi;
>>>>>> +	struct spi_transfer *t;
>>>>>> +	int status = 0;
>>>>>> +	int flags = 0;
>>>>>> +
>>>>>> +	/* setup command reg */
>>>>>> +	qspi->cmd = 0;
>>>>>> +	qspi->cmd |= QSPI_WLEN(8);
>>>>>> +	qspi->cmd |= QSPI_EN_CS(0);
>>>>>> +	qspi->cmd |= 0xfff;
>>>> Since, we dont know the number of frame lenght that need to be
>>>> transferred and it comes from the spi framework, we keep the frame
>>>> lenght to maximum.
>>>> Then depending on the count value above in while loop, we terminate
>>>> our trasnfer.
>>> what ? seriously didn't get what you meant.
>>>
>> I mean, the lower 12 bits of cmd register is meant to be filled with
>> frame lenght.
>>
>> But the frame lenght is parsed when you iterate the list. So, what is
> which list ?
>
message list, from which we iterate through each transfers.
>> done here is that
>> the framelenght is kept to its maximum value.
> why ? That seems wrong. If you can get the actual frame length at some
> point, that's what you should use.
>
Ok.Then probably it makes sense to have frame count interrupt also to
signal the end of frame.
>> Then, to signal the the end of the frame, we use
>>
>> static int qspi_transfer_msg(struct dra7xxx_qspi *qspi, unsigned count,
>>                          const u8 *txbuf, u8 *rxbuf, bool flags)
>> {
>>          uint status;
>>          int timeout;
>>
>>          while (count--) {
>>                  if (txbuf) {
>>                          pr_debug("tx cmd %08x dc %08x data %02x\n",
>>                                  qspi->cmd | QSPI_WR_SNGL, qspi->dc,
>> *txbuf);
>>                          dra7xxx_writel(qspi, *txbuf++, QSPI_SPI_DATA_REG);
>>                          dra7xxx_writel(qspi, qspi->dc, QSPI_SPI_DC_REG);
>>                          dra7xxx_writel(qspi, qspi->cmd | QSPI_WR_SNGL,
>>                                          QSPI_SPI_CMD_REG);
>>                          status = dra7xxx_readl(qspi, QSPI_SPI_STATUS_REG);
>>                          timeout = QSPI_TIMEOUT;
>>                          while ((status&  QSPI_WC_BUSY) != QSPI_XFER_DONE) {
>>                                  if (--timeout<  0) {
>>                                          pr_debug("QSPI tx timed out\n");
>>                                          return
>>
>>       .............................
>>
>>                                     status, *(rxbuf-1));
>>                  }
>>          }
>>
>>          if (flags&  XFER_END)
>>                  dra7xxx_writel(qspi, qspi->cmd | QSPI_INVAL,
>> QSPI_SPI_CMD_REG);
>>
>> }
>> INVAL will terminate the current frame.
> nevermind that this value is "RESERVED" on the documentation. You should
> not rely on reserved features, they can go away at any point in time.
>
> That's probably there only for some IP debugging kinda thing.
>


------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
