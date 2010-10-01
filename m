From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 05/10] OMAP3xxx: clock: add clkdev aliases for McBSP fclk
	source switching
Date: Fri, 01 Oct 2010 15:35:02 -0600
Message-ID: <20101001213500.1408.98951.stgit@twilight.localdomain>
References: <20101001213119.1408.65395.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49833 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756036Ab0JAVlZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 17:41:25 -0400
In-Reply-To: <20101001213119.1408.65395.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The OMAP3 clock tree already contains the infrastructure to support
clock framework-based McBSP functional clock source switching.  But it
did not contain the clkdev aliases for the McBSP code to refer to the
parent clocks in an SoC integration-neutral way.  So, add the clkdev
aliases for the parent clocks.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock3xxx_data.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index c73906d..accbcf3 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3188,6 +3188,11 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"osc_sys_ck",	&osc_sys_ck,	CK_3XXX),
 	CLK(NULL,	"sys_ck",	&sys_ck,	CK_3XXX),
 	CLK(NULL,	"sys_altclk",	&sys_altclk,	CK_3XXX),
+	CLK("omap-mcbsp.1",	"pad_fck",	&mcbsp_clks,	CK_3XXX),
+	CLK("omap-mcbsp.2",	"pad_fck",	&mcbsp_clks,	CK_3XXX),
+	CLK("omap-mcbsp.3",	"pad_fck",	&mcbsp_clks,	CK_3XXX),
+	CLK("omap-mcbsp.4",	"pad_fck",	&mcbsp_clks,	CK_3XXX),
+	CLK("omap-mcbsp.5",	"pad_fck",	&mcbsp_clks,	CK_3XXX),
 	CLK(NULL,	"mcbsp_clks",	&mcbsp_clks,	CK_3XXX),
 	CLK(NULL,	"sys_clkout1",	&sys_clkout1,	CK_3XXX),
 	CLK(NULL,	"dpll1_ck",	&dpll1_ck,	CK_3XXX),
@@ -3253,6 +3258,8 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"cpefuse_fck",	&cpefuse_fck,	CK_3430ES2 | CK_AM35XX),
 	CLK(NULL,	"ts_fck",	&ts_fck,	CK_3430ES2 | CK_AM35XX),
 	CLK(NULL,	"usbtll_fck",	&usbtll_fck,	CK_3430ES2 | CK_AM35XX),
+	CLK("omap-mcbsp.1",	"prcm_fck",	&core_96m_fck,	CK_3XXX),
+	CLK("omap-mcbsp.5",	"prcm_fck",	&core_96m_fck,	CK_3XXX),
 	CLK(NULL,	"core_96m_fck",	&core_96m_fck,	CK_3XXX),
 	CLK("mmci-omap-hs.2",	"fck",	&mmchs3_fck,	CK_3430ES2 | CK_AM35XX),
 	CLK("mmci-omap-hs.1",	"fck",	&mmchs2_fck,	CK_3XXX),
@@ -3346,6 +3353,9 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"omap_32ksync_ick", &omap_32ksync_ick, CK_3XXX),
 	CLK(NULL,	"gpt12_ick",	&gpt12_ick,	CK_3XXX),
 	CLK(NULL,	"gpt1_ick",	&gpt1_ick,	CK_3XXX),
+	CLK("omap-mcbsp.2",	"prcm_fck",	&per_96m_fck,	CK_3XXX),
+	CLK("omap-mcbsp.3",	"prcm_fck",	&per_96m_fck,	CK_3XXX),
+	CLK("omap-mcbsp.4",	"prcm_fck",	&per_96m_fck,	CK_3XXX),
 	CLK(NULL,	"per_96m_fck",	&per_96m_fck,	CK_3XXX),
 	CLK(NULL,	"per_48m_fck",	&per_48m_fck,	CK_3XXX),
 	CLK(NULL,	"uart3_fck",	&uart3_fck,	CK_3XXX),


