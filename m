From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: PM: Update omap3_pm_defconfig
Date: Wed, 07 Oct 2009 06:25:22 -0700
Message-ID: <87zl83mj3x.fsf@deeprootsystems.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030A332929@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f188.google.com ([209.85.222.188]:46205 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933139AbZJGN0I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Oct 2009 09:26:08 -0400
Received: by pzk26 with SMTP id 26so4410690pzk.4
        for <linux-omap@vger.kernel.org>; Wed, 07 Oct 2009 06:25:31 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030A332929@dbde02.ent.ti.com> (Rajendra Nayak's message of "Wed\, 7 Oct 2009 17\:35\:13 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Nayak, Rajendra" <rnayak@ti.com> writes:

>>-----Original Message-----
>>From: Gadiyar, Anand 
>>Sent: Wednesday, October 07, 2009 5:31 PM
>>To: Nayak, Rajendra; linux-omap@vger.kernel.org
>>Subject: RE: [PATCH] OMAP3: PM: Update omap3_pm_defconfig
>>
>>> Some of the sysfs deprecated entries, if not enabled cause
>>> root filesystem mounts to fail at boot.
>>> This is seen on both the 3430SDP as well as 3430zoom platforms.
>>> 
>>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>>> ---
>>>  arch/arm/configs/omap3_pm_defconfig |    3 ++-
>>>  1 files changed, 2 insertions(+), 1 deletions(-)
>>> 
>>> diff --git a/arch/arm/configs/omap3_pm_defconfig 
>>> b/arch/arm/configs/omap3_pm_defconfig
>>> index 9d54139..b1c42ed 100644
>>> --- a/arch/arm/configs/omap3_pm_defconfig
>>> +++ b/arch/arm/configs/omap3_pm_defconfig
>>> @@ -58,7 +58,8 @@ CONFIG_FAIR_GROUP_SCHED=y
>>>  CONFIG_USER_SCHED=y
>>>  # CONFIG_CGROUP_SCHED is not set
>>>  # CONFIG_CGROUPS is not set
>>> -# CONFIG_SYSFS_DEPRECATED_V2 is not set
>>> +CONFIG_SYSFS_DEPRECATED=y
>>> +CONFIG_SYSFS_DEPRECATED_V2=y
>>
>>I think these were deliberately removed on  many OMAP3
>>defconfigs by a recent patch from Vikram
>>.
>>Having these enabled makes it hard to boot on a newer
>>busybox filesystem.
>>
>>It's easy to fix if you just upgrade busybox to a newer
>>version.

Also, any OE-based distro expects these to be disabled to work
correctly.

Kevin
