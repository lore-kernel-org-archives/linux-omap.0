From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] Revert "OMAP: mach-omap2: Fix incorrect assignment warnings"
Date: Fri, 08 Oct 2010 15:47:38 -0700
Message-ID: <87eic0ti7p.fsf@deeprootsystems.com>
References: <AANLkTimCXyTh30iGVd2j8JUcfT2a0+xrT8AqjX=qQ0k+@mail.gmail.com>
	<87y6a8v48p.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:35673 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635Ab0JHWrl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Oct 2010 18:47:41 -0400
Received: by pxi15 with SMTP id 15so328724pxi.19
        for <linux-omap@vger.kernel.org>; Fri, 08 Oct 2010 15:47:41 -0700 (PDT)
In-Reply-To: <87y6a8v48p.fsf@deeprootsystems.com> (Kevin Hilman's message of
	"Fri, 08 Oct 2010 13:06:30 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, "G, Manjunath Kondaiah" <manjugk@ti.com>

Kevin Hilman <khilman@deeprootsystems.com> writes:

> Jean Pihet <jean.pihet@newoldbits.com> writes:
>
>> This patch reverts commit 914bab936fe0388a529079679e2f137aa4ff548d, which
>> breaks the OFF mode on the OMAP3 platforms.
>> The details are here below.
>>
>> The intent behind the original patch was to fix some compiler
>> warnings, which I do not have on my side. Is the problem dependent on
>> the setup and config used?
>
>> From ec85bc90978cf0f257e73eaad593ffb774595863 Mon Sep 17 00:00:00 2001
>> From: Jean Pihet <jean.pihet@newoldbits.com>
>> Date: Fri, 8 Oct 2010 18:36:48 +0200
>> Subject: [PATCH] Revert "OMAP: mach-omap2: Fix incorrect assignment warnings"
>>
>> This reverts commit 914bab936fe0388a529079679e2f137aa4ff548d, which
>> breaks the OFF mode on the OMAP3 platforms.
>>
>> The use of a void* pointer for scratchpad_address confuses the
>> compiler which generates wrong offset for the access to the L4
>> address space. In that case an alignement fault is generated
>> during the wake-up from OFF mode.
>>
>> The code that causes problem is:
>> __raw_readl(scratchpad_address + OMAP343X_TABLE_ADDRESS_OFFSET);
>
> Thanks Jean for tracking down why off-mode was broken on the master
> branch.  
>
> I completely agree this patch should be reverted.  However, the
> description here could be a litle more descriptive.

I changed my mind...

Since only one part of the original patch introduced a bug, I decided to
just fix that bug and keep the fixes for the sparse warnings.  I just
posted a patch[1] for the fix.   Please test.

Thanks,

Kevin

[1] https://patchwork.kernel.org/patch/242661/

