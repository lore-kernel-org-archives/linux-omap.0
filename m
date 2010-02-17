From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH] OMAP3EVM: PM: Update defconfig
Date: Wed, 17 Feb 2010 18:55:42 +0530
Message-ID: <1266413142-15532-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45025 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933189Ab0BQN1H (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Feb 2010 08:27:07 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o1HDR39u014417
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 17 Feb 2010 07:27:05 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

This patch updates the omap3_evm_defconfig to
select CONFIG_PM_DEBUG and CONFIG_DEBUG_FS.

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/configs/omap3_evm_defconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/omap3_evm_defconfig b/arch/arm/configs/omap3_evm_defconfig
index 86cc4be..b938507 100644
--- a/arch/arm/configs/omap3_evm_defconfig
+++ b/arch/arm/configs/omap3_evm_defconfig
@@ -333,7 +333,7 @@ CONFIG_BINFMT_MISC=y
 # Power management options
 #
 CONFIG_PM=y
-# CONFIG_PM_DEBUG is not set
+CONFIG_PM_DEBUG=y
 CONFIG_PM_SLEEP=y
 CONFIG_SUSPEND=y
 CONFIG_SUSPEND_FREEZER=y
@@ -1339,7 +1339,7 @@ CONFIG_ENABLE_MUST_CHECK=y
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

