From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 1/3] ARM: OMAP2+: kconfig: Enable devicetree by default for OMAP2+ systems
Date: Tue, 6 Dec 2011 17:49:07 +0100
Message-ID: <1323190149-6492-2-git-send-email-b-cousson@ti.com>
References: <y>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58611 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750846Ab1LFQtq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Dec 2011 11:49:46 -0500
In-Reply-To: <y>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

devicetree will become the mandatory boot method for OMAP2+.
In order to avoid cluttering the OMAP code with #ifdef CONFIG_OF,
select USE_OF by default for every OMAP2+ systems.
Select as well the APPENDED_DTB and ATAG_DTB_COMPAT to allow legacy
boot loader to keep working properly.

Enable PROC_DEVICETREE as well.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Kconfig |    1 -
 arch/arm/plat-omap/Kconfig  |    4 ++++
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index e1293aa..056a812 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -109,7 +109,6 @@ comment "OMAP Board Type"
 config MACH_OMAP_GENERIC
 	bool "Generic OMAP2+ board"
 	depends on ARCH_OMAP2PLUS
-	select USE_OF
 	default y
 	help
 	  Support for generic TI OMAP2+ boards using Flattened Device Tree.
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index aa59f42..74f41dc 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -24,6 +24,10 @@ config ARCH_OMAP2PLUS
 	select CLKDEV_LOOKUP
 	select GENERIC_IRQ_CHIP
 	select OMAP_DM_TIMER
+	select USE_OF
+	select ARM_APPENDED_DTB
+	select ARM_ATAG_DTB_COMPAT
+	select PROC_DEVICETREE
 	help
 	  "Systems based on OMAP2, OMAP3 or OMAP4"
 
-- 
1.7.0.4

