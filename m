From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 1/3] ARM: OMAP3: clock data: replace 3503/3517 flag with AM35x flag for UART4
Date: Mon, 30 Apr 2012 16:30:02 -0700
Message-ID: <1335828604-18795-2-git-send-email-khilman@ti.com>
References: <1335828604-18795-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:54599 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756938Ab2D3X3I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Apr 2012 19:29:08 -0400
Received: by dadz9 with SMTP id z9so4850494dad.5
        for <linux-omap@vger.kernel.org>; Mon, 30 Apr 2012 16:29:07 -0700 (PDT)
In-Reply-To: <1335828604-18795-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

The AM35x UART4 is common to all AM35x devices, so use CK_AM35XX instead
of (CK_3505 | CK_3517), which is equivalent.

Acked-by: Vaibhav Hiremath <hvaibhav@ti.com>
Tested-by: Vaibhav Hiremath <hvaibhav@ti.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
[paul@pwsan.com: also fixed AM35xx UART4 whitespace problem]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock3xxx_data.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index f4a626f..ce0cbd8 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -2489,13 +2489,13 @@ static struct clk uart4_fck = {
 };
 
 static struct clk uart4_fck_am35xx = {
-	.name           = "uart4_fck",
-	.ops            = &clkops_omap2_dflt_wait,
-	.parent         = &per_48m_fck,
-	.enable_reg     = OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit     = OMAP3430_EN_UART4_SHIFT,
-	.clkdm_name     = "core_l4_clkdm",
-	.recalc         = &followparent_recalc,
+	.name		= "uart4_fck",
+	.ops		= &clkops_omap2_dflt_wait,
+	.parent		= &per_48m_fck,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP3430_EN_UART4_SHIFT,
+	.clkdm_name	= "core_l4_clkdm",
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpt2_fck = {
@@ -3419,7 +3419,7 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"per_48m_fck",	&per_48m_fck,	CK_3XXX),
 	CLK(NULL,	"uart3_fck",	&uart3_fck,	CK_3XXX),
 	CLK(NULL,	"uart4_fck",	&uart4_fck,	CK_36XX),
-	CLK(NULL,	"uart4_fck",	&uart4_fck_am35xx, CK_3505 | CK_3517),
+	CLK(NULL,	"uart4_fck",	&uart4_fck_am35xx, CK_AM35XX),
 	CLK(NULL,	"gpt2_fck",	&gpt2_fck,	CK_3XXX),
 	CLK(NULL,	"gpt3_fck",	&gpt3_fck,	CK_3XXX),
 	CLK(NULL,	"gpt4_fck",	&gpt4_fck,	CK_3XXX),
-- 
1.7.9.2

