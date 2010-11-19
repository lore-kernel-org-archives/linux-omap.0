From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 09/13] OMAP3: PM: Apply errata i540 before save secure
 ram
Date: Fri, 19 Nov 2010 06:12:40 -0600
Message-ID: <4CE669B8.3040002@ti.com>
References: <1290131698-6194-1-git-send-email-nm@ti.com>	<1290131698-6194-10-git-send-email-nm@ti.com> <AANLkTi=Biq8y_FQunP9ih9fO1csvwkX_sCPR7yLA+n3U@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:51772 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753239Ab0KSMMz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Nov 2010 07:12:55 -0500
Received: by gyf2 with SMTP id 2so2779369gyf.21
        for <linux-omap@vger.kernel.org>; Fri, 19 Nov 2010 04:12:54 -0800 (PST)
In-Reply-To: <AANLkTi=Biq8y_FQunP9ih9fO1csvwkX_sCPR7yLA+n3U@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Kevin <khilman@deeprootsystems.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Tony <tony@atomide.com>

Jean Pihet wrote, on 11/19/2010 04:09 AM:
[...]
>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
>> index f520b38..c7e2db0 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -422,6 +422,14 @@ void omap_sram_idle(void)
>>                                 omap3_per_save_context();
>>         }
>>
>> +       /*
>> +        * We need to disable the autoidle bit from MPU INTC,
>> +        * otherwise INTC would get stall, and we would never
>> +        * come out of WFI. This is done here because
>> +        * save secure ram also does WFI.
>> +        */
> The comment should mention the errata ID i540, for easier readability
> and maintenance.
Thanks for your review. I agree + I was given an offline feedback:

1 bug = Erratum
1+ bug = Errata

;) I should be fixing my grammar throughout all patches - so I believe 
they all become Erratum ID: etc.. will try to fix them as well in my v2.


-- 
Regards,
Nishanth Menon
