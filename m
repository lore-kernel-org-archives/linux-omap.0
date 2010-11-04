From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v3 06/13] OMAP3: DMA: hwmod: add system DMA
Date: Thu, 04 Nov 2010 00:29:01 -0400
Message-ID: <4CD2368D.50107@ti.com>
References: <1288099513-1854-1-git-send-email-manjugk@ti.com> <1288099513-1854-7-git-send-email-manjugk@ti.com> <E0D41E29EB0DAC4E9F3FF173962E9E9402DC03B4C3@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37844 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751300Ab0KDE2E (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Nov 2010 00:28:04 -0400
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E9402DC03B4C3@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Manjunath,

On 11/3/2010 8:59 AM, G, Manjunath Kondaiah wrote:
> Kevin/Benoit,
>
>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of G,
>> Manjunath Kondaiah
>> Sent: Tuesday, October 26, 2010 6:55 PM
>>
>> Add OMAP3 DMA hwmod structures.
>>
>> Signed-off-by: G, Manjunath Kondaiah<manjugk@ti.com>
>> Cc: Benoit Cousson<b-cousson@ti.com>
>> Cc: Kevin Hilman<khilman@deeprootsystems.com>
>> Cc: Santosh Shilimkar<santosh.shilimkar@ti.com>
>> ---
>>   arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   93
>> ++++++++++++++++++++++++++++
>>   1 files changed, 93 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
>> b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
>> index ed6bf4a..4a5231c 100644
> [...]
>> +	.prcm = {
>> +		.omap2 = {
>> +			.prcm_reg_id		= 1,
>> +			.module_bit		=
>> OMAP3430_ST_SDMA_SHIFT,
>> +			.idlest_reg_id		= 1,
>> +			.idlest_idle_bit	=
>> OMAP3430_ST_SDMA_SHIFT,
>
> Looks like the .module_offs field is missing here. Since
> ST_SDMA bit belongs to CM_IDLEST1_CORE register, .module_offs should
> be CORE_MOD.
>
> But, it is observed that, using .module_offs results in warning dump
> during bootup. This is due to, ST_SDMA bit in standby mode. Since
> there is no fclk for DMA, this bit will never change till DMA channel
> is requested for data transfer.
>
> We might have to bypass calling "omap2_cm_wait_module_ready" in
> "_wait_target_ready" in omap_hwmod.c
>
> With exising flags, we can use "HWMOD_NO_IDLEST" flag, but this
> flag has different meaning. How about using new flag like
> "HWMOD_NO_FCLK_OPCLK" and if it is set, return without calling
> "omap2_cm_wait_module_ready"
>
> Any better suggestion to handle this issue?

Well, yes, use HWMOD_NO_IDLEST and remove idlest_reg_id & 
idlest_idle_bit entries in the omap2 structure.

ST_SDMA is the standby status of the SDMA, but there is no idle status 
on that IP, so you cannot do anything.
The standby will just reflect the activity of the master port of the 
DMA, but it will give you no information about the slave port and thus 
we do not have any module ready information.

Regards,
Benoit
