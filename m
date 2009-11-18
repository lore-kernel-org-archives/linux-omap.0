From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH] OMAP3: PM: Force write last pad config register into
 save area
Date: Wed, 18 Nov 2009 19:41:03 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A9CAB51@dbde02.ent.ti.com>
References: <1258475693-22068-1-git-send-email-tero.kristo@nokia.com>
 <87my2lf1ai.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41338 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753293AbZKROLH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 09:11:07 -0500
In-Reply-To: <87my2lf1ai.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, Tero Kristo <tero.kristo@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



>>-----Original Message-----
>>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kevin
>>Hilman
>>Sent: Wednesday, November 18, 2009 12:04 AM
>>To: Tero Kristo
>>Cc: linux-omap@vger.kernel.org
>>Subject: Re: [PATCH] OMAP3: PM: Force write last pad config register into save area
>>
>>Tero Kristo <tero.kristo@nokia.com> writes:
>>
>>> From: Tero Kristo <tero.kristo@nokia.com>
>>>
>>> Due to OMAP3 errata XYZ, the save of the last pad register (ETK_D14 and
>>> ETK_D15) can fail sometimes when there is simultaneous OCP access to the
>>> SCM register area. Fixed by writing the last register to the save area.
>>>
>>> Also, optimized the delay loop for the HW save to include an udelay(1),
>>> which limits the number of unnecessary HW accesses to SCM register area
>>> during the save.
>>>
>>> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
>>
>>I certainly like this fix much better than the original proposal:
>>
>>  http://marc.info/?l=linux-omap&m=125474186609661&w=2

Please do not merge this patch until TI officially confirms the workaround.
>>
>>Pulling into PM branch after s/XYZ/1.157/
>>
>>Kevin
>>
>>> ---
>>>  arch/arm/mach-omap2/pm34xx.c |   10 +++++++++-
>>>  1 files changed, 9 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
>>> index 4b01303..4ead40e 100644
>>> --- a/arch/arm/mach-omap2/pm34xx.c
>>> +++ b/arch/arm/mach-omap2/pm34xx.c
>>> @@ -155,7 +155,15 @@ static void omap3_core_save_context(void)
>>>  	/* wait for the save to complete */
>>>  	while (!(omap_ctrl_readl(OMAP343X_CONTROL_GENERAL_PURPOSE_STATUS)
>>>  			& PADCONF_SAVE_DONE))
>>> -		;
>>> +		udelay(1);
>>> +
>>> +	/*
>>> +	 * Force write last pad into memory, as this can fail in some
>>> +	 * cases according to errata XYZ
>>> +	 */
>>> +	omap_ctrl_writel(omap_ctrl_readl(OMAP343X_PADCONF_ETK_D14),
>>> +		OMAP343X_CONTROL_MEM_WKUP + 0x2a0);
>>> +
>>>  	/* Save the Interrupt controller context */
>>>  	omap_intc_save_context();
>>>  	/* Save the GPMC context */
>>> --
>>> 1.5.4.3
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>--
>>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html

