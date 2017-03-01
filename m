From: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Subject: Re: [RFC PATCH 2/2] mtd: devices: m25p80: Enable spi-nor bounce
 buffer support
Date: Wed, 1 Mar 2017 15:21:24 +0100
Message-ID: <8a2c9b3b-dd5f-fca7-fa5c-690e5bed949f@atmel.com>
References: <20170227120839.16545-1-vigneshr@ti.com>
 <20170227120839.16545-3-vigneshr@ti.com>
 <aa967f6a-0526-3e33-1de7-fbe7d4264f34@nod.at>
 <8f999a27-c3ce-2650-452c-b21c3e44989d@ti.com>
 <aeaf87ca-e8f5-72d0-997d-494df86abf68@atmel.com>
 <a6c61bf7-1f26-41db-9a6b-bcae87274cb9@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <a6c61bf7-1f26-41db-9a6b-bcae87274cb9@ti.com>
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
Cc: Frode Isaksen <fisaksen@baylibre.com>, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

+ Mark

Le 01/03/2017 =E0 12:46, Vignesh R a =E9crit :
> =

> =

> On Wednesday 01 March 2017 04:13 PM, Cyrille Pitchen wrote:
>> Le 01/03/2017 =E0 05:54, Vignesh R a =E9crit :
>>>
>>>
>>> On Wednesday 01 March 2017 03:11 AM, Richard Weinberger wrote:
>>>> Vignesh,
>>>>
>>>> Am 27.02.2017 um 13:08 schrieb Vignesh R:
>>>>> Many SPI controller drivers use DMA to read/write from m25p80 compati=
ble
>>>>> flashes. Therefore enable bounce buffers support provided by spi-nor
>>>>> framework to take care of handling vmalloc'd buffers which may not be
>>>>> DMA'able.
>>>>>
>>>>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>>>>> ---
>>>>>  drivers/mtd/devices/m25p80.c | 1 +
>>>>>  1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p8=
0.c
>>>>> index c4df3b1bded0..d05acf22eadf 100644
>>>>> --- a/drivers/mtd/devices/m25p80.c
>>>>> +++ b/drivers/mtd/devices/m25p80.c
>>>>> @@ -241,6 +241,7 @@ static int m25p_probe(struct spi_device *spi)
>>>>>  	else
>>>>>  		flash_name =3D spi->modalias;
>>>>>  =

>>>>> +	nor->flags |=3D SNOR_F_USE_BOUNCE_BUFFER;
>>>>
>>>> Isn't there a better way to detect whether a bounce buffer is needed o=
r not?
>>>
>>
>> I agree with Richard: the bounce buffer should be enabled only if needed
>> by the SPI controller.
>>
>>> Yes, I can poke the spi->master struct to see of dma channels are
>>> populated and request SNOR_F_USE_BOUNCE_BUFFER accordingly:
>>>
>>> -       nor->flags |=3D SNOR_F_USE_BOUNCE_BUFFER;
>>> +       if (spi->master->dma_tx || spi->master->dma_rx)
>>> +               nor->flags |=3D SNOR_F_USE_BOUNCE_BUFFER;
>>> +
>>>
>>
>> However I don't agree with this solution: master->dma_{tx|rx} can be set
>> for SPI controllers which already rely on spi_map_msg() to handle
>> vmalloc'ed memory during DMA transfers.
>> Such SPI controllers don't need the spi-nor bounce buffer.
>>
>> spi_map_msg() can build a scatter-gather list from vmalloc'ed buffer
>> then map this sg list with dma_map_sg(). AFAIK, It is safe to do so for
>> architectures using PIPT caches since the possible cache aliases issue
>> present for VIPT or VIVT caches is always avoided for PIPT caches.
>>
>> For instance, the drivers/spi/spi-atmel.c driver relies on spi_map_sg()
>> to be called from the SPI sub-system to handle vmalloc'ed buffers and
>> both master->dma_tx and master->dma_rx are set by the this driver.
>>
>>
>> By the way, Is there any case where the same physical page is actually
>> mapped into two different virtual addresses for the buffers allocated by
>> the MTD sub-system? Because for a long time now I wonder whether the
>> cache aliases issue is a real or only theoretical issue but I have no
>> answer to that question.
>>
> =

> I have atleast one evidence of VIVT aliasing causing problem. Please see
> this thread on DMA issues with davinci-spi driver
> https://www.spinics.net/lists/arm-kernel/msg563420.html
> https://www.spinics.net/lists/arm-kernel/msg563445.html
> =

>> Then my next question: is spi_map_msg() enough in every case, even with
>> VIPT or VIVT caches?
>>
> =

> Not really, I am debugging another issue with UBIFS on DRA74 EVM (ARM
> cortex-a15) wherein pages allocated by vmalloc are in highmem region
> that are not addressable using 32 bit addresses and is backed by LPAE.
> So, a 32 bit DMA cannot access these buffers at all.
> When dma_map_sg() is called to map these pages by spi_map_buf() the
> physical address is just truncated to 32 bit in pfn_to_dma() (as part of
> dma_map_sg() call). This results in random crashes as DMA starts
> accessing random memory during SPI read.
> =

> IMO, there may be more undiscovered caveat with using dma_map_sg() for
> non kmalloc'd buffers and its better that spi-nor starts handling these
> buffers instead of relying on spi_map_msg() and working around every
> time something pops up.
> =


Both Frode and you confirmed that the alias issue does occur at least
with VIVT caches, hence we can't rely on spi_map_msg() in that case.
So I agree with you: adding a bounce buffer in spi-nor seems to be a
good solution at least till some rework is done in the ubifs layer, as
proposed by Boris, to replace vmalloc'ed buffers by kmalloc'ed memory.

However I still think testing spi->master->dma_{tx|rx} only is not
accurate enough to decided whether or not the SNOR_F_USE_BOUNCE_BUFFER
flag should be set. I have doubts about forcing the use of the bounce
buffer for *all* SPI controllers doing DMA transfers.

We already know that the cache aliases issue can't occur with PIPT
caches or some VIPT caches. So in those cases spi_map_buf() is enough,
hence can we justify the performance loss of the copy into the bounce
buffer for people who don't suffer the issue?

Besides, some SPI controller drivers may already use their own bounce
buffer for other reasons. Then for those controllers, it would be one
more copy.

Then I don't whether we should:
1 -  extend in SPI sub-system API to tell us if the SPI controller can
deal with non-kmalloc'd buffer for DMA transfers

or

2 - get the answer at a system-wide level.

Indeed, the question cache aliases is clearly not specific to the MTD or
SPI sub-systems but only the SPI controller driver can tell whether it
already uses its own bounce buffer.

Best regards,

Cyrille


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
