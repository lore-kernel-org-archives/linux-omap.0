From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 3/3] ARM: OMAP: clock: convert AM3517/3505 detection/flags to AM35xx
Date: Mon, 30 Apr 2012 16:30:04 -0700
Message-ID: <1335828604-18795-4-git-send-email-khilman@ti.com>
References: <1335828604-18795-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog128.obsmtp.com ([74.125.149.141]:35482 "EHLO
	na3sys009aog128.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757423Ab2D3X3L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Apr 2012 19:29:11 -0400
Received: by pbbrp2 with SMTP id rp2so1678888pbb.0
        for <linux-omap@vger.kernel.org>; Mon, 30 Apr 2012 16:29:10 -0700 (PDT)
In-Reply-To: <1335828604-18795-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

From: Paul Walmsley <paul@pwsan.com>

To improve the clarity of the code, replace the CK_3517 flag used in
the clock data with CK_AM35XX.  The CK_3505 flag can also be
removed, since it is now unused.

Acked-by: Vaibhav Hiremath <hvaibhav@ti.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock3xxx_data.c          |    6 +++---
 arch/arm/plat-omap/include/plat/clkdev_omap.h |    4 +---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 5e64b33..9f48f84 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3294,8 +3294,8 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"gfx_l3_ick",	&gfx_l3_ick,	CK_3430ES1),
 	CLK(NULL,	"gfx_cg1_ck",	&gfx_cg1_ck,	CK_3430ES1),
 	CLK(NULL,	"gfx_cg2_ck",	&gfx_cg2_ck,	CK_3430ES1),
-	CLK(NULL,	"sgx_fck",	&sgx_fck,	CK_3430ES2PLUS | CK_3517 | CK_36XX),
-	CLK(NULL,	"sgx_ick",	&sgx_ick,	CK_3430ES2PLUS | CK_3517 | CK_36XX),
+	CLK(NULL,	"sgx_fck",	&sgx_fck,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
+	CLK(NULL,	"sgx_ick",	&sgx_ick,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
 	CLK(NULL,	"d2d_26m_fck",	&d2d_26m_fck,	CK_3430ES1),
 	CLK(NULL,	"modem_fck",	&modem_fck,	CK_34XX | CK_36XX),
 	CLK(NULL,	"sad2d_ick",	&sad2d_ick,	CK_34XX | CK_36XX),
@@ -3515,7 +3515,7 @@ int __init omap3xxx_clk_init(void)
 
 	if (cpu_is_omap3517()) {
 		cpu_mask = RATE_IN_34XX;
-		cpu_clkflg = CK_3517;
+		cpu_clkflg = CK_AM35XX;
 	} else if (cpu_is_omap3630()) {
 		cpu_mask = (RATE_IN_34XX | RATE_IN_36XX);
 		cpu_clkflg = CK_36XX;
diff --git a/arch/arm/plat-omap/include/plat/clkdev_omap.h b/arch/arm/plat-omap/include/plat/clkdev_omap.h
index b299b8d..d0ed8c4 100644
--- a/arch/arm/plat-omap/include/plat/clkdev_omap.h
+++ b/arch/arm/plat-omap/include/plat/clkdev_omap.h
@@ -34,8 +34,7 @@ struct omap_clk {
 #define CK_243X		(1 << 5)	/* 243x, 253x */
 #define CK_3430ES1	(1 << 6)	/* 34xxES1 only */
 #define CK_3430ES2PLUS	(1 << 7)	/* 34xxES2, ES3, non-Sitara 35xx only */
-#define CK_3505		(1 << 8)
-#define CK_3517		(1 << 9)
+#define CK_AM35XX	(1 << 9)	/* Sitara AM35xx */
 #define CK_36XX		(1 << 10)	/* 36xx/37xx-specific clocks */
 #define CK_443X		(1 << 11)
 #define CK_TI816X	(1 << 12)
@@ -44,7 +43,6 @@ struct omap_clk {
 
 
 #define CK_34XX		(CK_3430ES1 | CK_3430ES2PLUS)
-#define CK_AM35XX	(CK_3505 | CK_3517)	/* all Sitara AM35xx */
 #define CK_3XXX		(CK_34XX | CK_AM35XX | CK_36XX)
 
 
-- 
1.7.9.2

