From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 05/13] DSPBRIDGE: enable smart/autoidle for mailbox sysconfig
Date: Wed, 15 Jul 2009 17:01:11 -0500
Message-ID: <4A5E51A7.6040907@ti.com>
References: <1247669795-23895-1-git-send-email-ameya.palande@nokia.com> <1247669795-23895-2-git-send-email-ameya.palande@nokia.com> <1247669795-23895-3-git-send-email-ameya.palande@nokia.com> <1247669795-23895-4-git-send-email-ameya.palande@nokia.com> <1247669795-23895-5-git-send-email-ameya.palande@nokia.com> <1247669795-23895-6-git-send-email-ameya.palande@nokia.com> <496565EC904933469F292DDA3F1663E602A32025B9@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52269 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751883AbZGOWBT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Jul 2009 18:01:19 -0400
In-Reply-To: <496565EC904933469F292DDA3F1663E602A32025B9@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <x0095840@ti.com>
Cc: Ameya Palande <ameya.palande@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "hiroshi.doyu@nokia.com" <hiroshi.doyu@nokia.com>

Guzman Lugo, Fernando had written, on 07/15/2009 04:59 PM, the following:
>> diff --git a/drivers/dsp/bridge/hw/hw_mbox.c
>> b/drivers/dsp/bridge/hw/hw_mbox.c
>> index ee79032..5a87597 100644
>> --- a/drivers/dsp/bridge/hw/hw_mbox.c
>> +++ b/drivers/dsp/bridge/hw/hw_mbox.c
>> @@ -33,7 +33,9 @@
>>  /* width in bits of MBOX Id */
>>  #define HW_MBOX_ID_WIDTH	   2
>>
>> -struct MAILBOX_CONTEXT mboxsetting = {0x4, 0x1, 0x1};
>> +static struct MAILBOX_CONTEXT mboxsetting = {
>> +	.sysconfig = 2 << 3 | 1, /* SMART/AUTO-IDLE */
>> +};
>>
>>  /* Saves the mailbox context */
>>  HW_STATUS HW_MBOX_saveSettings(void __iomem *baseAddress)
>> diff --git a/drivers/dsp/bridge/hw/hw_mbox.h
>> b/drivers/dsp/bridge/hw/hw_mbox.h
>> index ad1a89c..8a5f6bd 100644
>> --- a/drivers/dsp/bridge/hw/hw_mbox.h
>> +++ b/drivers/dsp/bridge/hw/hw_mbox.h
>> @@ -320,4 +320,9 @@ extern HW_STATUS HW_MBOX_saveSettings(void __iomem
>> *baseAddres);
>>  */
>>  extern HW_STATUS HW_MBOX_restoreSettings(void __iomem *baseAddres);
>>
>> +static inline void HW_MBOX_initSettings(void __iomem *baseAddres)
>> +{
>> +	HW_MBOX_restoreSettings(baseAddres);
>> +}
>> +
>>  #endif  /* __MBOX_H */
>> diff --git a/drivers/dsp/bridge/wmd/io_sm.c
>> b/drivers/dsp/bridge/wmd/io_sm.c
>> index 39c34f7..d8ae1f1 100644
>> --- a/drivers/dsp/bridge/wmd/io_sm.c
>> +++ b/drivers/dsp/bridge/wmd/io_sm.c
>> @@ -282,6 +282,7 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phIOMgr,
>>  		pIOMgr->fSharedIRQ = pMgrAttrs->fShared;
>>  		IO_DisableInterrupt(hWmdContext);
>>  		if (devType == DSP_UNIT) {
>> +			HW_MBOX_initSettings(hostRes.dwMboxBase);
> 
> What do think about doing a call to __raw_writel to avoid a new function wrapper as Omar suggested? Something like that:
> 				
> 			/* Enabling mailbox SMART/AUTO-IDLE */
> 			__raw_writel(2 << 3 | 1, hostRes.dwMboxBase + 10);
> 
> 
I think this is cleaner than piggybacking on the context save/restore 
structure. We should use macros though for 2<<3 | 1 etc.. just my 2Cents 
for readability.

Regards,
Nishanth Menon
