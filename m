From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH] OMAP3: defconfigs: remove SYSFS_DEPRECATED flag
Date: Sat, 12 Sep 2009 00:23:56 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F9C311C1@dbde02.ent.ti.com>
References: <1250112211-25445-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50374 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755860AbZIKSyD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Sep 2009 14:54:03 -0400
In-Reply-To: <1250112211-25445-1-git-send-email-vikram.pandita@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>

Tony/Kevin
 Any feedback on this patch for removal of SYSFS_DEPRECATED flag?

Reference:
http://marc.info/?l=linux-omap&m=125011227920673&q=raw


>-----Original Message-----
>From: Pandita, Vikram
>Sent: Wednesday, August 12, 2009 4:24 PM
>To: linux-omap@vger.kernel.org
>Cc: khilman@deeprootsystems.com; Pandita, Vikram
>Subject: [PATCH] OMAP3: defconfigs: remove SYSFS_DEPRECATED flag
>
>Remove the SYSFS_DEPRECATED flag from OMAP3 board defconfigs
>This is a deprecated feature no longer needed.
>
>Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
>---
>[Note: Did not change omap2/1 boards as they may still be using
>old filesysterms requiring this flag]
>
> arch/arm/configs/omap3_beagle_defconfig  |    4 ++--
> arch/arm/configs/omap3_evm_defconfig     |    4 ++--
> arch/arm/configs/omap3_pandora_defconfig |    5 +++--
> arch/arm/configs/omap_3430sdp_defconfig  |    4 ++--
> arch/arm/configs/omap_4430sdp_defconfig  |    4 ++--
> arch/arm/configs/omap_ldp_defconfig      |    4 ++--
> arch/arm/configs/omap_zoom2_defconfig    |    4 ++--
> arch/arm/configs/overo_defconfig         |    4 ++--
> 8 files changed, 17 insertions(+), 16 deletions(-)
>
>diff --git a/arch/arm/configs/omap3_beagle_defconfig b/arch/arm/configs/omap3_beagle_defconfig
>index fe38a83..0c48a7c 100644
>--- a/arch/arm/configs/omap3_beagle_defconfig
>+++ b/arch/arm/configs/omap3_beagle_defconfig
>@@ -52,8 +52,8 @@ CONFIG_FAIR_GROUP_SCHED=y
> # CONFIG_RT_GROUP_SCHED is not set
> CONFIG_USER_SCHED=y
> # CONFIG_CGROUP_SCHED is not set
>-CONFIG_SYSFS_DEPRECATED=y
>-CONFIG_SYSFS_DEPRECATED_V2=y
>+# CONFIG_SYSFS_DEPRECATED=y is not set
>+# CONFIG_SYSFS_DEPRECATED_V2=y is not set
> # CONFIG_RELAY is not set
> # CONFIG_NAMESPACES is not set
> CONFIG_BLK_DEV_INITRD=y
>diff --git a/arch/arm/configs/omap3_evm_defconfig b/arch/arm/configs/omap3_evm_defconfig
>index 28be17f..9273dcc 100644
>--- a/arch/arm/configs/omap3_evm_defconfig
>+++ b/arch/arm/configs/omap3_evm_defconfig
>@@ -59,8 +59,8 @@ CONFIG_FAIR_GROUP_SCHED=y
> CONFIG_USER_SCHED=y
> # CONFIG_CGROUP_SCHED is not set
> # CONFIG_CGROUPS is not set
>-CONFIG_SYSFS_DEPRECATED=y
>-CONFIG_SYSFS_DEPRECATED_V2=y
>+# CONFIG_SYSFS_DEPRECATED=y is not set
>+# CONFIG_SYSFS_DEPRECATED_V2=y is not set
> # CONFIG_RELAY is not set
> # CONFIG_NAMESPACES is not set
> CONFIG_BLK_DEV_INITRD=y
>diff --git a/arch/arm/configs/omap3_pandora_defconfig b/arch/arm/configs/omap3_pandora_defconfig
>index b54ad2e..de0e659 100644
>--- a/arch/arm/configs/omap3_pandora_defconfig
>+++ b/arch/arm/configs/omap3_pandora_defconfig
>@@ -51,8 +51,9 @@ CONFIG_FAIR_GROUP_SCHED=y
> # CONFIG_RT_GROUP_SCHED is not set
> CONFIG_USER_SCHED=y
> # CONFIG_CGROUP_SCHED is not set
>-CONFIG_SYSFS_DEPRECATED=y
>-CONFIG_SYSFS_DEPRECATED_V2=y
>+# CONFIG_SYSFS_DEPRECATED=y is not set
>+# CONFIG_SYSFS_DEPRECATED_V2=y is not set
>+
> # CONFIG_RELAY is not set
> # CONFIG_NAMESPACES is not set
> CONFIG_BLK_DEV_INITRD=y
>diff --git a/arch/arm/configs/omap_3430sdp_defconfig b/arch/arm/configs/omap_3430sdp_defconfig
>index 8a4a7e2..5c9a686 100644
>--- a/arch/arm/configs/omap_3430sdp_defconfig
>+++ b/arch/arm/configs/omap_3430sdp_defconfig
>@@ -61,8 +61,8 @@ CONFIG_FAIR_GROUP_SCHED=y
> CONFIG_USER_SCHED=y
> # CONFIG_CGROUP_SCHED is not set
> # CONFIG_CGROUPS is not set
>-CONFIG_SYSFS_DEPRECATED=y
>-CONFIG_SYSFS_DEPRECATED_V2=y
>+# CONFIG_SYSFS_DEPRECATED=y is not set
>+# CONFIG_SYSFS_DEPRECATED_V2=y is not set
> # CONFIG_RELAY is not set
> # CONFIG_NAMESPACES is not set
> CONFIG_BLK_DEV_INITRD=y
>diff --git a/arch/arm/configs/omap_4430sdp_defconfig b/arch/arm/configs/omap_4430sdp_defconfig
>index 23e43ea..a464ca3 100644
>--- a/arch/arm/configs/omap_4430sdp_defconfig
>+++ b/arch/arm/configs/omap_4430sdp_defconfig
>@@ -52,8 +52,8 @@ CONFIG_FAIR_GROUP_SCHED=y
> CONFIG_USER_SCHED=y
> # CONFIG_CGROUP_SCHED is not set
> # CONFIG_CGROUPS is not set
>-CONFIG_SYSFS_DEPRECATED=y
>-CONFIG_SYSFS_DEPRECATED_V2=y
>+# CONFIG_SYSFS_DEPRECATED=y is not set
>+# CONFIG_SYSFS_DEPRECATED_V2=y is not set
> # CONFIG_RELAY is not set
> # CONFIG_NAMESPACES is not set
> CONFIG_BLK_DEV_INITRD=y
>diff --git a/arch/arm/configs/omap_ldp_defconfig b/arch/arm/configs/omap_ldp_defconfig
>index b9c4891..9139532 100644
>--- a/arch/arm/configs/omap_ldp_defconfig
>+++ b/arch/arm/configs/omap_ldp_defconfig
>@@ -49,8 +49,8 @@ CONFIG_FAIR_GROUP_SCHED=y
> # CONFIG_RT_GROUP_SCHED is not set
> CONFIG_USER_SCHED=y
> # CONFIG_CGROUP_SCHED is not set
>-CONFIG_SYSFS_DEPRECATED=y
>-CONFIG_SYSFS_DEPRECATED_V2=y
>+# CONFIG_SYSFS_DEPRECATED=y is not set
>+# CONFIG_SYSFS_DEPRECATED_V2=y is not set
> # CONFIG_RELAY is not set
> # CONFIG_NAMESPACES is not set
> CONFIG_BLK_DEV_INITRD=y
>diff --git a/arch/arm/configs/omap_zoom2_defconfig b/arch/arm/configs/omap_zoom2_defconfig
>index f1739fa..a32d126 100644
>--- a/arch/arm/configs/omap_zoom2_defconfig
>+++ b/arch/arm/configs/omap_zoom2_defconfig
>@@ -59,8 +59,8 @@ CONFIG_FAIR_GROUP_SCHED=y
> CONFIG_USER_SCHED=y
> # CONFIG_CGROUP_SCHED is not set
> # CONFIG_CGROUPS is not set
>-CONFIG_SYSFS_DEPRECATED=y
>-CONFIG_SYSFS_DEPRECATED_V2=y
>+# CONFIG_SYSFS_DEPRECATED=y is not set
>+# CONFIG_SYSFS_DEPRECATED_V2=y is not set
> # CONFIG_RELAY is not set
> # CONFIG_NAMESPACES is not set
> CONFIG_BLK_DEV_INITRD=y
>diff --git a/arch/arm/configs/overo_defconfig b/arch/arm/configs/overo_defconfig
>index a57f9e4..b3ea2c4 100644
>--- a/arch/arm/configs/overo_defconfig
>+++ b/arch/arm/configs/overo_defconfig
>@@ -54,8 +54,8 @@ CONFIG_FAIR_GROUP_SCHED=y
> # CONFIG_RT_GROUP_SCHED is not set
> CONFIG_USER_SCHED=y
> # CONFIG_CGROUP_SCHED is not set
>-CONFIG_SYSFS_DEPRECATED=y
>-CONFIG_SYSFS_DEPRECATED_V2=y
>+# CONFIG_SYSFS_DEPRECATED=y is not set
>+# CONFIG_SYSFS_DEPRECATED_V2=y is not set
> # CONFIG_RELAY is not set
> # CONFIG_NAMESPACES is not set
> CONFIG_BLK_DEV_INITRD=y
>--
>1.6.3.3.334.g916e1

