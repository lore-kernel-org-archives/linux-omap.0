From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv6 9/9] OMAP3: PM: Added support for suspending to INACTIVE state
Date: Mon, 08 Mar 2010 09:16:12 -0800
Message-ID: <87wrxmvin7.fsf@deeprootsystems.com>
References: <1265999265-4363-1-git-send-email-tero.kristo@nokia.com>
	<1265999265-4363-2-git-send-email-tero.kristo@nokia.com>
	<1265999265-4363-3-git-send-email-tero.kristo@nokia.com>
	<1265999265-4363-4-git-send-email-tero.kristo@nokia.com>
	<1265999265-4363-5-git-send-email-tero.kristo@nokia.com>
	<1265999265-4363-6-git-send-email-tero.kristo@nokia.com>
	<1265999265-4363-7-git-send-email-tero.kristo@nokia.com>
	<1265999265-4363-8-git-send-email-tero.kristo@nokia.com>
	<1265999265-4363-9-git-send-email-tero.kristo@nokia.com>
	<1265999265-4363-10-git-send-email-tero.kristo@nokia.com>
	<873a0j8v6x.fsf@deeprootsystems.com>
	<1F18D6510CF0474A8C9500565A7E41A224BF70AF00@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:38603 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642Ab0CHRQT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Mar 2010 12:16:19 -0500
Received: by pvb32 with SMTP id 32so1472258pvb.19
        for <linux-omap@vger.kernel.org>; Mon, 08 Mar 2010 09:16:19 -0800 (PST)
In-Reply-To: <1F18D6510CF0474A8C9500565A7E41A224BF70AF00@NOK-EUMSG-02.mgdnok.nokia.com> (Tero Kristo's message of "Tue\, 2 Mar 2010 11\:12\:36 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero.Kristo@nokia.com
Cc: linux-omap@vger.kernel.org

<Tero.Kristo@nokia.com> writes:

[...]

> True, ancient info there. OFF for example has been supported for ages already.
>
>>
>>
>>> +	if (state != PWRDM_POWER_INACTIVE)
>>> +		while (!(pwrdm->pwrsts & (1 << state))) {
>>> +			if (state == PWRDM_POWER_OFF)
>>> +				return ret;
>>> +			state--;
>>> +		}
>>
>>I think all powerdomains can be inactive right?
>
> Yes.
>
>>I think it would be cleaner to just have all the pwrdm->pwrsts fields
>>include intactive as a valid option.
>>
>>Something like the patch below.  IIRC, you did something like this in
>>one of the earlier versions of the patch.
>
> Yeah, something like this was done previously, however Paul did not
> like the idea of changing the generic powerdomain code too much so I
> dropped it completely. It is now done only via the support functions
> in patch #1, and only done for the powerdomains that actually need
> it for the cpuidle (mpu/core/neon.) It would be possible to add
> support for the rest of the powerdomains also, but I decided to drop
> this in favor of getting the patch set in.

I'm not proposing changing any of the other powerdomain code.  Just
changing the PWRSTS_* defines, essentially so that INACTIVE is
a valid state.

That will eliminate the need for a special check for inactive in this
patch.

Kevin

>>
>>diff --git a/arch/arm/plat-omap/include/plat/powerdomain.h 
>>b/arch/arm/plat-omap/include/plat/powerdomain.h
>>index a1ecd47..c692472 100644
>>--- a/arch/arm/plat-omap/include/plat/powerdomain.h
>>+++ b/arch/arm/plat-omap/include/plat/powerdomain.h
>>@@ -31,17 +31,17 @@
>> #define PWRDM_MAX_PWRSTS	4
>> 
>> /* Powerdomain allowable state bitfields */
>>-#define PWRSTS_OFF_ON		((1 << PWRDM_POWER_OFF) | \
>>+#define PWRSTS_ON		((1 << PWRDM_POWER_INACTIVE) | \
>> 				 (1 << PWRDM_POWER_ON))
>> 
>>+#define PWRSTS_OFF_ON		((1 << PWRDM_POWER_OFF) | PWRSTS_ON)
>>+
>> #define PWRSTS_OFF_RET		((1 << PWRDM_POWER_OFF) | \
>> 				 (1 << PWRDM_POWER_RET))
>> 
>>-#define PWRSTS_RET_ON		((1 << PWRDM_POWER_RET) | \
>>-				 (1 << PWRDM_POWER_ON))
>>-
>>-#define PWRSTS_OFF_RET_ON	(PWRSTS_OFF_RET | (1 << PWRDM_POWER_ON))
>>+#define PWRSTS_RET_ON		((1 << PWRDM_POWER_RET) | PWRSTS_ON)
>> 
>>+#define PWRSTS_OFF_RET_ON	(PWRSTS_OFF_RET | PWRSTS_ON)
>> 
>> /* Powerdomain flags */
>> #define PWRDM_HAS_HDWR_SAR	(1 << 0) /* hardware 
>>save-and-restore support */
>>
