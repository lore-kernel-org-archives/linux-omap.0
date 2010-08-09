From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 1/3] OMAP4: prcm: Add temporarily helper functions for
 rmw and read inside the PRM
Date: Mon, 09 Aug 2010 19:34:03 +0200
Message-ID: <4C603C0B.4070602@ti.com>
References: <1280959968-23933-1-git-send-email-b-cousson@ti.com>	<1280959968-23933-2-git-send-email-b-cousson@ti.com> <87hbj3lmmo.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49244 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751029Ab0HIReK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 9 Aug 2010 13:34:10 -0400
In-Reply-To: <87hbj3lmmo.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

On 8/9/2010 7:30 PM, Kevin Hilman wrote:
> Benoit Cousson<b-cousson@ti.com>  writes:
>
>> Since OMAP4 is using an absolute address, the current PRM accessors
>> are not useable.
>> OMAP4 adaptation for these API are currently ongoing, so define temp
>> version until the proper ones are defined.
>
> Curious what we're waiting for for the final versions of these?

That should be soon... Rajendra is working on that... among hundreds 
other stuff.

Benoit

> Kevin
>
>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>> Cc: Paul Walmsley<paul@pwsan.com>
>> Cc: Kevin Hilman<khilman@deeprootsystems.com>
>> ---
>>   arch/arm/mach-omap2/prcm.c             |   24 ++++++++++++++++++++++++
>>   arch/arm/plat-omap/include/plat/prcm.h |    2 ++
>>   2 files changed, 26 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
>> index 96f4616..d4388d3 100644
>> --- a/arch/arm/mach-omap2/prcm.c
>> +++ b/arch/arm/mach-omap2/prcm.c
>> @@ -216,6 +216,30 @@ u32 prm_read_mod_bits_shift(s16 domain, s16 idx, u32 mask)
>>   	return v;
>>   }
>>
>> +/* Read a PRM register, AND it, and shift the result down to bit 0 */
>> +u32 omap4_prm_read_bits_shift(void __iomem *reg, u32 mask)
>> +{
>> +	u32 v;
>> +
>> +	v = __raw_readl(reg);
>> +	v&= mask;
>> +	v>>= __ffs(mask);
>> +
>> +	return v;
>> +}
>> +
>> +/* Read-modify-write a register in a PRM module. Caller must lock */
>> +u32 omap4_prm_rmw_reg_bits(u32 mask, u32 bits, void __iomem *reg)
>> +{
>> +	u32 v;
>> +
>> +	v = __raw_readl(reg);
>> +	v&= ~mask;
>> +	v |= bits;
>> +	__raw_writel(v, reg);
>> +
>> +	return v;
>> +}
>>   /* Read a register in a CM module */
>>   u32 cm_read_mod_reg(s16 module, u16 idx)
>>   {
>> diff --git a/arch/arm/plat-omap/include/plat/prcm.h b/arch/arm/plat-omap/include/plat/prcm.h
>> index 9fbd914..ab77442 100644
>> --- a/arch/arm/plat-omap/include/plat/prcm.h
>> +++ b/arch/arm/plat-omap/include/plat/prcm.h
>> @@ -38,6 +38,8 @@ u32 prm_read_mod_reg(s16 module, u16 idx);
>>   void prm_write_mod_reg(u32 val, s16 module, u16 idx);
>>   u32 prm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx);
>>   u32 prm_read_mod_bits_shift(s16 domain, s16 idx, u32 mask);
>> +u32 omap4_prm_read_bits_shift(void __iomem *reg, u32 mask);
>> +u32 omap4_prm_rmw_reg_bits(u32 mask, u32 bits, void __iomem *reg);
>>   u32 cm_read_mod_reg(s16 module, u16 idx);
>>   void cm_write_mod_reg(u32 val, s16 module, u16 idx);
>>   u32 cm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx);

