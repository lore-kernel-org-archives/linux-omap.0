From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 4/4] usb: musb: tusb6010_omap: Convert to DMAengine API
Date: Fri, 5 May 2017 18:17:42 +0300
Message-ID: <52c733a8-e8d3-abd9-2ea8-f3f91f823b89@ti.com>
References: <20170503105645.26759-1-peter.ujfalusi@ti.com>
 <20170503105645.26759-5-peter.ujfalusi@ti.com>
 <20170504194034.GA3489@atomide.com> <20170504210529.GB3489@atomide.com>
 <e7a7db55-753f-7b3b-b2e6-290518e7371b@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e7a7db55-753f-7b3b-b2e6-290518e7371b@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: b-liu@ti.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@kernel.org, linux-kernel@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org



On 2017-05-05 16:37, Peter Ujfalusi wrote:
> Tony,
>
> On 2017-05-05 00:05, Tony Lindgren wrote:
>> * Tony Lindgren <tony@atomide.com> [170504 12:43]:
>>> Hi,
>>>
>>> * Peter Ujfalusi <peter.ujfalusi@ti.com> [170503 04:00]:
>>>> With the port_window support in DMAengine and the sDMA driver we can
>>>> convert the driver to DMAengine.
>>>
>>> Actually looks like this patch still has some issues.. Pinging
>>> the n8x0 with for example ping -s1 causes things to stop working.
>>
>> Sorry it's actually ping -s2048, not -s1. Here's what happens
>> on n8x0 with first ping -s2048 with 4/4 applied:
>>
>> musb-hdrc musb-hdrc.1.auto: Busy rx dma, not using: 00000010
>> g_ether gadget: invalid EEM CRC
>> g_ether gadget: invalid EEM CRC
>> musb-hdrc musb-hdrc.1.auto: ep1 rx dma: 0x86803842 len: 512(512)
>> packet_sz: 512(512)
>> musb-hdrc musb-hdrc.1.auto: ep1 rx using 16-bit async dma from
>> 0x02000620 to 0x86803842
>> musb-hdrc musb-hdrc.1.auto: ep1 rx dma callback
>> musb-hdrc musb-hdrc.1.auto: DMA remaining 448/512
>> musb-hdrc musb-hdrc.1.auto: Busy rx dma, not using: 000001c0
>> musb-hdrc musb-hdrc.1.auto: Busy rx dma, not using: 00000008
>> musb-hdrc musb-hdrc.1.auto: ep1 rx dma: 0x869fdc02 len: 512(512)
>> packet_sz: 512(512)
>> musb-hdrc musb-hdrc.1.auto: ep1 rx using 16-bit async dma from
>> 0x02000620 to 0x869fdc02
>> musb-hdrc musb-hdrc.1.auto: ep1 rx dma callback
>> musb-hdrc musb-hdrc.1.auto: DMA remaining 448/512
>> musb-hdrc musb-hdrc.1.auto: Busy rx dma, not using: 000001c0
>> musb-hdrc musb-hdrc.1.auto: Busy rx dma, not using: 00000008
>> musb-hdrc musb-hdrc.1.auto: ep1 rx dma: 0x869fc642 len: 512(512)
>> packet_sz: 512(512)
>> musb-hdrc musb-hdrc.1.auto: ep1 rx using 16-bit async dma from
>> 0x02000620 to 0x869fc642
>> musb-hdrc musb-hdrc.1.auto: ep1 rx dma callback
>> musb-hdrc musb-hdrc.1.auto: Corrupt rx XFR_SIZE: 0x7ffffec0
>> musb-hdrc musb-hdrc.1.auto: DMA remaining 0/512
>> musb-hdrc musb-hdrc.1.auto: Busy rx dma, not using: 7ffffec0
>> musb-hdrc musb-hdrc.1.auto: Busy rx dma, not using: 00000008
>> musb-hdrc musb-hdrc.1.auto: Busy rx dma, not using: 00000010
>> musb-hdrc musb-hdrc.1.auto: Busy rx dma, not using: 7ffffcf0
>>
>> It seems the hardware dmareq line is not triggering anything
>> above?
>>
>> Also with just ping with no size specified, it seems every other
>> packet is missed or DMA interrupts are not properly triggering
>> as I'm getting these:
>>
>> g_ether gadget: invalid EEM CRC
>>
>>> This is when using only with the async gpmc access as the sync
>>> gpmc access seems to have a regression not related to this series.
>>> I'll try to track down that sync gpmc issue as that most likely
>>> hints to something being wrong in the gpmc code in general.
>>
>> And this sync gpmc issue seems to be timing related. Setting
>> DEBUG in tusb6010_omap.c makes it happen easily while without
>> it it's much harder to trigger. So probably some kind of issue
>> with GPMC sync timings.
>
> Indeed there are some interesting things happening...
> As I said, I was testing with g_cdc (CDC Composite (ECM + ACM)) and I
> found it pretty stable with DMAengine. But short story long:
>
> With the series applied and getting rid of the dma_addr & 0x2, plus
> setting the set the quirk_avoids_skb_reserve flag:
> g_cdc (ECM + ACM) boots to nfsroot most of the time, ping, scp works
> g_ether (ECM) does not boot to nfsroot, ping does not work. However if I
> disable the rx DMA with:
>
> diff --git a/drivers/usb/musb/tusb6010_omap.c
> b/drivers/usb/musb/tusb6010_omap.c
> index 8b43c4b99f04..8e0a19b47132 100644
> --- a/drivers/usb/musb/tusb6010_omap.c
> +++ b/drivers/usb/musb/tusb6010_omap.c
> @@ -512,6 +512,12 @@ tusb_omap_dma_allocate(struct dma_controller *c,
>          return NULL;
>      }
>
> +    if (!tx) {
> +        dev_err(musb->controller, "Not allowing RX DMA for ep%i %s\n",
> +            chdat->epnum);

Remove the %s and s/chdat/hw_ep

and the kernel will not crash :( But still not booting with DMAengine 
when RX DMA is disabled :o

> +        return NULL;
> +    }
> +
>      for (i = 0; i < MAX_DMAREQ; i++) {
>          struct dma_channel *ch = dma_channel_pool[i];
>          if (ch->status == MUSB_DMA_STATUS_UNKNOWN) {
>
>
> nfsroot works, ping and scp also - TX is using DMA.
>
> g_ncm (NCM): not booting to nfsroot, no ping, but if I disable the RX
> DMA, then I have NULL pointer dereference :o
> Something is wrong for sure.
>
> But to see what I have been comparing to, I have reverted my series and
> added the dma_addr & 2 and the quirk:
>
> g_cdc (ECM + ACM): no nfsroot, no ping
> g_ether (ECM): no nfsroot, no ping
> g_ncm (NCM): no nfsroot, no ping, disabling RX DMA allow it to boot up,
> but ping kills the USB
>
> None of this is issue I think currently as the DMA is effectively
> disabled for tusb by the dma_addr & 0x2 check, but it is somehow
> bothersome...
>
> I'll try to pin-point out what is going on.
>
> As reference, my configs are:
> https://github.com/omap-audio/linux-audio/blob/peter/linux-next-wip/arch/arm/configs/nokia_n810_cdc_defconfig
>
>
> https://github.com/omap-audio/linux-audio/blob/peter/linux-next-wip/arch/arm/configs/nokia_n810_ether_defconfig
>
>
> https://github.com/omap-audio/linux-audio/blob/peter/linux-next-wip/arch/arm/configs/nokia_n810_ncm_defconfig
>
>
> - Péter
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

- Péter
