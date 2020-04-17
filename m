Return-Path: <SRS0=+Rou=6B=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541C6C38A2D
	for <linux-omap@archiver.kernel.org>; Fri, 17 Apr 2020 16:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CFEE2223F
	for <linux-omap@archiver.kernel.org>; Fri, 17 Apr 2020 16:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgDQQzl (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 17 Apr 2020 12:55:41 -0400
Received: from muru.com ([72.249.23.125]:50050 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728020AbgDQQzl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Fri, 17 Apr 2020 12:55:41 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id BF0B08047;
        Fri, 17 Apr 2020 16:56:27 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Tero Kristo <t-kristo@ti.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Adam Ford <aford173@gmail.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Keerthy <j-keerthy@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/14] clk: ti: dm816: enable sysclk6_ck on init
Date:   Fri, 17 Apr 2020 09:55:08 -0700
Message-Id: <20200417165519.4979-4-tony@atomide.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200417165519.4979-1-tony@atomide.com>
References: <20200417165519.4979-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

We need sysclk6_ck enabled early as it is needed by l4_ls and system
timers early on boot. This removes the dependency of system timers to
the interconnect related code that can be then probed later on when
suitable at module_init time.

Cc: linux-clk@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/clk/ti/clk-816x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/ti/clk-816x.c b/drivers/clk/ti/clk-816x.c
--- a/drivers/clk/ti/clk-816x.c
+++ b/drivers/clk/ti/clk-816x.c
@@ -73,6 +73,7 @@ static const char *enable_init_clks[] = {
 	"ddr_pll_clk1",
 	"ddr_pll_clk2",
 	"ddr_pll_clk3",
+	"sysclk6_ck",
 };
 
 int __init dm816x_dt_clk_init(void)
-- 
2.26.1
