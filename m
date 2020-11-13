Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7F4C388F7
	for <linux-omap@archiver.kernel.org>; Fri, 13 Nov 2020 13:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 622792223C
	for <linux-omap@archiver.kernel.org>; Fri, 13 Nov 2020 13:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgKMNM4 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 13 Nov 2020 08:12:56 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7538 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgKMNM4 (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Fri, 13 Nov 2020 08:12:56 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CXf5Z64R4zhbfr;
        Fri, 13 Nov 2020 21:12:34 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Fri, 13 Nov 2020
 21:12:39 +0800
From:   Zhang Qilong <zhangqilong3@huawei.com>
To:     <t-kristo@ti.com>, <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <linux-omap@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: [PATCH] clk: ti: Fix memleak in ti_fapll_synth_setup
Date:   Fri, 13 Nov 2020 21:16:23 +0800
Message-ID: <20201113131623.2098222-1-zhangqilong3@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

If clk_register fails, we should goto free branch
before function returns to prevent memleak.

Fixes: 163152cbbe321 ("clk: ti: Add support for FAPLL on dm816x")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
---
 drivers/clk/ti/fapll.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/ti/fapll.c b/drivers/clk/ti/fapll.c
index 95e36ba64acc..8024c6d2b9e9 100644
--- a/drivers/clk/ti/fapll.c
+++ b/drivers/clk/ti/fapll.c
@@ -498,6 +498,7 @@ static struct clk * __init ti_fapll_synth_setup(struct fapll_data *fd,
 {
 	struct clk_init_data *init;
 	struct fapll_synth *synth;
+	struct clk *clk = ERR_PTR(-ENOMEM);
 
 	init = kzalloc(sizeof(*init), GFP_KERNEL);
 	if (!init)
@@ -520,13 +521,19 @@ static struct clk * __init ti_fapll_synth_setup(struct fapll_data *fd,
 	synth->hw.init = init;
 	synth->clk_pll = pll_clk;
 
-	return clk_register(NULL, &synth->hw);
+	clk = clk_register(NULL, &synth->hw);
+	if (IS_ERR(clk)) {
+		pr_err("failed to register clock\n");
+		goto free;
+	}
+
+	return clk;
 
 free:
 	kfree(synth);
 	kfree(init);
 
-	return ERR_PTR(-ENOMEM);
+	return clk;
 }
 
 static void __init ti_fapll_setup(struct device_node *node)
-- 
2.25.4

