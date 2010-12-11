From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH] OMAP1: clock_data: use runtime cpu / machine checks
Date: Sat, 11 Dec 2010 21:50:31 +0100
Message-ID: <201012112150.33831.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:58015 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751537Ab0LKUvL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 11 Dec 2010 15:51:11 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Cory Maccarrone <darkstar6262@gmail.com>

Otherwise multi-omap1 configurations may set wrong clock speed.

Created and tested against l-o master on Amstrad Delta.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---
Tested with omap1_defconfig after dropping 
CONFIG_OMAP_CLOCKS_SET_BY_BOOTLOADER=y and those of 12MHz xtal based clock 
speeds which are too high for my board.

 arch/arm/mach-omap1/clock_data.c |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

--- git/arch/arm/mach-omap1/clock_data.c.orig	2010-12-09 23:07:35.000000000 +0100
+++ git/arch/arm/mach-omap1/clock_data.c	2010-12-11 21:05:52.000000000 +0100
@@ -823,12 +823,10 @@ int __init omap1_clk_init(void)
 			crystal_type = info->system_clock_type;
 	}
 
-#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
-	ck_ref.rate = 13000000;
-#elif defined(CONFIG_ARCH_OMAP16XX)
-	if (crystal_type == 2)
+	if (cpu_is_omap7xx())
+		ck_ref.rate = 13000000;
+	if (cpu_is_omap16xx() && crystal_type == 2)
 		ck_ref.rate = 19200000;
-#endif
 
 	pr_info("Clocks: ARM_SYSST: 0x%04x DPLL_CTL: 0x%04x ARM_CKCTL: "
 		"0x%04x\n", omap_readw(ARM_SYSST), omap_readw(DPLL_CTL),
@@ -883,10 +881,11 @@ int __init omap1_clk_init(void)
 	       ck_dpll1.rate / 1000000, (ck_dpll1.rate / 100000) % 10,
 	       arm_ck.rate / 1000000, (arm_ck.rate / 100000) % 10);
 
-#if defined(CONFIG_MACH_OMAP_PERSEUS2) || defined(CONFIG_MACH_OMAP_FSAMPLE)
-	/* Select slicer output as OMAP input clock */
-	omap_writew(omap_readw(OMAP7XX_PCC_UPLD_CTRL) & ~0x1, OMAP7XX_PCC_UPLD_CTRL);
-#endif
+	if (machine_is_omap_perseus2() || machine_is_omap_fsample()) {
+		/* Select slicer output as OMAP input clock */
+		omap_writew(omap_readw(OMAP7XX_PCC_UPLD_CTRL) & ~0x1,
+				OMAP7XX_PCC_UPLD_CTRL);
+	}
 
 	/* Amstrad Delta wants BCLK high when inactive */
 	if (machine_is_ams_delta())
