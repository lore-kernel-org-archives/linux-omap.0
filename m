From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH v2] ARM: OMAP3: Fix warnings in clock34xx.h
Date: Mon, 23 Jun 2008 18:08:24 +0200
Message-ID: <485FCA78.9000209@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010205050801010502050004"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hs-out-0708.google.com ([64.233.178.244]:59554 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754341AbYFWQIV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Jun 2008 12:08:21 -0400
Received: by hs-out-0708.google.com with SMTP id 4so321699hsl.5
        for <linux-omap@vger.kernel.org>; Mon, 23 Jun 2008 09:08:20 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This is a multi-part message in MIME format.
--------------010205050801010502050004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Fix warnings

arch/arm/mach-omap2/clock34xx.h:178: warning: initialization makes 
pointer from integer without a cast
arch/arm/mach-omap2/clock34xx.h:204: warning: initialization makes 
pointer from integer without a cast
arch/arm/mach-omap2/clock34xx.h:229: warning: initialization makes 
pointer from integer without a cast
arch/arm/mach-omap2/clock34xx.h:2238: warning: initialization makes 
pointer from integer without a cast

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>


--------------010205050801010502050004
Content-Type: text/plain;
 name="clock34xx_h_warning_fix.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="clock34xx_h_warning_fix.txt"


Subject: ARM: OMAP3: Fix warnings in clock34xx.h 

From: Dirk Behme <dirk.behme@gmail.com>

Fix warnings

arch/arm/mach-omap2/clock34xx.h:178: warning: initialization makes pointer from integer without a cast
arch/arm/mach-omap2/clock34xx.h:204: warning: initialization makes pointer from integer without a cast
arch/arm/mach-omap2/clock34xx.h:229: warning: initialization makes pointer from integer without a cast
arch/arm/mach-omap2/clock34xx.h:2238: warning: initialization makes pointer from integer without a cast

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>

---

Changes in V2: Incorporating comments from Paul Walmsley. Thanks!

Index: linux-beagle/arch/arm/mach-omap2/clock34xx.h
===================================================================
--- linux-beagle.orig/arch/arm/mach-omap2/clock34xx.h
+++ linux-beagle/arch/arm/mach-omap2/clock34xx.h
@@ -53,14 +53,17 @@ static int omap3_noncore_dpll_set_rate(s
 #define DPLL_LOW_POWER_BYPASS		0x5
 #define DPLL_LOCKED			0x7
 
+#define _OMAP34XX_PRM_REGADDR(module, reg)				\
+	((__force void __iomem *)(OMAP34XX_PRM_REGADDR((module), (reg))))
+
 #define OMAP3430_PRM_CLKSRC_CTRL					\
-	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0070)
+	_OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, OMAP3_PRM_CLKSRC_CTRL_OFFSET)
 
 #define OMAP3430_PRM_CLKSEL						\
-	OMAP34XX_PRM_REGADDR(OMAP3430_CCR_MOD, OMAP3_PRM_CLKSEL_OFFSET)
+	_OMAP34XX_PRM_REGADDR(OMAP3430_CCR_MOD, OMAP3_PRM_CLKSEL_OFFSET)
 
 #define OMAP3430_PRM_CLKOUT_CTRL					\
-	OMAP34XX_PRM_REGADDR(OMAP3430_CCR_MOD, OMAP3_PRM_CLKOUT_CTRL_OFFSET)
+	_OMAP34XX_PRM_REGADDR(OMAP3430_CCR_MOD, OMAP3_PRM_CLKOUT_CTRL_OFFSET)
 
 /* PRM CLOCKS */
 
@@ -2235,7 +2238,7 @@ static struct clk usbhost_sar_fck = {
 	.name		= "usbhost_sar_fck",
 	.parent		= &osc_sys_ck,
 	.init		= &omap2_init_clk_clkdm,
-	.enable_reg	= OMAP34XX_PRM_REGADDR(OMAP3430ES2_USBHOST_MOD, PM_PWSTCTRL),
+	.enable_reg	= _OMAP34XX_PRM_REGADDR(OMAP3430ES2_USBHOST_MOD, PM_PWSTCTRL),
 	.enable_bit	= OMAP3430ES2_SAVEANDRESTORE_SHIFT,
 	.flags		= CLOCK_IN_OMAP3430ES2,
 	.clkdm_name	= "usbhost_clkdm",

--------------010205050801010502050004--
