From: "andrzej zaborowski" <balrogg@gmail.com>
Subject: Re: [PATCH 1/2] driver: irda support 3430
Date: Fri, 4 Jul 2008 18:17:10 +0200
Message-ID: <fb249edb0807040917p2af2db49h4135249b835d8033@mail.gmail.com>
References: <63319.192.168.10.89.1215067509.squirrel@dbdmail.itg.ti.com>
	 <20080703103717.GN14276@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:6593 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752219AbYGDQRO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Jul 2008 12:17:14 -0400
Received: by ug-out-1314.google.com with SMTP id h2so812916ugf.16
        for <linux-omap@vger.kernel.org>; Fri, 04 Jul 2008 09:17:10 -0700 (PDT)
In-Reply-To: <20080703103717.GN14276@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Girish. S. G." <girishsg@ti.com>, linux-omap@vger.kernel.org

2008/7/3 Tony Lindgren <tony@atomide.com>:
> Hi,
>
> * Girish. S. G. <girishsg@ti.com> [080703 11:10]:
>> Irda driver changes to support on 3430
>>
>> Signed-off-by: Girish S G <girishsg@ti.com>
>> ---
>>  drivers/net/irda/omap-ir.c |   14 +++++++++++---
>>  1 files changed, 11 insertions(+), 3 deletions(-)
>>
>> Index: linux-omap-2.6_today/drivers/net/irda/omap-ir.c
>> ===================================================================
>> --- linux-omap-2.6_today.orig/drivers/net/irda/omap-ir.c      2008-07-03
>> 10:33:57.000000000 +0530
>> +++ linux-omap-2.6_today/drivers/net/irda/omap-ir.c   2008-07-03
>> 10:35:30.000000000 +0530
>> @@ -217,7 +217,7 @@
>>       struct net_device *dev = data;
>>       struct omap_irda *omap_ir = netdev_priv(dev);
>>
>> -     /*Stop DMA controller */
>> +     /* Stop DMA controller */
>>       omap_stop_dma(omap_ir->tx_dma_channel);
>>  }
>>
>> @@ -378,8 +378,12 @@
>>
>>               skb_reserve(skb, 1);
>>
>> -             w = omap_get_dma_dst_pos(omap_ir->rx_dma_channel) -
>> -                                             omap_ir->rx_buf_dma_phys;
>> +             w = OMAP_DMA4_CDAC(omap_ir->rx_dma_channel);

Anything with DMA4 in the name won't work on OMAP1 and may return an
unspecified value I'm afraid.

>> +
>> +             if (cpu_is_omap16xx())
>> +                     w -= OMAP1_DMA_CDSA_L(omap_ir->rx_dma_channel);
>> +             if (cpu_is_omap24xx() || cpu_is_omap34xx())
>> +                     w -= OMAP_DMA4_CDSA(omap_ir->rx_dma_channel);
>>
>>               if (!IS_FIR(omap_ir))
>>                       /* Copy DMA buffer to skb */
>
> Let's not tinker with the DMA registers again directly just as I
> thought I got all that clean-up a bit! :)
>
> Can you rather use the exported functions? If something is missing,
> let's add it. But in the above case omap_set_dma_dest_params() and
> omap_set_dma_src_params() should work I believe.

Actually iirc omap_set_dma_dst_params() doesn't work on OMAP15xx,
because CDAC was added in DMA3.2 and OMAP15xx has DMA3.1. I had a
patch somewhere to use this IrDA driver on OMAP15xx and the main
change was this.

Regards
