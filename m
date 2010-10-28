From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [Question] which type of DMA taken by musb of beagle-xM(DM3730)?
Date: Thu, 28 Oct 2010 23:36:58 +0800
Message-ID: <AANLkTikUqXpMhPfMV78sf4zusQ-h4JpE+eSgnnpE2PON@mail.gmail.com>
References: <AANLkTi=r08ipWPYfEbpsX-tuG=3evFfVazR198ECjFnn@mail.gmail.com>
	<AANLkTi=4K1V2pZQNZOhbkJJ8WCh0X8botpWHOU03p3Hv@mail.gmail.com>
	<AANLkTimYJ-hyNm7nx+dvTrgO4QC2YSjBYjLqHR_wvGni@mail.gmail.com>
	<AANLkTim_xYch-BS0Edc70679Rx03fpofpoGSkTzQV1HW@mail.gmail.com>
	<4CC84109.9040304@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48815 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752525Ab0J1Pg7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Oct 2010 11:36:59 -0400
In-Reply-To: <4CC84109.9040304@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-usb <linux-usb@vger.kernel.org>

Hello,

2010/10/27 Anand Gadiyar <gadiyar@ti.com>:
> On 10/27/2010 10:55 AM, Ming Lei wrote:
>>
>> 2010/10/27 Ming Lei<tom.leiming@gmail.com>:
>>>
>>> Hi Gadiyar,
>>>
>>> Thanks for your reply.
>>>
>>> 2010/10/27 Gadiyar, Anand<gadiyar@ti.com>:
>>>>
>>>> On Wed, Oct 27, 2010 at 5:54 AM, Ming Lei<tom.leiming@gmail.com> =A0=
wrote:
>>>>>
>>>>> I want to know which type of DMA is taken by musb of DM3730,
>>>>> INVENTRA_DMA, TI_CPPI_DMA or others?
>>>>
>>>> Inventra DMA. An updated version compared to the OMAP34xx/35xx.
>>>>
>>>> - No major change to the programming model
>>>> - The simultaneous TX-RX DMA hang bug is gone with this one.
>>>
>>> I find one issue about the dma transfer if Inventra DMA is used, se=
ems
>>> always 2 bytes less than required length, is it caused by unaligned
>>> destination address?
>>>
>>> See the log captured in g_ether context:
>>>
>
> Ouch, yes. I'd forgotten about this one. I think I did post out patch=
es for
> this. But I've moved to other activities and didn't follow up. I'll d=
ig them
> up and =A0post in a bit.
>
> The issue is that, by design, the last 2 bits of DMA_ADDR are masked =
by the
> DMA engine; so we need DMA_ADDR to be aligned to a 32-bit boundary.
>
> In gadget mode, g_ether is one driver that's badly affected - there w=
ere
> some patches posted which improved g_ether somewhat. In host mode,
> USB-networking cases were most affected. MUSB has two options:
>
> - dma_channel_program can reject transfers to unaligned DMA addresses=
, so
> that the backup PIO mode can take over (a quick fix - I'll post this =
one
> again)
>
> - MUSB can bounce the transfer buffer to another buffer which is prop=
erly
> aligned
>
> Any other ideas?

Another question, musb_read_fifo and musb_write_fifo need to be fixed t=
o
use 32bit operation only alike am35x?

thanks,
--=20
Lei Ming
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
