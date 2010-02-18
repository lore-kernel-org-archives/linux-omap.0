From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 23/23] OMAP3EVM: PM: Update defconfig
Date: Wed, 17 Feb 2010 17:32:50 -0800
Message-ID: <20100218013250.32075.51003.stgit@baageli.muru.com>
References: <20100218013012.32075.43788.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:59657 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755529Ab0BRBcA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Feb 2010 20:32:00 -0500
In-Reply-To: <20100218013012.32075.43788.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Sanjeev Premi <premi@ti.com>

From: Sanjeev Premi <premi@ti.com>

This patch updates the omap3_evm_defconfig to
select these options:
  * CONFIG_PM_DEBUG
  * CONFIG_DEBUG_FS
  * CONFIG_OMAP_SMARTREFLEX

Signed-off-by: Sanjeev Premi <premi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
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

