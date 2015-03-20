From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv5 22/35] ARM: OMAP2+: control: remove API for getting control module base address
Date: Fri, 20 Mar 2015 20:44:33 +0200
Message-ID: <1426877086-17131-23-git-send-email-t-kristo@ti.com>
References: <1426877086-17131-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57042 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751781AbbCTSqZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Mar 2015 14:46:25 -0400
In-Reply-To: <1426877086-17131-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, sakari.ailus@iki.fi
Cc: linux-arm-kernel@lists.infradead.org

This shall not be used anymore, as control module driver is converted
into using regmap.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/control.c |    5 -----
 arch/arm/mach-omap2/control.h |    2 --
 2 files changed, 7 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 4b40946..202fc72 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -145,11 +145,6 @@ void __init omap2_set_globals_control(void __iomem *ctrl,
 	omap4_ctrl_pad_base = ctrl_pad;
 }
 
-void __iomem *omap_ctrl_base_get(void)
-{
-	return omap2_ctrl_base;
-}
-
 u8 omap_ctrl_readb(u16 offset)
 {
 	return readb_relaxed(OMAP_CTRL_REGADDR(offset));
diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
index c1057eb..5353ff4 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -440,7 +440,6 @@
 
 #ifndef __ASSEMBLY__
 #ifdef CONFIG_ARCH_OMAP2PLUS
-extern void __iomem *omap_ctrl_base_get(void);
 extern u8 omap_ctrl_readb(u16 offset);
 extern u16 omap_ctrl_readw(u16 offset);
 extern u32 omap_ctrl_readl(u16 offset);
@@ -470,7 +469,6 @@ extern void omap2_set_globals_control(void __iomem *ctrl,
 				      void __iomem *ctrl_pad);
 void __init omap3_control_legacy_iomap_init(void);
 #else
-#define omap_ctrl_base_get()		0
 #define omap_ctrl_readb(x)		0
 #define omap_ctrl_readw(x)		0
 #define omap_ctrl_readl(x)		0
-- 
1.7.9.5

