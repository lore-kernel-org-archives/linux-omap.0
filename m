From: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 2/2] spi: spi-ti-qspi: Use bounce buffer if read buffer
 is not DMA'ble
Date: Fri, 16 Jun 2017 17:54:57 +0200
Message-ID: <c9dbe3d1-549c-f510-fa76-8e326601ecdc@atmel.com>
References: <20170411115225.31709-1-vigneshr@ti.com>
 <20170411115225.31709-3-vigneshr@ti.com>
 <20170421170655.dpyxlwipfwnwjjwy@sirena.org.uk>
 <3955ad22-28a2-5222-4ae3-aa34dc69cde6@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3955ad22-28a2-5222-4ae3-aa34dc69cde6-l0cyMroinI0@public.gmane.org>
Content-Language: en-GB
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>, Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi all,

+ Richard and Boris as MTD maintainers

Le 25/04/2017 à 14:18, Vignesh R a écrit :
> 
> 
> On Friday 21 April 2017 10:36 PM, Mark Brown wrote:
>> On Tue, Apr 11, 2017 at 05:22:25PM +0530, Vignesh R wrote:
>>> Flash filesystems like JFFS2, UBIFS and MTD block layer can provide
>>> vmalloc'd or kmap'd buffers that cannot be mapped using dma_map_sg() and
>>> can potentially be in memory region above 32bit addressable region(ie
>>> buffers belonging to memory region backed by LPAE) of DMA, implement
>>> spi_flash_can_dma() interface to inform SPI core not to map such
>>> buffers.
>>
>> I'll apply this since it fixes bugs for your systems but it feels like
>> something that we should be moving further into the core since LPAE
>> isn't specific to your devices.  We should ideally have something
>> (possibly in the DMA mapping code even) which does the remapping without
>> the driver needing to know about it.
>>
> 
> I agree, there is a need to have generic remapping code. Also, I guess,
> once UBIFS is moved to use kmalloc'd buffers SPI flash devices will not
> have to worry much about vmalloc'd buffers.
> 

I've just discussed with Richard and Boris and AFAIK, nothing is planned
at the UBIFS side to replace vmalloc'd buffers by kmalloc'd buffers.
There are reasons for using vmalloc() but Richard can explain better
than me :)

Also, depending on the cache model used by Atmel SoCs, the spi-atmel.c
driver may suffer from the same issue too: using spi_map_buf() hence
mapping vmalloc'ed buffers for DMA usage will be OK with ARM Cortex A5
(PIPT data cache, so no cache aliasing issue at all) hence with SAMA5
series but is not OK for some older cores like ARM926 (VIVT data cache)
hence the SAM9 series.

So to fix the spi-atmel.c driver when used with SAM9 SoCs, we are
thinking about sending a first patch to simply disable the use of DMA
transfers on SAM9 SoCs in case of vmalloc'ed buffers and use CPU
transfers instead.
The code will be left unchanged for SAMA5 SoCs so there would be no
performance loss on those SoCs.
It won't be optimal on SAM9 SoCs but at least it would work.

Then in a new series, if nobody has started to work on this topic yet,
we could propose a generic solution using a bounce buffer at the SPI
core level. however we first need to think how we could do this.

Best regards,

Cyrille
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
