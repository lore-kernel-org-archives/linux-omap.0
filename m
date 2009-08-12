From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH] OMAP3: defconfigs: remove SYSFS_DEPRECATED flag
Date: Wed, 12 Aug 2009 16:23:31 -0500
Message-ID: <1250112211-25445-1-git-send-email-vikram.pandita@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48705 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751339AbZHLVY0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Aug 2009 17:24:26 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, Vikram Pandita <vikram.pandita@ti.com>

Remove the SYSFS_DEPRECATED flag from OMAP3 board defconfigs
This is a deprecated feature no longer needed.

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
---
[Note: Did not change omap2/1 boards as they may still be using 
old filesysterms requiring this flag]

 arch/arm/configs/omap3_beagle_defconfig  |    4 ++--
 arch/arm/configs/omap3_evm_defconfig     |    4 ++--
 arch/arm/configs/omap3_pandora_defconfig |    5 +++--
 arch/arm/configs/omap_3430sdp_defconfig  |    4 ++--
 arch/arm/configs/omap_4430sdp_defconfig  |    4 ++--
 arch/arm/configs/omap_ldp_defconfig      |    4 ++--
 arch/arm/configs/omap_zoom2_defconfig    |    4 ++--
 arch/arm/configs/overo_defconfig         |    4 ++--
 8 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/arch/arm/configs/omap3_beagle_defconfig b/arch/arm/configs/omap3_beagle_defconfig
index fe38a83..0c48a7c 100644
--- a/arch/arm/configs/omap3_beagle_defconfig
+++ b/arch/arm/configs/omap3_beagle_defconfig
@@ -52,8 +52,8 @@ CONFIG_FAIR_GROUP_SCHED=y
 # CONFIG_RT_GROUP_SCHED is not set
 CONFIG_USER_SCHED=y
 # CONFIG_CGROUP_SCHED is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED=y is not set
+# CONFIG_SYSFS_DEPRECATED_V2=y is not set
 # CONFIG_RELAY is not set
 # CONFIG_NAMESPACES is not set
 CONFIG_BLK_DEV_INITRD=y
diff --git a/arch/arm/configs/omap3_evm_defconfig b/arch/arm/configs/omap3_evm_defconfig
index 28be17f..9273dcc 100644
--- a/arch/arm/configs/omap3_evm_defconfig
+++ b/arch/arm/configs/omap3_evm_defconfig
@@ -59,8 +59,8 @@ CONFIG_FAIR_GROUP_SCHED=y
 CONFIG_USER_SCHED=y
 # CONFIG_CGROUP_SCHED is not set
 # CONFIG_CGROUPS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED=y is not set
+# CONFIG_SYSFS_DEPRECATED_V2=y is not set
 # CONFIG_RELAY is not set
 # CONFIG_NAMESPACES is not set
 CONFIG_BLK_DEV_INITRD=y
diff --git a/arch/arm/configs/omap3_pandora_defconfig b/arch/arm/configs/omap3_pandora_defconfig
index b54ad2e..de0e659 100644
--- a/arch/arm/configs/omap3_pandora_defconfig
+++ b/arch/arm/configs/omap3_pandora_defconfig
@@ -51,8 +51,9 @@ CONFIG_FAIR_GROUP_SCHED=y
 # CONFIG_RT_GROUP_SCHED is not set
 CONFIG_USER_SCHED=y
 # CONFIG_CGROUP_SCHED is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED=y is not set
+# CONFIG_SYSFS_DEPRECATED_V2=y is not set
+
 # CONFIG_RELAY is not set
 # CONFIG_NAMESPACES is not set
 CONFIG_BLK_DEV_INITRD=y
diff --git a/arch/arm/configs/omap_3430sdp_defconfig b/arch/arm/configs/omap_3430sdp_defconfig
index 8a4a7e2..5c9a686 100644
--- a/arch/arm/configs/omap_3430sdp_defconfig
+++ b/arch/arm/configs/omap_3430sdp_defconfig
@@ -61,8 +61,8 @@ CONFIG_FAIR_GROUP_SCHED=y
 CONFIG_USER_SCHED=y
 # CONFIG_CGROUP_SCHED is not set
 # CONFIG_CGROUPS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED=y is not set
+# CONFIG_SYSFS_DEPRECATED_V2=y is not set
 # CONFIG_RELAY is not set
 # CONFIG_NAMESPACES is not set
 CONFIG_BLK_DEV_INITRD=y
diff --git a/arch/arm/configs/omap_4430sdp_defconfig b/arch/arm/configs/omap_4430sdp_defconfig
index 23e43ea..a464ca3 100644
--- a/arch/arm/configs/omap_4430sdp_defconfig
+++ b/arch/arm/configs/omap_4430sdp_defconfig
@@ -52,8 +52,8 @@ CONFIG_FAIR_GROUP_SCHED=y
 CONFIG_USER_SCHED=y
 # CONFIG_CGROUP_SCHED is not set
 # CONFIG_CGROUPS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED=y is not set
+# CONFIG_SYSFS_DEPRECATED_V2=y is not set
 # CONFIG_RELAY is not set
 # CONFIG_NAMESPACES is not set
 CONFIG_BLK_DEV_INITRD=y
diff --git a/arch/arm/configs/omap_ldp_defconfig b/arch/arm/configs/omap_ldp_defconfig
index b9c4891..9139532 100644
--- a/arch/arm/configs/omap_ldp_defconfig
+++ b/arch/arm/configs/omap_ldp_defconfig
@@ -49,8 +49,8 @@ CONFIG_FAIR_GROUP_SCHED=y
 # CONFIG_RT_GROUP_SCHED is not set
 CONFIG_USER_SCHED=y
 # CONFIG_CGROUP_SCHED is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED=y is not set
+# CONFIG_SYSFS_DEPRECATED_V2=y is not set
 # CONFIG_RELAY is not set
 # CONFIG_NAMESPACES is not set
 CONFIG_BLK_DEV_INITRD=y
diff --git a/arch/arm/configs/omap_zoom2_defconfig b/arch/arm/configs/omap_zoom2_defconfig
index f1739fa..a32d126 100644
--- a/arch/arm/configs/omap_zoom2_defconfig
+++ b/arch/arm/configs/omap_zoom2_defconfig
@@ -59,8 +59,8 @@ CONFIG_FAIR_GROUP_SCHED=y
 CONFIG_USER_SCHED=y
 # CONFIG_CGROUP_SCHED is not set
 # CONFIG_CGROUPS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED=y is not set
+# CONFIG_SYSFS_DEPRECATED_V2=y is not set
 # CONFIG_RELAY is not set
 # CONFIG_NAMESPACES is not set
 CONFIG_BLK_DEV_INITRD=y
diff --git a/arch/arm/configs/overo_defconfig b/arch/arm/configs/overo_defconfig
index a57f9e4..b3ea2c4 100644
--- a/arch/arm/configs/overo_defconfig
+++ b/arch/arm/configs/overo_defconfig
@@ -54,8 +54,8 @@ CONFIG_FAIR_GROUP_SCHED=y
 # CONFIG_RT_GROUP_SCHED is not set
 CONFIG_USER_SCHED=y
 # CONFIG_CGROUP_SCHED is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED=y is not set
+# CONFIG_SYSFS_DEPRECATED_V2=y is not set
 # CONFIG_RELAY is not set
 # CONFIG_NAMESPACES is not set
 CONFIG_BLK_DEV_INITRD=y
-- 
1.6.3.3.334.g916e1

