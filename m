From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: Update SMP_ON_UP code to detect A9MPCore with 1
 CPU devices
Date: Mon, 12 Aug 2013 14:34:13 -0400
Message-ID: <52092AA5.3090005@ti.com>
References: <1375381033-13220-1-git-send-email-santosh.shilimkar@ti.com> <51FBC610.9030900@arm.com> <51FBCEC3.4030207@ti.com> <51FBD42A.9040901@arm.com> <20130802154857.GD5292@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55856 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973Ab3HLSeo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Aug 2013 14:34:44 -0400
In-Reply-To: <20130802154857.GD5292@mudshark.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Vaibhav Bedia <vaibhav.bedia@ti.com>

Will,

On Friday 02 August 2013 11:48 AM, Will Deacon wrote:
> On Fri, Aug 02, 2013 at 04:45:46PM +0100, Sudeep KarkadaNagesha wrote:
>> On 02/08/13 16:22, Santosh Shilimkar wrote:
>>>>> +	@ Core indicates it is SMP.  Check for Aegis SOC where a single
>>>>> +	@ Cortex-A9 CPU is present but SMP operations fault.
>>>>> +	mov	r4, #0x41000000
>>>>> +	orr	r4, r4, #0x0000c000
>>>>> +	orr	r4, r4, #0x00000090
>>>>> +	teq	r3, r4			@ Check for ARM Cortex-A9
>>>>> +	movne	pc, lr			@ Not ARM Cortex-A9,
>>>>> +
>>>>> +	mrc	p15, 4, r0, c15, c0	@ get SCU base address
>>>> Correct me if I am interpreting this wrong, but CRn=15 here which is
>>>> IMPLEMENTATION DEFINED registers.
>>>>
>>>> If not, then I wonder why few platform have to read SCU base from DT or
>>>> some header, why not this way ?
>>>>
>>> I don't know if there is Cortex-A9 based SOC which don't implement SCU
>>> CP15 base address register, so can't comment really why not always use
>>> CP15 based method. I am not even sure if there are other reasons behind
>>> DT usage.
>>>
>> I may be wrong, but it's just my understanding as I see that ARM ARM
>> clearly states CRn=15 space is IMPLEMENTATION DEFINED registers and we
>> can't expect it to work on all IMPLEMENTATIONS.
>>
>> I just had a glance at all the usage of CR15 space of CP15 register, its
>> either platform specific or under specific errata/condition.
>>
>> Will/Dave/Russell can confirm if it's safe to access these registers on
>> any implementation or you may need to make it conditional.
> 
> I think this an A9-specific register, which reads as 0 on UP A9 and reads as
> some form of PERIPH_BASE for SMP parts. The issue I have is when PERIPH_BASE
> is zero.
> 
What do we do here ? Should we document this in the code and proceed ?
Mostly there is no platform with PERIPH_BASE = 0, so its should be fine but
I am open for any other alternative.

Regards,
Santosh

