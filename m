From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 1/5] mtd: nand: omap2: Support parsing dma channel
 information from DT
Date: Thu, 15 Oct 2015 10:35:25 +0300
Message-ID: <561F573D.6010704@ti.com>
References: <1444700338-27582-1-git-send-email-fcooper@ti.com>
 <1444700338-27582-2-git-send-email-fcooper@ti.com> <561E3E4F.9020302@ti.com>
 <561E41EB.3050005@ti.com> <561E5803.5090609@ti.com> <561E629F.5070202@ti.com>
 <561E6791.3030404@ti.com> <20151014161813.GC10113@atomide.com>
 <561E8184.6020206@ti.com> <20151014181337.GF10113@atomide.com>
 <561EB4FB.8040709@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <561EB4FB.8040709@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Franklin S Cooper Jr." <fcooper@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, nsekhar@ti.com, computersforpeace@gmail.com, dwmw2@infradead.org
List-Id: linux-omap@vger.kernel.org

On 14/10/15 23:03, Franklin S Cooper Jr. wrote:
> 
> 
> On 10/14/2015 01:13 PM, Tony Lindgren wrote:
>> * Franklin S Cooper Jr. <fcooper@ti.com> [151014 09:27]:
>>>
>>> On 10/14/2015 11:18 AM, Tony Lindgren wrote:
>>>> * Franklin S Cooper Jr. <fcooper@ti.com> [151014 07:37]:
>>>>> On 10/14/2015 09:11 AM, Roger Quadros wrote:
>>>>>> On 14/10/15 16:26, Franklin S Cooper Jr. wrote:
>>>>>>> On 10/14/2015 06:52 AM, Roger Quadros wrote:
>>>>>>>> Franklin,
>>>>>>>>
>>>>>>>> On 14/10/15 14:36, Roger Quadros wrote:
>>>>>>>>> On 13/10/15 04:38, Franklin S Cooper Jr wrote:
>>>>>>>>>> Switch from dma_request_channel to allow passing dma channel
>>>>>>>>>> information from DT rather than hardcoding a value.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
>>>>>>>>> Acked-by: Roger Quadros <rogerq@ti.com>
>>>>>>>>>
>>>>>>>>>> ---
>>>>>>>>>>  drivers/mtd/nand/omap2.c | 4 +++-
>>>>>>>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
>>>>>>>>>> index d0f2620..957c32f 100644
>>>>>>>>>> --- a/drivers/mtd/nand/omap2.c
>>>>>>>>>> +++ b/drivers/mtd/nand/omap2.c
>>>>>>>>>> @@ -1866,7 +1866,9 @@ static int omap_nand_probe(struct platform_device *pdev)
>>>>>>>>>>  		dma_cap_zero(mask);
>>>>>>>>>>  		dma_cap_set(DMA_SLAVE, mask);
>>>>>>>>>>  		sig = OMAP24XX_DMA_GPMC;
>>>>>>>>>> -		info->dma = dma_request_channel(mask, omap_dma_filter_fn, &sig);
>>>>>>>>>> +		info->dma = dma_request_slave_channel_compat(mask,
>>>>>>>>>> +			omap_dma_filter_fn, &sig, pdev->dev.parent, "rxtx");
>>>>>>>>>> +
>>>>>>>> Just discovered that you are using the parent device node.
>>>>>>>>
>>>>>>>> How about moving the dma bindings to the nand node instead and using
>>>>>>>> pdev->dev here?
>>>>>>> Roger,
>>>>>>>
>>>>>>> From what I can tell the interrupt number and the dma channel will always be
>>>>>>> the same no matter what. Doesn't matter if you have multiple nands or a
>>>>>>> combination of nands and nors. Since that is the case I think it just makes
>>>>>>> sense to leave it in the gpmc parent node and define it once.
>>>>>> Is prefetch/writepost dma used for NOR or any other GPMC peripheral
>>>>>> or only for NAND?
>>>>> The dma seems tied to the prefetch. From what I can tell the prefetch is only
>>>>> used by nand.
>>>>>> Let's also get Tony's inputs on this.
>>>>> Sure.
>>>> Hmm so what would keep other devices from using the prefetch
>>> Looking at the TRM any references to the prefetch are always with respect to
>>> NAND.
>>>
>>> I also see the below mentioned in the TRM.
>>> Pre-fetch and write posting engine associated with system DMA to get full performance from NAND
>>> device with minimum impact on NOR/SRAM concurrent access.
>> OK up to you guys to figure out if it may be usable in a generic way then :)
> Ok I just got clarification from hw folks. DMA for GPMC can be used for any of the
> various modes. But the prefetch is specific to NAND.

In that case the dma information must be in the GPMC node.

cheers,
-roger
