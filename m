Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C526C2D0E4
	for <linux-omap@archiver.kernel.org>; Thu, 19 Nov 2020 13:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CF262468D
	for <linux-omap@archiver.kernel.org>; Thu, 19 Nov 2020 13:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbgKSNHe (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 19 Nov 2020 08:07:34 -0500
Received: from muru.com ([72.249.23.125]:48802 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726474AbgKSNHe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Thu, 19 Nov 2020 08:07:34 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 16F718139;
        Thu, 19 Nov 2020 13:07:38 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        devicetree@vger.kernel.org, Tero Kristo <t-kristo@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Roger Quadros <rogerq@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Suman Anna <s-anna@ti.com>, linux-clk@vger.kernel.org
Subject: [PATCH 2/7] soc: ti: omap-prm: omap4: add genpd support for remaining PRM instances
Date:   Thu, 19 Nov 2020 15:07:15 +0200
Message-Id: <20201119130720.63140-3-tony@atomide.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201119130720.63140-1-tony@atomide.com>
References: <20201119130720.63140-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

From: Tero Kristo <t-kristo@ti.com>

Add genpd support for mpu, tesla, always_on_core, core, ivahd, cam, dss,
gfx, l3init, l4per, cefuse, wkup and emu instances.

Cc: Santosh Shilimkar <ssantosh@kernel.org>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/soc/ti/omap_prm.c | 71 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 67 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/ti/omap_prm.c b/drivers/soc/ti/omap_prm.c
--- a/drivers/soc/ti/omap_prm.c
+++ b/drivers/soc/ti/omap_prm.c
@@ -128,6 +128,12 @@ static const struct omap_prm_domain_map omap_prm_alwon = {
 	.usable_modes = BIT(OMAP_PRMD_ON_ACTIVE),
 };
 
+static const struct omap_prm_domain_map omap_prm_reton = {
+	.usable_modes = BIT(OMAP_PRMD_ON_ACTIVE) | BIT(OMAP_PRMD_RETENTION),
+	.statechange = 1,
+	.logicretstate = 1,
+};
+
 static const struct omap_rst_map rst_map_0[] = {
 	{ .rst = 0, .st = 0 },
 	{ .rst = -1 },
@@ -147,14 +153,71 @@ static const struct omap_rst_map rst_map_012[] = {
 };
 
 static const struct omap_prm_data omap4_prm_data[] = {
-	{ .name = "tesla", .base = 0x4a306400, .rstctrl = 0x10, .rstst = 0x14, .rstmap = rst_map_01 },
+	{
+		.name = "mpu", .base = 0x4a306300,
+		.pwrstctrl = 0x0, .pwrstst = 0x4, .dmap = &omap_prm_reton,
+	},
+	{
+		.name = "tesla", .base = 0x4a306400,
+		.pwrstctrl = 0x0, .pwrstst = 0x4, .dmap = &omap_prm_noinact,
+		.rstctrl = 0x10, .rstst = 0x14, .rstmap = rst_map_01
+	},
 	{
 		.name = "abe", .base = 0x4a306500,
 		.pwrstctrl = 0, .pwrstst = 0x4, .dmap = &omap_prm_all,
 	},
-	{ .name = "core", .base = 0x4a306700, .rstctrl = 0x210, .rstst = 0x214, .clkdm_name = "ducati", .rstmap = rst_map_012 },
-	{ .name = "ivahd", .base = 0x4a306f00, .rstctrl = 0x10, .rstst = 0x14, .rstmap = rst_map_012 },
-	{ .name = "device", .base = 0x4a307b00, .rstctrl = 0x0, .rstst = 0x4, .rstmap = rst_map_01, .flags = OMAP_PRM_HAS_RSTCTRL | OMAP_PRM_HAS_NO_CLKDM },
+	{
+		.name = "always_on_core", .base = 0x4a306600,
+		.pwrstctrl = 0x0, .pwrstst = 0x4, .dmap = &omap_prm_alwon,
+	},
+	{
+		.name = "core", .base = 0x4a306700,
+		.pwrstctrl = 0x0, .pwrstst = 0x4, .dmap = &omap_prm_reton,
+		.rstctrl = 0x210, .rstst = 0x214, .clkdm_name = "ducati",
+		.rstmap = rst_map_012
+	},
+	{
+		.name = "ivahd", .base = 0x4a306f00,
+		.pwrstctrl = 0x0, .pwrstst = 0x4, .dmap = &omap_prm_noinact,
+		.rstctrl = 0x10, .rstst = 0x14, .rstmap = rst_map_012
+	},
+	{
+		.name = "cam", .base = 0x4a307000,
+		.pwrstctrl = 0x0, .pwrstst = 0x4, .dmap = &omap_prm_onoff_noauto,
+	},
+	{
+		.name = "dss", .base = 0x4a307100,
+		.pwrstctrl = 0x0, .pwrstst = 0x4, .dmap = &omap_prm_noinact
+	},
+	{
+		.name = "gfx", .base = 0x4a307200,
+		.pwrstctrl = 0x0, .pwrstst = 0x4, .dmap = &omap_prm_onoff_noauto
+	},
+	{
+		.name = "l3init", .base = 0x4a307300,
+		.pwrstctrl = 0x0, .pwrstst = 0x4, .dmap = &omap_prm_reton
+	},
+	{
+		.name = "l4per", .base = 0x4a307400,
+		.pwrstctrl = 0x0, .pwrstst = 0x4, .dmap = &omap_prm_reton
+	},
+	{
+		.name = "cefuse", .base = 0x4a307600,
+		.pwrstctrl = 0x0, .pwrstst = 0x4, .dmap = &omap_prm_onoff_noauto
+	},
+	{
+		.name = "wkup", .base = 0x4a307700,
+		.pwrstctrl = 0x0, .pwrstst = 0x4, .dmap = &omap_prm_alwon
+	},
+	{
+		.name = "emu", .base = 0x4a307900,
+		.pwrstctrl = 0x0, .pwrstst = 0x4, .dmap = &omap_prm_onoff_noauto
+	},
+	{
+		.name = "device", .base = 0x4a307b00,
+		.rstctrl = 0x0, .rstst = 0x4, .rstmap = rst_map_01,
+		.flags = OMAP_PRM_HAS_RSTCTRL | OMAP_PRM_HAS_NO_CLKDM
+	},
 	{ },
 };
 
-- 
2.29.2
