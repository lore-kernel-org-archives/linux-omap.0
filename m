From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 06/19] omap: Enable PM_RUNTIME in defconfigs to avoid USB
	compile errors
Date: Thu, 11 Mar 2010 15:48:19 -0800
Message-ID: <20100311234819.4500.4924.stgit@baageli.muru.com>
References: <20100311234404.4500.82861.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:52366 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753632Ab0CKXq4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Mar 2010 18:46:56 -0500
In-Reply-To: <20100311234404.4500.82861.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

While waiting for the related USB patch, fix compile by enabling
it in the defconfigs. As discussed at:

http://thread.gmane.org/gmane.linux.usb.general/27432/focus=4460

Otherwise we'll get errors like:

drivers/usb/core/hcd.c:1892: error: 'pm_wq' undeclared (first use in this function)
drivers/usb/core/hcd.c:1892: error: (Each undeclared identifier is reported only once
drivers/usb/core/hcd.c:1892: error: for each function it appears in.)

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/cm_t35_defconfig          |    2 +-
 arch/arm/configs/n770_defconfig            |    1 +
 arch/arm/configs/omap3_beagle_defconfig    |    1 +
 arch/arm/configs/omap3_defconfig           |    2 +-
 arch/arm/configs/omap3_evm_defconfig       |    1 +
 arch/arm/configs/omap3_touchbook_defconfig |    2 +-
 arch/arm/configs/omap_3430sdp_defconfig    |    1 +
 arch/arm/configs/omap_3630sdp_defconfig    |    2 +-
 arch/arm/configs/omap_h2_1610_defconfig    |    1 +
 arch/arm/configs/omap_zoom2_defconfig      |    1 +
 arch/arm/configs/omap_zoom3_defconfig      |    2 +-
 arch/arm/configs/rx51_defconfig            |    1 +
 12 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/arm/configs/cm_t35_defconfig b/arch/arm/configs/cm_t35_defconfig
index 893cd26..032b49b 100644
--- a/arch/arm/configs/cm_t35_defconfig
+++ b/arch/arm/configs/cm_t35_defconfig
@@ -358,7 +358,7 @@ CONFIG_PM_SLEEP=y
 CONFIG_SUSPEND=y
 CONFIG_SUSPEND_FREEZER=y
 # CONFIG_APM_EMULATION is not set
-# CONFIG_PM_RUNTIME is not set
+CONFIG_PM_RUNTIME=y
 CONFIG_ARCH_SUSPEND_POSSIBLE=y
 CONFIG_NET=y
 
diff --git a/arch/arm/configs/n770_defconfig b/arch/arm/configs/n770_defconfig
index 75cae18..de0c28a 100644
--- a/arch/arm/configs/n770_defconfig
+++ b/arch/arm/configs/n770_defconfig
@@ -308,6 +308,7 @@ CONFIG_PM_SLEEP=y
 CONFIG_SUSPEND_UP_POSSIBLE=y
 CONFIG_SUSPEND=y
 # CONFIG_APM_EMULATION is not set
+CONFIG_PM_RUNTIME=y
 
 #
 # Networking
diff --git a/arch/arm/configs/omap3_beagle_defconfig b/arch/arm/configs/omap3_beagle_defconfig
index c7999f5..5a9e95f 100644
--- a/arch/arm/configs/omap3_beagle_defconfig
+++ b/arch/arm/configs/omap3_beagle_defconfig
@@ -324,6 +324,7 @@ CONFIG_PM_SLEEP=y
 CONFIG_SUSPEND=y
 CONFIG_SUSPEND_FREEZER=y
 # CONFIG_APM_EMULATION is not set
+CONFIG_PM_RUNTIME=y
 CONFIG_ARCH_SUSPEND_POSSIBLE=y
 CONFIG_NET=y
 
diff --git a/arch/arm/configs/omap3_defconfig b/arch/arm/configs/omap3_defconfig
index 714835e..d6ad921 100644
--- a/arch/arm/configs/omap3_defconfig
+++ b/arch/arm/configs/omap3_defconfig
@@ -450,7 +450,7 @@ CONFIG_SUSPEND=y
 # CONFIG_PM_TEST_SUSPEND is not set
 CONFIG_SUSPEND_FREEZER=y
 # CONFIG_APM_EMULATION is not set
-# CONFIG_PM_RUNTIME is not set
+CONFIG_PM_RUNTIME=y
 CONFIG_ARCH_SUSPEND_POSSIBLE=y
 CONFIG_NET=y
 
diff --git a/arch/arm/configs/omap3_evm_defconfig b/arch/arm/configs/omap3_evm_defconfig
index e2ad859..a6dd6d1 100644
--- a/arch/arm/configs/omap3_evm_defconfig
+++ b/arch/arm/configs/omap3_evm_defconfig
@@ -340,6 +340,7 @@ CONFIG_PM_SLEEP=y
 CONFIG_SUSPEND=y
 CONFIG_SUSPEND_FREEZER=y
 # CONFIG_APM_EMULATION is not set
+CONFIG_PM_RUNTIME=y
 CONFIG_ARCH_SUSPEND_POSSIBLE=y
 CONFIG_NET=y
 
diff --git a/arch/arm/configs/omap3_touchbook_defconfig b/arch/arm/configs/omap3_touchbook_defconfig
index 74fe6be..968fbaa 100644
--- a/arch/arm/configs/omap3_touchbook_defconfig
+++ b/arch/arm/configs/omap3_touchbook_defconfig
@@ -368,7 +368,7 @@ CONFIG_SUSPEND=y
 # CONFIG_PM_TEST_SUSPEND is not set
 CONFIG_SUSPEND_FREEZER=y
 # CONFIG_APM_EMULATION is not set
-# CONFIG_PM_RUNTIME is not set
+CONFIG_PM_RUNTIME=y
 CONFIG_ARCH_SUSPEND_POSSIBLE=y
 CONFIG_NET=y
 
diff --git a/arch/arm/configs/omap_3430sdp_defconfig b/arch/arm/configs/omap_3430sdp_defconfig
index bb2917e..ddde429 100644
--- a/arch/arm/configs/omap_3430sdp_defconfig
+++ b/arch/arm/configs/omap_3430sdp_defconfig
@@ -363,6 +363,7 @@ CONFIG_PM_SLEEP=y
 CONFIG_SUSPEND=y
 CONFIG_SUSPEND_FREEZER=y
 # CONFIG_APM_EMULATION is not set
+CONFIG_PM_RUNTIME=y
 CONFIG_ARCH_SUSPEND_POSSIBLE=y
 CONFIG_NET=y
 
diff --git a/arch/arm/configs/omap_3630sdp_defconfig b/arch/arm/configs/omap_3630sdp_defconfig
index d25c3d4..609f348 100644
--- a/arch/arm/configs/omap_3630sdp_defconfig
+++ b/arch/arm/configs/omap_3630sdp_defconfig
@@ -361,7 +361,7 @@ CONFIG_SUSPEND=y
 # CONFIG_PM_TEST_SUSPEND is not set
 CONFIG_SUSPEND_FREEZER=y
 # CONFIG_APM_EMULATION is not set
-# CONFIG_PM_RUNTIME is not set
+CONFIG_PM_RUNTIME=y
 CONFIG_ARCH_SUSPEND_POSSIBLE=y
 CONFIG_NET=y
 
diff --git a/arch/arm/configs/omap_h2_1610_defconfig b/arch/arm/configs/omap_h2_1610_defconfig
index 5231895..91ef2ed 100644
--- a/arch/arm/configs/omap_h2_1610_defconfig
+++ b/arch/arm/configs/omap_h2_1610_defconfig
@@ -331,6 +331,7 @@ CONFIG_PM_SLEEP=y
 CONFIG_SUSPEND=y
 CONFIG_SUSPEND_FREEZER=y
 # CONFIG_APM_EMULATION is not set
+CONFIG_PM_RUNTIME=y
 CONFIG_ARCH_SUSPEND_POSSIBLE=y
 
 #
diff --git a/arch/arm/configs/omap_zoom2_defconfig b/arch/arm/configs/omap_zoom2_defconfig
index a82e813..f5c6e11 100644
--- a/arch/arm/configs/omap_zoom2_defconfig
+++ b/arch/arm/configs/omap_zoom2_defconfig
@@ -343,6 +343,7 @@ CONFIG_SUSPEND=y
 # CONFIG_PM_TEST_SUSPEND is not set
 CONFIG_SUSPEND_FREEZER=y
 # CONFIG_APM_EMULATION is not set
+CONFIG_PM_RUNTIME=y
 CONFIG_ARCH_SUSPEND_POSSIBLE=y
 CONFIG_NET=y
 
diff --git a/arch/arm/configs/omap_zoom3_defconfig b/arch/arm/configs/omap_zoom3_defconfig
index ff8ac3d..ea9a501 100644
--- a/arch/arm/configs/omap_zoom3_defconfig
+++ b/arch/arm/configs/omap_zoom3_defconfig
@@ -361,7 +361,7 @@ CONFIG_SUSPEND=y
 # CONFIG_PM_TEST_SUSPEND is not set
 CONFIG_SUSPEND_FREEZER=y
 # CONFIG_APM_EMULATION is not set
-# CONFIG_PM_RUNTIME is not set
+CONFIG_PM_RUNTIME=y
 CONFIG_ARCH_SUSPEND_POSSIBLE=y
 CONFIG_NET=y
 
diff --git a/arch/arm/configs/rx51_defconfig b/arch/arm/configs/rx51_defconfig
index 193bd33..45135ff 100644
--- a/arch/arm/configs/rx51_defconfig
+++ b/arch/arm/configs/rx51_defconfig
@@ -322,6 +322,7 @@ CONFIG_PM_SLEEP=y
 CONFIG_SUSPEND=y
 CONFIG_SUSPEND_FREEZER=y
 # CONFIG_APM_EMULATION is not set
+CONFIG_PM_RUNTIME=y
 CONFIG_ARCH_SUSPEND_POSSIBLE=y
 CONFIG_NET=y
 

