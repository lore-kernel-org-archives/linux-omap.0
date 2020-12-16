Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC0AC0018C
	for <linux-omap@archiver.kernel.org>; Wed, 16 Dec 2020 13:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0451C2339F
	for <linux-omap@archiver.kernel.org>; Wed, 16 Dec 2020 13:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725825AbgLPNGK (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 16 Dec 2020 08:06:10 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9213 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725274AbgLPNGK (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Wed, 16 Dec 2020 08:06:10 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CwwM91DJkzkqWN;
        Wed, 16 Dec 2020 21:04:37 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Wed, 16 Dec 2020 21:05:02 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <t-kristo@ti.com>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] ti/fapll: Delete useless kfree code
Date:   Wed, 16 Dec 2020 21:05:34 +0800
Message-ID: <20201216130534.13925-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

The parameter of kfree function is NULL, so kfree code is useless, delete it.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/clk/ti/fapll.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/ti/fapll.c b/drivers/clk/ti/fapll.c
index 95e36ba64acc..a61d69159e9a 100644
--- a/drivers/clk/ti/fapll.c
+++ b/drivers/clk/ti/fapll.c
@@ -523,7 +523,6 @@ static struct clk * __init ti_fapll_synth_setup(struct fapll_data *fd,
 	return clk_register(NULL, &synth->hw);
 
 free:
-	kfree(synth);
 	kfree(init);
 
 	return ERR_PTR(-ENOMEM);
-- 
2.22.0

