From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH v2 2/2] spi: spi-ti-qspi: Use bounce buffer if read buffer
 is not DMA'ble
Date: Tue, 20 Jun 2017 15:15:34 +0530
Message-ID: <faa7fdc4-25d1-aa9e-762b-25d5e89a771f@ti.com>
References: <20170411115225.31709-1-vigneshr@ti.com>
 <20170411115225.31709-3-vigneshr@ti.com>
 <20170421170655.dpyxlwipfwnwjjwy@sirena.org.uk>
 <3955ad22-28a2-5222-4ae3-aa34dc69cde6@ti.com>
 <c9dbe3d1-549c-f510-fa76-8e326601ecdc@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c9dbe3d1-549c-f510-fa76-8e326601ecdc@atmel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Cyrille Pitchen <cyrille.pitchen@atmel.com>, Mark Brown <broonie@kernel.org>
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Richard Weinberger <richard@nod.at>, Boris BREZILLON <boris.brezillon@free-electrons.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On Friday 16 June 2017 09:24 PM, Cyrille Pitchen wrote:
> Hi all,
> 
> + Richard and Boris as MTD maintainers
> 
> Le 25/04/2017 à 14:18, Vignesh R a écrit :
>>
>>
>> On Friday 21 April 2017 10:36 PM, Mark Brown wrote:
>>> On Tue, Apr 11, 2017 at 05:22:25PM +0530, Vignesh R wrote:
>>>> Flash filesystems like JFFS2, UBIFS and MTD block layer can provide
>>>> vmalloc'd or kmap'd buffers that cannot be mapped using dma_map_sg() and
>>>> can potentially be in memory region above 32bit addressable region(ie
>>>> buffers belonging to memory region backed by LPAE) of DMA, implement
>>>> spi_flash_can_dma() interface to inform SPI core not to map such
>>>> buffers.
>>>
>>> I'll apply this since it fixes bugs for your systems but it feels like
>>> something that we should be moving further into the core since LPAE
>>> isn't specific to your devices.  We should ideally have something
>>> (possibly in the DMA mapping code even) which does the remapping without
>>> the driver needing to know about it.
>>>
>>
>> I agree, there is a need to have generic remapping code. Also, I guess,
>> once UBIFS is moved to use kmalloc'd buffers SPI flash devices will not
>> have to worry much about vmalloc'd buffers.
>>
> 
> I've just discussed with Richard and Boris and AFAIK, nothing is planned
> at the UBIFS side to replace vmalloc'd buffers by kmalloc'd buffers.
> There are reasons for using vmalloc() but Richard can explain better
> than me :)
> 
> Also, depending on the cache model used by Atmel SoCs, the spi-atmel.c
> driver may suffer from the same issue too: using spi_map_buf() hence
> mapping vmalloc'ed buffers for DMA usage will be OK with ARM Cortex A5
> (PIPT data cache, so no cache aliasing issue at all) hence with SAMA5
> series but is not OK for some older cores like ARM926 (VIVT data cache)
> hence the SAM9 series.
> 
> So to fix the spi-atmel.c driver when used with SAM9 SoCs, we are
> thinking about sending a first patch to simply disable the use of DMA
> transfers on SAM9 SoCs in case of vmalloc'ed buffers and use CPU
> transfers instead.
> The code will be left unchanged for SAMA5 SoCs so there would be no
> performance loss on those SoCs.
> It won't be optimal on SAM9 SoCs but at least it would work.
> 
> Then in a new series, if nobody has started to work on this topic yet,
> we could propose a generic solution using a bounce buffer at the SPI
> core level. however we first need to think how we could do this.
> 

One of the questions that was hovering around when this issue was
discussed last time around was where should the code to detect whether
or not to use bounce buffer reside? Some extension to generic DMA APIs
or SPI drivers or somewhere else?

-- 
Regards
Vignesh
