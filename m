From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [RFC PATCH 2/2] mtd: devices: m25p80: Enable spi-nor bounce
 buffer support
Date: Wed, 1 Mar 2017 15:28:55 +0100
Message-ID: <20170301152855.0cfcdf0f@bbrezillon>
References: <20170227120839.16545-1-vigneshr@ti.com>
        <20170227120839.16545-3-vigneshr@ti.com>
        <aa967f6a-0526-3e33-1de7-fbe7d4264f34@nod.at>
        <8f999a27-c3ce-2650-452c-b21c3e44989d@ti.com>
        <aeaf87ca-e8f5-72d0-997d-494df86abf68@atmel.com>
        <a6c61bf7-1f26-41db-9a6b-bcae87274cb9@ti.com>
        <8a2c9b3b-dd5f-fca7-fa5c-690e5bed949f@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <8a2c9b3b-dd5f-fca7-fa5c-690e5bed949f-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Frode Isaksen <fisaksen-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, 1 Mar 2017 15:21:24 +0100
Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org> wrote:

> + Mark
> 
> Le 01/03/2017 à 12:46, Vignesh R a écrit :
> > 
> > 
> > On Wednesday 01 March 2017 04:13 PM, Cyrille Pitchen wrote:  
> >> Le 01/03/2017 à 05:54, Vignesh R a écrit :  
> >>>
> >>>
> >>> On Wednesday 01 March 2017 03:11 AM, Richard Weinberger wrote:  
> >>>> Vignesh,
> >>>>
> >>>> Am 27.02.2017 um 13:08 schrieb Vignesh R:  
> >>>>> Many SPI controller drivers use DMA to read/write from m25p80 compatible
> >>>>> flashes. Therefore enable bounce buffers support provided by spi-nor
> >>>>> framework to take care of handling vmalloc'd buffers which may not be
> >>>>> DMA'able.
> >>>>>
> >>>>> Signed-off-by: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
> >>>>> ---
> >>>>>  drivers/mtd/devices/m25p80.c | 1 +
> >>>>>  1 file changed, 1 insertion(+)
> >>>>>
> >>>>> diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
> >>>>> index c4df3b1bded0..d05acf22eadf 100644
> >>>>> --- a/drivers/mtd/devices/m25p80.c
> >>>>> +++ b/drivers/mtd/devices/m25p80.c
> >>>>> @@ -241,6 +241,7 @@ static int m25p_probe(struct spi_device *spi)
> >>>>>  	else
> >>>>>  		flash_name = spi->modalias;
> >>>>>  
> >>>>> +	nor->flags |= SNOR_F_USE_BOUNCE_BUFFER;  
> >>>>
> >>>> Isn't there a better way to detect whether a bounce buffer is needed or not?  
> >>>  
> >>
> >> I agree with Richard: the bounce buffer should be enabled only if needed
> >> by the SPI controller.
> >>  
> >>> Yes, I can poke the spi->master struct to see of dma channels are
> >>> populated and request SNOR_F_USE_BOUNCE_BUFFER accordingly:
> >>>
> >>> -       nor->flags |= SNOR_F_USE_BOUNCE_BUFFER;
> >>> +       if (spi->master->dma_tx || spi->master->dma_rx)
> >>> +               nor->flags |= SNOR_F_USE_BOUNCE_BUFFER;
> >>> +
> >>>  
> >>
> >> However I don't agree with this solution: master->dma_{tx|rx} can be set
> >> for SPI controllers which already rely on spi_map_msg() to handle
> >> vmalloc'ed memory during DMA transfers.
> >> Such SPI controllers don't need the spi-nor bounce buffer.
> >>
> >> spi_map_msg() can build a scatter-gather list from vmalloc'ed buffer
> >> then map this sg list with dma_map_sg(). AFAIK, It is safe to do so for
> >> architectures using PIPT caches since the possible cache aliases issue
> >> present for VIPT or VIVT caches is always avoided for PIPT caches.
> >>
> >> For instance, the drivers/spi/spi-atmel.c driver relies on spi_map_sg()
> >> to be called from the SPI sub-system to handle vmalloc'ed buffers and
> >> both master->dma_tx and master->dma_rx are set by the this driver.
> >>
> >>
> >> By the way, Is there any case where the same physical page is actually
> >> mapped into two different virtual addresses for the buffers allocated by
> >> the MTD sub-system? Because for a long time now I wonder whether the
> >> cache aliases issue is a real or only theoretical issue but I have no
> >> answer to that question.
> >>  
> > 
> > I have atleast one evidence of VIVT aliasing causing problem. Please see
> > this thread on DMA issues with davinci-spi driver
> > https://www.spinics.net/lists/arm-kernel/msg563420.html
> > https://www.spinics.net/lists/arm-kernel/msg563445.html
> >   
> >> Then my next question: is spi_map_msg() enough in every case, even with
> >> VIPT or VIVT caches?
> >>  
> > 
> > Not really, I am debugging another issue with UBIFS on DRA74 EVM (ARM
> > cortex-a15) wherein pages allocated by vmalloc are in highmem region
> > that are not addressable using 32 bit addresses and is backed by LPAE.
> > So, a 32 bit DMA cannot access these buffers at all.
> > When dma_map_sg() is called to map these pages by spi_map_buf() the
> > physical address is just truncated to 32 bit in pfn_to_dma() (as part of
> > dma_map_sg() call). This results in random crashes as DMA starts
> > accessing random memory during SPI read.
> > 
> > IMO, there may be more undiscovered caveat with using dma_map_sg() for
> > non kmalloc'd buffers and its better that spi-nor starts handling these
> > buffers instead of relying on spi_map_msg() and working around every
> > time something pops up.
> >   
> 
> Both Frode and you confirmed that the alias issue does occur at least
> with VIVT caches, hence we can't rely on spi_map_msg() in that case.
> So I agree with you: adding a bounce buffer in spi-nor seems to be a
> good solution at least till some rework is done in the ubifs layer, as
> proposed by Boris, to replace vmalloc'ed buffers by kmalloc'ed memory.

We should keep it even after reworking UBI/UBIFS, because UBI is just
one user of MTD, and other users might pass vmalloc-ed or kmap-ed bufs.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
