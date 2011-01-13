From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 1/4] arm: omap: clock: fix compile warning
Date: Thu, 13 Jan 2011 13:41:05 +0200
Message-ID: <1294918868-16263-2-git-send-email-balbi@ti.com>
References: <1294918868-16263-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:45736 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932891Ab1AMLlV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Jan 2011 06:41:21 -0500
Received: by gxk24 with SMTP id 24so802104gxk.4
        for <linux-omap@vger.kernel.org>; Thu, 13 Jan 2011 03:41:18 -0800 (PST)
In-Reply-To: <1294918868-16263-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

if building kernels without OMAP2 support, we
will see a warning such as:

arch/arm/mach-omap2/io.c: In function 'omap2_init_common_infrastructure':
arch/arm/mach-omap2/io.c:389:3: warning: statement with no effect
arch/arm/mach-omap2/io.c:391:3: warning: statement with no effect

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/clock2xxx.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clock2xxx.h b/arch/arm/mach-omap2/clock2xxx.h
index 6a658b89..9bafa27 100644
--- a/arch/arm/mach-omap2/clock2xxx.h
+++ b/arch/arm/mach-omap2/clock2xxx.h
@@ -23,13 +23,13 @@ void omap2xxx_clk_prepare_for_reboot(void);
 #ifdef CONFIG_ARCH_OMAP2420
 int omap2420_clk_init(void);
 #else
-#define omap2420_clk_init()	0
+#define omap2420_clk_init()	do { } while(0)
 #endif
 
 #ifdef CONFIG_ARCH_OMAP2430
 int omap2430_clk_init(void);
 #else
-#define omap2430_clk_init()	0
+#define omap2430_clk_init()	do { } while(0)
 #endif
 
 extern void __iomem *prcm_clksrc_ctrl, *cm_idlest_pll;
-- 
1.7.3.4.598.g85356

