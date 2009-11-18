From: <Tero.Kristo@nokia.com>
Subject: RE: [PATCH] OMAP3: PM: Force write last pad config register into
 save area
Date: Wed, 18 Nov 2009 13:23:42 +0100
Message-ID: <1F18D6510CF0474A8C9500565A7E41A2236D84D0B6@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1258475693-22068-1-git-send-email-tero.kristo@nokia.com>
 <87my2lf1ai.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:38751 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214AbZKRMXx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 07:23:53 -0500
In-Reply-To: <87my2lf1ai.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org

 

>-----Original Message-----
>From: ext Kevin Hilman [mailto:khilman@deeprootsystems.com] 
>Sent: 17 November, 2009 20:34
>To: Kristo Tero (Nokia-D/Tampere)
>Cc: linux-omap@vger.kernel.org
>Subject: Re: [PATCH] OMAP3: PM: Force write last pad config 
>register into save area
>
>Tero Kristo <tero.kristo@nokia.com> writes:
>
>> From: Tero Kristo <tero.kristo@nokia.com>
>>
>> Due to OMAP3 errata XYZ, the save of the last pad register 
>(ETK_D14 and
>> ETK_D15) can fail sometimes when there is simultaneous OCP 
>access to the
>> SCM register area. Fixed by writing the last register to the 
>save area.
>>
>> Also, optimized the delay loop for the HW save to include an 
>udelay(1),
>> which limits the number of unnecessary HW accesses to SCM 
>register area
>> during the save.
>>
>> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
>
>I certainly like this fix much better than the original proposal:
>
>  http://marc.info/?l=linux-omap&m=125474186609661&w=2
>
>Pulling into PM branch after s/XYZ/1.157/

I will resend the patch when TI has confirmed the errata number. This version of the patch was also missing an "#include <linux/delay.h>" for the udelay, I missed this in the hurry, so I will add this one also.

-Tero

>
>> ---
>>  arch/arm/mach-omap2/pm34xx.c |   10 +++++++++-
>>  1 files changed, 9 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/pm34xx.c 
>b/arch/arm/mach-omap2/pm34xx.c
>> index 4b01303..4ead40e 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -155,7 +155,15 @@ static void omap3_core_save_context(void)
>>  	/* wait for the save to complete */
>>  	while 
>(!(omap_ctrl_readl(OMAP343X_CONTROL_GENERAL_PURPOSE_STATUS)
>>  			& PADCONF_SAVE_DONE))
>> -		;
>> +		udelay(1);
>> +
>> +	/*
>> +	 * Force write last pad into memory, as this can fail in some
>> +	 * cases according to errata XYZ
>> +	 */
>> +	omap_ctrl_writel(omap_ctrl_readl(OMAP343X_PADCONF_ETK_D14),
>> +		OMAP343X_CONTROL_MEM_WKUP + 0x2a0);
>> +
>>  	/* Save the Interrupt controller context */
>>  	omap_intc_save_context();
>>  	/* Save the GPMC context */
>> -- 
>> 1.5.4.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe 
>linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>