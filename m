From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/6] omap2/3/4: Move Kconfig options to mach-omap2/Kconfig
Date: Tue, 29 Jun 2010 14:47:32 +0300
Message-ID: <20100629114732.16008.56598.stgit@baageli.muru.com>
References: <20100629113229.16008.2931.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63967 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755813Ab0F2LrU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jun 2010 07:47:20 -0400
In-Reply-To: <20100629113229.16008.2931.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Move omap2/3/4 specific Kconfig options to mach-omap2/Kconfig

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Kconfig |   18 ++++++++++++++++++
 arch/arm/plat-omap/Kconfig  |   18 ------------------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index e94ee6b..d306aa1 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -2,6 +2,24 @@ if ARCH_OMAP2PLUS
 
 menu "TI OMAP2/3/4 Specific Features"
 
+config ARCH_OMAP2
+	bool "TI OMAP2"
+	depends on ARCH_OMAP2PLUS
+	select CPU_V6
+
+config ARCH_OMAP3
+	bool "TI OMAP3"
+	depends on ARCH_OMAP2PLUS
+	select CPU_V7
+	select USB_ARCH_HAS_EHCI
+	select ARM_L1_CACHE_SHIFT_6
+
+config ARCH_OMAP4
+	bool "TI OMAP4"
+	depends on ARCH_OMAP2PLUS
+	select CPU_V7
+	select ARM_GIC
+
 comment "OMAP Core Type"
 	depends on ARCH_OMAP2
 
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index a4e8727..b7a3d80 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -21,24 +21,6 @@ config ARCH_OMAP2PLUS
 	help
 	  "Systems based on omap24xx, omap34xx or omap44xx"
 
-config ARCH_OMAP2
-	bool "TI OMAP2"
-	depends on ARCH_OMAP2PLUS
-	select CPU_V6
-
-config ARCH_OMAP3
-	bool "TI OMAP3"
-	depends on ARCH_OMAP2PLUS
-	select CPU_V7
-	select USB_ARCH_HAS_EHCI
-	select ARM_L1_CACHE_SHIFT_6
-
-config ARCH_OMAP4
-	bool "TI OMAP4"
-	depends on ARCH_OMAP2PLUS
-	select CPU_V7
-	select ARM_GIC
-
 endchoice
 
 comment "OMAP Feature Selections"

