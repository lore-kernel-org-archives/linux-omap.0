From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCHv3 8/17] dmtimer: register mappings moved to hwmod database
Date: Tue, 12 Oct 2010 13:11:10 +0200
Message-ID: <4CB4424E.9050000@ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB593023436338D@dbde02.ent.ti.com> <4CB415EE.2010409@ti.com> <B85A65D85D7EB246BE421B3FB0FBB59302343634CA@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53734 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757196Ab0JLLKx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Oct 2010 07:10:53 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59302343634CA@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Basak, Partha" <p-basak2@ti.com>
Cc: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

On 10/12/2010 11:35 AM, Basak, Partha wrote:
>
>> From: Cousson, Benoit
>> Sent: Tuesday, October 12, 2010 1:32 PM
>> To: Basak, Partha
>> Cc: DebBarma, Tarun Kanti; Kevin Hilman; G, Manjunath
>> Kondaiah; linux-omap@vger.kernel.org; Shilimkar, Santosh;
>> Paul Walmsley; Tony Lindgren
>> Subject: Re: [PATCHv3 8/17] dmtimer: register mappings moved
>> to hwmod database
>>
>> On 10/12/2010 9:22 AM, Basak, Partha wrote:
>>>
>>>> From: DebBarma, Tarun Kanti
>>>> Sent: Tuesday, October 12, 2010 11:19 AM
>>>> To: Cousson, Benoit
>>>>
>>>> Benoit,
>>>>> From: Cousson, Benoit
>>>>> Sent: Tuesday, October 12, 2010 4:42 AM
>>>>> To: DebBarma, Tarun Kanti
>>>>>
>>>>> Hi Tarun,
>>>>>
>>>>> On 10/9/2010 5:40 PM, DebBarma, Tarun Kanti wrote:
>>>>>> Benoit,
>>>>>>
>>>>>>> From: Cousson, Benoit
>>>>>>> Sent: Thursday, September 23, 2010 10:15 PM
>>>>>>> To: Basak, Partha
>>>>>>>
>>>>>>> On 9/23/2010 11:34 AM, Basak, Partha wrote:
>>>>>>>>
>>>>>>>>> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>>>>>>>> Sent: Thursday, September 23, 2010 3:10 AM
>>>>>>>>>
>>>>>>>>> "G, Manjunath Kondaiah"<manjugk@ti.com>     writes:
>>>>>>>>>
>>>>>>>>>> Hi Tarun,
>>>>>>>>>>
>>>>>>>>>>> From: linux-omap-owner@vger.kernel.org
>>>>>>>>>>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
>>>>>>>>>>> DebBarma, Tarun Kanti
>>
>> <...>
>>
>>>>>>>
>>>>>>> Also, I'm not sure that you have to handle each register
>>>> separately
>>>>>>> considering that you have one offset to handle for the
>> functional
>>>>>>> register.
>>>>>>> The change in sysconfig and interrupt register are all
>>>> standard mapping
>>>>>>> that stick to TI highlander standard.
>>>>>>> Meaning, as soon as an IP is a v2 (highlander version) all these
>>>>>>> registers will be at the same place... at least in theory :-)
>>>>>>>
>>>>>>> Here are the deltas between the legacy and the new one:
>>>>>>>
>>>>>>> [OMAP_TIMER_ID_REG]             0x00,
>>>>>>> [OMAP_TIMER_OCP_CFG_REG]        0x10, same
>>>>>>> [OMAP_TIMER_SYS_STAT_REG]       0x14, (not used anymore)
>>>>>>>
>>>>>>> You should not care about these ones, because hwmod will
>>>> handle them.
>>>>>>>
>>>>>>> [OMAP_TIMER_STAT_REG]           0x28, +10
>>>>>>> [OMAP_TIMER_INT_EN_REG]         0x2c, +10
>>>>>>> [OMAP_TIMER_INT_CLR_REG]        0x30, (new)
>>>>>>>
>>>>>>> These ones are standard registers
>>>>>>>
>>>>>>> [OMAP_TIMER_WAKEUP_EN_REG]      0x34, +14
>>>>>>> [OMAP_TIMER_CTRL_REG]           0x38, +14
>>>>>>> [OMAP_TIMER_COUNTER_REG]        0x3c, +14
>>>>>>> [OMAP_TIMER_LOAD_REG]           0x40, +14
>>>>>>> [OMAP_TIMER_TRIGGER_REG]        0x44, +14
>>>>>>> [OMAP_TIMER_WRITE_PEND_REG]     0x48, +14
>>>>>>> [OMAP_TIMER_MATCH_REG]          0x4c, +14
>>>>>>> [OMAP_TIMER_CAPTURE_REG]        0x50, +14
>>>>>>> [OMAP_TIMER_IF_CTRL_REG]        0x54, +14
>>>>>>> [OMAP_TIMER_CAPTURE2_REG]       0x58, +14
>>>>>>>
>>>>>>> You can probably handle that with only 2 offsets instead
>>>> of having one
>>>>>>> address per registers.
>>>>>>>
>>>>>> To keep aligned with other driver implementations, I
>> would like to
>>>>> follow this:
>>>>>>
>>>>>> 1) move the table in mach-omap1/2 since
>>>>>> 2) remove entries which are handled by hwmod.
>>>>>> However, I am not sure if there is any issue in keeping
>>>> them in the
>>>>> table.
>>>>>
>>>>> I don't think you need a table for that. All the functional
>>>> registers
>>>>> are using a constant offset. IRQ is then the only exception.
>>>
>>> Other than the offsets 0x14 for the Timer functional registers
>>> and 0x10 for the IRQ registers, following differences exist
>>> between the two versions:
>>> 1. OMAP_TIMER_SYS_STAT_REG is used only for v1, missing for v2.
>>
>> This is handled by hwmod anyway.
>>
>>
>>> 2. OMAP_TIMER_INT_CLR_REG is new for v2, not used for v1.
>>
>> Follow regular IRQ management for highlander IP. Should be
>> some generic
>> code in order to allow reuse.
>>
>>> 3. Following registers are applicable only for v1.
>>> [OMAP_TIMER_TICK_POS_REG]     		0x48
>>> [OMAP_TIMER_TICK_NEG_REG]     		0x4c
>>> [OMAP_TIMER_TICK_COUNT_REG]     		0x50
>>> [OMAP_TIMER_TICK_INT_MASK_SET_REG]		0x54
>>> [OMAP_TIMER_TICK_INT_MASK_COUNT_REG]	0x58
>>
>> These are only there in the 1ms version of this IP.
>>
>>> In the end, having separate tables is neater and consistent
>>> with other drivers.
>>
>> I don't see why? And what other driver are you referring too?
>
> I2c driver uses reg_map tables. Initially McSPI and MMC were using
> similar reg_map tables which were later removed based on review comments.
>
> However, the delta were minimal in this case.
> e.g. MCSPI_HL_REV, MCSPI_HL_HWINFO, MCSPI_HL_SYSCONFIG were the only
> difference for McSPI, all the other functional registers
> were moved forward by 0x100.
>
> Maybe, it is relevant for I2C as the amount of delta is more.
>
> I also observed your comments on MMC. Now that both McSPI&  MMC are
> not having table based approach, my argument of consistency across drivers
> does not hold good. It depends upon the IPs really.

Yep, I do agree, for both SPI and MMC, it was really over-designed 
because the offset was constant.
For the timer, it is a little bit more complex, but still can be handled 
easily. At some point, the table approach can clearly make sense.
For for the timer, I still think it is a little bit over-designed.

>>
>> What the point of adding a table and an extra level of
>> indirection, when
>> a simple addition will do it?
>>
>>> But instead of duplicating for each mach,
>>> keeping them in plat should be OK.
>>>
>>> Additionally, the implementation should take care to prevent access
>>> of non-existing registers for a particular version.
>>
>> You just need the IP version to do that.
>>
>> We have 3 timer variants to handle today:
>> Legacy timer, legacy 1ms timer and highlander timer. You can
>> handle that
>> with 2 flags and 2 offsets.
>
> If you look at the previous version of the DMTimer code, this is indeed
> based on a bunch of #defines and offset updation. We then need to revert
> back to this model with the following:

I didn't check carefully, but if you think that there is a clear benefit 
for the readability point of view or if is simplify the code a lot maybe 
that worth it.

In that case, you can maybe hide that by providing 2 accessors like 
omap_timer_read and omap_timer_write, and 2 others for IRQ registers, 
and you will add the offset calculation in it.

> 1. Maintain IP revs as dev_attrs.
>
> 2. For each IP rev, define two offsets, interrupt_reg_offset&
> functional_reg_offset. 0x10 for v2 interrupt regs, 0x14 for the v2 functional regs.
>
> 3. In addiiton, take care to grant access of valid registers and prevent
> access of non-existing registers for any particular IP revision.
>
> Benoit, Tarun, do you agree?

That sound good to me.

Benoit
