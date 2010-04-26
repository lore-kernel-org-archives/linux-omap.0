From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: PM: Fix zoom3 defconfig build
Date: Mon, 26 Apr 2010 11:11:52 -0700
Message-ID: <87bpd6ulqv.fsf@deeprootsystems.com>
References: <1272287902-4707-1-git-send-email-manjugk@ti.com>
	<4BD5AA4F.800@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:46375 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751853Ab0DZSL5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Apr 2010 14:11:57 -0400
Received: by pxi17 with SMTP id 17so1761057pxi.19
        for <linux-omap@vger.kernel.org>; Mon, 26 Apr 2010 11:11:56 -0700 (PDT)
In-Reply-To: <4BD5AA4F.800@ti.com> (Nishanth Menon's message of "Mon\, 26 Apr 2010 09\:59\:27 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Manjunatha GK <manjugk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Nishanth Menon <nm@ti.com> writes:

> Manjunatha GK had written, on 04/26/2010 08:18 AM, the following:
>> The zoom3 defconfig build is broken with opp patches.
>> This patch will fix the same. Build and boot tested on
>> omap zoom3 board.
>>
>> Build error log:
>> In file included from arch/arm/plat-omap/include/plat/omap-pm.h:21,
>>                  from arch/arm/mach-omap2/hsmmc.c:19:
>> arch/arm/plat-omap/include/plat/opp.h: In function 'opp_find_freq_exact':
>> arch/arm/plat-omap/include/plat/opp.h:255: error: implicit declaration of function 'ERR_PTR'
>
> I think this is a valid change, though I think commit message is not
> informative enough in this case. the problem is that opp.h defines a
> set of empty access functions for use when CPUFREQ is not defined,
> which is the case you seem to be hitting. it is not restricted to
> zoom3 defconfig.
>
> If you could rephrase the commit message accordingly, it would be helpful.

No need... I found a few other problems related to CPUfreq not being
enabled and I folded the fixes into the original commits and rebase
pm-opp.

Kevin
