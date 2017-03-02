From: Vignesh R <vigneshr@ti.com>
Subject: Re: [RFC PATCH 2/2] mtd: devices: m25p80: Enable spi-nor bounce
 buffer support
Date: Thu, 2 Mar 2017 19:24:43 +0530
Message-ID: <4cd22ddd-b108-f697-0bde-ad844a386e62@ti.com>
References: <20170227120839.16545-1-vigneshr@ti.com>
 <20170227120839.16545-3-vigneshr@ti.com>
 <aa967f6a-0526-3e33-1de7-fbe7d4264f34@nod.at>
 <8f999a27-c3ce-2650-452c-b21c3e44989d@ti.com>
 <aeaf87ca-e8f5-72d0-997d-494df86abf68@atmel.com>
 <a6c61bf7-1f26-41db-9a6b-bcae87274cb9@ti.com>
 <20170301175506.202cb478@bbrezillon>
 <09ffe06d-565d-afe8-8b7d-d1a0b575595b@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <09ffe06d-565d-afe8-8b7d-d1a0b575595b@baylibre.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Frode Isaksen <fisaksen@baylibre.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Mark Brown <broonie@kernel.org>
Cc: linux-omap@vger.kernel.org, Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org, Cyrille Pitchen <cyrille.pitchen@atmel.com>, Brian Norris <computersforpeace@gmail.com>, David Woodhouse <dwmw2@infradead.org>
List-Id: linux-omap@vger.kernel.org


>>>>   
>>> Not really, I am debugging another issue with UBIFS on DRA74 EVM (ARM
>>> cortex-a15) wherein pages allocated by vmalloc are in highmem region
>>> that are not addressable using 32 bit addresses and is backed by LPAE.
>>> So, a 32 bit DMA cannot access these buffers at all.
>>> When dma_map_sg() is called to map these pages by spi_map_buf() the
>>> physical address is just truncated to 32 bit in pfn_to_dma() (as part of
>>> dma_map_sg() call). This results in random crashes as DMA starts
>>> accessing random memory during SPI read.
>>>
>>> IMO, there may be more undiscovered caveat with using dma_map_sg() for
>>> non kmalloc'd buffers and its better that spi-nor starts handling these
>>> buffers instead of relying on spi_map_msg() and working around every
>>> time something pops up.
>>>
>> Ok, I had a closer look at the SPI framework, and it seems there's a
>> way to tell to the core that a specific transfer cannot use DMA
>> (->can_dam()). The first thing you should do is fix the spi-davinci
>> driver:
>>
>> 1/ implement ->can_dma()
>> 2/ patch davinci_spi_bufs() to take the decision to do DMA or not on a
>>    per-xfer basis and not on a per-device basis
>>

This would lead to poor perf defeating entire purpose of using DMA.

>> Then we can start thinking about how to improve perfs by using a bounce
>> buffer for large transfers, but I'm still not sure this should be done
>> at the MTD level...

If its at SPI level, then I guess each individual drivers which cannot
handle vmalloc'd buffers will have to implement bounce buffer logic.

Or SPI core can be extended in a way similar to this RFC. That is, SPI
master driver will set a flag to request SPI core to use of bounce
buffer for vmalloc'd buffers. And spi_map_buf() just uses bounce buffer
in case buf does not belong to kmalloc region based on the flag.

Mark, Cyrille, Is that what you prefer?

-- 
Regards
Vignesh

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
