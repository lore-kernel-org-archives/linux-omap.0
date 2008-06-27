From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH v3] ARM: OMAP3: Fix warnings in clock34xx.h
Date: Fri, 27 Jun 2008 18:55:33 +0200
Message-ID: <48651B85.9030904@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000808020006070703060105"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.31]:3216 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882AbYF0Qzl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Jun 2008 12:55:41 -0400
Received: by yw-out-2324.google.com with SMTP id 9so220767ywe.1
        for <linux-omap@vger.kernel.org>; Fri, 27 Jun 2008 09:55:35 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This is a multi-part message in MIME format.
--------------000808020006070703060105
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Fix warnings

arch/arm/mach-omap2/clock34xx.h:178: warning: initialization makes 
pointer from integer without a cast
arch/arm/mach-omap2/clock34xx.h:204: warning: initialization makes 
pointer from integer without a cast
arch/arm/mach-omap2/clock34xx.h:229: warning: initialization makes 
pointer from integer without a cast

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>


--------------000808020006070703060105
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


Signed-off-by: Dirk Behme <dirk.behme@gmail.com>

---

Changes in V3: Update to recent git.

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
 

--------------000808020006070703060105--
