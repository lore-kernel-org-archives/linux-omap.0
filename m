From: Anand Gadiyar <gadiyar@ti.com>
Subject: Re: [Question] which type of DMA taken by musb of beagle-xM(DM3730)?
Date: Sun, 31 Oct 2010 01:34:11 -0400
Message-ID: <4CCCFFD3.6050703@ti.com>
References: <AANLkTi=r08ipWPYfEbpsX-tuG=3evFfVazR198ECjFnn@mail.gmail.com>	<AANLkTi=4K1V2pZQNZOhbkJJ8WCh0X8botpWHOU03p3Hv@mail.gmail.com>	<AANLkTimYJ-hyNm7nx+dvTrgO4QC2YSjBYjLqHR_wvGni@mail.gmail.com>	<AANLkTim_xYch-BS0Edc70679Rx03fpofpoGSkTzQV1HW@mail.gmail.com>	<4CC84109.9040304@ti.com> <AANLkTi=ZHb4iNW3KzJzoVyMP1bp3ne3oRmW3YWh0ueEm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:33938 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751035Ab0JaFeT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 31 Oct 2010 01:34:19 -0400
In-Reply-To: <AANLkTi=ZHb4iNW3KzJzoVyMP1bp3ne3oRmW3YWh0ueEm@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-usb <linux-usb@vger.kernel.org>

On 10/27/2010 11:27 AM, Ming Lei wrote:
> 2010/10/27 Anand Gadiyar<gadiyar@ti.com>:
>> On 10/27/2010 10:55 AM, Ming Lei wrote:
>>>
>>> 2010/10/27 Ming Lei<tom.leiming@gmail.com>:
>>>>
>>>> Hi Gadiyar,
>>>>
>>>> Thanks for your reply.
>>>>
>>>> 2010/10/27 Gadiyar, Anand<gadiyar@ti.com>:
>>>>>
>>>>> On Wed, Oct 27, 2010 at 5:54 AM, Ming Lei<tom.leiming@gmail.com>    wrote:
>>>>>>
>>>>>> I want to know which type of DMA is taken by musb of DM3730,
>>>>>> INVENTRA_DMA, TI_CPPI_DMA or others?
>>>>>
>>>>> Inventra DMA. An updated version compared to the OMAP34xx/35xx.
>>>>>
>>>>> - No major change to the programming model
>>>>> - The simultaneous TX-RX DMA hang bug is gone with this one.
>>>>
>>>> I find one issue about the dma transfer if Inventra DMA is used, seems
>>>> always 2 bytes less than required length, is it caused by unaligned
>>>> destination address?
>>>>
>>>> See the log captured in g_ether context:
>>>>
>>
>> Ouch, yes. I'd forgotten about this one. I think I did post out patches for
>> this. But I've moved to other activities and didn't follow up. I'll dig them
>> up and  post in a bit.
>>
>> The issue is that, by design, the last 2 bits of DMA_ADDR are masked by the
>> DMA engine; so we need DMA_ADDR to be aligned to a 32-bit boundary.
>>
>> In gadget mode, g_ether is one driver that's badly affected - there were
>> some patches posted which improved g_ether somewhat. In host mode,
>> USB-networking cases were most affected. MUSB has two options:
>>
>> - dma_channel_program can reject transfers to unaligned DMA addresses, so
>> that the backup PIO mode can take over (a quick fix - I'll post this one
>> again)
>>
>> - MUSB can bounce the transfer buffer to another buffer which is properly
>> aligned
>>
>
> Seems such design of DMA engine is a regression in chip, :-(
>
> Both the two options may degrade performance a lot, at least
> for g_ether application.
>
> I don't think there is better fix in software than the two ones
> you posted.
>

Looking at old mail threads, I remember Ajay had one objection to using 
PIO for unaligned transfers - when multiple DMA channels are repeatedly 
hit with unaligned DMA addresses, throughput and CPU load go for a toss. 
Ajay wanted to use the OMAP's SystemDMA engine to carry out the 
transfers in those cases. Anyway, that's a separate topic - and should 
probably be done after the DMA code is rewritten. (I think Felipe had 
some plans for that).

I've posted a patch implementing the quick fix. Let me know if it solves 
the problem with g_ether.

While fixing this, I noticed dma_channel_program also returns "true"
while it is supposed to return an "int". Topic for a separate patch.

- Anand
