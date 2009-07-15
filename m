From: "Sonasath, Moiz" <m-sonasath@ti.com>
Subject: RE: [PATCH 3/3] [OMAP:I2C]OMAP3430 Silicon Errata 1.153
Date: Wed, 15 Jul 2009 17:23:15 -0500
Message-ID: <CD8CC2B65FEE304DA95744A5472698F202957C7DB5@dlee06.ent.ti.com>
References: <CD8CC2B65FEE304DA95744A5472698F202957C7AFE@dlee06.ent.ti.com>
 <4A5D136D.8030701@ti.com>
 <CD8CC2B65FEE304DA95744A5472698F202957C7C3A@dlee06.ent.ti.com>
 <4A5E4D7A.6010706@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60475 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755599AbZGOWXU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Jul 2009 18:23:20 -0400
In-Reply-To: <4A5E4D7A.6010706@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kamat, Nishant" <nskamat@ti.com>, Paul Walmsley <paul@pwsan.com>, "Pandita, Vikram" <vikram.pandita@ti.com>

Hello Nishant,

Comments inlined,

Regards
Moiz Sonasath


-----Original Message-----
From: Menon, Nishanth 
Sent: Wednesday, July 15, 2009 4:43 PM
To: Sonasath, Moiz
Cc: linux-omap@vger.kernel.org; Kamat, Nishant; Paul Walmsley
Subject: Re: [PATCH 3/3] [OMAP:I2C]OMAP3430 Silicon Errata 1.153

Sonasath, Moiz had written, on 07/15/2009 10:40 AM, the following:
>> When an XRDY/XDR is hit, wait for XUDF before writing data to DATA_REG.
>> Otherwise some data bytes can be lost while transferring them from the
>> memory to the I2C interface.
>>
>> Do a Busy-wait for XUDF, before writing data to DATA_REG. While waiting
>> if there is NACK | AL, set the appropriate error flags, ack the pending
>> +							}
>> +							cpu_relax();
>> +							stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
>> +						}
> this is an infinite while loop + it tries to handle error cases - 
> essentially do another isr routine inside itself.
> [Moiz]
> Yes, it is a busy wait loop. But AFAIK while we come to this part of
 > the code the only thing that can go wrong in the transfer is either
 > the device would go off suddenly (creating a NACK) or there is an
 > arbitration lost(AL). This loop takes care of these two error conditions.
 > Apart from these, if the hardware is functional, the XUDF bit should
 > be set as soon as the FIFO gets empty.
> 
> Correct me if I am missing something.
That is exactly what I was complaining about -> why not use the existing 
logic above in the code to take care of it as I indicated below? do you 
see a problem with the logic I send? it is lesser code and should IMHO 
take care of the same issue without the additional 3rd nested while loop
> 
> How about:
> Apply [1] and the following?
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index ad8d201..e3f21af 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -728,6 +728,12 @@ omap_i2c_isr(int this_irq, void *dev_id)
>                  }
>                  if (stat & (OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR)) {
>                          u8 num_bytes = 1;
> +                       if (cpu_is_omap34xx() &&
> +                               !(stat & OMAP_I2C_STAT_XUDF)){
> +                               cpu_relax();
> +                               continue;
> +                       }
> +

[Moiz]

In this alternate implementation if a NACK|AL is produced while waiting on the XUDF, it returns from the ISR (as per my patch [2/3]) without ACKING the XRDY/XDR interrupts which would make it return to the ISR again and again which looks like a problem. To accommodate this implementation, we will have to ACK XRDY/XDR before returning from the ISR.
		

>                          if (dev->fifo_size) {
>                                  if (stat & OMAP_I2C_STAT_XRDY)
>                                          num_bytes = dev->fifo_size;
> 
> 
> Regards,
> Nishanth Menon
> Ref:
> [1] http://patchwork.kernel.org/patch/32332/

-- 
Regards,
Nishanth Menon
