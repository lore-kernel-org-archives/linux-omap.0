From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 13/13] OMAP3630: PM: Errata i583: disable coreoff if <
 ES1.2
Date: Fri, 19 Nov 2010 06:14:34 -0600
Message-ID: <4CE66A2A.1060307@ti.com>
References: <1290131698-6194-1-git-send-email-nm@ti.com>	<1290131698-6194-14-git-send-email-nm@ti.com> <AANLkTimqoLvHK3xzg9kVWn7wNexBKN=iiKrCjnwJY40y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:37561 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751412Ab0KSMOo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Nov 2010 07:14:44 -0500
Received: by mail-yx0-f180.google.com with SMTP id 4so3107413yxj.25
        for <linux-omap@vger.kernel.org>; Fri, 19 Nov 2010 04:14:44 -0800 (PST)
In-Reply-To: <AANLkTimqoLvHK3xzg9kVWn7wNexBKN=iiKrCjnwJY40y@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Kevin <khilman@deeprootsystems.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Tony <tony@atomide.com>

Jean Pihet wrote, on 11/19/2010 04:07 AM:
[..]
>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
>> index 0102d60..1890e49 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -86,6 +86,7 @@ static int secure_ram_saved;
>>
>>   #define PER_WAKEUP_ERRATA_i582 (1<<  0)
>>   #define RTA_ERRATA_i608                (1<<  1)
>> +#define SDRC_WAKEUP_ERRATA_i583        (1<<  0)
> This value should be (1<<  2).

Thanks. you are absolutely right.. Oh boy, I need to check what the 
caffeine I have been drinking..

-- 
Regards,
Nishanth Menon
