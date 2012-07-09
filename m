From: Zumeng Chen <zumeng.chen@windriver.com>
Subject: Re: [PATCH v2 0/2] Watchdog: OMAP: bootstatus fix for omap3 and changes
 for the current watchdog framework
Date: Mon, 9 Jul 2012 14:00:18 +0800
Message-ID: <4FFA7372.4050201@windriver.com>
References: <1341808779-25532-1-git-send-email-zumeng.chen@windriver.com> <4FFA73DB.1020009@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:52273 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751525Ab2GIGEK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Jul 2012 02:04:10 -0400
In-Reply-To: <4FFA73DB.1020009@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: shubhrajyoti@ti.com, wim@iguana.be, linux-watchdog@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, paul.gortmaker@windriver.com

=E4=BA=8E 2012=E5=B9=B407=E6=9C=8809=E6=97=A5 14:02, Vaibhav Hiremath =E5=
=86=99=E9=81=93:
>
> On 7/9/2012 10:09 AM, Zumeng Chen wrote:
>> Hello,
>>
>> The following patches based on the 3.5-rc6 from Wim, which
>> are based on:
>>
>> 1 ) bootstatus fix for omap3,
>>
>> 2 ) omap-wdt framework update cater for the current framework
>>      as Shubhrajyoti comments mentioned.
>>
>> Regards,
>> Zumeng
>>
>>    Linux 3.5-rc6 (2012-07-07 17:23:56 -0700)
>>
>> Zumeng Chen (3):
>>        Watchdog: Omap: Changes for the new watchdog framework
>>        Watchdog: Omap: select watchdog core for framework change
>>        Watchdog: Omap: get the bootstatus for OMAP2Plus
>>
> It looks like you have manually created your cover letter, cover-lett=
er
> says [0/2] but actually you have 3 patches in series.
>
>
> You should use following command to create cover letter,
>
> git format-patch --cover-letter<no of patches OR commits for patches>
OK, I'll re-send it again, so Please ignore this thread from now.

Many thanks for your kind reminder

Zumeng

>
>
> Thanks,
> Vaibhav
>
>>   arch/arm/mach-omap2/prcm.c  |    5 +-
>>   drivers/watchdog/Kconfig    |    1 +
>>   drivers/watchdog/omap_wdt.c |  338 ++++++++++++++++---------------=
------------
>>   drivers/watchdog/omap_wdt.h |    5 +
>>   4 files changed, 133 insertions(+), 216 deletions(-)
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
