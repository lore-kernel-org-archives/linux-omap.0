From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 2/2] ARM: OMAP3: clock: fix boot breakage in legacy mode
Date: Fri, 12 Dec 2014 15:22:01 +0200
Message-ID: <1418390521-7541-3-git-send-email-t-kristo@ti.com>
References: <1418390521-7541-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35912 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967664AbaLLNVN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Dec 2014 08:21:13 -0500
In-Reply-To: <1418390521-7541-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@kernel.org>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

The new usage of determine_rate and set_rate_and_parent calls for
OMAP DPLLs assumes the DPLLs must have two parents defined, even
if it is the same clock. Legacy clock data did not fullfill this
requirement and caused a boot crash. Fixed by adding the missing
parent information to the DPLL clocks.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Fixes: 2e1a7b014f ("ARM: OMAP3+: DPLL: use determine_rate() and...")
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/cclock3xxx_data.c |   23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/cclock3xxx_data.c b/arch/arm/mach-omap2/cclock3xxx_data.c
index 5c5ebb4..644ff32 100644
--- a/arch/arm/mach-omap2/cclock3xxx_data.c
+++ b/arch/arm/mach-omap2/cclock3xxx_data.c
@@ -111,6 +111,7 @@ static struct clk dpll3_ck;
 
 static const char *dpll3_ck_parent_names[] = {
 	"sys_ck",
+	"sys_ck",
 };
 
 static const struct clk_ops dpll3_ck_ops = {
@@ -733,6 +734,10 @@ static const char *corex2_fck_parent_names[] = {
 DEFINE_STRUCT_CLK_HW_OMAP(corex2_fck, NULL);
 DEFINE_STRUCT_CLK(corex2_fck, corex2_fck_parent_names, core_ck_ops);
 
+static const char *cpefuse_fck_parent_names[] = {
+	"sys_ck",
+};
+
 static struct clk cpefuse_fck;
 
 static struct clk_hw_omap cpefuse_fck_hw = {
@@ -744,7 +749,7 @@ static struct clk_hw_omap cpefuse_fck_hw = {
 	.clkdm_name	= "core_l4_clkdm",
 };
 
-DEFINE_STRUCT_CLK(cpefuse_fck, dpll3_ck_parent_names, aes2_ick_ops);
+DEFINE_STRUCT_CLK(cpefuse_fck, cpefuse_fck_parent_names, aes2_ick_ops);
 
 static struct clk csi2_96m_fck;
 
@@ -775,7 +780,7 @@ static struct clk_hw_omap d2d_26m_fck_hw = {
 	.clkdm_name	= "d2d_clkdm",
 };
 
-DEFINE_STRUCT_CLK(d2d_26m_fck, dpll3_ck_parent_names, aes2_ick_ops);
+DEFINE_STRUCT_CLK(d2d_26m_fck, cpefuse_fck_parent_names, aes2_ick_ops);
 
 static struct clk des1_ick;
 
@@ -1046,7 +1051,7 @@ static struct clk_hw_omap dss2_alwon_fck_hw = {
 	.clkdm_name	= "dss_clkdm",
 };
 
-DEFINE_STRUCT_CLK(dss2_alwon_fck, dpll3_ck_parent_names, aes2_ick_ops);
+DEFINE_STRUCT_CLK(dss2_alwon_fck, cpefuse_fck_parent_names, aes2_ick_ops);
 
 static struct clk dss_96m_fck;
 
@@ -1368,7 +1373,7 @@ DEFINE_STRUCT_CLK(gpio1_dbck, gpio1_dbck_parent_names, aes2_ick_ops);
 static struct clk wkup_l4_ick;
 
 DEFINE_STRUCT_CLK_HW_OMAP(wkup_l4_ick, "wkup_clkdm");
-DEFINE_STRUCT_CLK(wkup_l4_ick, dpll3_ck_parent_names, core_l4_ick_ops);
+DEFINE_STRUCT_CLK(wkup_l4_ick, cpefuse_fck_parent_names, core_l4_ick_ops);
 
 static struct clk gpio1_ick;
 
@@ -1862,7 +1867,7 @@ static struct clk_hw_omap hecc_ck_hw = {
 	.clkdm_name	= "core_l3_clkdm",
 };
 
-DEFINE_STRUCT_CLK(hecc_ck, dpll3_ck_parent_names, aes2_ick_ops);
+DEFINE_STRUCT_CLK(hecc_ck, cpefuse_fck_parent_names, aes2_ick_ops);
 
 static struct clk hsotgusb_fck_am35xx;
 
@@ -1875,7 +1880,7 @@ static struct clk_hw_omap hsotgusb_fck_am35xx_hw = {
 	.clkdm_name	= "core_l3_clkdm",
 };
 
-DEFINE_STRUCT_CLK(hsotgusb_fck_am35xx, dpll3_ck_parent_names, aes2_ick_ops);
+DEFINE_STRUCT_CLK(hsotgusb_fck_am35xx, cpefuse_fck_parent_names, aes2_ick_ops);
 
 static struct clk hsotgusb_ick_3430es1;
 
@@ -2411,7 +2416,7 @@ static struct clk_hw_omap modem_fck_hw = {
 	.clkdm_name	= "d2d_clkdm",
 };
 
-DEFINE_STRUCT_CLK(modem_fck, dpll3_ck_parent_names, aes2_ick_ops);
+DEFINE_STRUCT_CLK(modem_fck, cpefuse_fck_parent_names, aes2_ick_ops);
 
 static struct clk mspro_fck;
 
@@ -2710,7 +2715,7 @@ static struct clk_hw_omap sr1_fck_hw = {
 	.clkdm_name	= "wkup_clkdm",
 };
 
-DEFINE_STRUCT_CLK(sr1_fck, dpll3_ck_parent_names, aes2_ick_ops);
+DEFINE_STRUCT_CLK(sr1_fck, cpefuse_fck_parent_names, aes2_ick_ops);
 
 static struct clk sr2_fck;
 
@@ -2724,7 +2729,7 @@ static struct clk_hw_omap sr2_fck_hw = {
 	.clkdm_name	= "wkup_clkdm",
 };
 
-DEFINE_STRUCT_CLK(sr2_fck, dpll3_ck_parent_names, aes2_ick_ops);
+DEFINE_STRUCT_CLK(sr2_fck, cpefuse_fck_parent_names, aes2_ick_ops);
 
 static struct clk sr_l4_ick;
 
-- 
1.7.9.5

