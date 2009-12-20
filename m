From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: [PATCH fixes] [OMAP1] Add missing clocks for OMAP 7xx
Date: Sun, 20 Dec 2009 09:35:04 -0700
Message-ID: <1261326904-31656-1-git-send-email-darkstar6262@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:44670 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753137AbZLTQfP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 20 Dec 2009 11:35:15 -0500
Received: by yxe17 with SMTP id 17so4245142yxe.33
        for <linux-omap@vger.kernel.org>; Sun, 20 Dec 2009 08:35:13 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Cory Maccarrone <darkstar6262@gmail.com>

This change adds in some missing clocks that were needed as a result
of 526505... (OMAP1 clock: convert mach-omap1/clock.h to
mach-omap1/clock_data.c).

Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
---
 arch/arm/mach-omap1/clock_data.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap1/clock_data.c b/arch/arm/mach-omap1/clock_data.c
index ab995a9..31fba07 100644
--- a/arch/arm/mach-omap1/clock_data.c
+++ b/arch/arm/mach-omap1/clock_data.c
@@ -599,7 +599,7 @@ static struct clk i2c_ick = {
 static struct omap_clk omap_clks[] = {
 	/* non-ULPD clocks */
 	CLK(NULL,	"ck_ref",	&ck_ref,	CK_16XX | CK_1510 | CK_310 | CK_7XX),
-	CLK(NULL,	"ck_dpll1",	&ck_dpll1,	CK_16XX | CK_1510 | CK_310),
+	CLK(NULL,	"ck_dpll1",	&ck_dpll1,	CK_16XX | CK_1510 | CK_310 | CK_7XX),
 	/* CK_GEN1 clocks */
 	CLK(NULL,	"ck_dpll1out",	&ck_dpll1out.clk, CK_16XX),
 	CLK(NULL,	"ck_sossi",	&sossi_ck,	CK_16XX),
@@ -627,7 +627,7 @@ static struct omap_clk omap_clks[] = {
 	CLK(NULL,	"tc2_ck",	&tc2_ck,	CK_16XX),
 	CLK(NULL,	"dma_ck",	&dma_ck,	CK_16XX | CK_1510 | CK_310),
 	CLK(NULL,	"dma_lcdfree_ck", &dma_lcdfree_ck, CK_16XX),
-	CLK(NULL,	"api_ck",	&api_ck.clk,	CK_16XX | CK_1510 | CK_310),
+	CLK(NULL,	"api_ck",	&api_ck.clk,	CK_16XX | CK_1510 | CK_310 | CK_7XX),
 	CLK(NULL,	"lb_ck",	&lb_ck.clk,	CK_1510 | CK_310),
 	CLK(NULL,	"rhea1_ck",	&rhea1_ck,	CK_16XX),
 	CLK(NULL,	"rhea2_ck",	&rhea2_ck,	CK_16XX),
-- 
1.6.3.3

