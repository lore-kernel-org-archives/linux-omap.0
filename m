From: Vignesh R <vigneshr@ti.com>
Subject: Re: [RFC PATCH 2/2] mtd: devices: m25p80: Enable spi-nor bounce
 buffer support
Date: Tue, 14 Mar 2017 18:51:38 +0530
Message-ID: <40a824c2-012c-df55-feb4-ded1fff543cb@ti.com>
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
 <03b185f6-e70a-beda-5b7f-776a03fa14c0@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <03b185f6-e70a-beda-5b7f-776a03fa14c0@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>, Mark Brown <broonie@kernel.org>
Cc: Frode Isaksen <fisaksen@baylibre.com>, Cyrille Pitchen <cyrille.pitchen@atmel.com>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org



On 3/6/2017 5:17 PM, Vignesh R wrote:
> 
> 
> On Thursday 02 March 2017 07:59 PM, Boris Brezillon wrote:
>> On Thu, 2 Mar 2017 19:24:43 +0530
>> Vignesh R <vigneshr@ti.com> wrote:
[...]
>>>
>>> If its at SPI level, then I guess each individual drivers which cannot
>>> handle vmalloc'd buffers will have to implement bounce buffer logic.
>>
>> Well, that's my opinion. The only one that can decide when to do
>> PIO, when to use DMA or when to use a bounce buffer+DMA is the SPI
>> controller.
>> If you move this logic to the SPI NOR layer, you'll have to guess what
>> is the best approach, and I fear the decision will be wrong on some
>> platforms (leading to perf degradation).
>>
>> You're mentioning code duplication in each SPI controller, I agree,
>> this is far from ideal, but what you're suggesting is not necessarily
>> better. What if another SPI user starts passing vmalloc-ed buffers to
>> the SPI controller? You'll have to duplicate the bounce-buffer logic in
>> this user as well.
>>
> 
> Hmm... Yes, there are ways to by pass SPI core.
> 
>>>
>>> Or SPI core can be extended in a way similar to this RFC. That is, SPI
>>> master driver will set a flag to request SPI core to use of bounce
>>> buffer for vmalloc'd buffers. And spi_map_buf() just uses bounce buffer
>>> in case buf does not belong to kmalloc region based on the flag.
>>
>> That's a better approach IMHO. Note that the decision should not only
>> be based on the buffer type, but also on the transfer length and/or
>> whether the controller supports transferring non physically contiguous
>> buffers.
>>
>> Maybe we should just extend ->can_dma() to let the core know if it
>> should use a bounce buffer.
>>
> 
> Yes, this is definitely needed. ->can_dma() currently returns bool. We
> need a better interface that returns different error codes for
> restriction on buffer length vs buffer type (I dont see any appropriate
> error codes) or make ->can_dma() return flag asking for bounce buffer.
> SPI controller drivers may use cache_is_*() and virt_addr_valid() to
> decide whether or not request bounce buffer.
> 
>> Regarding the bounce buffer allocation logic, I'm not sure how it
>> should be done. The SPI user should be able to determine a max transfer
>> len (at least this is the case for SPI NORs) and inform the SPI layer
>> about this boundary so that the SPI core can allocate a bounce buffer
>> of this size. But we also have limitations at the SPI master level
>> (->max_transfer_size(), ->max_message_size()).
>>
> 
> Again, I guess only SPI controller can suggest the appropriate size of
> bounce buffer based on its internal constraints and use cases that its
> known to support.
> 

I will work on a patch series implementing bounce buffer support in SPI
core and extend ->can_dma() to inform when bounce buffer needs to be
used. This will make sure that SPI controller drivers that are not
affected by cache aliasing problem or LPAE buffers don't have
performance impact. Any comments appreciated!

-- 
Regards
Vignesh
