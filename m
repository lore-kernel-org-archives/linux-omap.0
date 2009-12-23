From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: [PATCH] [OMAP1] Clock fixups for OMAP1 and OMAP7xx
Date: Tue, 22 Dec 2009 17:37:21 -0700
Message-ID: <1261528641-22465-1-git-send-email-darkstar6262@gmail.com>
References: <6cb013310912221628m1b2b820fy1a96a9a9102274e5@mail.gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:46743 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751348AbZLWAhj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Dec 2009 19:37:39 -0500
Received: by yxe17 with SMTP id 17so6373920yxe.33
        for <linux-omap@vger.kernel.org>; Tue, 22 Dec 2009 16:37:39 -0800 (PST)
In-Reply-To: <6cb013310912221628m1b2b820fy1a96a9a9102274e5@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Cory Maccarrone <darkstar6262@gmail.com>

This change adds in some missing clocks that were needed as a result
of 526505... (OMAP1 clock: convert mach-omap1/clock.h to
mach-omap1/clock_data.c).  Prior to this, it was just assumed that
these clocks existed for all devices, and it was used directly instead
of calling it out with a clk_get call.  So, not having the CK_7XX
meant these clocks weren't being used anymore for omap 7xx devices,
which broke things badly.

Additionally, that change added an __initdata decoration to the
structure containing the clk_enable and clk_disable functions.  Once
init data was freed, these pointers went to null, and the next enable
or disable call caused the kernel to crash.  This change removes
this decoration.

Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
---
 arch/arm/mach-omap1/clock_data.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap1/clock_data.c b/arch/arm/mach-omap1/clock_data.c
index ab995a9..62f6ec3 100644
--- a/arch/arm/mach-omap1/clock_data.c
+++ b/arch/arm/mach-omap1/clock_data.c
@@ -599,15 +599,15 @@ static struct clk i2c_ick = {
 static struct omap_clk omap_clks[] = {
 	/* non-ULPD clocks */
 	CLK(NULL,	"ck_ref",	&ck_ref,	CK_16XX | CK_1510 | CK_310 | CK_7XX),
-	CLK(NULL,	"ck_dpll1",	&ck_dpll1,	CK_16XX | CK_1510 | CK_310),
+	CLK(NULL,	"ck_dpll1",	&ck_dpll1,	CK_16XX | CK_1510 | CK_310 | CK_7XX),
 	/* CK_GEN1 clocks */
 	CLK(NULL,	"ck_dpll1out",	&ck_dpll1out.clk, CK_16XX),
 	CLK(NULL,	"ck_sossi",	&sossi_ck,	CK_16XX),
 	CLK(NULL,	"arm_ck",	&arm_ck,	CK_16XX | CK_1510 | CK_310),
-	CLK(NULL,	"armper_ck",	&armper_ck.clk,	CK_16XX | CK_1510 | CK_310),
+	CLK(NULL,	"armper_ck",	&armper_ck.clk,	CK_16XX | CK_1510 | CK_310 | CK_7XX),
 	CLK(NULL,	"arm_gpio_ck",	&arm_gpio_ck,	CK_1510 | CK_310),
 	CLK(NULL,	"armxor_ck",	&armxor_ck.clk,	CK_16XX | CK_1510 | CK_310 | CK_7XX),
-	CLK(NULL,	"armtim_ck",	&armtim_ck.clk,	CK_16XX | CK_1510 | CK_310),
+	CLK(NULL,	"armtim_ck",	&armtim_ck.clk,	CK_16XX | CK_1510 | CK_310 | CK_7XX),
 	CLK("omap_wdt",	"fck",		&armwdt_ck.clk,	CK_16XX | CK_1510 | CK_310),
 	CLK("omap_wdt",	"ick",		&armper_ck.clk,	CK_16XX),
 	CLK("omap_wdt", "ick",		&dummy_ck,	CK_1510 | CK_310),
@@ -627,7 +627,7 @@ static struct omap_clk omap_clks[] = {
 	CLK(NULL,	"tc2_ck",	&tc2_ck,	CK_16XX),
 	CLK(NULL,	"dma_ck",	&dma_ck,	CK_16XX | CK_1510 | CK_310),
 	CLK(NULL,	"dma_lcdfree_ck", &dma_lcdfree_ck, CK_16XX),
-	CLK(NULL,	"api_ck",	&api_ck.clk,	CK_16XX | CK_1510 | CK_310),
+	CLK(NULL,	"api_ck",	&api_ck.clk,	CK_16XX | CK_1510 | CK_310 | CK_7XX),
 	CLK(NULL,	"lb_ck",	&lb_ck.clk,	CK_1510 | CK_310),
 	CLK(NULL,	"rhea1_ck",	&rhea1_ck,	CK_16XX),
 	CLK(NULL,	"rhea2_ck",	&rhea2_ck,	CK_16XX),
@@ -674,7 +674,7 @@ static struct omap_clk omap_clks[] = {
  * init
  */
 
-static struct clk_functions omap1_clk_functions __initdata = {
+static struct clk_functions omap1_clk_functions = {
 	.clk_enable		= omap1_clk_enable,
 	.clk_disable		= omap1_clk_disable,
 	.clk_round_rate		= omap1_clk_round_rate,
-- 
1.6.3.3

