From: David Lechner <david@lechnology.com>
Subject: Re: [PATCH] Revert "spi: omap2-mcspi: Set FIFO DMA trigger level to
 word length"
Date: Mon, 14 Jan 2019 17:57:06 -0600
Message-ID: <bf29d3f6-69d1-2088-6533-76b94c80711b@lechnology.com>
References: <20190113204905.29795-1-david@lechnology.com>
 <829bdc72-cf96-6aee-28d8-a47d0430710d@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <829bdc72-cf96-6aee-28d8-a47d0430710d@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>, "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Cc: Mark Brown <broonie@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 1/14/19 6:30 AM, Vignesh R wrote:
> 
> On 14/01/19 2:19 AM, David Lechner wrote:
>> This reverts commit b682cffa3ac6d9d9e16e9b413c45caee3b391fab.
>>
>> That commit breaks displays using tinydrm drivers, such as ili9225.
>>
>> It causes corruption in the image that is displayed (it looks like only
>> 1/2 of the framebuffer data is sent, the other half of the display
>> remains blank.)
>>
>> The following error appears multiple times:
>>
>>      ili9225 spi1.0: EOW timed out
>>
>> Eventually, the system locks up without any additional errors.
>>
> Oops, that's unfortunate. I see ili9225 is using bits_per_word = 16.
> I believe commit b682cffa3ac6d9d broke spi_transfers where
> bits_per_word anything other than 8 bits.
> I don't have ili9225 HW but was able emulate this condition using a SPI
> flash as slave on AM335x and successfully reproduced the issue. Could
> you test if this diff[1] helps in fixing the regression without needing
> to revert commit b682cffa3ac6d9d?
> 
> If below diff does not help, then could you post logs of types of
> spi_transfers being queued by ili9225 driver? I guess you can dump them
> by enabling DEBUG option in tinydrm-helpers.c.
> Also which TI SoC are you using?
> 
> Sorry for the trouble!
> 
> [1]:
> 
> Adjust maxburst size of DMA xfer according to the DMA trigger level and word length
> instead of just word length
> 
> 
> diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
> index 2fd8881fcd65..6b7edcff0e6b 100644
> --- a/drivers/spi/spi-omap2-mcspi.c
> +++ b/drivers/spi/spi-omap2-mcspi.c
> @@ -623,8 +623,8 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
>          cfg.dst_addr = cs->phys + OMAP2_MCSPI_TX0;
>          cfg.src_addr_width = width;
>          cfg.dst_addr_width = width;
> -       cfg.src_maxburst = es;
> -       cfg.dst_maxburst = es;
> +       cfg.src_maxburst = width / es;
> +       cfg.dst_maxburst = width / es;

Just an observation... won't `width / es` always == 1 because width is always == es?


>   
>          rx = xfer->rx_buf;
>          tx = xfer->tx_buf;
> 
