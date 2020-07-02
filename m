Return-Path: <SRS0=KqvK=AN=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26DFC433E2
	for <linux-omap@archiver.kernel.org>; Thu,  2 Jul 2020 15:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C314520CC7
	for <linux-omap@archiver.kernel.org>; Thu,  2 Jul 2020 15:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbgGBPp1 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 2 Jul 2020 11:45:27 -0400
Received: from muru.com ([72.249.23.125]:60328 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbgGBPp0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Thu, 2 Jul 2020 11:45:26 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 802A980BD;
        Thu,  2 Jul 2020 15:46:17 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     "Andrew F . Davis" <afd@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 4/6] soc: ti: omap-prm: Configure omap4 and 5 l4_abe power domain
Date:   Thu,  2 Jul 2020 08:45:11 -0700
Message-Id: <20200702154513.31859-5-tony@atomide.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702154513.31859-1-tony@atomide.com>
References: <20200702154513.31859-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Let's add omap4 and 5 l4_abe interconnect instance for the power
domain.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/soc/ti/omap_prm.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/soc/ti/omap_prm.c b/drivers/soc/ti/omap_prm.c
--- a/drivers/soc/ti/omap_prm.c
+++ b/drivers/soc/ti/omap_prm.c
@@ -95,6 +95,13 @@ struct omap_reset_data {
 
 #define PRM_ST_INTRANSITION	BIT(20)
 
+static const struct omap_prm_domain_map omap_prm_all = {
+	.usable_modes = BIT(OMAP_PRMD_ON_ACTIVE) | BIT(OMAP_PRMD_ON_INACTIVE) |
+			BIT(OMAP_PRMD_RETENTION) | BIT(OMAP_PRMD_OFF),
+	.statechange = 1,
+	.logicretstate = 1,
+};
+
 static const struct omap_prm_domain_map omap_prm_noinact = {
 	.usable_modes = BIT(OMAP_PRMD_ON_ACTIVE) | BIT(OMAP_PRMD_RETENTION) |
 			BIT(OMAP_PRMD_OFF),
@@ -102,6 +109,13 @@ static const struct omap_prm_domain_map omap_prm_noinact = {
 	.logicretstate = 1,
 };
 
+static const struct omap_prm_domain_map omap_prm_nooff = {
+	.usable_modes = BIT(OMAP_PRMD_ON_ACTIVE) | BIT(OMAP_PRMD_ON_INACTIVE) |
+			BIT(OMAP_PRMD_RETENTION),
+	.statechange = 1,
+	.logicretstate = 1,
+};
+
 static const struct omap_prm_domain_map omap_prm_onoff_noauto = {
 	.usable_modes = BIT(OMAP_PRMD_ON_ACTIVE) | BIT(OMAP_PRMD_OFF),
 	.statechange = 1,
@@ -127,6 +141,10 @@ static const struct omap_rst_map rst_map_012[] = {
 
 static const struct omap_prm_data omap4_prm_data[] = {
 	{ .name = "tesla", .base = 0x4a306400, .rstctrl = 0x10, .rstst = 0x14, .rstmap = rst_map_01 },
+	{
+		.name = "abe", .base = 0x4a306500,
+		.pwrstctrl = 0, .pwrstst = 0x4, .dmap = &omap_prm_all,
+	},
 	{ .name = "core", .base = 0x4a306700, .rstctrl = 0x210, .rstst = 0x214, .clkdm_name = "ducati", .rstmap = rst_map_012 },
 	{ .name = "ivahd", .base = 0x4a306f00, .rstctrl = 0x10, .rstst = 0x14, .rstmap = rst_map_012 },
 	{ .name = "device", .base = 0x4a307b00, .rstctrl = 0x0, .rstst = 0x4, .rstmap = rst_map_01, .flags = OMAP_PRM_HAS_RSTCTRL | OMAP_PRM_HAS_NO_CLKDM },
@@ -135,6 +153,10 @@ static const struct omap_prm_data omap4_prm_data[] = {
 
 static const struct omap_prm_data omap5_prm_data[] = {
 	{ .name = "dsp", .base = 0x4ae06400, .rstctrl = 0x10, .rstst = 0x14, .rstmap = rst_map_01 },
+	{
+		.name = "abe", .base = 0x4ae06500,
+		.pwrstctrl = 0, .pwrstst = 0x4, .dmap = &omap_prm_nooff,
+	},
 	{ .name = "core", .base = 0x4ae06700, .rstctrl = 0x210, .rstst = 0x214, .clkdm_name = "ipu", .rstmap = rst_map_012 },
 	{ .name = "iva", .base = 0x4ae07200, .rstctrl = 0x10, .rstst = 0x14, .rstmap = rst_map_012 },
 	{ .name = "device", .base = 0x4ae07c00, .rstctrl = 0x0, .rstst = 0x4, .rstmap = rst_map_01, .flags = OMAP_PRM_HAS_RSTCTRL | OMAP_PRM_HAS_NO_CLKDM },
-- 
2.27.0
