From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH] OMAP3: PM: Update omap3_pm_defconfig
Date: Wed,  7 Oct 2009 12:29:28 +0530
Message-ID: <1254898768-16495-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46404 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883AbZJGHAJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Oct 2009 03:00:09 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n976xUvK024141
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 7 Oct 2009 01:59:32 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>

Some of the sysfs deprecated entries, if not enabled cause
root filesystem mounts to fail at boot.
This is seen on both the 3430SDP as well as 3430zoom platforms.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/configs/omap3_pm_defconfig |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/omap3_pm_defconfig b/arch/arm/configs/omap3_pm_defconfig
index 9d54139..b1c42ed 100644
--- a/arch/arm/configs/omap3_pm_defconfig
+++ b/arch/arm/configs/omap3_pm_defconfig
@@ -58,7 +58,8 @@ CONFIG_FAIR_GROUP_SCHED=y
 CONFIG_USER_SCHED=y
 # CONFIG_CGROUP_SCHED is not set
 # CONFIG_CGROUPS is not set
-# CONFIG_SYSFS_DEPRECATED_V2 is not set
+CONFIG_SYSFS_DEPRECATED=y
+CONFIG_SYSFS_DEPRECATED_V2=y
 # CONFIG_RELAY is not set
 # CONFIG_NAMESPACES is not set
 CONFIG_BLK_DEV_INITRD=y
-- 
1.5.4.7

