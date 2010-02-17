From: Sanjeev Premi <premi@ti.com>
Subject: [PATCHv2] OMAP3EVM: PM: Update defconfig
Date: Wed, 17 Feb 2010 19:26:52 +0530
Message-ID: <1266415012-23300-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46428 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933457Ab0BQN5A (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Feb 2010 08:57:00 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o1HDuvxs016921
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 17 Feb 2010 07:56:59 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

This patch updates the omap3_evm_defconfig to
select these options:
  * CONFIG_PM_DEBUG
  * CONFIG_DEBUG_FS
  * CONFIG_OMAP_SMARTREFLEX

Signed-off-by: Sanjeev Premi <premi@ti.com>
---

 Found that SmartReflex was disabled as well. Didn't
 feel need for a different patch for same.


 arch/arm/configs/omap3_evm_defconfig |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/omap3_evm_defconfig b/arch/arm/configs/omap3_evm_defconfig
index 86cc4be..e2ad859 100644
--- a/arch/arm/configs/omap3_evm_defconfig
+++ b/arch/arm/configs/omap3_evm_defconfig
@@ -187,6 +187,8 @@ CONFIG_ARCH_OMAP3=y
 #
 # OMAP Feature Selections
 #
+CONFIG_OMAP_SMARTREFLEX=y
+# CONFIG_OMAP_SMARTREFLEX_TESTING is not set
 # CONFIG_OMAP_DEBUG_POWERDOMAIN is not set
 # CONFIG_OMAP_DEBUG_CLOCKDOMAIN is not set
 CONFIG_OMAP_RESET_CLOCKS=y
@@ -333,7 +335,7 @@ CONFIG_BINFMT_MISC=y
 # Power management options
 #
 CONFIG_PM=y
-# CONFIG_PM_DEBUG is not set
+CONFIG_PM_DEBUG=y
 CONFIG_PM_SLEEP=y
 CONFIG_SUSPEND=y
 CONFIG_SUSPEND_FREEZER=y
@@ -1339,7 +1341,7 @@ CONFIG_ENABLE_MUST_CHECK=y
 CONFIG_FRAME_WARN=1024
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_UNUSED_SYMBOLS is not set
-# CONFIG_DEBUG_FS is not set
+CONFIG_DEBUG_FS=y
 # CONFIG_HEADERS_CHECK is not set
 CONFIG_DEBUG_KERNEL=y
 # CONFIG_DEBUG_SHIRQ is not set
-- 
1.6.6.1

