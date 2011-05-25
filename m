From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 10/13] OMAP3: PM: export the v7_flush_dcache_all API to modules
Date: Wed, 25 May 2011 14:21:23 +0200
Message-ID: <BANLkTimwVqdNByZ2FhChdUm9cTi4qDzp=A@mail.gmail.com>
References: <1305739950-11695-1-git-send-email-j-pihet@ti.com>
	<1305739950-11695-11-git-send-email-j-pihet@ti.com>
	<4DD4CF11.5010701@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:32889 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754752Ab1EYMVY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 May 2011 08:21:24 -0400
Received: by qyg14 with SMTP id 14so4442280qyg.19
        for <linux-omap@vger.kernel.org>; Wed, 25 May 2011 05:21:24 -0700 (PDT)
In-Reply-To: <4DD4CF11.5010701@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org

Hi Santosh,

On Thu, May 19, 2011 at 10:04 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> On 5/18/2011 11:02 PM, jean.pihet@newoldbits.com wrote:
>>
>> From: Jean Pihet<j-pihet@ti.com>
>>
>> Provide the the assembly function v7_flush_dcache_all to the
>> OMAP3 PM module, under CONFIG_CPU_V7.
>> v7_flush_dcache_all is used by the low level sleep code.
>>
>> Signed-off-by: Jean Pihet<j-pihet@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/pm.c | =A0 =A04 ++++
>> =A0arch/arm/mach-omap2/pm.h | =A0 =A04 ++++
>> =A02 files changed, 8 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
>> index 2e43fd6..ab69c5a 100644
>> --- a/arch/arm/mach-omap2/pm.c
>> +++ b/arch/arm/mach-omap2/pm.c
>> @@ -325,6 +325,10 @@ unsigned long
>> omap_pm_tick_nohz_get_sleep_length_us(void)
>> =A0EXPORT_SYMBOL(omap_pm_tick_nohz_get_sleep_length_us);
>> =A0#endif
>>
>> +#ifdef CONFIG_CPU_V7
>> +EXPORT_SYMBOL(v7_flush_dcache_all);
>> +#endif
>> +
>
> You have already mentioned, this export is wrong and indeed it
> is wrong. You can use "flush_cache_all()" instead here which will
> pick the right asm function.
I could not find a usable flush cache function that is exported for
use by the modules. I will re-submit the next version of the patches
and specifically ask about it on l-a-k ML as well.

>The downside is it will invalidate
> I cache as well but that's ok because it's get invalidated anyways
> in wakeup path.
That should be ok.

>
> Regards
> Santosh
>

Thanks,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
