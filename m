From: Sebastien Guiriec <s-guiriec@ti.com>
Subject: Re: [PATCH 08/10] ARM: OMAP5: hwmod data: Create initial OMAP5 SOC
 hwmod data
Date: Mon, 21 Jan 2013 15:25:52 +0100
Message-ID: <50FD4FF0.1020403@ti.com>
References: <1358522856-12180-1-git-send-email-santosh.shilimkar@ti.com> <1358522856-12180-9-git-send-email-santosh.shilimkar@ti.com> <20130118171500.GC15361@atomide.com> <50FCF838.6000105@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41510 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753809Ab3AUO0E (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Jan 2013 09:26:04 -0500
In-Reply-To: <50FCF838.6000105@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mturquette@linaro.org, rnayak@ti.com, b-cousson@ti.com, Paul Walmsley <paul@pwsan.com>

Hi Santosh

We can also remove all the next data:
	omap54xx_l4_abe__aess_dma,
	omap54xx_l4_abe__dmic_dma,
	omap54xx_l4_abe__mcasp_dma,
	omap54xx_l4_abe__mcbsp1_dma,
	omap54xx_l4_abe__mcbsp2_dma,
	omap54xx_l4_abe__mcbsp3_dma,
	omap54xx_l4_abe__mcpdm_dma,
	omap54xx_l4_abe__slimbus1_dma,
	omap54xx_l4_abe__timer5_dma,
	omap54xx_l4_abe__timer6_dma,
	omap54xx_l4_abe__timer7_dma,
	omap54xx_l4_abe__timer8_dma,
	omap54xx_l4_abe__wd_timer3_dma,

It was needed in the past due to the way the lockup between DT data and 
hwmod was done but Peter clean it up in 3.8.

For AESS we just need the last memory bank due to hwmod code for 
SYS_CONFIG access.

Best regards,

Sebastien


On 01/21/2013 09:11 AM, Santosh Shilimkar wrote:
> On Friday 18 January 2013 10:45 PM, Tony Lindgren wrote:
>> Hi,
>>
>> * Santosh Shilimkar <santosh.shilimkar@ti.com> [130118 07:30]:
>>> From: Benoit Cousson <b-cousson@ti.com>
>>>
>>> Adding the hwmod data for OMAP54xx platforms.
>>> --- /dev/null
>>> +++ b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
>>> +/* bb2d */
>>> +static struct omap_hwmod_irq_info omap54xx_bb2d_irqs[] = {
>>> +    { .irq = 125 + OMAP54XX_IRQ_GIC_START },
>>> +    { .irq = -1 }
>>> +};
>> ...
>>
>>> +/* c2c */
>>> +static struct omap_hwmod_irq_info omap54xx_c2c_irqs[] = {
>>> +    { .irq = 88 + OMAP54XX_IRQ_GIC_START },
>>> +    { .irq = -1 }
>>> +};
>> ...
>>
>>
>>> +static struct omap_hwmod_dma_info omap54xx_c2c_sdma_reqs[] = {
>>> +    { .dma_req = 68 + OMAP54XX_DMA_REQ_START },
>>> +    { .dma_req = -1 }
>>> +};
>>
>>
>>
>>> +static struct omap_hwmod_addr_space omap54xx_elm_addrs[] = {
>>> +    {
>>> +        .pa_start    = 0x48078000,
>>> +        .pa_end        = 0x48078fff,
>>> +        .flags        = ADDR_TYPE_RT
>>> +    },
>>> +    { }
>>> +};
>> ...
>>
>>> +static struct omap_hwmod_addr_space omap54xx_emif1_addrs[] = {
>>> +    {
>>> +        .pa_start    = 0x4c000000,
>>> +        .pa_end        = 0x4c0003ff,
>>> +        .flags        = ADDR_TYPE_RT
>>> +    },
>>> +    { }
>>> +};
>>
>> As discussed earlier on this list, let's not duplicate the standard
>> resources here as they already are supposed to come from device tree.
>>
>> Whatever issues prevent us from dropping the duplicate data here need
>> to be fixed. I believe Benoit already had some scripts/patches for
>> that and was just waiting for the DMA binding to get merged?
>>
> Will have a loot at it. DMA binding pull request narrowly missed
> 3.8 but should get into 3.9.
>
> Regards
> santosh
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

