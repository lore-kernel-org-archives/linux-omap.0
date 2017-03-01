From: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Subject: Re: [RFC PATCH 2/2] mtd: devices: m25p80: Enable spi-nor bounce
 buffer support
Date: Wed, 1 Mar 2017 11:43:48 +0100
Message-ID: <aeaf87ca-e8f5-72d0-997d-494df86abf68@atmel.com>
References: <20170227120839.16545-1-vigneshr@ti.com>
 <20170227120839.16545-3-vigneshr@ti.com>
 <aa967f6a-0526-3e33-1de7-fbe7d4264f34@nod.at>
 <8f999a27-c3ce-2650-452c-b21c3e44989d@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <8f999a27-c3ce-2650-452c-b21c3e44989d@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Vignesh R <vigneshr@ti.com>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Marek Vasut <marek.vasut@gmail.com>
Cc: Frode Isaksen <fisaksen@baylibre.com>, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Le 01/03/2017 =E0 05:54, Vignesh R a =E9crit :
> =

> =

> On Wednesday 01 March 2017 03:11 AM, Richard Weinberger wrote:
>> Vignesh,
>>
>> Am 27.02.2017 um 13:08 schrieb Vignesh R:
>>> Many SPI controller drivers use DMA to read/write from m25p80 compatible
>>> flashes. Therefore enable bounce buffers support provided by spi-nor
>>> framework to take care of handling vmalloc'd buffers which may not be
>>> DMA'able.
>>>
>>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>>> ---
>>>  drivers/mtd/devices/m25p80.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
>>> index c4df3b1bded0..d05acf22eadf 100644
>>> --- a/drivers/mtd/devices/m25p80.c
>>> +++ b/drivers/mtd/devices/m25p80.c
>>> @@ -241,6 +241,7 @@ static int m25p_probe(struct spi_device *spi)
>>>  	else
>>>  		flash_name =3D spi->modalias;
>>>  =

>>> +	nor->flags |=3D SNOR_F_USE_BOUNCE_BUFFER;
>>
>> Isn't there a better way to detect whether a bounce buffer is needed or =
not?
>

I agree with Richard: the bounce buffer should be enabled only if needed
by the SPI controller.

> Yes, I can poke the spi->master struct to see of dma channels are
> populated and request SNOR_F_USE_BOUNCE_BUFFER accordingly:
> =

> -       nor->flags |=3D SNOR_F_USE_BOUNCE_BUFFER;
> +       if (spi->master->dma_tx || spi->master->dma_rx)
> +               nor->flags |=3D SNOR_F_USE_BOUNCE_BUFFER;
> +
> =


However I don't agree with this solution: master->dma_{tx|rx} can be set
for SPI controllers which already rely on spi_map_msg() to handle
vmalloc'ed memory during DMA transfers.
Such SPI controllers don't need the spi-nor bounce buffer.

spi_map_msg() can build a scatter-gather list from vmalloc'ed buffer
then map this sg list with dma_map_sg(). AFAIK, It is safe to do so for
architectures using PIPT caches since the possible cache aliases issue
present for VIPT or VIVT caches is always avoided for PIPT caches.

For instance, the drivers/spi/spi-atmel.c driver relies on spi_map_sg()
to be called from the SPI sub-system to handle vmalloc'ed buffers and
both master->dma_tx and master->dma_rx are set by the this driver.


By the way, Is there any case where the same physical page is actually
mapped into two different virtual addresses for the buffers allocated by
the MTD sub-system? Because for a long time now I wonder whether the
cache aliases issue is a real or only theoretical issue but I have no
answer to that question.

Then my next question: is spi_map_msg() enough in every case, even with
VIPT or VIVT caches?

Best regards,

Cyrille

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
