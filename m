From: jean.pihet@newoldbits.com
Subject: [PATCH 18/26] OMAP2+: Use the TRM formula to calculate the SmartReflex clock rate
Date: Tue, 22 Nov 2011 16:06:02 +0100
Message-ID: <1321974370-25800-19-git-send-email-j-pihet@ti.com>
References: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:43561 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757127Ab1KVPHX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Nov 2011 10:07:23 -0500
Received: by mail-ww0-f44.google.com with SMTP id 5so432213wwe.1
        for <linux-omap@vger.kernel.org>; Tue, 22 Nov 2011 07:07:23 -0800 (PST)
In-Reply-To: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, paul@pwsan.com, khilman@ti.com, balbi@ti.com, rjw@sisk.pl
Cc: Jean Pihet <j-pihet@ti.com>

From: Paul Walmsley <paul@pwsan.com>

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |   53 ++++++++++++++----------------------
 arch/arm/mach-omap2/smartreflex.h |    8 -----
 2 files changed, 21 insertions(+), 40 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 154a98b..882f1d5 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -33,6 +33,13 @@
 #define NVALUE_NAME_LEN		40
 #define SR_DISABLE_TIMEOUT	200
 
+/*
+ * SR_CLK is the internal SmartReflex sensor sampling clock.  The OMAP34xx
+ * TRM Rev ZH Section 4.10.5.4.3 "SmartReflex Submodules" states that this
+ * should be 100KHz.
+ */
+#define SR_CLK			100000 /* Hz */
+
 /* sr_list contains all the instances of smartreflex module */
 static LIST_HEAD(sr_list);
 
@@ -111,43 +118,25 @@ static irqreturn_t sr_interrupt(int irq, void *data)
 
 static void sr_set_clk_length(struct smartreflex *sr)
 {
-	struct clk *sys_ck;
-	u32 sys_clk_speed;
+	struct clk *fck;
+	int fck_rate;
 
-	if (cpu_is_omap34xx())
-		sys_ck = clk_get(NULL, "sys_ck");
-	else
-		sys_ck = clk_get(NULL, "sys_clkin_ck");
-
-	if (IS_ERR(sys_ck)) {
+	fck = clk_get(sr->pdev->dev, "fck");
+	if (IS_ERR(fck)) {
 		dev_err(&sr->pdev->dev, "%s: unable to get sys clk\n",
 			__func__);
 		return;
 	}
-	sys_clk_speed = clk_get_rate(sys_ck);
-	clk_put(sys_ck);
-
-	switch (sys_clk_speed) {
-	case 12000000:
-		sr->clk_length = SRCLKLENGTH_12MHZ_SYSCLK;
-		break;
-	case 13000000:
-		sr->clk_length = SRCLKLENGTH_13MHZ_SYSCLK;
-		break;
-	case 19200000:
-		sr->clk_length = SRCLKLENGTH_19MHZ_SYSCLK;
-		break;
-	case 26000000:
-		sr->clk_length = SRCLKLENGTH_26MHZ_SYSCLK;
-		break;
-	case 38400000:
-		sr->clk_length = SRCLKLENGTH_38MHZ_SYSCLK;
-		break;
-	default:
-		dev_err(&sr->pdev->dev, "%s: Invalid sysclk value: %d\n",
-			__func__, sys_clk_speed);
-		break;
-	}
+	fck_rate = clk_get_rate(fck);
+	clk_put(fck);
+
+	/*
+	 * This formula is from OMAP34xx TRM Rev ZH Section 4.10.5.4.3
+	 * "SmartReflex Submodules"
+	 */
+	sr->clk_length = fck_rate / (2 * SR_CLK);
+
+	dev_dbg(&sr->pdev->dev, "%s: SRCLKLENGTH = %03x\n", sr->clk_length);
 }
 
 static void sr_start_vddautocomp(struct smartreflex *sr)
diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
index e7ed7a1..59fff8a 100644
--- a/arch/arm/mach-omap2/smartreflex.h
+++ b/arch/arm/mach-omap2/smartreflex.h
@@ -119,14 +119,6 @@
 #define IRQENABLE_MCUBOUNDSINT		BIT(1)
 #define IRQENABLE_MCUDISABLEACKINT	BIT(0)
 
-/* Common Bit values */
-
-#define SRCLKLENGTH_12MHZ_SYSCLK	0x3c
-#define SRCLKLENGTH_13MHZ_SYSCLK	0x41
-#define SRCLKLENGTH_19MHZ_SYSCLK	0x60
-#define SRCLKLENGTH_26MHZ_SYSCLK	0x82
-#define SRCLKLENGTH_38MHZ_SYSCLK	0xC0
-
 /*
  * 3430 specific values. Maybe these should be passed from board file or
  * pmic structures.
-- 
1.7.5.4

