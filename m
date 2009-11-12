From: Anand Gadiyar <gadiyar@ti.com>
Subject: [PATCH] omap: zoom3: remove SYSFS_DEPRECATED from defconfig
Date: Thu, 12 Nov 2009 13:08:41 +0530
Message-ID: <1258011521-30994-1-git-send-email-gadiyar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51427 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362AbZKLHik (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Nov 2009 02:38:40 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAC7chjL021419
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 12 Nov 2009 01:38:45 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Anand Gadiyar <gadiyar@ti.com>, Vikram Pandita <vikram.pandita@ti.com>

omap: zoom3: remove SYSFS_DEPRECATED from defconfig

SYSFS_DEPRECATED seems to have been accidentally introduced.
This option has been removed from the other OMAP defconfigs
and should not be needed here.

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Cc: Vikram Pandita <vikram.pandita@ti.com>
---
Found this after sending out the previous zoom3 patch.

Okay with me to fold these patches into one.

 arch/arm/configs/omap_zoom3_defconfig |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

Index: linux-omap-2.6/arch/arm/configs/omap_zoom3_defconfig
===================================================================
--- linux-omap-2.6.orig/arch/arm/configs/omap_zoom3_defconfig
+++ linux-omap-2.6/arch/arm/configs/omap_zoom3_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.32-rc6
-# Thu Nov 12 12:39:26 2009
+# Thu Nov 12 13:04:07 2009
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
@@ -58,8 +58,7 @@ CONFIG_FAIR_GROUP_SCHED=y
 CONFIG_USER_SCHED=y
 # CONFIG_CGROUP_SCHED is not set
 # CONFIG_CGROUPS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 # CONFIG_RELAY is not set
 # CONFIG_NAMESPACES is not set
 CONFIG_BLK_DEV_INITRD=y
