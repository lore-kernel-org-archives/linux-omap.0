From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] ARM: PM: build sleep/suspend code for idle path also (not only suspend)
Date: Fri, 07 Oct 2011 15:49:37 -0700
Message-ID: <8739f4ju2m.fsf@ti.com>
References: <1318026686-20191-1-git-send-email-khilman@ti.com>
	<20111007223922.GC26805@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:53601 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754755Ab1JGWtk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Oct 2011 18:49:40 -0400
Received: by mail-qy0-f178.google.com with SMTP id 14so4206214qyg.9
        for <linux-omap@vger.kernel.org>; Fri, 07 Oct 2011 15:49:39 -0700 (PDT)
In-Reply-To: <20111007223922.GC26805@n2100.arm.linux.org.uk> (Russell King's
	message of "Fri, 7 Oct 2011 23:39:22 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Fri, Oct 07, 2011 at 03:31:26PM -0700, Kevin Hilman wrote:
>> Some platforms (e.g. OMAP) use the same common cpu_suspend/cpu_resume
>> helpers during idle as well as suspend.
>> 
>> Currently, if suspend is disabled (CONFIG_PM_SLEEP=n) and the platform
>> idle code is using the common cpu_suspend/cpu_resume functions, the
>> kernel will not link.
>> 
>> Since platform code commonly uses CONFIG_PM=y to build it's idle code,
>> build the common sleep/suspend code based on CONFIG_PM instead of
>> CONFIG_PM_SLEEP.
>> 
>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>> ---
>> Applies on Russell's devel-stable branch, where the new common
>> suspend/resume code is queued.
>
> See:
>
> commit 15e0d9e37c7fe9711b60f47221c394d45553ad8c
> Author: Arnd Bergmann <arnd@arndb.de>
> Date:   Sat Oct 1 21:09:39 2011 +0200
>
>     ARM: pm: let platforms select cpu_suspend support
>
>     Support for the cpu_suspend functions is only built-in
>     when CONFIG_PM_SLEEP is enabled, but omap3/4, exynos4
>     and pxa always call cpu_suspend when CONFIG_PM is enabled.
>
>     Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Nice.  That will work too.

I see this in Arnd's randconfig/arm branch but not yet in
arm-soc/for-next.   Is this being queued for v3.2?

This will also conflict with your devel-stable where the suspend.c is
added.

Kevin
