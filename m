From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 1/1] OMAP: omap_device: only override _noirq methods, not normal suspend/resume
Date: Thu, 01 Sep 2011 10:50:24 -0700
Message-ID: <8762lcf8yn.fsf@ti.com>
References: <1314229437-31836-1-git-send-email-khilman@ti.com>
	<1314229437-31836-2-git-send-email-khilman@ti.com>
	<201109011800.55516.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:52596 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756448Ab1IARu2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Sep 2011 13:50:28 -0400
Received: by mail-iy0-f169.google.com with SMTP id v1so2881063iag.14
        for <linux-omap@vger.kernel.org>; Thu, 01 Sep 2011 10:50:27 -0700 (PDT)
In-Reply-To: <201109011800.55516.arnd@arndb.de> (Arnd Bergmann's message of
	"Thu, 1 Sep 2011 18:00:55 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Thursday 25 August 2011, Kevin Hilman wrote:
>> --- a/arch/arm/plat-omap/omap_device.c
>> +++ b/arch/arm/plat-omap/omap_device.c
>> @@ -622,7 +622,8 @@ static struct dev_pm_domain omap_device_pm_domain = {
>>                 SET_RUNTIME_PM_OPS(_od_runtime_suspend, _od_runtime_resume,
>>                                    _od_runtime_idle)
>>                 USE_PLATFORM_PM_SLEEP_OPS
>> -               SET_SYSTEM_SLEEP_PM_OPS(_od_suspend_noirq, _od_resume_noirq)
>> +               .suspend_noirq = _od_suspend_noirq,
>> +               .resume_noirq = _od_resume_noirq,
>>         }
>>  };
>
> This breaks if CONFIG_SUSPEND is not set and the _od_suspend_noirq/_od_resume_noirq
> functions are not defined.

Indeed.

Will post a fix shortly.

Kevin

