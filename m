From: <Tero.Kristo@nokia.com>
Subject: RE: [PATCH] OMAP3: PM: Force USB to standby if not used
Date: Fri, 15 May 2009 10:34:29 +0200
Message-ID: <1F18D6510CF0474A8C9500565A7E41A2053ED06851@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1242302980-4082-1-git-send-email-tero.kristo@nokia.com>
 <87ws8jy8zq.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:33778 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755392AbZEOIfE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 May 2009 04:35:04 -0400
In-Reply-To: <87ws8jy8zq.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org

 

>-----Original Message-----
>From: ext Kevin Hilman [mailto:khilman@deeprootsystems.com] 
>Sent: 14 May, 2009 18:56
>To: Kristo Tero (Nokia-D/Tampere)
>Cc: linux-omap@vger.kernel.org
>Subject: Re: [PATCH] OMAP3: PM: Force USB to standby if not used
>
>Tero Kristo <tero.kristo@nokia.com> writes:
>
>> From: Tero Kristo <tero.kristo@nokia.com>
>>
>> This patch will allow device to enter sleep mode while a USB 
>cable is 
>> connected and USB is either disabled or built as a module 
>from kernel 
>> config.
>>
>> Applies on top of PM branch.
>>
>> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
>> ---
>>  arch/arm/mach-omap2/usb-musb.c |   10 ++++++++--
>>  1 files changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/usb-musb.c 
>> b/arch/arm/mach-omap2/usb-musb.c index 12a9b0a..dd51d2f 100644
>> --- a/arch/arm/mach-omap2/usb-musb.c
>> +++ b/arch/arm/mach-omap2/usb-musb.c
>> @@ -32,7 +32,9 @@
>>  #include <mach/usb.h>
>>  
>>  #define AUTOIDLE        (1 << 0)
>> +#define FORCESTDBY	(1 << 0)
>>  #define OTG_SYSCONFIG	(OMAP34XX_HSUSB_OTG_BASE + 0x404)
>> +#define OTG_FORCESTDBY	(OMAP34XX_HSUSB_OTG_BASE + 0x414)
>>  
>>  static struct resource musb_resources[] = {
>>  	[0] = { /* start and end set dynamically */ @@ -185,7 
>+187,11 @@ 
>> void __init usb_musb_init(void)
>>  		return;
>>  	}
>>  
>> -	/* Enable smartidle on MUSB to improve C1 wakeup latency */
>> -	if (cpu_is_omap34xx())
>> +#if !defined(CONFIG_USB) || defined(CONFIG_USB_MODULE)
>> +	/* Force MUSB to standby if not used */
>> +	if (cpu_is_omap34xx()) {
>>  		omap_writel(AUTOIDLE, OTG_SYSCONFIG);
>> +		omap_writel(FORCESTDBY, OTG_FORCESTDBY);
>> +	}
>> +#endif
>
>Tero,
>
>Is this needed if OTG_SYSCONFIG is set to force-idle?
>
>Yesterday, I pushed a patch changing OTG_SYSCONFIG to 
>force-idle instead of auto-idle since on ES3.0 3430SDP, having 
>it in auto-idle was keeping CORE from hitting retention.  
>IIUC, there's an errata where force-idle doesn't work properly.
>
>Also, why the #ifdefs?
>
>This code is already conditionally compiled based on 
>CONFIG_USB_MUSB_SOC (see mach-omap2/Makefile) which is set 
>whether MUSB is built-in or a module.
>
>#if !defined(CONFIG_USB) then CONFIG_USB_MUSB_SOC will not be 
>defined either.

You are actually right, I missed that change to Makefile. The reason for this patch was to be able to hit retention / off when USB is not enabled, and this was possible with the #ifdef:s earlier. I think you can just ignore this patch.

-Tero