Return-Path: <SRS0=J+Ql=EC=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A75AC64E69
	for <linux-omap@archiver.kernel.org>; Tue, 27 Oct 2020 00:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E06E52151B
	for <linux-omap@archiver.kernel.org>; Tue, 27 Oct 2020 00:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603757749;
	bh=XybQFfIDHZ//jyCK9OkTtlBQWlpQPKQezx0o3w3QdeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QfVyvMgWPgRNCHfdRSl+LE7JzHu5h7dC1nEYDCKihUHZWphOIxbJVC1k6DAoG+TrF
	 M5ielp7dgBTpPPCciY8IgnP3pM0CqB57c5EoB0Y4OAA+gllAgI2HU9GrgUsnSrT6ad
	 0s1PLDHAQMQ0rZEvrti4dIq1agmjs2cczTYqtBtU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391853AbgJ0AK1 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 26 Oct 2020 20:10:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:59378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394807AbgJ0AK0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Mon, 26 Oct 2020 20:10:26 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E51E4217A0;
        Tue, 27 Oct 2020 00:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603757425;
        bh=XybQFfIDHZ//jyCK9OkTtlBQWlpQPKQezx0o3w3QdeA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hZKbbZAueJHXZ7LjzFkV+nfm7bwqpbET884PjiKpb/l5NvWr3P9oA8M0goHufEj8O
         WuO9wPqIZ7+ai0qrWw83Udb/l8DRC6snFIFqR9D9Z8XCRMM+Wraqr6J4I/jVYL/b4a
         kEUatEQKJK92i1nEY8GtQn5ynGua1QTsnitlklwY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tero Kristo <t-kristo@ti.com>, Dan Murphy <dmurphy@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 33/46] clk: ti: clockdomain: fix static checker warning
Date:   Mon, 26 Oct 2020 20:09:32 -0400
Message-Id: <20201027000946.1026923-33-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201027000946.1026923-1-sashal@kernel.org>
References: <20201027000946.1026923-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

From: Tero Kristo <t-kristo@ti.com>

[ Upstream commit b7a7943fe291b983b104bcbd2f16e8e896f56590 ]

Fix a memory leak induced by not calling clk_put after doing of_clk_get.

Reported-by: Dan Murphy <dmurphy@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
Link: https://lore.kernel.org/r/20200907082600.454-3-t-kristo@ti.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/ti/clockdomain.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/ti/clockdomain.c b/drivers/clk/ti/clockdomain.c
index 07a805125e98c..11d92311e162f 100644
--- a/drivers/clk/ti/clockdomain.c
+++ b/drivers/clk/ti/clockdomain.c
@@ -146,10 +146,12 @@ static void __init of_ti_clockdomain_setup(struct device_node *node)
 		if (clk_hw_get_flags(clk_hw) & CLK_IS_BASIC) {
 			pr_warn("can't setup clkdm for basic clk %s\n",
 				__clk_get_name(clk));
+			clk_put(clk);
 			continue;
 		}
 		to_clk_hw_omap(clk_hw)->clkdm_name = clkdm_name;
 		omap2_init_clk_clkdm(clk_hw);
+		clk_put(clk);
 	}
 }
 
-- 
2.25.1

