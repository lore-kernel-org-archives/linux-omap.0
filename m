From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: [PATCH] OMAP3: PM: Update omap3_pm_defconfig
Date: Wed, 7 Oct 2009 17:35:13 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A332929@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030A332920@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60659 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932835AbZJGMFy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Oct 2009 08:05:54 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n97C5FMe004208
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 7 Oct 2009 07:05:17 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n97C5FHa010366
	for <linux-omap@vger.kernel.org>; Wed, 7 Oct 2009 17:35:15 +0530 (IST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030A332920@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>-----Original Message-----
>From: Gadiyar, Anand 
>Sent: Wednesday, October 07, 2009 5:31 PM
>To: Nayak, Rajendra; linux-omap@vger.kernel.org
>Subject: RE: [PATCH] OMAP3: PM: Update omap3_pm_defconfig
>
>> Some of the sysfs deprecated entries, if not enabled cause
>> root filesystem mounts to fail at boot.
>> This is seen on both the 3430SDP as well as 3430zoom platforms.
>> 
>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>> ---
>>  arch/arm/configs/omap3_pm_defconfig |    3 ++-
>>  1 files changed, 2 insertions(+), 1 deletions(-)
>> 
>> diff --git a/arch/arm/configs/omap3_pm_defconfig 
>> b/arch/arm/configs/omap3_pm_defconfig
>> index 9d54139..b1c42ed 100644
>> --- a/arch/arm/configs/omap3_pm_defconfig
>> +++ b/arch/arm/configs/omap3_pm_defconfig
>> @@ -58,7 +58,8 @@ CONFIG_FAIR_GROUP_SCHED=y
>>  CONFIG_USER_SCHED=y
>>  # CONFIG_CGROUP_SCHED is not set
>>  # CONFIG_CGROUPS is not set
>> -# CONFIG_SYSFS_DEPRECATED_V2 is not set
>> +CONFIG_SYSFS_DEPRECATED=y
>> +CONFIG_SYSFS_DEPRECATED_V2=y
>
>I think these were deliberately removed on  many OMAP3
>defconfigs by a recent patch from Vikram
>.
>Having these enabled makes it hard to boot on a newer
>busybox filesystem.
>
>It's easy to fix if you just upgrade busybox to a newer
>version.

Ok.. makes sense. I'll try with a newer busybox.

>
>- Anand
>