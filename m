From: jean.pihet@newoldbits.com
Subject: [PATCH 17/26] OMAP3+: Add SmartReflex clocks
Date: Tue, 22 Nov 2011 16:06:01 +0100
Message-ID: <1321974370-25800-18-git-send-email-j-pihet@ti.com>
References: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:48485 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757188Ab1KVPHV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Nov 2011 10:07:21 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so270729eye.19
        for <linux-omap@vger.kernel.org>; Tue, 22 Nov 2011 07:07:20 -0800 (PST)
In-Reply-To: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, paul@pwsan.com, khilman@ti.com, balbi@ti.com, rjw@sisk.pl
Cc: Jean Pihet <j-pihet@ti.com>

From: Paul Walmsley <paul@pwsan.com>

Add functional clocks for OMAP3 SmartReflex 1&2 and for OMAP4 SmartReflex 1,2&3

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/clock3xxx_data.c |    6 ++++++
 arch/arm/mach-omap2/clock44xx_data.c |    3 +++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 5d0064a..d653005 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3448,7 +3448,13 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"traceclk_src_fck", &traceclk_src_fck, CK_3XXX),
 	CLK(NULL,	"traceclk_fck",	&traceclk_fck,	CK_3XXX),
 	CLK(NULL,	"sr1_fck",	&sr1_fck,	CK_34XX | CK_36XX),
+	/*
+	 * These smartreflex alias lines should be removable after
+	 * the omap_device code adds clkdev aliases to "main"
+	 */
+	CLK("smartreflex.0",	"fck",	&sr1_fck,	CK_34XX | CK_36XX),
 	CLK(NULL,	"sr2_fck",	&sr2_fck,	CK_34XX | CK_36XX),
+	CLK("smartreflex.1",	"fck",	&sr2_fck,	CK_34XX | CK_36XX),
 	CLK(NULL,	"sr_l4_ick",	&sr_l4_ick,	CK_34XX | CK_36XX),
 	CLK(NULL,	"secure_32k_fck", &secure_32k_fck, CK_3XXX),
 	CLK(NULL,	"gpt12_fck",	&gpt12_fck,	CK_3XXX),
diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 0798a80..1988fa2 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -3278,8 +3278,11 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"slimbus2_slimbus_clk",		&slimbus2_slimbus_clk,	CK_443X),
 	CLK(NULL,	"slimbus2_fck",			&slimbus2_fck,	CK_443X),
 	CLK(NULL,	"smartreflex_core_fck",		&smartreflex_core_fck,	CK_443X),
+	CLK("smartreflex.0", "fck",			&smartreflex_core_fck,	CK_443X),
 	CLK(NULL,	"smartreflex_iva_fck",		&smartreflex_iva_fck,	CK_443X),
+	CLK("smartreflex.1", "fck",			&smartreflex_iva_fck,	CK_443X),
 	CLK(NULL,	"smartreflex_mpu_fck",		&smartreflex_mpu_fck,	CK_443X),
+	CLK("smartreflex.2", "fck",			&smartreflex_mpu_fck,	CK_443X),
 	CLK(NULL,	"gpt1_fck",			&timer1_fck,	CK_443X),
 	CLK(NULL,	"gpt10_fck",			&timer10_fck,	CK_443X),
 	CLK(NULL,	"gpt11_fck",			&timer11_fck,	CK_443X),
-- 
1.7.5.4

