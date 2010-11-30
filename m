From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 4/5 v2] OMAP3630: PM: Disable L2 cache while invalidating
 L2 cache
Date: Tue, 30 Nov 2010 08:18:08 -0600
Message-ID: <4CF507A0.9030304@ti.com>
References: <1291061993-4740-1-git-send-email-nm@ti.com> <1291061993-4740-5-git-send-email-nm@ti.com> <AANLkTi=ynHCz_dGM___7wD1+dx=GTLm+NSTYxbCeP8xc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:43658 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751349Ab0K3OSN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Nov 2010 09:18:13 -0500
Received: by mail-gy0-f179.google.com with SMTP id 8so3108745gyg.38
        for <linux-omap@vger.kernel.org>; Tue, 30 Nov 2010 06:18:12 -0800 (PST)
In-Reply-To: <AANLkTi=ynHCz_dGM___7wD1+dx=GTLm+NSTYxbCeP8xc@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Jean <jean.pihet@newoldbits.com>, Tony <tony@atomide.com>, Kevin <khilman@deeprootsystems.com>, Vishwa <vishwanath.bs@ti.com>

Varadarajan, Charulatha had written, on 11/30/2010 12:12 AM, the following:

>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
>> index bd426cc..e0ade5f 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -988,6 +988,9 @@ static void pm_errata_configure(void)
>>        if (cpu_is_omap34xx()) {
>>                if (cpu_is_omap3630())
>>                        pm34xx_errata |= RTA_ERRATUM_i608;
>> +               /* Enable the l2 cache toggling in sleep logic */
>> +               if (cpu_is_omap3630())
>> +                       enable_omap3630_toggle_l2_on_restore();
> 
> 
> This can simply be like this:
> ...
> ...
> -         if (cpu_is_omap3630())
> +         if (cpu_is_omap3630()) {
>                          pm34xx_errata |= RTA_ERRATUM_i608;
> +                        /* Enable the l2 cache toggling in sleep logic */
> +                       enable_omap3630_toggle_l2_on_restore();
> +          }
There are two ways to arrange code there:
a) based on silicon revision enable all erratas
b) arrange it per errata case

In the original series there are additional erratas like the uart one 
which basically makes (a) a dirty implementation. I chose to go with 
(b). but personally, I am open to either and have no strong feeling abt 
it. mebbe others can also comment as to which way you'd like to see this 
organized.


-- 
Regards,
Nishanth Menon
