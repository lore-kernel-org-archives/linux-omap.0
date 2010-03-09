From: <Tero.Kristo@nokia.com>
Subject: RE: [PATCHv6 9/9] OMAP3: PM: Added support for suspending to
 INACTIVE state
Date: Tue, 9 Mar 2010 09:07:09 +0100
Message-ID: <1F18D6510CF0474A8C9500565A7E41A224FCDB82E6@NOK-EUMSG-02.mgdnok.nokia.com>
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
 <87wrxmvin7.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:21222 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667Ab0CIIHf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Mar 2010 03:07:35 -0500
In-Reply-To: <87wrxmvin7.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org

 

>-----Original Message-----
>From: ext Kevin Hilman [mailto:khilman@deeprootsystems.com] 
>Sent: 08 March, 2010 19:16
>To: Kristo Tero (Nokia-D/Tampere)
>Cc: linux-omap@vger.kernel.org
>Subject: Re: [PATCHv6 9/9] OMAP3: PM: Added support for 
>suspending to INACTIVE state
>
><Tero.Kristo@nokia.com> writes:
>
>[...]
>
>> True, ancient info there. OFF for example has been supported 
>for ages already.
>>
>>>
>>>
>>>> +	if (state != PWRDM_POWER_INACTIVE)
>>>> +		while (!(pwrdm->pwrsts & (1 << state))) {
>>>> +			if (state == PWRDM_POWER_OFF)
>>>> +				return ret;
>>>> +			state--;
>>>> +		}
>>>
>>>I think all powerdomains can be inactive right?
>>
>> Yes.
>>
>>>I think it would be cleaner to just have all the pwrdm->pwrsts fields
>>>include intactive as a valid option.
>>>
>>>Something like the patch below.  IIRC, you did something like this in
>>>one of the earlier versions of the patch.
>>
>> Yeah, something like this was done previously, however Paul did not
>> like the idea of changing the generic powerdomain code too much so I
>> dropped it completely. It is now done only via the support functions
>> in patch #1, and only done for the powerdomains that actually need
>> it for the cpuidle (mpu/core/neon.) It would be possible to add
>> support for the rest of the powerdomains also, but I decided to drop
>> this in favor of getting the patch set in.
>
>I'm not proposing changing any of the other powerdomain code.  Just
>changing the PWRSTS_* defines, essentially so that INACTIVE is
>a valid state.
>
>That will eliminate the need for a special check for inactive in this
>patch.

This is a chicken-egg problem. If you alter the PWRSTS_* defines, you need to change implementation of pwrdm_set_next_pwrst() as it would accept INACTIVE also, which is not supported by the code right now.

>
>Kevin
>
>>>
>>>diff --git a/arch/arm/plat-omap/include/plat/powerdomain.h 
>>>b/arch/arm/plat-omap/include/plat/powerdomain.h
>>>index a1ecd47..c692472 100644
>>>--- a/arch/arm/plat-omap/include/plat/powerdomain.h
>>>+++ b/arch/arm/plat-omap/include/plat/powerdomain.h
>>>@@ -31,17 +31,17 @@
>>> #define PWRDM_MAX_PWRSTS	4
>>> 
>>> /* Powerdomain allowable state bitfields */
>>>-#define PWRSTS_OFF_ON		((1 << PWRDM_POWER_OFF) | \
>>>+#define PWRSTS_ON		((1 << PWRDM_POWER_INACTIVE) | \
>>> 				 (1 << PWRDM_POWER_ON))
>>> 
>>>+#define PWRSTS_OFF_ON		((1 << PWRDM_POWER_OFF) 
>| PWRSTS_ON)
>>>+
>>> #define PWRSTS_OFF_RET		((1 << PWRDM_POWER_OFF) | \
>>> 				 (1 << PWRDM_POWER_RET))
>>> 
>>>-#define PWRSTS_RET_ON		((1 << PWRDM_POWER_RET) | \
>>>-				 (1 << PWRDM_POWER_ON))
>>>-
>>>-#define PWRSTS_OFF_RET_ON	(PWRSTS_OFF_RET | (1 << PWRDM_POWER_ON))
>>>+#define PWRSTS_RET_ON		((1 << PWRDM_POWER_RET) 
>| PWRSTS_ON)
>>> 
>>>+#define PWRSTS_OFF_RET_ON	(PWRSTS_OFF_RET | PWRSTS_ON)
>>> 
>>> /* Powerdomain flags */
>>> #define PWRDM_HAS_HDWR_SAR	(1 << 0) /* hardware 
>>>save-and-restore support */
>>>
>