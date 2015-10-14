From: "Franklin S Cooper Jr." <fcooper-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/5] mtd: nand: omap2: Support parsing dma channel
 information from DT
Date: Wed, 14 Oct 2015 11:23:32 -0500
Message-ID: <561E8184.6020206@ti.com>
References: <1444700338-27582-1-git-send-email-fcooper@ti.com>
 <1444700338-27582-2-git-send-email-fcooper@ti.com> <561E3E4F.9020302@ti.com>
 <561E41EB.3050005@ti.com> <561E5803.5090609@ti.com> <561E629F.5070202@ti.com>
 <561E6791.3030404@ti.com> <20151014161813.GC10113@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151014161813.GC10113-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org



On 10/14/2015 11:18 AM, Tony Lindgren wrote:
> * Franklin S Cooper Jr. <fcooper-l0cyMroinI0@public.gmane.org> [151014 07:37]:
>>
>> On 10/14/2015 09:11 AM, Roger Quadros wrote:
>>> On 14/10/15 16:26, Franklin S Cooper Jr. wrote:
>>>> On 10/14/2015 06:52 AM, Roger Quadros wrote:
>>>>> Franklin,
>>>>>
>>>>> On 14/10/15 14:36, Roger Quadros wrote:
>>>>>> On 13/10/15 04:38, Franklin S Cooper Jr wrote:
>>>>>>> Switch from dma_request_channel to allow passing dma channel
>>>>>>> information from DT rather than hardcoding a value.
>>>>>>>
>>>>>>> Signed-off-by: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
>>>>>> Acked-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
>>>>>>
>>>>>>> ---
>>>>>>>  drivers/mtd/nand/omap2.c | 4 +++-
>>>>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
>>>>>>> index d0f2620..957c32f 100644
>>>>>>> --- a/drivers/mtd/nand/omap2.c
>>>>>>> +++ b/drivers/mtd/nand/omap2.c
>>>>>>> @@ -1866,7 +1866,9 @@ static int omap_nand_probe(struct platform_device *pdev)
>>>>>>>  		dma_cap_zero(mask);
>>>>>>>  		dma_cap_set(DMA_SLAVE, mask);
>>>>>>>  		sig = OMAP24XX_DMA_GPMC;
>>>>>>> -		info->dma = dma_request_channel(mask, omap_dma_filter_fn, &sig);
>>>>>>> +		info->dma = dma_request_slave_channel_compat(mask,
>>>>>>> +			omap_dma_filter_fn, &sig, pdev->dev.parent, "rxtx");
>>>>>>> +
>>>>> Just discovered that you are using the parent device node.
>>>>>
>>>>> How about moving the dma bindings to the nand node instead and using
>>>>> pdev->dev here?
>>>> Roger,
>>>>
>>>> From what I can tell the interrupt number and the dma channel will always be
>>>> the same no matter what. Doesn't matter if you have multiple nands or a
>>>> combination of nands and nors. Since that is the case I think it just makes
>>>> sense to leave it in the gpmc parent node and define it once.
>>> Is prefetch/writepost dma used for NOR or any other GPMC peripheral
>>> or only for NAND?
>> The dma seems tied to the prefetch. From what I can tell the prefetch is only
>> used by nand.
>>> Let's also get Tony's inputs on this.
>> Sure.
> Hmm so what would keep other devices from using the prefetch
Looking at the TRM any references to the prefetch are always with respect to
NAND.

I also see the below mentioned in the TRM.
Pre-fetch and write posting engine associated with system DMA to get full performance from NAND
device with minimum impact on NOR/SRAM concurrent access.
>
> Regards,
>
> Tony

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
