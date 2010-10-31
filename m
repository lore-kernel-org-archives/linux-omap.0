From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [Question] which type of DMA taken by musb of beagle-xM(DM3730)?
Date: Sun, 31 Oct 2010 18:11:37 +0800
Message-ID: <AANLkTin8WukW0nZUEv08-2V7wLh3Q3_xGu1P2syz5VD+@mail.gmail.com>
References: <AANLkTi=r08ipWPYfEbpsX-tuG=3evFfVazR198ECjFnn@mail.gmail.com>
	<AANLkTi=4K1V2pZQNZOhbkJJ8WCh0X8botpWHOU03p3Hv@mail.gmail.com>
	<AANLkTimYJ-hyNm7nx+dvTrgO4QC2YSjBYjLqHR_wvGni@mail.gmail.com>
	<AANLkTim_xYch-BS0Edc70679Rx03fpofpoGSkTzQV1HW@mail.gmail.com>
	<4CC84109.9040304@ti.com>
	<AANLkTi=ZHb4iNW3KzJzoVyMP1bp3ne3oRmW3YWh0ueEm@mail.gmail.com>
	<4CCCFFD3.6050703@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39855 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755008Ab0JaKLj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 31 Oct 2010 06:11:39 -0400
In-Reply-To: <4CCCFFD3.6050703@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-usb <linux-usb@vger.kernel.org>

2010/10/31 Anand Gadiyar <gadiyar@ti.com>:
> On 10/27/2010 11:27 AM, Ming Lei wrote:

>> I don't think there is better fix in software than the two ones
>> you posted.
>>
>
> Looking at old mail threads, I remember Ajay had one objection to using PIO
> for unaligned transfers - when multiple DMA channels are repeatedly hit with
> unaligned DMA addresses, throughput and CPU load go for a toss. Ajay wanted
> to use the OMAP's SystemDMA engine to carry out the transfers in those
> cases. Anyway, that's a separate topic - and should probably be done after
> the DMA code is rewritten. (I think Felipe had some plans for that).

Seems DMA code should not be rewritten, only a DMA version
of musb_write_fifo and musb_read_fifo need to be implemented as
omap dependent code just like Blackfin,  right?

>
> I've posted a patch implementing the quick fix. Let me know if it solves the
> problem with g_ether.

Yes, I have tested your patch about g_ether on beagle xM, and it does fix
the DMA issue for unaligned buffer address.

>
> While fixing this, I noticed dma_channel_program also returns "true"
> while it is supposed to return an "int". Topic for a separate patch.
>
> - Anand
>


-- 
Lei Ming
