From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH] arm: omap1/2/3/4: change sync_32k_ick to ick
Date: Tue, 23 Mar 2010 15:42:00 +0200
Message-ID: <1269351720-7032-1-git-send-email-felipe.balbi@nokia.com>
References: <1269350966-9311-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:60605 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753095Ab0CWNm1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Mar 2010 09:42:27 -0400
In-Reply-To: <1269350966-9311-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>

Use clkdev and forget about clock names.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---

and now make all the clocks with same name

 arch/arm/mach-omap2/clock2420_data.c |    2 +-
 arch/arm/mach-omap2/clock2430_data.c |    2 +-
 arch/arm/mach-omap2/clock3xxx_data.c |    2 +-
 arch/arm/plat-omap/clocksource.c     |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-omap2/clock2420_data.c
index d932b14..0115853 100644
--- a/arch/arm/mach-omap2/clock2420_data.c
+++ b/arch/arm/mach-omap2/clock2420_data.c
@@ -1806,7 +1806,7 @@ static struct omap_clk omap2420_clks[] = {
 	CLK(NULL,	"gpios_fck",	&gpios_fck,	CK_242X),
 	CLK("omap_wdt",	"ick",		&mpu_wdt_ick,	CK_242X),
 	CLK("omap_wdt",	"fck",		&mpu_wdt_fck,	CK_242X),
-	CLK(NULL,	"sync_32k_ick",	&sync_32k_ick,	CK_242X),
+	CLK("omap-clksrc",	"ick",	&sync_32k_ick,	CK_242X),
 	CLK(NULL,	"wdt1_ick",	&wdt1_ick,	CK_242X),
 	CLK(NULL,	"omapctrl_ick",	&omapctrl_ick,	CK_242X),
 	CLK("omap24xxcam", "fck",	&cam_fck,	CK_242X),
diff --git a/arch/arm/mach-omap2/clock2430_data.c b/arch/arm/mach-omap2/clock2430_data.c
index 0438b6e..d2e1041 100644
--- a/arch/arm/mach-omap2/clock2430_data.c
+++ b/arch/arm/mach-omap2/clock2430_data.c
@@ -1900,7 +1900,7 @@ static struct omap_clk omap2430_clks[] = {
 	CLK(NULL,	"gpios_fck",	&gpios_fck,	CK_243X),
 	CLK("omap_wdt",	"ick",		&mpu_wdt_ick,	CK_243X),
 	CLK("omap_wdt",	"fck",		&mpu_wdt_fck,	CK_243X),
-	CLK(NULL,	"sync_32k_ick",	&sync_32k_ick,	CK_243X),
+	CLK("omap-clksrc",	"ick",	&sync_32k_ick,	CK_243X),
 	CLK(NULL,	"wdt1_ick",	&wdt1_ick,	CK_243X),
 	CLK(NULL,	"omapctrl_ick",	&omapctrl_ick,	CK_243X),
 	CLK(NULL,	"icr_ick",	&icr_ick,	CK_243X),
diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index d5153b6..6bf0f96 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3414,7 +3414,7 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK("omap_wdt",	"ick",		&wdt2_ick,	CK_3XXX),
 	CLK(NULL,	"wdt1_ick",	&wdt1_ick,	CK_3XXX),
 	CLK(NULL,	"gpio1_ick",	&gpio1_ick,	CK_3XXX),
-	CLK(NULL,	"omap_32ksync_ick", &omap_32ksync_ick, CK_3XXX),
+	CLK("omap-clksrc",	"ick", &omap_32ksync_ick, CK_3XXX),
 	CLK(NULL,	"gpt12_ick",	&gpt12_ick,	CK_3XXX),
 	CLK(NULL,	"gpt1_ick",	&gpt1_ick,	CK_3XXX),
 	CLK(NULL,	"per_96m_fck",	&per_96m_fck,	CK_3XXX),
diff --git a/arch/arm/plat-omap/clocksource.c b/arch/arm/plat-omap/clocksource.c
index 9a43b0c..13ae8da 100644
--- a/arch/arm/plat-omap/clocksource.c
+++ b/arch/arm/plat-omap/clocksource.c
@@ -139,7 +139,7 @@ static int __init omap_clksrc_probe(struct platform_device *pdev)
 		goto err2;
 	}
 
-	ick = clk_get(&pdev->dev, "sync_32k_ick");
+	ick = clk_get(&pdev->dev, "ick");
 	if (IS_ERR(ick)) {
 		dev_dbg(&pdev->dev, "couldn't get clock\n");
 		ret = PTR_ERR(ick);
-- 
1.7.0.rc0.33.g7c3932

