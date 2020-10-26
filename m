Return-Path: <SRS0=mtBc=EB=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFF5C56201
	for <linux-omap@archiver.kernel.org>; Mon, 26 Oct 2020 11:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A87042465A
	for <linux-omap@archiver.kernel.org>; Mon, 26 Oct 2020 11:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1772605AbgJZLWs (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 26 Oct 2020 07:22:48 -0400
Received: from muru.com ([72.249.23.125]:46678 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1422405AbgJZLWs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Mon, 26 Oct 2020 07:22:48 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id A2A2A8196;
        Mon, 26 Oct 2020 11:22:52 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        devicetree@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>,
        Suman Anna <s-anna@ti.com>, Roger Quadros <rogerq@ti.com>,
        Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 06/18] ARM: OMAP2+: Drop legacy platform data for am3 wkup_m3
Date:   Mon, 26 Oct 2020 13:22:10 +0200
Message-Id: <20201026112222.56894-7-tony@atomide.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201026112222.56894-1-tony@atomide.com>
References: <20201026112222.56894-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

We can now probe devices with ti-sysc interconnect driver and dts
data. Let's drop the related platform data and custom ti,hwmods
dts property.

As we're just dropping data, and the early platform data init
is based on the custom ti,hwmods property, we want to drop both
the platform data and ti,hwmods property in a single patch.

Cc: Dave Gerlach <d-gerlach@ti.com>
Cc: Suman Anna <s-anna@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/am33xx-l4.dtsi           |  1 -
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c | 43 ----------------------
 2 files changed, 44 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx-l4.dtsi b/arch/arm/boot/dts/am33xx-l4.dtsi
--- a/arch/arm/boot/dts/am33xx-l4.dtsi
+++ b/arch/arm/boot/dts/am33xx-l4.dtsi
@@ -32,7 +32,6 @@ segment@100000 {					/* 0x44d00000 */
 
 		target-module@0 {			/* 0x44d00000, ap 4 28.0 */
 			compatible = "ti,sysc-omap4", "ti,sysc";
-			ti,hwmods = "wkup_m3";
 			reg = <0x0 0x4>;
 			reg-names = "rev";
 			clocks = <&l4_wkup_aon_clkctrl AM3_L4_WKUP_AON_WKUP_M3_CLKCTRL 0>;
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -57,31 +57,6 @@ static struct omap_hwmod am33xx_l4_hs_hwmod = {
 	},
 };
 
-static struct omap_hwmod_rst_info am33xx_wkup_m3_resets[] = {
-	{ .name = "wkup_m3", .rst_shift = 3, .st_shift = 5 },
-};
-
-/* wkup_m3  */
-static struct omap_hwmod am33xx_wkup_m3_hwmod = {
-	.name		= "wkup_m3",
-	.class		= &am33xx_wkup_m3_hwmod_class,
-	.clkdm_name	= "l4_wkup_aon_clkdm",
-	/* Keep hardreset asserted */
-	.flags		= HWMOD_INIT_NO_RESET | HWMOD_NO_IDLEST,
-	.main_clk	= "dpll_core_m4_div2_ck",
-	.prcm		= {
-		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_WKUP_WKUP_M3_CLKCTRL_OFFSET,
-			.rstctrl_offs	= AM33XX_RM_WKUP_RSTCTRL_OFFSET,
-			.rstst_offs	= AM33XX_RM_WKUP_RSTST_OFFSET,
-			.modulemode	= MODULEMODE_SWCTRL,
-		},
-	},
-	.rst_lines	= am33xx_wkup_m3_resets,
-	.rst_lines_cnt	= ARRAY_SIZE(am33xx_wkup_m3_resets),
-};
-
-
 /*
  * Modules omap_hwmod structures
  *
@@ -202,22 +177,6 @@ static struct omap_hwmod_ocp_if am33xx_l3_main__l4_hs = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-/* wkup m3 -> l4 wkup */
-static struct omap_hwmod_ocp_if am33xx_wkup_m3__l4_wkup = {
-	.master		= &am33xx_wkup_m3_hwmod,
-	.slave		= &am33xx_l4_wkup_hwmod,
-	.clk		= "dpll_core_m4_div2_ck",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4 wkup -> wkup m3 */
-static struct omap_hwmod_ocp_if am33xx_l4_wkup__wkup_m3 = {
-	.master		= &am33xx_l4_wkup_hwmod,
-	.slave		= &am33xx_wkup_m3_hwmod,
-	.clk		= "dpll_core_m4_div2_ck",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
 /* l3_main -> debugss */
 static struct omap_hwmod_ocp_if am33xx_l3_main__debugss = {
 	.master		= &am33xx_l3_main_hwmod,
@@ -252,9 +211,7 @@ static struct omap_hwmod_ocp_if *am33xx_hwmod_ocp_ifs[] __initdata = {
 	&am33xx_l3_main__l3_s,
 	&am33xx_l3_main__l3_instr,
 	&am33xx_l3_s__l3_main,
-	&am33xx_wkup_m3__l4_wkup,
 	&am33xx_l3_main__debugss,
-	&am33xx_l4_wkup__wkup_m3,
 	&am33xx_l4_wkup__smartreflex0,
 	&am33xx_l4_wkup__smartreflex1,
 	&am33xx_l3_s__gpmc,
-- 
2.29.1
