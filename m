From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 12/12] OMAP1: clock_data: use runtime cpu / machine checks
Date: Mon, 13 Dec 2010 23:34:55 -0700
Message-ID: <20101214063454.21555.37831.stgit@twilight.localdomain>
References: <20101214063308.21555.76050.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50300 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753912Ab0LNGf2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Dec 2010 01:35:28 -0500
In-Reply-To: <20101214063308.21555.76050.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

Otherwise multi-omap1 configurations may set wrong clock speed.

Created and tested against l-o master on Amstrad Delta.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap1/clock_data.c |   17 ++++++++---------
 1 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap1/clock_data.c b/arch/arm/mach-omap1/clock_data.c
index 423d21d..c7c2a52 100644
--- a/arch/arm/mach-omap1/clock_data.c
+++ b/arch/arm/mach-omap1/clock_data.c
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


