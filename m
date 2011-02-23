From: Sricharan R <r.sricharan@ti.com>
Subject: RE: [PATCH 4/6] omap4: hwmod_data: Add l3 errorlog data to hwmod database.
Date: Wed, 23 Feb 2011 11:08:31 +0530
Message-ID: <43067ab756e2e48efb745dee3ecc67eb@mail.gmail.com>
References: <1298295990-1070-1-git-send-email-santosh.shilimkar@ti.com>
 <1298295990-1070-5-git-send-email-santosh.shilimkar@ti.com> <4D627937.8030309@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:44084 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750795Ab1BWFii (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Feb 2011 00:38:38 -0500
Received: by eyg24 with SMTP id 24so1000113eyg.11
        for <linux-omap@vger.kernel.org>; Tue, 22 Feb 2011 21:38:35 -0800 (PST)
In-Reply-To: <4D627937.8030309@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>

Hi Benoit,
>-----Original Message-----
>From: Cousson, Benoit [mailto:b-cousson@ti.com]
>Sent: Monday, February 21, 2011 8:10 PM
>To: Shilimkar, Santosh
>Cc: linux-omap@vger.kernel.org; Balbi, Felipe; R, Sricharan
>Subject: Re: [PATCH 4/6] omap4: hwmod_data: Add l3 errorlog data to hwmod
>database.
>
>Hi Sricharan,
>
>On 2/21/2011 2:46 PM, Shilimkar, Santosh wrote:
>> From: sricharan<r.sricharan@ti.com>
>>
>> Add the error log registers, irqs of the l3 interconnect to the
>> hwmod data. The hwmod change is aligned with Benoit Cousson.
>
>The change is almost aligned with Benoit Cousson :-)
>
>The subject should be something like: omap4: hwmod data: Add address
>space and irq in L3 hwmod
>
>There is no errolog data in that patch. The changelog should be updated
>too.
Ok. I will change the subject and the change log as well.
>
>> Signed-off-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
>> Signed-off-by: sricharan<r.sricharan@ti.com>
>> Tested-by: sricharan<r.sricharan@ti.com>
>> Cc: Benoit Cousson<b-cousson@ti.com>
>> ---
>>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   28
>++++++++++++++++++++++++++++
>>   1 files changed, 28 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
b/arch/arm/mach-
>omap2/omap_hwmod_44xx_data.c
>> index c2806bd..95001d4 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> @@ -229,11 +229,37 @@ static struct omap_hwmod_ocp_if
>omap44xx_l4_cfg__l3_main_1 = {
>>   	.user		= OCP_USER_MPU | OCP_USER_SDMA,
>>   };
>>
>> +/* L3 target configuration and error log registers */
>> +static struct omap_hwmod_irq_info omap44xx_l3_targ_irqs[] = {
>> +	{ .irq = 9  + OMAP44XX_IRQ_GIC_START },
>> +	{ .irq = 10 + OMAP44XX_IRQ_GIC_START },
>> +};
>> +
>> +static struct omap_hwmod_addr_space omap44xx_l3_targ_addrs[] = {
>> +	{
>> +		.pa_start	= 0x44000000,
>> +		.pa_end		= 0x44100000,
>> +		.flags		= ADDR_TYPE_RT,
>> +	},
>> +	{
>> +		.pa_start	= 0x44800000,
>> +		.pa_end		= 0x44900000,
>> +		.flags		= ADDR_TYPE_RT,
>> +	},
>> +	{
>> +		.pa_start	= 0x45000000,
>> +		.pa_end		= 0x45100000,
>> +		.flags		= ADDR_TYPE_RT,
>
>IIRC, we do have one address space per l3_main instance, and we do have
>3 instances and thus 3 hwmods.
>So you should potentially duplicate the code below at hwmod structure
>level and not only at address space level.
>
>In that case, you will re-group the 3 instances in only one omap_device.
>For the IRQ, in theory we should duplicate the same entry 3 times just
>in case someone want to use only the second instance. But, I'm still not
>convinced this is the right thing to do... so let's keep it only for
>l3_main_1 for the moment.
Ok.
>
>Regards,
>Benoit
