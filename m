From: "Pedanekar, Hemant" <hemantp@ti.com>
Subject: RE: [PATCH 2/6] TI816X: Update common omap platform files
Date: Thu, 5 Aug 2010 20:46:12 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B030E65BB20@dbde02.ent.ti.com>
References: <1280523096-25041-1-git-send-email-hemantp@ti.com>
 <87ocdh2kwx.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49147 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933589Ab0HEPQT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Aug 2010 11:16:19 -0400
In-Reply-To: <87ocdh2kwx.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

Kevin Hilman wrote:
> Hemant Pedanekar <hemantp@ti.com> writes:
> 
>> This patch updates the common platform files with TI816X specific
>> additions. 
>> 
>> Also adds new files for TI816X modules base addresseses and irq
>> definitions. 
>> 
[...]
>> +		bne	9998f
>> +
>> +		/*
>> +		 * ti816x has additional IRQ pending register. Checking this
>> +		 * register on omap2 & omap3 has no effect (read as 0). +		 */
>> +		ldr	\irqnr, [\base, #0xf8] /* IRQ pending reg 4 */
>> +		cmp	\irqnr, #0x0
> 
> This part makes me a slightly nervous.  At least according to
> the TRMs,
> this address is undefined on OMAP2 & OMAP3 (yet still in the
> INTC block.)
> Was this tested on OMAP2/3 hardware and verified to return 0?
>

I tested this on OMAP3 but haven't verified on OMAP2. I will try to 
check this on all the variants.
  
> You might also consider wrapping this section in
> #ifdef CONFIG_ARCH_TI816X so a multi-OMAP kernel without 816x support would
> avoid this extra read. 
>

Yes, that is better. Will add.
 
>>  9998:
>>  		ldrne	\irqnr, [\base, #INTCPS_SIR_IRQ_OFFSET]
>>  		and	\irqnr, \irqnr, #ACTIVEIRQ_MASK /* Clear spurious bits */
>> @@ -139,6 +148,35 @@ omap_irq_base:	.word	0
>>  		.endm
>>  #endif
>> 
>> +/*
>> + * Optimized irq functions for ti816x
>> + */
>> +
>> +#ifdef CONFiG_ARCH_TI816X
>               ^
> typo?  these are case-sensitive, so this part would never be compiled
>
Yes, I will fix this.
 
[...]
> 
> Kevin


Thanks
-
Hemant

