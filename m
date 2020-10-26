Return-Path: <SRS0=mtBc=EB=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614B7C5DF9D
	for <linux-omap@archiver.kernel.org>; Mon, 26 Oct 2020 11:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 195E322263
	for <linux-omap@archiver.kernel.org>; Mon, 26 Oct 2020 11:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1773123AbgJZLLF (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 26 Oct 2020 07:11:05 -0400
Received: from muru.com ([72.249.23.125]:46510 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1773120AbgJZLLE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Mon, 26 Oct 2020 07:11:04 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 35B8380AA;
        Mon, 26 Oct 2020 11:11:06 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     "Andrew F . Davis" <afd@ti.com>, Dave Gerlach <d-gerlach@ti.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Roger Quadros <rogerq@ti.com>, Suman Anna <s-anna@ti.com>,
        Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
Subject: [PATCH 2/9] ARM: OMAP2+: Probe PRCM first to probe l4_wkup with simple-pm-bus
Date:   Mon, 26 Oct 2020 13:10:42 +0200
Message-Id: <20201026111049.54835-3-tony@atomide.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201026111049.54835-1-tony@atomide.com>
References: <20201026111049.54835-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

In preparation for probing the interconnects with simple-pm-bus to
make use of genpd, we need to probe the always-on PRCM first for the
clocks needed by l4_wkup instance.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/pdata-quirks.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -580,6 +580,8 @@ static void pdata_quirks_check(struct pdata_init *quirks)
 
 void __init pdata_quirks_init(const struct of_device_id *omap_dt_match_table)
 {
+	struct device_node *np;
+
 	/*
 	 * We still need this for omap2420 and omap3 PM to work, others are
 	 * using drivers/misc/sram.c already.
@@ -591,6 +593,15 @@ void __init pdata_quirks_init(const struct of_device_id *omap_dt_match_table)
 	if (of_machine_is_compatible("ti,omap3"))
 		omap3_mcbsp_init();
 	pdata_quirks_check(auxdata_quirks);
+
+	/* Populate always-on PRCM in l4_wkup to probe l4_wkup */
+	np = of_find_node_by_name(NULL, "prcm");
+	if (!np)
+		np = of_find_node_by_name(NULL, "prm");
+	if (np)
+		of_platform_populate(np, omap_dt_match_table,
+				     omap_auxdata_lookup, NULL);
+
 	of_platform_populate(NULL, omap_dt_match_table,
 			     omap_auxdata_lookup, NULL);
 	pdata_quirks_check(pdata_quirks);
-- 
2.29.1
