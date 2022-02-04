Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C691C433FE
	for <linux-omap@archiver.kernel.org>; Fri,  4 Feb 2022 07:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348653AbiBDHO7 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 4 Feb 2022 02:14:59 -0500
Received: from muru.com ([72.249.23.125]:46246 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348584AbiBDHO6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Fri, 4 Feb 2022 02:14:58 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id D404C8171;
        Fri,  4 Feb 2022 07:14:40 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-clk@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org
Subject: [PATCH 1/8] clk: ti: Constify clkctrl_name
Date:   Fri,  4 Feb 2022 09:14:42 +0200
Message-Id: <20220204071449.16762-2-tony@atomide.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220204071449.16762-1-tony@atomide.com>
References: <20220204071449.16762-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

We can constify clkctrl_name in preparation for making use of the
clock-output-names property.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/clk/ti/clkctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/ti/clkctrl.c b/drivers/clk/ti/clkctrl.c
--- a/drivers/clk/ti/clkctrl.c
+++ b/drivers/clk/ti/clkctrl.c
@@ -505,7 +505,7 @@ static void __init _ti_omap4_clkctrl_setup(struct device_node *node)
 	struct omap_clkctrl_clk *clkctrl_clk = NULL;
 	const __be32 *addrp;
 	bool legacy_naming;
-	char *clkctrl_name;
+	const char *clkctrl_name;
 	u32 addr;
 	int ret;
 	char *c;
-- 
2.35.1
