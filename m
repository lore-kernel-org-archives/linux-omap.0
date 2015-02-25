From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 22/35] ARM: OMAP2+: control: remove API for getting control module base address
Date: Wed, 25 Feb 2015 21:04:32 +0200
Message-ID: <1424891085-10392-23-git-send-email-t-kristo@ti.com>
References: <1424891085-10392-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54378 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753123AbbBYTFY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Feb 2015 14:05:24 -0500
In-Reply-To: <1424891085-10392-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

This shall not be used anymore, as control module driver is converted
into using regmap.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/control.c |    5 -----
 arch/arm/mach-omap2/control.h |    2 --
 2 files changed, 7 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 2b54250..a9aee85 100644
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

