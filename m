From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 03/10][RFC] OMAP4: PM: Add a dummy node to prevent crash at bootup
Date: Fri, 29 May 2009 14:12:13 +0530
Message-ID: <1243586540-12274-3-git-send-email-rnayak@ti.com>
References: <1243586540-12274-1-git-send-email-rnayak@ti.com>
 <1243586540-12274-2-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42743 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754383AbZE2ImZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 May 2009 04:42:25 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n4T8gLVh008059
	for <linux-omap@vger.kernel.org>; Fri, 29 May 2009 03:42:27 -0500
In-Reply-To: <1243586540-12274-2-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>

This patch adds a dummy gpmc clock node to prevent a
crash at bootup on OMAP4.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clock44xx.c |    1 +
 arch/arm/mach-omap2/clock44xx.h |    7 +++++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx.c b/arch/arm/mach-omap2/clock44xx.c
index f4e0113..ffb63b3 100644
--- a/arch/arm/mach-omap2/clock44xx.c
+++ b/arch/arm/mach-omap2/clock44xx.c
@@ -73,6 +73,7 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"gpt9_fck",	&gpt9_fck,	CK_443X),
 	CLK(NULL,	"gpt10_fck",	&gpt10_fck,	CK_443X),
 	CLK(NULL,	"gpt11_fck",	&gpt11_fck,	CK_443X),
+	CLK(NULL,       "gpmc_fck",    &gpmc_fck,     CK_443X),
 };
 
 static struct clk_functions omap2_clk_functions = {
diff --git a/arch/arm/mach-omap2/clock44xx.h b/arch/arm/mach-omap2/clock44xx.h
index 2ce7147..8a0cc62 100644
--- a/arch/arm/mach-omap2/clock44xx.h
+++ b/arch/arm/mach-omap2/clock44xx.h
@@ -291,4 +291,11 @@ static struct clk gpt11_fck = {
 	.clksel         = omap443x_gpt_clksel,
 	.recalc         = &omap2_clksel_recalc,
 };
+
+/* TODO:Dummy clock node still needed to boot on Omap4, remove later */
+static struct clk gpmc_fck = {
+	.name           = "gpmc_fck",
+	.ops            = &clkops_null,
+};
+
 #endif
-- 
1.5.4.7

