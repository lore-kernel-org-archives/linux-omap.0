From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [Question] which type of DMA taken by musb of beagle-xM(DM3730)?
Date: Wed, 27 Oct 2010 22:55:00 +0800
Message-ID: <AANLkTim_xYch-BS0Edc70679Rx03fpofpoGSkTzQV1HW@mail.gmail.com>
References: <AANLkTi=r08ipWPYfEbpsX-tuG=3evFfVazR198ECjFnn@mail.gmail.com>
	<AANLkTi=4K1V2pZQNZOhbkJJ8WCh0X8botpWHOU03p3Hv@mail.gmail.com>
	<AANLkTimYJ-hyNm7nx+dvTrgO4QC2YSjBYjLqHR_wvGni@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:56607 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933645Ab0J0OzC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Oct 2010 10:55:02 -0400
In-Reply-To: <AANLkTimYJ-hyNm7nx+dvTrgO4QC2YSjBYjLqHR_wvGni@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-usb <linux-usb@vger.kernel.org>

2010/10/27 Ming Lei <tom.leiming@gmail.com>:
> Hi Gadiyar,
>
> Thanks for your reply.
>
> 2010/10/27 Gadiyar, Anand <gadiyar@ti.com>:
>> On Wed, Oct 27, 2010 at 5:54 AM, Ming Lei <tom.leiming@gmail.com> wr=
ote:
>>> I want to know which type of DMA is taken by musb of DM3730,
>>> INVENTRA_DMA, TI_CPPI_DMA or others?
>>
>> Inventra DMA. An updated version compared to the OMAP34xx/35xx.
>>
>> - No major change to the programming model
>> - The simultaneous TX-RX DMA hang bug is gone with this one.
>
> I find one issue about the dma transfer if Inventra DMA is used, seem=
s
> always 2 bytes less than required length, is it caused by unaligned
> destination address?
>
> See the log captured in g_ether context:
>
> ......
> musb_g_rx 765: <=3D=3D ep1out, rxcsr 0003 (dma) dec241c0
> dma_channel_program 165: ep1-Rx pkt_sz 512, dma_addr 0x9ecc7802 lengt=
h
> 70, mode 0
> configure_channel 130: dec57068, pkt_sz 512, addr 0x9ecc7802, len 70,=
 mode 0
> dma_controller_irq 302: ch dec57068, 0x9ecc7802 -> 0x9ecc7846 (68 /
> 70) =3D> reconfig 0
> musb_g_rx 765: <=3D=3D ep1out, rxcsr 2003 (dma) dec241c0
> musb_g_rx 808: RXCSR1 0003, dma off, 0003, len 68, req dec241c0
> musb_g_giveback 143: ep1out done request dec241c0, =A068/1536
> musb_gadget_queue 1146: <=3D=3D to ep1out request=3Ddec241c0
> musb_interrupt 1594: ** IRQ peripheral usb0008 tx0000 rx0002
> musb_stage0_irq 462: <=3D=3D Power=3Df0, DevCtl=3D99, int_usb=3D0x8
> musb_g_rx 765: <=3D=3D ep1out, rxcsr 0003 (dma) dec244c0
> dma_channel_program 165: ep1-Rx pkt_sz 512, dma_addr 0x9ecc7002 lengt=
h
> 341, mode 0
> configure_channel 130: dec57068, pkt_sz 512, addr 0x9ecc7002, len 341=
, mode 0
> dma_controller_irq 302: ch dec57068, 0x9ecc7002 -> 0x9ecc7155 (339 /
> 341) =3D> reconfig 0
> ......

BTW:  No such issue in omap3530 of beagle B5, but find it in DM3730 of
beagle xM with the same musb driver and kernel.


--=20
Lei Ming
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
