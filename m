From: Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Question] which type of DMA taken by musb of beagle-xM(DM3730)?
Date: Wed, 27 Oct 2010 23:27:19 +0800
Message-ID: <AANLkTi=ZHb4iNW3KzJzoVyMP1bp3ne3oRmW3YWh0ueEm@mail.gmail.com>
References: <AANLkTi=r08ipWPYfEbpsX-tuG=3evFfVazR198ECjFnn@mail.gmail.com>
	<AANLkTi=4K1V2pZQNZOhbkJJ8WCh0X8botpWHOU03p3Hv@mail.gmail.com>
	<AANLkTimYJ-hyNm7nx+dvTrgO4QC2YSjBYjLqHR_wvGni@mail.gmail.com>
	<AANLkTim_xYch-BS0Edc70679Rx03fpofpoGSkTzQV1HW@mail.gmail.com>
	<4CC84109.9040304@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4CC84109.9040304-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

2010/10/27 Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>:
> On 10/27/2010 10:55 AM, Ming Lei wrote:
>>
>> 2010/10/27 Ming Lei<tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>>>
>>> Hi Gadiyar,
>>>
>>> Thanks for your reply.
>>>
>>> 2010/10/27 Gadiyar, Anand<gadiyar-l0cyMroinI0@public.gmane.org>:
>>>>
>>>> On Wed, Oct 27, 2010 at 5:54 AM, Ming Lei<tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> =A0=
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

Seems such design of DMA engine is a regression in chip, :-(

Both the two options may degrade performance a lot, at least
for g_ether application.

I don't think there is better fix in software than the two ones
you posted.

thanks,
--=20
Lei Ming
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
