From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 7/8] ARM: OMAP5: Make errata i688 workaround available
Date: Wed, 20 Feb 2013 20:57:13 +0530
Message-ID: <1361374034-21831-8-git-send-email-santosh.shilimkar@ti.com>
References: <1361374034-21831-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47384 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935413Ab3BTP0D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Feb 2013 10:26:03 -0500
In-Reply-To: <1361374034-21831-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

Errata i688 is also applicable for OMAP5 based devices. Update the
code so that it can be enabled on OMAP5 devices.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/Kconfig |    2 +-
 arch/arm/mach-omap2/io.c    |    9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 41b581f..63a12d4 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -397,7 +397,7 @@ config OMAP3_SDRC_AC_TIMING
 
 config OMAP4_ERRATA_I688
 	bool "OMAP4 errata: Async Bridge Corruption"
-	depends on ARCH_OMAP4
+	depends on ARCH_OMAP4 || SOC_OMAP5
 	select ARCH_HAS_BARRIERS
 	help
 	  If a data is stalled inside asynchronous bridge because of back
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 2c3fdd6..2bef5a7 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -271,6 +271,14 @@ static struct map_desc omap54xx_io_desc[] __initdata = {
 		.length		= L4_PER_54XX_SIZE,
 		.type		= MT_DEVICE,
 	},
+#ifdef CONFIG_OMAP4_ERRATA_I688
+	{
+		.virtual	= OMAP4_SRAM_VA,
+		.pfn		= __phys_to_pfn(OMAP4_SRAM_PA),
+		.length		= PAGE_SIZE,
+		.type		= MT_MEMORY_SO,
+	},
+#endif
 };
 #endif
 
@@ -323,6 +331,7 @@ void __init omap4_map_io(void)
 void __init omap5_map_io(void)
 {
 	iotable_init(omap54xx_io_desc, ARRAY_SIZE(omap54xx_io_desc));
+	omap_barriers_init();
 }
 #endif
 /*
-- 
1.7.9.5

