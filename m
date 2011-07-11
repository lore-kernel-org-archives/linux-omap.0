From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v14 01/12] OMAP2+: dmtimer: add device names to flck nodes
Date: Mon, 11 Jul 2011 16:59:08 +0530
Message-ID: <1310383759-19059-2-git-send-email-tarun.kanti@ti.com>
References: <1310383759-19059-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52970 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756495Ab1GKMsu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jul 2011 08:48:50 -0400
In-Reply-To: <1310383759-19059-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Thara Gopinath <thara@ti.com>

Add device name to OMAP2 dmtimer fclk nodes so that the fclk nodes can be
retrieved by doing a clk_get with the corresponding device pointers or
device names.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com
Signed-off-by: Thara Gopinath <thara@ti.com>
Acked-by: Cousson, Benoit <b-cousson@ti.com>
---
 arch/arm/mach-omap2/clock2420_data.c |   52 ++++++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/clock2430_data.c |   48 +++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/clock3xxx_data.c |   36 +++++++++++++++++++++++
 arch/arm/mach-omap2/clock44xx_data.c |   33 +++++++++++++++++++++
 4 files changed, 167 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-omap2/clock2420_data.c
index 2926d02..15114f5 100644
--- a/arch/arm/mach-omap2/clock2420_data.c
+++ b/arch/arm/mach-omap2/clock2420_data.c
@@ -1838,9 +1838,9 @@ static struct omap_clk omap2420_clks[] = {
 	CLK(NULL,	"gpt9_ick",	&gpt9_ick,	CK_242X),
 	CLK(NULL,	"gpt9_fck",	&gpt9_fck,	CK_242X),
 	CLK(NULL,	"gpt10_ick",	&gpt10_ick,	CK_242X),
-	CLK(NULL,	"gpt10_fck",	&gpt10_fck,	CK_242X),
+	CLK(NULL,	"gpt_10fck",	&gpt10_fck,	CK_242X),
 	CLK(NULL,	"gpt11_ick",	&gpt11_ick,	CK_242X),
-	CLK(NULL,	"gpt11_fck",	&gpt11_fck,	CK_242X),
+	CLK(NULL,	"gpt_11fck",	&gpt11_fck,	CK_242X),
 	CLK(NULL,	"gpt12_ick",	&gpt12_ick,	CK_242X),
 	CLK(NULL,	"gpt12_fck",	&gpt12_fck,	CK_242X),
 	CLK("omap-mcbsp.1", "ick",	&mcbsp1_ick,	CK_242X),
@@ -1898,6 +1898,54 @@ static struct omap_clk omap2420_clks[] = {
 	CLK(NULL,	"pka_ick",	&pka_ick,	CK_242X),
 	CLK(NULL,	"usb_fck",	&usb_fck,	CK_242X),
 	CLK("musb-hdrc",	"fck",	&osc_ck,	CK_242X),
+	CLK("omap_timer.1",	"fck",	&gpt1_fck,	CK_242X),
+	CLK("omap_timer.2",	"fck",	&gpt2_fck,	CK_242X),
+	CLK("omap_timer.3",	"fck",	&gpt3_fck,	CK_242X),
+	CLK("omap_timer.4",	"fck",	&gpt4_fck,	CK_242X),
+	CLK("omap_timer.5",	"fck",	&gpt5_fck,	CK_242X),
+	CLK("omap_timer.6",	"fck",	&gpt6_fck,	CK_242X),
+	CLK("omap_timer.7",	"fck",	&gpt7_fck,	CK_242X),
+	CLK("omap_timer.8",	"fck",	&gpt8_fck,	CK_242X),
+	CLK("omap_timer.9",	"fck",	&gpt9_fck,	CK_242X),
+	CLK("omap_timer.10",	"fck",	&gpt10_fck,	CK_242X),
+	CLK("omap_timer.11",	"fck",	&gpt11_fck,	CK_242X),
+	CLK("omap_timer.12",	"fck",	&gpt12_fck,	CK_242X),
+	CLK("omap_timer.1",	"32k_ck",	&func_32k_ck,	CK_243X),
+	CLK("omap_timer.2",	"32k_ck",	&func_32k_ck,	CK_243X),
+	CLK("omap_timer.3",	"32k_ck",	&func_32k_ck,	CK_243X),
+	CLK("omap_timer.4",	"32k_ck",	&func_32k_ck,	CK_243X),
+	CLK("omap_timer.5",	"32k_ck",	&func_32k_ck,	CK_243X),
+	CLK("omap_timer.6",	"32k_ck",	&func_32k_ck,	CK_243X),
+	CLK("omap_timer.7",	"32k_ck",	&func_32k_ck,	CK_243X),
+	CLK("omap_timer.8",	"32k_ck",	&func_32k_ck,	CK_243X),
+	CLK("omap_timer.9",	"32k_ck",	&func_32k_ck,	CK_243X),
+	CLK("omap_timer.10",	"32k_ck",	&func_32k_ck,	CK_243X),
+	CLK("omap_timer.11",	"32k_ck",	&func_32k_ck,	CK_243X),
+	CLK("omap_timer.12",	"32k_ck",	&func_32k_ck,	CK_243X),
+	CLK("omap_timer.1",	"sys_ck",	&sys_ck,	CK_243X),
+	CLK("omap_timer.2",	"sys_ck",	&sys_ck,	CK_243X),
+	CLK("omap_timer.3",	"sys_ck",	&sys_ck,	CK_243X),
+	CLK("omap_timer.4",	"sys_ck",	&sys_ck,	CK_243X),
+	CLK("omap_timer.5",	"sys_ck",	&sys_ck,	CK_243X),
+	CLK("omap_timer.6",	"sys_ck",	&sys_ck,	CK_243X),
+	CLK("omap_timer.7",	"sys_ck",	&sys_ck,	CK_243X),
+	CLK("omap_timer.8",	"sys_ck",	&sys_ck,	CK_243X),
+	CLK("omap_timer.9",	"sys_ck",	&sys_ck,	CK_243X),
+	CLK("omap_timer.10",	"sys_ck",	&sys_ck,	CK_243X),
+	CLK("omap_timer.11",	"sys_ck",	&sys_ck,	CK_243X),
+	CLK("omap_timer.12",	"sys_ck",	&sys_ck,	CK_243X),
+	CLK("omap_timer.1",	"alt_ck",	&alt_ck,	CK_243X),
+	CLK("omap_timer.2",	"alt_ck",	&alt_ck,	CK_243X),
+	CLK("omap_timer.3",	"alt_ck",	&alt_ck,	CK_243X),
+	CLK("omap_timer.4",	"alt_ck",	&alt_ck,	CK_243X),
+	CLK("omap_timer.5",	"alt_ck",	&alt_ck,	CK_243X),
+	CLK("omap_timer.6",	"alt_ck",	&alt_ck,	CK_243X),
+	CLK("omap_timer.7",	"alt_ck",	&alt_ck,	CK_243X),
+	CLK("omap_timer.8",	"alt_ck",	&alt_ck,	CK_243X),
+	CLK("omap_timer.9",	"alt_ck",	&alt_ck,	CK_243X),
+	CLK("omap_timer.10",	"alt_ck",	&alt_ck,	CK_243X),
+	CLK("omap_timer.11",	"alt_ck",	&alt_ck,	CK_243X),
+	CLK("omap_timer.12",	"alt_ck",	&alt_ck,	CK_243X),
 };
 
 /*
diff --git a/arch/arm/mach-omap2/clock2430_data.c b/arch/arm/mach-omap2/clock2430_data.c
index 0c79d39..7b4e688 100644
--- a/arch/arm/mach-omap2/clock2430_data.c
+++ b/arch/arm/mach-omap2/clock2430_data.c
@@ -1998,6 +1998,54 @@ static struct omap_clk omap2430_clks[] = {
 	CLK(NULL,	"mdm_intc_ick",	&mdm_intc_ick,	CK_243X),
 	CLK("omap_hsmmc.0", "mmchsdb_fck",	&mmchsdb1_fck,	CK_243X),
 	CLK("omap_hsmmc.1", "mmchsdb_fck",	&mmchsdb2_fck,	CK_243X),
+	CLK("omap_timer.1",     "fck",  &gpt1_fck,      CK_243X),
+	CLK("omap_timer.2",     "fck",  &gpt2_fck,      CK_243X),
+	CLK("omap_timer.3",     "fck",  &gpt3_fck,      CK_243X),
+	CLK("omap_timer.4",     "fck",  &gpt4_fck,      CK_243X),
+	CLK("omap_timer.5",     "fck",  &gpt5_fck,      CK_243X),
+	CLK("omap_timer.6",     "fck",  &gpt6_fck,      CK_243X),
+	CLK("omap_timer.7",     "fck",  &gpt7_fck,      CK_243X),
+	CLK("omap_timer.8",     "fck",  &gpt8_fck,      CK_243X),
+	CLK("omap_timer.9",     "fck",  &gpt9_fck,      CK_243X),
+	CLK("omap_timer.10",    "fck",  &gpt10_fck,     CK_243X),
+	CLK("omap_timer.11",    "fck",  &gpt11_fck,     CK_243X),
+	CLK("omap_timer.12",    "fck",  &gpt12_fck,     CK_243X),
+	CLK("omap_timer.1",	"32k_ck",  &func_32k_ck,   CK_243X),
+	CLK("omap_timer.2",	"32k_ck",  &func_32k_ck,   CK_243X),
+	CLK("omap_timer.3",	"32k_ck",  &func_32k_ck,   CK_243X),
+	CLK("omap_timer.4",	"32k_ck",  &func_32k_ck,   CK_243X),
+	CLK("omap_timer.5",	"32k_ck",  &func_32k_ck,   CK_243X),
+	CLK("omap_timer.6",	"32k_ck",  &func_32k_ck,   CK_243X),
+	CLK("omap_timer.7",	"32k_ck",  &func_32k_ck,   CK_243X),
+	CLK("omap_timer.8",	"32k_ck",  &func_32k_ck,   CK_243X),
+	CLK("omap_timer.9",	"32k_ck",  &func_32k_ck,   CK_243X),
+	CLK("omap_timer.10",	"32k_ck",  &func_32k_ck,   CK_243X),
+	CLK("omap_timer.11",	"32k_ck",  &func_32k_ck,   CK_243X),
+	CLK("omap_timer.12",	"32k_ck",  &func_32k_ck,   CK_243X),
+	CLK("omap_timer.1",	"sys_ck",	&sys_ck,	CK_243X),
+	CLK("omap_timer.2",	"sys_ck",	&sys_ck,	CK_243X),
+	CLK("omap_timer.3",	"sys_ck",	&sys_ck,	CK_243X),
+	CLK("omap_timer.4",	"sys_ck",	&sys_ck,	CK_243X),
+	CLK("omap_timer.5",	"sys_ck",	&sys_ck,	CK_243X),
+	CLK("omap_timer.6",	"sys_ck",	&sys_ck,	CK_243X),
+	CLK("omap_timer.7",	"sys_ck",	&sys_ck,	CK_243X),
+	CLK("omap_timer.8",	"sys_ck",	&sys_ck,	CK_243X),
+	CLK("omap_timer.9",	"sys_ck",	&sys_ck,	CK_243X),
+	CLK("omap_timer.10",	"sys_ck",	&sys_ck,	CK_243X),
+	CLK("omap_timer.11",	"sys_ck",	&sys_ck,	CK_243X),
+	CLK("omap_timer.12",	"sys_ck",	&sys_ck,	CK_243X),
+	CLK("omap_timer.1",	"alt_ck",	&alt_ck,	CK_243X),
+	CLK("omap_timer.2",	"alt_ck",	&alt_ck,	CK_243X),
+	CLK("omap_timer.3",	"alt_ck",	&alt_ck,	CK_243X),
+	CLK("omap_timer.4",	"alt_ck",	&alt_ck,	CK_243X),
+	CLK("omap_timer.5",	"alt_ck",	&alt_ck,	CK_243X),
+	CLK("omap_timer.6",	"alt_ck",	&alt_ck,	CK_243X),
+	CLK("omap_timer.7",	"alt_ck",	&alt_ck,	CK_243X),
+	CLK("omap_timer.8",	"alt_ck",	&alt_ck,	CK_243X),
+	CLK("omap_timer.9",	"alt_ck",	&alt_ck,	CK_243X),
+	CLK("omap_timer.10",	"alt_ck",	&alt_ck,	CK_243X),
+	CLK("omap_timer.11",	"alt_ck",	&alt_ck,	CK_243X),
+	CLK("omap_timer.12",	"alt_ck",	&alt_ck,	CK_243X),
 };
 
 /*
diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 75b119b..7d97525 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3462,6 +3462,42 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK("musb-am35x",	"fck",		&hsotgusb_fck_am35xx,	CK_AM35XX),
 	CLK(NULL,	"hecc_ck",	&hecc_ck,	CK_AM35XX),
 	CLK(NULL,	"uart4_ick",	&uart4_ick_am35xx,	CK_AM35XX),
+	CLK("omap_timer.1",	"fck",	&gpt1_fck,	CK_3XXX),
+	CLK("omap_timer.2",	"fck",	&gpt2_fck,	CK_3XXX),
+	CLK("omap_timer.3",	"fck",	&gpt3_fck,	CK_3XXX),
+	CLK("omap_timer.4",	"fck",	&gpt4_fck,	CK_3XXX),
+	CLK("omap_timer.5",	"fck",	&gpt5_fck,	CK_3XXX),
+	CLK("omap_timer.6",	"fck",	&gpt6_fck,	CK_3XXX),
+	CLK("omap_timer.7",	"fck",	&gpt7_fck,	CK_3XXX),
+	CLK("omap_timer.8",	"fck",	&gpt8_fck,	CK_3XXX),
+	CLK("omap_timer.9",	"fck",	&gpt9_fck,	CK_3XXX),
+	CLK("omap_timer.10",    "fck",  &gpt10_fck,     CK_3XXX),
+	CLK("omap_timer.11",    "fck",  &gpt11_fck,     CK_3XXX),
+	CLK("omap_timer.12",    "fck",  &gpt12_fck,     CK_3XXX),
+	CLK("omap_timer.1",	"32k_ck",	&omap_32k_fck,  CK_3XXX),
+	CLK("omap_timer.2",	"32k_ck",	&omap_32k_fck,  CK_3XXX),
+	CLK("omap_timer.3",	"32k_ck",	&omap_32k_fck,  CK_3XXX),
+	CLK("omap_timer.4",	"32k_ck",	&omap_32k_fck,  CK_3XXX),
+	CLK("omap_timer.5",	"32k_ck",	&omap_32k_fck,  CK_3XXX),
+	CLK("omap_timer.6",	"32k_ck",	&omap_32k_fck,  CK_3XXX),
+	CLK("omap_timer.7",	"32k_ck",	&omap_32k_fck,  CK_3XXX),
+	CLK("omap_timer.8",	"32k_ck",	&omap_32k_fck,  CK_3XXX),
+	CLK("omap_timer.9",	"32k_ck",	&omap_32k_fck,  CK_3XXX),
+	CLK("omap_timer.10",	"32k_ck",	&omap_32k_fck,  CK_3XXX),
+	CLK("omap_timer.11",	"32k_ck",	&omap_32k_fck,  CK_3XXX),
+	CLK("omap_timer.12",	"32k_ck",	&omap_32k_fck,  CK_3XXX),
+	CLK("omap_timer.1",	"sys_ck",	&sys_ck,	CK_3XXX),
+	CLK("omap_timer.2",	"sys_ck",	&sys_ck,	CK_3XXX),
+	CLK("omap_timer.3",	"sys_ck",	&sys_ck,	CK_3XXX),
+	CLK("omap_timer.4",	"sys_ck",	&sys_ck,	CK_3XXX),
+	CLK("omap_timer.5",	"sys_ck",	&sys_ck,	CK_3XXX),
+	CLK("omap_timer.6",	"sys_ck",	&sys_ck,	CK_3XXX),
+	CLK("omap_timer.7",	"sys_ck",	&sys_ck,	CK_3XXX),
+	CLK("omap_timer.8",	"sys_ck",	&sys_ck,	CK_3XXX),
+	CLK("omap_timer.9",	"sys_ck",	&sys_ck,	CK_3XXX),
+	CLK("omap_timer.10",	"sys_ck",	&sys_ck,	CK_3XXX),
+	CLK("omap_timer.11",	"sys_ck",	&sys_ck,	CK_3XXX),
+	CLK("omap_timer.12",	"sys_ck",	&sys_ck,	CK_3XXX),
 };
 
 
diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 8c96567..7d18b13 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -3283,6 +3283,39 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"auxclkreq3_ck",		&auxclkreq3_ck,	CK_443X),
 	CLK(NULL,	"auxclkreq4_ck",		&auxclkreq4_ck,	CK_443X),
 	CLK(NULL,	"auxclkreq5_ck",		&auxclkreq5_ck,	CK_443X),
+	CLK("omap_timer.1",	"fck",			&timer1_fck,	CK_443X),
+	CLK("omap_timer.2",	"fck",			&timer2_fck,	CK_443X),
+	CLK("omap_timer.3",	"fck",			&timer3_fck,	CK_443X),
+	CLK("omap_timer.4",	"fck",			&timer4_fck,	CK_443X),
+	CLK("omap_timer.5",	"fck",			&timer5_fck,	CK_443X),
+	CLK("omap_timer.6",	"fck",			&timer6_fck,	CK_443X),
+	CLK("omap_timer.7",	"fck",			&timer7_fck,	CK_443X),
+	CLK("omap_timer.8",	"fck",			&timer8_fck,	CK_443X),
+	CLK("omap_timer.9",	"fck",			&timer9_fck,	CK_443X),
+	CLK("omap_timer.10",	"fck",			&timer10_fck,	CK_443X),
+	CLK("omap_timer.11",	"fck",			&timer11_fck,	CK_443X),
+	CLK("omap_timer.1",	"32k_ck",	&sys_32k_ck,	CK_443X),
+	CLK("omap_timer.2",	"32k_ck",	&sys_32k_ck,	CK_443X),
+	CLK("omap_timer.3",	"32k_ck",	&sys_32k_ck,	CK_443X),
+	CLK("omap_timer.4",	"32k_ck",	&sys_32k_ck,	CK_443X),
+	CLK("omap_timer.5",	"32k_ck",	&sys_32k_ck,	CK_443X),
+	CLK("omap_timer.6",	"32k_ck",	&sys_32k_ck,	CK_443X),
+	CLK("omap_timer.7",	"32k_ck",	&sys_32k_ck,	CK_443X),
+	CLK("omap_timer.8",	"32k_ck",	&sys_32k_ck,	CK_443X),
+	CLK("omap_timer.9",	"32k_ck",	&sys_32k_ck,	CK_443X),
+	CLK("omap_timer.10",	"32k_ck",	&sys_32k_ck,	CK_443X),
+	CLK("omap_timer.11",	"32k_ck",	&sys_32k_ck,	CK_443X),
+	CLK("omap_timer.1",	"sys_ck",	&sys_clkin_ck,	CK_443X),
+	CLK("omap_timer.2",	"sys_ck",	&sys_clkin_ck,	CK_443X),
+	CLK("omap_timer.3",	"sys_ck",	&sys_clkin_ck,	CK_443X),
+	CLK("omap_timer.4",	"sys_ck",	&sys_clkin_ck,	CK_443X),
+	CLK("omap_timer.9",	"sys_ck",	&sys_clkin_ck,	CK_443X),
+	CLK("omap_timer.10",	"sys_ck",	&sys_clkin_ck,	CK_443X),
+	CLK("omap_timer.11",	"sys_ck",	&sys_clkin_ck,	CK_443X),
+	CLK("omap_timer.5",	"sys_ck",	&syc_clk_div_ck,	CK_443X),
+	CLK("omap_timer.6",	"sys_ck",	&syc_clk_div_ck,	CK_443X),
+	CLK("omap_timer.7",	"sys_ck",	&syc_clk_div_ck,	CK_443X),
+	CLK("omap_timer.8",	"sys_ck",	&syc_clk_div_ck,	CK_443X),
 };
 
 int __init omap4xxx_clk_init(void)
-- 
1.6.0.4

