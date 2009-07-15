From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 2/3] [OMAP:I2C]In case of a NACK|ARDY|AL return from the
 ISR
Date: Wed, 15 Jul 2009 16:37:04 -0500
Message-ID: <4A5E4C00.6090407@ti.com>
References: <CD8CC2B65FEE304DA95744A5472698F202957C7AFA@dlee06.ent.ti.com> <7A436F7769CA33409C6B44B358BFFF0C011E5ED9E0@dlee02.ent.ti.com> <CD8CC2B65FEE304DA95744A5472698F202957C7C2D@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38869 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752391AbZGOVhL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Jul 2009 17:37:11 -0400
In-Reply-To: <CD8CC2B65FEE304DA95744A5472698F202957C7C2D@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sonasath, Moiz" <m-sonasath@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kamat, Nishant" <nskamat@ti.com>, Paul Walmsley <paul@pwsan.com>

Sonasath, Moiz had written, on 07/15/2009 10:25 AM, the following:
>> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
>> index d280acf..05b5e4c 100644
>> --- a/drivers/i2c/busses/i2c-omap.c
>> +++ b/drivers/i2c/busses/i2c-omap.c
>> @@ -685,8 +685,10 @@ omap_i2c_isr(int this_irq, void *dev_id)
>>  			err |= OMAP_I2C_STAT_AL;
>>  		}
>>  		if (stat & (OMAP_I2C_STAT_ARDY | OMAP_I2C_STAT_NACK |
>> -					OMAP_I2C_STAT_AL))
>> +					OMAP_I2C_STAT_AL)) {
>>  			omap_i2c_complete_cmd(dev, err);
>> +			return IRQ_HANDLED;
>> +		}
> What is the status of IRQ_STAT register? Who will clear that if we return immediately from ISR? Isr will be reinvoked and we'd handle the same anyways..
> 
> [Moiz]
> Correct me if I am wrong, but you are referring to the OMAP_I2C_STAT_REG (which has the interrupt status information). 
 >This is actually ACKED just before going into the NACK|AL|ARDY error 
cases. I suppose a few days back you also sent out a
 >atch to change this to ACK all interrupts other than RRDY/RDR and 
XRDY/XDR as we have to ACK these only after we service them.
>
> I think this conflicts with [1]
> [Moiz]
> Actually, it does not conflict with [1], as [1] changes the later part of the code allowing this patch to be applied cleanly.

Got it. Thanks for clarifying. my bad.
Acked-by: Nishanth Menon <nm@ti.com>
-- 
Regards,
Nishanth Menon
