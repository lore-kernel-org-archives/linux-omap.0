From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 89/97] ARM: l2c: AM43x: add L2 cache support
Date: Mon, 28 Apr 2014 20:33:46 +0100
Message-ID: <E1WerJC-0001Zk-Oc@rmk-PC.arm.linux.org.uk>
References: <20140428192419.GV26756@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:55856 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932704AbaD1Tds (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Apr 2014 15:33:48 -0400
In-Reply-To: <20140428192419.GV26756@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.ifradead.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: Sekhar Nori <nsekhar@ti.com>
To: linux-arm-kernel@lists.ifradead.org

Add support for L2 cache controller (PL310) on AM437x SoC.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/Kconfig | 1 +
 arch/arm/mach-omap2/io.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index cb31d4390d52..0ba482638ebf 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -65,6 +65,7 @@ config SOC_AM43XX
 	select ARCH_HAS_OPP
 	select ARM_GIC
 	select MACH_OMAP_GENERIC
+	select MIGHT_HAVE_CACHE_L2X0
 
 config SOC_DRA7XX
 	bool "TI DRA7XX"
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index b28299b5afd5..4e2df49991ad 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -609,6 +609,7 @@ void __init am43xx_init_early(void)
 	am43xx_clockdomains_init();
 	am43xx_hwmod_init();
 	omap_hwmod_init_postsetup();
+	omap_l2_cache_init();
 	omap_clk_soc_init = am43xx_dt_clk_init;
 }
 
-- 
1.8.3.1

