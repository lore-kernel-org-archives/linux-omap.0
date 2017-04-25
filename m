From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 2/2] spi: spi-ti-qspi: Use bounce buffer if read buffer
 is not DMA'ble
Date: Tue, 25 Apr 2017 17:48:53 +0530
Message-ID: <3955ad22-28a2-5222-4ae3-aa34dc69cde6@ti.com>
References: <20170411115225.31709-1-vigneshr@ti.com>
 <20170411115225.31709-3-vigneshr@ti.com>
 <20170421170655.dpyxlwipfwnwjjwy@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170421170655.dpyxlwipfwnwjjwy-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org



On Friday 21 April 2017 10:36 PM, Mark Brown wrote:
> On Tue, Apr 11, 2017 at 05:22:25PM +0530, Vignesh R wrote:
>> Flash filesystems like JFFS2, UBIFS and MTD block layer can provide
>> vmalloc'd or kmap'd buffers that cannot be mapped using dma_map_sg() and
>> can potentially be in memory region above 32bit addressable region(ie
>> buffers belonging to memory region backed by LPAE) of DMA, implement
>> spi_flash_can_dma() interface to inform SPI core not to map such
>> buffers.
> 
> I'll apply this since it fixes bugs for your systems but it feels like
> something that we should be moving further into the core since LPAE
> isn't specific to your devices.  We should ideally have something
> (possibly in the DMA mapping code even) which does the remapping without
> the driver needing to know about it.
> 

I agree, there is a need to have generic remapping code. Also, I guess,
once UBIFS is moved to use kmalloc'd buffers SPI flash devices will not
have to worry much about vmalloc'd buffers.

-- 
Regards
Vignesh
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
