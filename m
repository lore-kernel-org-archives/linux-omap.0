From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] omap3: feature: fix OMAP3_IVA_MASK
Date: Wed, 17 Nov 2010 05:35:36 -0600
Message-ID: <4CE3BE08.208@ti.com>
References: <1288973121-14073-1-git-send-email-nm@ti.com> <20101116212715.GK9264@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:57703 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932962Ab0KQLfn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Nov 2010 06:35:43 -0500
Received: by gxk7 with SMTP id 7so1225362gxk.0
        for <linux-omap@vger.kernel.org>; Wed, 17 Nov 2010 03:35:43 -0800 (PST)
In-Reply-To: <20101116212715.GK9264@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Arno Steffen <arno.steffen@googlemail.com>

Tony Lindgren wrote, on 11/16/2010 03:27 PM:
> * Nishanth Menon<nm@ti.com>  [101105 17:29]:
>> From: Arno Steffen<arno.steffen@googlemail.com>
>>
>> OMAP3_IVA_MASK should use OMAP3_IVA_SHIFT instead of OMAP3_SGX_SHIFT
>>
>> Signed-off-by: Arno Steffen<arno.steffen@googlemail.com>
>> ---
>> Sending on behalf of Arno - he pointed at the change and everything
>> except for the patch ;)
>> Reported here:
>> http://marc.info/?l=linux-omap&m=128896969832702&w=2
>
> Hmm, until we have an official verbal-patch-to-unified-diff translator,
> I guess the right thing to do here is to make it be:
>
> From: Nishanth Menon<nm@ti.com>
>
> OMAP3_IVA_MASK should use OMAP3_IVA_SHIFT instead of OMAP3_SGX_SHIFT
>
> Reported-by: Arno Steffen<arno.steffen@googlemail.com>
> Signed-off-by: Nishanth Menon<nm@ti.com>
>
> Can you please repost or confirm that's OK for you?

I would prefer if Arno resubmit the patch under his name - but if he 
cannot do so, I can take ownership.

Arno,
please comment.

>
> Tony
>
>>   arch/arm/mach-omap2/control.h |    2 +-
>>   1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
>> index b6c6b7c..5325297 100644
>> --- a/arch/arm/mach-omap2/control.h
>> +++ b/arch/arm/mach-omap2/control.h
>> @@ -309,7 +309,7 @@
>>   #define		FEAT_SGX_NONE		2
>>
>>   #define OMAP3_IVA_SHIFT			12
>> -#define OMAP3_IVA_MASK			(1<<  OMAP3_SGX_SHIFT)
>> +#define OMAP3_IVA_MASK			(1<<  OMAP3_IVA_SHIFT)
>>   #define		FEAT_IVA		0
>>   #define		FEAT_IVA_NONE		1
>>
>> --
>> 1.7.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Regards,
Nishanth Menon
