From: Frode Isaksen <fisaksen@baylibre.com>
Subject: Re: [RFC PATCH 2/2] mtd: devices: m25p80: Enable spi-nor bounce
 buffer support
Date: Thu, 2 Mar 2017 16:03:17 +0100
Message-ID: <341ef45d-bad5-fd7c-aa05-807041c35f42@baylibre.com>
References: <20170227120839.16545-1-vigneshr@ti.com>
 <20170227120839.16545-3-vigneshr@ti.com>
 <aa967f6a-0526-3e33-1de7-fbe7d4264f34@nod.at>
 <8f999a27-c3ce-2650-452c-b21c3e44989d@ti.com>
 <aeaf87ca-e8f5-72d0-997d-494df86abf68@atmel.com>
 <a6c61bf7-1f26-41db-9a6b-bcae87274cb9@ti.com>
 <20170301175506.202cb478@bbrezillon>
 <09ffe06d-565d-afe8-8b7d-d1a0b575595b@baylibre.com>
 <4cd22ddd-b108-f697-0bde-ad844a386e62@ti.com>
 <20170302152921.1c031b57@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20170302152921.1c031b57@bbrezillon>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>, Vignesh R <vigneshr@ti.com>
Cc: linux-omap@vger.kernel.org, Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>, Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org, Cyrille Pitchen <cyrille.pitchen@atmel.com>, Brian Norris <computersforpeace@gmail.com>, David Woodhouse <dwmw2@infradead.org>
List-Id: linux-omap@vger.kernel.org



On 02/03/2017 15:29, Boris Brezillon wrote:
> On Thu, 2 Mar 2017 19:24:43 +0530
> Vignesh R <vigneshr@ti.com> wrote:
>
>>>>>>     
>>>>> Not really, I am debugging another issue with UBIFS on DRA74 EVM (ARM
>>>>> cortex-a15) wherein pages allocated by vmalloc are in highmem region
>>>>> that are not addressable using 32 bit addresses and is backed by LPAE.
>>>>> So, a 32 bit DMA cannot access these buffers at all.
>>>>> When dma_map_sg() is called to map these pages by spi_map_buf() the
>>>>> physical address is just truncated to 32 bit in pfn_to_dma() (as part of
>>>>> dma_map_sg() call). This results in random crashes as DMA starts
>>>>> accessing random memory during SPI read.
>>>>>
>>>>> IMO, there may be more undiscovered caveat with using dma_map_sg() for
>>>>> non kmalloc'd buffers and its better that spi-nor starts handling these
>>>>> buffers instead of relying on spi_map_msg() and working around every
>>>>> time something pops up.
>>>>>  
>>>> Ok, I had a closer look at the SPI framework, and it seems there's a
>>>> way to tell to the core that a specific transfer cannot use DMA
>>>> (->can_dam()). The first thing you should do is fix the spi-davinci
>>>> driver:
>>>>
>>>> 1/ implement ->can_dma()
>>>> 2/ patch davinci_spi_bufs() to take the decision to do DMA or not on a
>>>>    per-xfer basis and not on a per-device basis
>>>>  
>> This would lead to poor perf defeating entire purpose of using DMA.
> Hm, that's not really true. For all cases where you have a DMA-able
> buffer it would still use DMA. For other cases (like the UBI+SPI-NOR
> case we're talking about here), yes, it will be slower, but slower is
> still better than buggy.
> So, in any case, I think the fixes pointed by Frode are needed.
Also, I think the UBIFS layer only uses vmalloc'ed buffers during mount/unmount and not for read/write, so the performance hit is not that big. In most cases the buffer is the size of the erase block, but I've seen vmalloc'ed buffer of size only 11 bytes ! So, to optimize this, the best solution is probably to change how the UBIFS layer is using vmalloc'ed vs kmalloc'ed buffers, since vmalloc'ed should only be used for large (> 128K) buffers.

Frode
>
>>>> Then we can start thinking about how to improve perfs by using a bounce
>>>> buffer for large transfers, but I'm still not sure this should be done
>>>> at the MTD level...  
>> If its at SPI level, then I guess each individual drivers which cannot
>> handle vmalloc'd buffers will have to implement bounce buffer logic.
> Well, that's my opinion. The only one that can decide when to do
> PIO, when to use DMA or when to use a bounce buffer+DMA is the SPI
> controller.
> If you move this logic to the SPI NOR layer, you'll have to guess what
> is the best approach, and I fear the decision will be wrong on some
> platforms (leading to perf degradation).
>
> You're mentioning code duplication in each SPI controller, I agree,
> this is far from ideal, but what you're suggesting is not necessarily
> better. What if another SPI user starts passing vmalloc-ed buffers to
> the SPI controller? You'll have to duplicate the bounce-buffer logic in
> this user as well.
>
>> Or SPI core can be extended in a way similar to this RFC. That is, SPI
>> master driver will set a flag to request SPI core to use of bounce
>> buffer for vmalloc'd buffers. And spi_map_buf() just uses bounce buffer
>> in case buf does not belong to kmalloc region based on the flag.
> That's a better approach IMHO. Note that the decision should not only
> be based on the buffer type, but also on the transfer length and/or
> whether the controller supports transferring non physically contiguous
> buffers.
>
> Maybe we should just extend ->can_dma() to let the core know if it
> should use a bounce buffer.
>
> Regarding the bounce buffer allocation logic, I'm not sure how it
> should be done. The SPI user should be able to determine a max transfer
> len (at least this is the case for SPI NORs) and inform the SPI layer
> about this boundary so that the SPI core can allocate a bounce buffer
> of this size. But we also have limitations at the SPI master level
> (->max_transfer_size(), ->max_message_size()).
>
>


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
