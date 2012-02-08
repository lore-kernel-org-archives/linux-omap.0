From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 12/16] ARM: omap: fix section mismatch warning for
 sdp3430_twl_gpio_setup()
Date: Wed, 08 Feb 2012 16:39:50 +0000
Message-ID: <E1RvAYg-0006Ha-Mf@rmk-PC.arm.linux.org.uk>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:35005 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755591Ab2BHQj4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 11:39:56 -0500
In-Reply-To: <20120208163546.GA15849@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org

WARNING: arch/arm/mach-omap2/built-in.o(.text+0xd0f0): Section mismatch in reference from the function sdp3430_twl_gpio_setup() to the function .init.text:omap2_hsmmc_init()
The function sdp3430_twl_gpio_setup() references
the function __init omap2_hsmmc_init().
This is often because sdp3430_twl_gpio_setup lacks a __init
annotation or the annotation of omap2_hsmmc_init is wrong.

sdp3430_twl_gpio_setup() is called via platform data from the
gpio-twl4030 module, which can be inserted and removed at runtime.
This makes sdp3430_twl_gpio_setup() callable at runtime, and prevents
it being marked with an __init annotation.

As it calls omap2_hsmmc_init() unconditionally, the only resolution to
this warning is to remove the __init markings from omap2_hsmmc_init()
and its called functions.  This addresses the functions in hsmmc.c.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/hsmmc.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index ad0adb5..b40c288 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -293,8 +293,8 @@ static inline void omap_hsmmc_mux(struct omap_mmc_platform_data *mmc_controller,
 	}
 }
 
-static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
-					struct omap_mmc_platform_data *mmc)
+static int omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
+				 struct omap_mmc_platform_data *mmc)
 {
 	char *hc_name;
 
@@ -430,7 +430,7 @@ static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
 
 #define MAX_OMAP_MMC_HWMOD_NAME_LEN		16
 
-void __init omap_init_hsmmc(struct omap2_hsmmc_info *hsmmcinfo, int ctrl_nr)
+void omap_init_hsmmc(struct omap2_hsmmc_info *hsmmcinfo, int ctrl_nr)
 {
 	struct omap_hwmod *oh;
 	struct platform_device *pdev;
@@ -487,7 +487,7 @@ void __init omap_init_hsmmc(struct omap2_hsmmc_info *hsmmcinfo, int ctrl_nr)
 	kfree(mmc_data);
 }
 
-void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
+void omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
 {
 	u32 reg;
 
-- 
1.7.4.4

