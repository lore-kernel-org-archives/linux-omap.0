From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH] spi: ti-qspi: use 128 bit transfer mode for writing to
 flash
Date: Tue, 25 Aug 2015 12:24:53 +0530
Message-ID: <55DC113D.6000406@ti.com>
References: <1440066659-5356-1-git-send-email-vigneshr@ti.com> <20150820175514.GG12027@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150820175514.GG12027@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org



On 08/20/2015 11:25 PM, Mark Brown wrote:
> On Thu, Aug 20, 2015 at 04:00:59PM +0530, Vignesh R wrote:
> 
>> -			writeb(*txbuf, qspi->base + QSPI_SPI_DATA_REG);
>> +			if (count >= QSPI_WLEN_MAX_BYTES) {
>> +				u32 *txp = (u32 *)txbuf;
>> +
>> +				data = cpu_to_be32(*txp++);
>> +				writel(data, qspi->base +
>> +				       QSPI_SPI_DATA_REG_3);
>> +				data = cpu_to_be32(*txp++);
>> +				writel(data, qspi->base +
>> +				       QSPI_SPI_DATA_REG_2);
>> +				data = cpu_to_be32(*txp++);
>> +				writel(data, qspi->base +
>> +				       QSPI_SPI_DATA_REG_1);
>> +				data = cpu_to_be32(*txp++);
>> +				writel(data, qspi->base +
>> +				       QSPI_SPI_DATA_REG);
>> +				xfer_len = QSPI_WLEN_MAX_BYTES;
>> +				cmd |= QSPI_WLEN(QSPI_WLEN_MAX_BITS);
>> +			} else {
>> +				writeb(*txbuf, qspi->base + QSPI_SPI_DATA_REG);
>> +				cmd = qspi->cmd | QSPI_WR_SNGL;
>> +				xfer_len = wlen;
>> +				cmd |= QSPI_WLEN(wlen);
>> +			}
> 
> It's a bit sad that this isn't able to do a Duff's device type thing and
> only kicks in for the full 128 bit FIFO size, it looks like it could do
> any number of words.
> 

Yes, any number of bytes can be transfered (max 16 bytes).
I will try to work on your suggestion. Thanks!

-- 
Regards
Vignesh
