From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [Question] which type of DMA taken by musb of beagle-xM(DM3730)?
Date: Wed, 27 Oct 2010 22:51:14 +0800
Message-ID: <AANLkTimYJ-hyNm7nx+dvTrgO4QC2YSjBYjLqHR_wvGni@mail.gmail.com>
References: <AANLkTi=r08ipWPYfEbpsX-tuG=3evFfVazR198ECjFnn@mail.gmail.com>
	<AANLkTi=4K1V2pZQNZOhbkJJ8WCh0X8botpWHOU03p3Hv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:47355 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933455Ab0J0OvQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Oct 2010 10:51:16 -0400
In-Reply-To: <AANLkTi=4K1V2pZQNZOhbkJJ8WCh0X8botpWHOU03p3Hv@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-usb <linux-usb@vger.kernel.org>

Hi Gadiyar,

Thanks for your reply.

2010/10/27 Gadiyar, Anand <gadiyar@ti.com>:
> On Wed, Oct 27, 2010 at 5:54 AM, Ming Lei <tom.leiming@gmail.com> wrote:
>> I want to know which type of DMA is taken by musb of DM3730,
>> INVENTRA_DMA, TI_CPPI_DMA or others?
>
> Inventra DMA. An updated version compared to the OMAP34xx/35xx.
>
> - No major change to the programming model
> - The simultaneous TX-RX DMA hang bug is gone with this one.

I find one issue about the dma transfer if Inventra DMA is used, seems
always 2 bytes less than required length, is it caused by unaligned
destination address?

See the log captured in g_ether context:

......
musb_g_rx 765: <== ep1out, rxcsr 0003 (dma) dec241c0
dma_channel_program 165: ep1-Rx pkt_sz 512, dma_addr 0x9ecc7802 length
70, mode 0
configure_channel 130: dec57068, pkt_sz 512, addr 0x9ecc7802, len 70, mode 0
dma_controller_irq 302: ch dec57068, 0x9ecc7802 -> 0x9ecc7846 (68 /
70) => reconfig 0
musb_g_rx 765: <== ep1out, rxcsr 2003 (dma) dec241c0
musb_g_rx 808: RXCSR1 0003, dma off, 0003, len 68, req dec241c0
musb_g_giveback 143: ep1out done request dec241c0,  68/1536
musb_gadget_queue 1146: <== to ep1out request=dec241c0
musb_interrupt 1594: ** IRQ peripheral usb0008 tx0000 rx0002
musb_stage0_irq 462: <== Power=f0, DevCtl=99, int_usb=0x8
musb_g_rx 765: <== ep1out, rxcsr 0003 (dma) dec244c0
dma_channel_program 165: ep1-Rx pkt_sz 512, dma_addr 0x9ecc7002 length
341, mode 0
configure_channel 130: dec57068, pkt_sz 512, addr 0x9ecc7002, len 341, mode 0
dma_controller_irq 302: ch dec57068, 0x9ecc7002 -> 0x9ecc7155 (339 /
341) => reconfig 0
......


thanks,
-- 
Lei Ming
