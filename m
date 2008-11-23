From: "Ramirez Luna, Omar" <x00omar@ti.com>
Subject: RE: [omapzoom][PATCH 2/4] DSPBRIDGE: LM Timer release for
 hibernation
Date: Sat, 22 Nov 2008 20:30:46 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A5303F1D3C5B9@dlee03.ent.ti.com>
References: <27F9C60D11D683428E133F85D2BB4A5303F1A398ED@dlee03.ent.ti.com>
 <20081121.185357.54461979.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51186 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755015AbYKWCa4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 22 Nov 2008 21:30:56 -0500
In-Reply-To: <20081121.185357.54461979.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gupta, Ramesh" <grgupta@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>

Hi,

Yes that patch will conflict because PM cleanup patch was only submitted to l-o. I was trying to get the patches but it seems like cloning from http protocol is giving me some trouble, I'll try to get them over git.

- omar

>From: Hiroshi DOYU [mailto:Hiroshi.DOYU@nokia.com]
>Sent: Friday, November 21, 2008 10:54 AM
>To: Ramirez Luna, Omar
>Cc: Pandita, Vikram; linux-omap@vger.kernel.org; Gupta, Ramesh; Kanigeri,
>Hari
>Subject: Re: [omapzoom][PATCH 2/4] DSPBRIDGE: LM Timer release for
>hibernation
>
>Hi Omar,
>
>It seems that this patch conflicts the previous bridge patch:
>
>   "[PATCH] BRIDGE Power Management cleanup"
>   	    http://article.gmane.org/gmane.linux.ports.arm.omap/13447
>
>I'm guessing that this is because that previous patch may be missed in
>"o-z", could you take a look, please?
>
>You can get the latest "l-o" + the latest "tidspbridge" from:
>
>    http://git.gitorious.org/lk/mainline.git tidspbridge
>
>If I missed something except this patch, please let me know.
>
>    Hiroshi DOYU
>
>From: "ext Ramirez Luna, Omar" <x00omar@ti.com>
>Subject: [omapzoom][PATCH 2/4] DSPBRIDGE: LM Timer release for hibernation
>Date: Thu, 20 Nov 2008 03:11:59 -0600
>
>> From: Ramesh Gupta <grgupta@ti.com>
>> Date: Mon, 17 Nov 2008 16:11:19 -0600
>> Subject: [PATCH] DSPBRIDGE: LM Timer release for hibernation
>>
>> Release load monitor timer when the DSP is
>> inactive and goes to hibernation
>>
>> Signed-off-by: Ramesh Gupta <grgupta@ti.com>
>> Signed-off-by: SuiLun Lam <s-lam@ti.com>
>> ---
>>  drivers/dsp/bridge/wmd/tiomap_sm.c |    8 +++++---
>>  1 files changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/dsp/bridge/wmd/tiomap_sm.c
>b/drivers/dsp/bridge/wmd/tiomap_sm.c
>> index 63655d9..edc3bcf 100644
>> --- a/drivers/dsp/bridge/wmd/tiomap_sm.c
>> +++ b/drivers/dsp/bridge/wmd/tiomap_sm.c
>> @@ -190,7 +190,6 @@ DSP_STATUS CHNLSM_InterruptDSP(struct WMD_DEV_CONTEXT
>*hDevContext)
>>
>>  	if  (pDevContext->dwBrdState == BRD_DSP_HIBERNATION ||
>>  	    pDevContext->dwBrdState == BRD_HIBERNATION) {
>> -		pDevContext->dwBrdState = BRD_RUNNING;
>>  #ifndef CONFIG_DISABLE_BRIDGE_PM
>>  #ifndef CONFIG_DISABLE_BRIDGE_DVFS
>>  #ifndef CONFIG_OMAP3_PM
>> @@ -235,9 +234,12 @@ DSP_STATUS CHNLSM_InterruptDSP(struct
>WMD_DEV_CONTEXT *hDevContext)
>>  			  mboxsetting.irqEnable0);
>>  		DBG_Trace(DBG_LEVEL6, "MailBoxSettings: IRQENABLE1 = 0x%x\n",
>>  			 mboxsetting.irqEnable1);
>> -		/* Restart the peripheral clocks that were disabled */
>> -		DSP_PeripheralClocks_Enable(hDevContext, NULL);
>> +		/* Restart the peripheral clocks that were disabled only
>> +		 * in DSP initiated Hibernation case.*/
>> +		if (pDevContext->dwBrdState == BRD_DSP_HIBERNATION)
>> +			DSP_PeripheralClocks_Enable(hDevContext, NULL);
>>
>> +		pDevContext->dwBrdState = BRD_RUNNING;
>>  	}
>>  	while (--cnt) {
>>  		hwStatus = HW_MBOX_IsFull(resources.dwMboxBase,
>> --
>> 1.6.0

