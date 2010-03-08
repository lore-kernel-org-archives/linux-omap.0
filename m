From: Sergio Aguirre <saaguirre@ti.com>
Subject: [RFC part1/2 merge v2 RESEND][PATCH 04/10] OMAP clock: Add uart4_ick/fck definitions for 3630
Date: Mon,  8 Mar 2010 11:28:46 -0600
Message-ID: <1268069332-14082-5-git-send-email-saaguirre@ti.com>
References: <1268069332-14082-1-git-send-email-saaguirre@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52204 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752241Ab0CHR15 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Mar 2010 12:27:57 -0500
In-Reply-To: <1268069332-14082-1-git-send-email-saaguirre@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Vikram Pandita <vikram.pandita@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Sergio Aguirre <saaguirre@ti.com>

This is only valid for omap 36xx family of chips.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 arch/arm/mach-omap2/clock3xxx_data.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index d5153b6..e8afaa6 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -2541,6 +2541,16 @@ static struct clk uart3_fck = {
 	.recalc		= &followparent_recalc,
 };
 
+static struct clk uart4_fck = {
+	.name		= "uart4_fck",
+	.ops		= &clkops_omap2_dflt_wait,
+	.parent		= &per_48m_fck,
+	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
+	.enable_bit	= OMAP3630_EN_UART4_SHIFT,
+	.clkdm_name	= "per_clkdm",
+	.recalc		= &followparent_recalc,
+};
+
 static struct clk gpt2_fck = {
 	.name		= "gpt2_fck",
 	.ops		= &clkops_omap2_dflt_wait,
@@ -2791,6 +2801,16 @@ static struct clk uart3_ick = {
 	.recalc		= &followparent_recalc,
 };
 
+static struct clk uart4_ick = {
+	.name		= "uart4_ick",
+	.ops		= &clkops_omap2_dflt_wait,
+	.parent		= &per_l4_ick,
+	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
+	.enable_bit	= OMAP3630_EN_UART4_SHIFT,
+	.clkdm_name	= "per_clkdm",
+	.recalc		= &followparent_recalc,
+};
+
 static struct clk gpt9_ick = {
 	.name		= "gpt9_ick",
 	.ops		= &clkops_omap2_dflt_wait,
@@ -3420,6 +3440,7 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"per_96m_fck",	&per_96m_fck,	CK_3XXX),
 	CLK(NULL,	"per_48m_fck",	&per_48m_fck,	CK_3XXX),
 	CLK(NULL,	"uart3_fck",	&uart3_fck,	CK_3XXX),
+	CLK(NULL,	"uart4_fck",	&uart4_fck,	CK_36XX),
 	CLK(NULL,	"gpt2_fck",	&gpt2_fck,	CK_3XXX),
 	CLK(NULL,	"gpt3_fck",	&gpt3_fck,	CK_3XXX),
 	CLK(NULL,	"gpt4_fck",	&gpt4_fck,	CK_3XXX),
@@ -3443,6 +3464,7 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"gpio2_ick",	&gpio2_ick,	CK_3XXX),
 	CLK(NULL,	"wdt3_ick",	&wdt3_ick,	CK_3XXX),
 	CLK(NULL,	"uart3_ick",	&uart3_ick,	CK_3XXX),
+	CLK(NULL,	"uart4_ick",	&uart4_ick,	CK_36XX),
 	CLK(NULL,	"gpt9_ick",	&gpt9_ick,	CK_3XXX),
 	CLK(NULL,	"gpt8_ick",	&gpt8_ick,	CK_3XXX),
 	CLK(NULL,	"gpt7_ick",	&gpt7_ick,	CK_3XXX),
-- 
1.6.3.3

