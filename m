From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/5] extra module resets to ensure full-chip idle
Date: Wed, 26 Nov 2008 21:14:13 -0800
Message-ID: <871vwxiwd6.fsf@deeprootsystems.com>
References: <1227744349-12118-1-git-send-email-khilman@deeprootsystems.com>
	<492E2A52.4030200@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.28]:59250 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894AbYK0FOU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Nov 2008 00:14:20 -0500
Received: by yx-out-2324.google.com with SMTP id 8so384959yxm.1
        for <linux-omap@vger.kernel.org>; Wed, 26 Nov 2008 21:14:18 -0800 (PST)
In-Reply-To: <492E2A52.4030200@googlemail.com> (Dirk Behme's message of "Thu\, 27 Nov 2008 06\:04\:18 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap@vger.kernel.org

Dirk Behme <dirk.behme@googlemail.com> writes:

> Kevin Hilman wrote:
>> Various bootloaders have been known to leave modules in a state
>> which prevents full-chip retention.  
>
> Does it make sense to check if
>
> [PATCH 1/5] OMAP3: PM: HSMMC: force MMC module reset on boot
> [PATCH 2/5] OMAP3: PM: Force IVA2 into idle during bootup
>
> can be done in U-Boot, too? If yes, I would have a look to it.

Yes, ideally u-boot or whatever bootloader isused should 
be leaving these modules in a known reset/idle state.

However, there are many bootloaders for many platforms out there so
until there is some sort of standard on bootloaders, I think the
kernel will have to ensure this is done.

Kevin

>
>> This series forces
>> MMC, IVA2 and D2D/modem into known reset/idle states so that
>> the OMAP3 can hit full-chip idle.
>>
>> Tested on OMAP3 Beagle, and custom OMAP3 hardware.
>>
>> NOTE: this is similar to the set I posted for the PM branch
>>       but this series is rebased onto linux-omap and includes
>>       the MMC reset.
>>
>> Kevin Hilman (5):
>>   OMAP3: PM: HSMMC: force MMC module reset on boot
>>   OMAP3: PM: Force IVA2 into idle during bootup
>>   OMAP3: PM: Add D2D clocks and auto-idle setup to PRCM init
>>   OMAP3: PM: D2D clockdomain supports SW supervised transitions
>>   OMAP3: PM: Ensure modem is reset during PRCM init
>>
>>  arch/arm/mach-omap2/clock34xx.h           |   37 +++++++++++++-
>>  arch/arm/mach-omap2/clockdomains.h        |    2 +-
>>  arch/arm/mach-omap2/cm-regbits-34xx.h     |   14 +++++
>>  arch/arm/mach-omap2/devices.c             |   76 +++++++++++++++++++++++++++++
>>  arch/arm/mach-omap2/pm34xx.c              |   65 ++++++++++++++++++++++++-
>>  arch/arm/plat-omap/include/mach/control.h |    5 ++
>>  6 files changed, 195 insertions(+), 4 deletions(-)
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
