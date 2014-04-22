From: Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH v3 3/3] ARM: OMAP2+: AM43x: L2 cache support
Date: Tue, 22 Apr 2014 13:58:03 +0530
Message-ID: <ea93988d503397a8540989955e32baef7d710e6f.1398149526.git.nsekhar@ti.com>
References: <cover.1398149526.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40322 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754345AbaDVI2k (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Apr 2014 04:28:40 -0400
In-Reply-To: <cover.1398149526.git.nsekhar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>, Sekhar Nori <nsekhar@ti.com>

Add support for L2 cache controller (PL310) on
AM437x SoC.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-omap2/Kconfig |    1 +
 arch/arm/mach-omap2/io.c    |    1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 1124155..1fd34d2 100644
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
index b28299b..4e2df49 100644
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
1.7.10.1

