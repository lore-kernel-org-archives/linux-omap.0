From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH] OMAP3: PM: Fix for Silicon bug on Context Restore on
 OMAP3430
Date: Tue, 6 Oct 2009 12:29:18 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A3321EF@dbde02.ent.ti.com>
References: <1254741761-31546-1-git-send-email-y>
 <87ljjpzs9p.fsf@deeprootsystems.com> <4ACA2C83.9080400@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34526 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754430AbZJFHAN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Oct 2009 03:00:13 -0400
In-Reply-To: <4ACA2C83.9080400@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gulati, Shweta" <shweta.gulati@ti.com>

The problem here is not with the restore. If MPU reads the PADCONF_SAVEDONE bit very close
to the end of context save sequence for the pad conf registers, the last context is not
saved to the scratchpad memory. This is a h/w bug. The workaround proposed is to delay the
MPU access of SAVEDONE bit until the last context has been saved. 300 us delay is the current
safe delay proposed by TI. I believe investigations are going on to whether this delay can be
optimized. Also only the last context (ETK_D14) has the risk of not getting saved.

We could add a defconfig option for this workaround and enable it on need basis till TI
comes out with proper optimized workaround sequence.

Regards
Thara

>>-----Original Message-----
>>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Menon,
>>Nishanth
>>Sent: Monday, October 05, 2009 10:58 PM
>>To: Kevin Hilman
>>Cc: linux-omap@vger.kernel.org; Gulati, Shweta
>>Subject: Re: [PATCH] OMAP3: PM: Fix for Silicon bug on Context Restore on OMAP3430
>>
>>Kevin Hilman had written, on 10/05/2009 12:04 PM, the following:
>>> y@india.ti.com writes:
>>>
>>>> From: Shweta Gulati <shweta.gulati@ti.com>
>>>
>>> Please add descriptive changelog, including Erratta number and
>>> summary of the bug.
>>>
>>>> Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
>>>> ---
>>>>  arch/arm/mach-omap2/pm34xx.c |    6 ++++++
>>>>  1 files changed, 6 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
>>>> index a9eda25..38f4781 100644
>>>> --- a/arch/arm/mach-omap2/pm34xx.c
>>>> +++ b/arch/arm/mach-omap2/pm34xx.c
>>>> @@ -140,6 +140,12 @@ static void omap3_core_save_context(void)
>>>>  	omap_ctrl_readl(OMAP343X_CONTROL_PADCONF_OFF);
>>>>  	control_padconf_off |= START_PADCONF_SAVE;
>>>>  	omap_ctrl_writel(control_padconf_off, OMAP343X_CONTROL_PADCONF_OFF);
>>>> +	/* Due to Silicon Bug on context restore it is found
>>>> +	 * that the CONTROL_PAD_CONF_ETK14 register is not saved into
>>>> +	 * scratch pad memory sometimes. To rectify it delay acess by Mpu
>>>> +	 * for 300us for scm to finish saving task
>>>> +	 */
>>>> +	udelay(300);
>>>
>>> Why 300 usecs?
>>300uSec could be optimized as I understand.
>>
>>> Is ETK14 the only register not saved?
>>The bug as I understand is that the register is saved, but restore
>>potentially can corrupt the values.
>>there is an alternative implementation possible:
>>a) we save the register in a seperate variable
>>b) we allow the restore issue to kick us (essentially allow it to be
>>corrupted)
>>c) we over write the restored value with the saved value.
>>This has the risk of a glitch on the line (between the corrupted restore
>>data to the time we restore with correct data).
>>
>>--
>>Regards,
>>Nishanth Menon
>>--
>>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html

