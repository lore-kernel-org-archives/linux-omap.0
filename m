From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: defconfigs: remove SYSFS_DEPRECATED flag
Date: Fri, 11 Sep 2009 14:08:55 -0700
Message-ID: <873a6t6vfc.fsf@deeprootsystems.com>
References: <1250112211-25445-1-git-send-email-vikram.pandita@ti.com>
	<FCCFB4CDC6E5564B9182F639FC35608702F9C311C1@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f189.google.com ([209.85.216.189]:44814 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932101AbZIKVI5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Sep 2009 17:08:57 -0400
Received: by pxi27 with SMTP id 27so1078180pxi.15
        for <linux-omap@vger.kernel.org>; Fri, 11 Sep 2009 14:08:59 -0700 (PDT)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702F9C311C1@dbde02.ent.ti.com> (Vikram Pandita's message of "Sat\, 12 Sep 2009 00\:23\:56 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

"Pandita, Vikram" <vikram.pandita@ti.com> writes:

> Tony/Kevin
>  Any feedback on this patch for removal of SYSFS_DEPRECATED flag?
>
> Reference:
> http://marc.info/?l=linux-omap&m=125011227920673&q=raw

I already ack'd:

  http://marc.info/?l=linux-omap&m=125011754929777&w=2

>
>>-----Original Message-----
>>From: Pandita, Vikram
>>Sent: Wednesday, August 12, 2009 4:24 PM
>>To: linux-omap@vger.kernel.org
>>Cc: khilman@deeprootsystems.com; Pandita, Vikram
>>Subject: [PATCH] OMAP3: defconfigs: remove SYSFS_DEPRECATED flag
>>
>>Remove the SYSFS_DEPRECATED flag from OMAP3 board defconfigs
>>This is a deprecated feature no longer needed.
>>
>>Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
>>---
>>[Note: Did not change omap2/1 boards as they may still be using
>>old filesysterms requiring this flag]
>>
>> arch/arm/configs/omap3_beagle_defconfig  |    4 ++--
>> arch/arm/configs/omap3_evm_defconfig     |    4 ++--
>> arch/arm/configs/omap3_pandora_defconfig |    5 +++--
>> arch/arm/configs/omap_3430sdp_defconfig  |    4 ++--
>> arch/arm/configs/omap_4430sdp_defconfig  |    4 ++--
>> arch/arm/configs/omap_ldp_defconfig      |    4 ++--
>> arch/arm/configs/omap_zoom2_defconfig    |    4 ++--
>> arch/arm/configs/overo_defconfig         |    4 ++--
>> 8 files changed, 17 insertions(+), 16 deletions(-)
>>
>>diff --git a/arch/arm/configs/omap3_beagle_defconfig b/arch/arm/configs/omap3_beagle_defconfig
>>index fe38a83..0c48a7c 100644
>>--- a/arch/arm/configs/omap3_beagle_defconfig
>>+++ b/arch/arm/configs/omap3_beagle_defconfig
>>@@ -52,8 +52,8 @@ CONFIG_FAIR_GROUP_SCHED=y
>> # CONFIG_RT_GROUP_SCHED is not set
>> CONFIG_USER_SCHED=y
>> # CONFIG_CGROUP_SCHED is not set
>>-CONFIG_SYSFS_DEPRECATED=y
>>-CONFIG_SYSFS_DEPRECATED_V2=y
>>+# CONFIG_SYSFS_DEPRECATED=y is not set
>>+# CONFIG_SYSFS_DEPRECATED_V2=y is not set
>> # CONFIG_RELAY is not set
>> # CONFIG_NAMESPACES is not set
>> CONFIG_BLK_DEV_INITRD=y
>>diff --git a/arch/arm/configs/omap3_evm_defconfig b/arch/arm/configs/omap3_evm_defconfig
>>index 28be17f..9273dcc 100644
>>--- a/arch/arm/configs/omap3_evm_defconfig
>>+++ b/arch/arm/configs/omap3_evm_defconfig
>>@@ -59,8 +59,8 @@ CONFIG_FAIR_GROUP_SCHED=y
>> CONFIG_USER_SCHED=y
>> # CONFIG_CGROUP_SCHED is not set
>> # CONFIG_CGROUPS is not set
>>-CONFIG_SYSFS_DEPRECATED=y
>>-CONFIG_SYSFS_DEPRECATED_V2=y
>>+# CONFIG_SYSFS_DEPRECATED=y is not set
>>+# CONFIG_SYSFS_DEPRECATED_V2=y is not set
>> # CONFIG_RELAY is not set
>> # CONFIG_NAMESPACES is not set
>> CONFIG_BLK_DEV_INITRD=y
>>diff --git a/arch/arm/configs/omap3_pandora_defconfig b/arch/arm/configs/omap3_pandora_defconfig
>>index b54ad2e..de0e659 100644
>>--- a/arch/arm/configs/omap3_pandora_defconfig
>>+++ b/arch/arm/configs/omap3_pandora_defconfig
>>@@ -51,8 +51,9 @@ CONFIG_FAIR_GROUP_SCHED=y
>> # CONFIG_RT_GROUP_SCHED is not set
>> CONFIG_USER_SCHED=y
>> # CONFIG_CGROUP_SCHED is not set
>>-CONFIG_SYSFS_DEPRECATED=y
>>-CONFIG_SYSFS_DEPRECATED_V2=y
>>+# CONFIG_SYSFS_DEPRECATED=y is not set
>>+# CONFIG_SYSFS_DEPRECATED_V2=y is not set
>>+
>> # CONFIG_RELAY is not set
>> # CONFIG_NAMESPACES is not set
>> CONFIG_BLK_DEV_INITRD=y
>>diff --git a/arch/arm/configs/omap_3430sdp_defconfig b/arch/arm/configs/omap_3430sdp_defconfig
>>index 8a4a7e2..5c9a686 100644
>>--- a/arch/arm/configs/omap_3430sdp_defconfig
>>+++ b/arch/arm/configs/omap_3430sdp_defconfig
>>@@ -61,8 +61,8 @@ CONFIG_FAIR_GROUP_SCHED=y
>> CONFIG_USER_SCHED=y
>> # CONFIG_CGROUP_SCHED is not set
>> # CONFIG_CGROUPS is not set
>>-CONFIG_SYSFS_DEPRECATED=y
>>-CONFIG_SYSFS_DEPRECATED_V2=y
>>+# CONFIG_SYSFS_DEPRECATED=y is not set
>>+# CONFIG_SYSFS_DEPRECATED_V2=y is not set
>> # CONFIG_RELAY is not set
>> # CONFIG_NAMESPACES is not set
>> CONFIG_BLK_DEV_INITRD=y
>>diff --git a/arch/arm/configs/omap_4430sdp_defconfig b/arch/arm/configs/omap_4430sdp_defconfig
>>index 23e43ea..a464ca3 100644
>>--- a/arch/arm/configs/omap_4430sdp_defconfig
>>+++ b/arch/arm/configs/omap_4430sdp_defconfig
>>@@ -52,8 +52,8 @@ CONFIG_FAIR_GROUP_SCHED=y
>> CONFIG_USER_SCHED=y
>> # CONFIG_CGROUP_SCHED is not set
>> # CONFIG_CGROUPS is not set
>>-CONFIG_SYSFS_DEPRECATED=y
>>-CONFIG_SYSFS_DEPRECATED_V2=y
>>+# CONFIG_SYSFS_DEPRECATED=y is not set
>>+# CONFIG_SYSFS_DEPRECATED_V2=y is not set
>> # CONFIG_RELAY is not set
>> # CONFIG_NAMESPACES is not set
>> CONFIG_BLK_DEV_INITRD=y
>>diff --git a/arch/arm/configs/omap_ldp_defconfig b/arch/arm/configs/omap_ldp_defconfig
>>index b9c4891..9139532 100644
>>--- a/arch/arm/configs/omap_ldp_defconfig
>>+++ b/arch/arm/configs/omap_ldp_defconfig
>>@@ -49,8 +49,8 @@ CONFIG_FAIR_GROUP_SCHED=y
>> # CONFIG_RT_GROUP_SCHED is not set
>> CONFIG_USER_SCHED=y
>> # CONFIG_CGROUP_SCHED is not set
>>-CONFIG_SYSFS_DEPRECATED=y
>>-CONFIG_SYSFS_DEPRECATED_V2=y
>>+# CONFIG_SYSFS_DEPRECATED=y is not set
>>+# CONFIG_SYSFS_DEPRECATED_V2=y is not set
>> # CONFIG_RELAY is not set
>> # CONFIG_NAMESPACES is not set
>> CONFIG_BLK_DEV_INITRD=y
>>diff --git a/arch/arm/configs/omap_zoom2_defconfig b/arch/arm/configs/omap_zoom2_defconfig
>>index f1739fa..a32d126 100644
>>--- a/arch/arm/configs/omap_zoom2_defconfig
>>+++ b/arch/arm/configs/omap_zoom2_defconfig
>>@@ -59,8 +59,8 @@ CONFIG_FAIR_GROUP_SCHED=y
>> CONFIG_USER_SCHED=y
>> # CONFIG_CGROUP_SCHED is not set
>> # CONFIG_CGROUPS is not set
>>-CONFIG_SYSFS_DEPRECATED=y
>>-CONFIG_SYSFS_DEPRECATED_V2=y
>>+# CONFIG_SYSFS_DEPRECATED=y is not set
>>+# CONFIG_SYSFS_DEPRECATED_V2=y is not set
>> # CONFIG_RELAY is not set
>> # CONFIG_NAMESPACES is not set
>> CONFIG_BLK_DEV_INITRD=y
>>diff --git a/arch/arm/configs/overo_defconfig b/arch/arm/configs/overo_defconfig
>>index a57f9e4..b3ea2c4 100644
>>--- a/arch/arm/configs/overo_defconfig
>>+++ b/arch/arm/configs/overo_defconfig
>>@@ -54,8 +54,8 @@ CONFIG_FAIR_GROUP_SCHED=y
>> # CONFIG_RT_GROUP_SCHED is not set
>> CONFIG_USER_SCHED=y
>> # CONFIG_CGROUP_SCHED is not set
>>-CONFIG_SYSFS_DEPRECATED=y
>>-CONFIG_SYSFS_DEPRECATED_V2=y
>>+# CONFIG_SYSFS_DEPRECATED=y is not set
>>+# CONFIG_SYSFS_DEPRECATED_V2=y is not set
>> # CONFIG_RELAY is not set
>> # CONFIG_NAMESPACES is not set
>> CONFIG_BLK_DEV_INITRD=y
>>--
>>1.6.3.3.334.g916e1
