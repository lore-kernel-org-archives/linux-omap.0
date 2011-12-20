From: Ilya Yanok <yanok@emcraft.com>
Subject: [PATCH] OMAP3: clock3xxx_data: change EMAC clocks aliases
Date: Wed, 21 Dec 2011 00:27:14 +0100
Message-ID: <1324423634-32581-1-git-send-email-yanok@emcraft.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:41312 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752414Ab1LTX1S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Dec 2011 18:27:18 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: sasha_d@emcraft.com, Ilya Yanok <yanok@emcraft.com>, Paul Walmsley <paul@pwsan.com>

Rename EMAC clocks to match driver expectations: both davinci_emac and
davinci_mdio drivers call clk_get(dev, NULL) so we have to provide
("davinci_emac", NULL) and ("davinci_mdio.0", NULL) clocks instead of
("davinci_emac", "emac_clk") and ("davinci_emac", "phy_clk") resp.

CC: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Ilya Yanok <yanok@emcraft.com>
---
 arch/arm/mach-omap2/clock3xxx_data.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index d75e5f6..1a60661 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3465,8 +3465,8 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"ipss_ick",	&ipss_ick,	CK_AM35XX),
 	CLK(NULL,	"rmii_ck",	&rmii_ck,	CK_AM35XX),
 	CLK(NULL,	"pclk_ck",	&pclk_ck,	CK_AM35XX),
-	CLK("davinci_emac",	"emac_clk",	&emac_ick,	CK_AM35XX),
-	CLK("davinci_emac",	"phy_clk",	&emac_fck,	CK_AM35XX),
+	CLK("davinci_emac",	NULL,	&emac_ick,	CK_AM35XX),
+	CLK("davinci_mdio.0",	NULL,	&emac_fck,	CK_AM35XX),
 	CLK("vpfe-capture",	"master",	&vpfe_ick,	CK_AM35XX),
 	CLK("vpfe-capture",	"slave",	&vpfe_fck,	CK_AM35XX),
 	CLK("musb-am35x",	"ick",		&hsotgusb_ick_am35xx,	CK_AM35XX),
-- 
1.7.6.4

