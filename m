From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 00/13] OMAP3: OFF mode fixes
Date: Fri, 19 Nov 2010 06:03:00 -0600
Message-ID: <4CE66774.4090807@ti.com>
References: <1290131698-6194-1-git-send-email-nm@ti.com> <AANLkTikLuJ2nY-VC=zNAs9TF5NCcjN48JXZF=p=WNf_X@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:46923 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753287Ab0KSMDL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Nov 2010 07:03:11 -0500
Received: by mail-gy0-f182.google.com with SMTP id 13so3142254gyg.41
        for <linux-omap@vger.kernel.org>; Fri, 19 Nov 2010 04:03:10 -0800 (PST)
In-Reply-To: <AANLkTikLuJ2nY-VC=zNAs9TF5NCcjN48JXZF=p=WNf_X@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Kevin <khilman@deeprootsystems.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Tony <tony@atomide.com>

Jean Pihet wrote, on 11/19/2010 04:18 AM:
> Hi,
>
> On Fri, Nov 19, 2010 at 2:54 AM, Nishanth Menon<nm@ti.com>  wrote:
>> Bunch of fixes as part of phase 1 targetting mainly OMAP3630 HS devices
>> for OFF mode logic.
>>
>> It is important to note - for proper functionality of HS OFF mode on OMAP3630,
>>    CONFIG_OMAP3_L2_AUX_SECURE_SAVE_RESTORE=y and
>>    CONFIG_OMAP3_L2_AUX_SECURE_SERVICE_SET_ID should be set to the correct
>>    service that the security PPA supports on the platform.
>>
>> Based on kernel.org 2.6.37-rc2 tag
>>
>> Smoke tested on:
>> SDP3630 -GP
>> Zoom3 (3630): GP&  EMU (Es1.1, ES1.2)
>> SDP3430 - GP&  EMU (ES3.1)
>>
>> These are fixes for corner case bugs seen, so tests of off and ret done with
>> wakeup timer - behavior between 2.6.37-rc2 before and after applying patch
>> seen consistent.
>>
>> Request for testing this series for comparison between master and this
>> series requested for additional platforms where available.
>>
>> Archana Sriram (1):
>>   OMAP3: PM: Errata i582: per domain reset issue: uart
>>
>> Eduardo Valentin (3):
>>   OMAP3: PM: Deny MPU idle while saving secure RAM
>>   OMAP3: PM: Apply errata i540 before save secure ram
>>   OMAP3630: PM: Errata i583: disable coreoff if<  ES1.2
>>
>> Nishanth Menon (3):
>>   OMAP3: PM: make secure ram save size configurable
>>   OMAP3: PM: Fix secure save size for OMAP3
>>   OMAP3630: PM: Errata i608: disable RTA
>>
>> Peter 'p2' De Schrijver (2):
>>   OMAP3: PM: Errata i581 suppport: dll kick strategy
>>   OMAP3630: PM: Disable L2 cache while invalidating L2 cache
>>
>> Richard Woodruff (1):
>>   OMAP3: PM: Update clean_l2 to use v7_flush_dcache_all
>>
>> Tero Kristo (3):
>>   OMAP3: PM: Save secure RAM context before entering WFI
>>   OMAP3: PM: optional save secure RAM context every core off cycle
>>   OMAP3: PM: allocate secure RAM context memory from low-mem
>>
>>   arch/arm/mach-omap2/control.c            |    5 +-
>>   arch/arm/mach-omap2/control.h            |    5 +
>>   arch/arm/mach-omap2/io.c                 |   11 ++
>>   arch/arm/mach-omap2/pm.h                 |   40 +++++++
>>   arch/arm/mach-omap2/pm34xx.c             |  184 ++++++++++++++++++++++++-----
>>   arch/arm/mach-omap2/serial.c             |   80 +++++++++++++
>>   arch/arm/mach-omap2/sleep34xx.S          |  187 ++++++++++++++++++-----------
>>   arch/arm/plat-omap/include/plat/serial.h |    4 +
>>   8 files changed, 412 insertions(+), 104 deletions(-)
>>
>> Regards,
>> Nishanth Menon
>>
>
> This is a nice set of changes, thanks! I sent my remarks.
>
> After having reviewed the patches I think the best is to merge those
> in, then apply the clean-up and possibly the move to DDR patches on
> top of that.
>
> What do you think?

I have the same feel as well.. thanks for your review. I suggest we take 
some more test feedback as well to ensure that there are no more mess 
ups I might have done as the paths are critical.

-- 
Regards,
Nishanth Menon
