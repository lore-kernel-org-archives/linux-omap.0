From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 03/12] omap3: defconfigs: remove SYSFS_DEPRECATED flag
Date: Mon, 16 Nov 2009 15:27:10 -0800
Message-ID: <20091116232710.24892.60673.stgit@localhost>
References: <20091116232435.24892.81547.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55349 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755187AbZKPX1H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Nov 2009 18:27:07 -0500
In-Reply-To: <20091116232435.24892.81547.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Vikram Pandita <vikram.pandita@ti.com>, linux-omap@vger.kernel.org

From: vikram pandita <vikram.pandita@ti.com>

Remove the SYSFS_DEPRECATED flag from OMAP3 board defconfigs
This is a deprecated feature no longer needed.

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
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
index b3c8cce..9cfae37 100644
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
index 36c99e0..180bf9f 100644
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
index 150deaf..b7a8d9f 100644
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
index 5a305f0..c39dbfc 100644
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

