Return-Path: <SRS0=J+Ql=EC=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F251C55178
	for <linux-omap@archiver.kernel.org>; Tue, 27 Oct 2020 00:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2DBD2151B
	for <linux-omap@archiver.kernel.org>; Tue, 27 Oct 2020 00:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603756879;
	bh=PYSup8cJDclLG37QWwdOKGOB4WRiilxqiT29AB8MppQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mkWzIESKr9obSD9eMrhm+VmSCrsV+quG1AeQXiZWBIIbkw5wuDqkt8NJ1knDR+6Vn
	 b4xG7u45VMAKo+7LjHwY+R3Y+PVWlX1/ncOnuGgK1+IGCQ2Gq2vCEDJispPN7V3YDg
	 Ct8b0nq4uGTtRNAWuUvLtdl81J01eKYyu/GbF4AA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437312AbgJ0ABS (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 26 Oct 2020 20:01:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:36320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411148AbgJZX43 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Mon, 26 Oct 2020 19:56:29 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D29F820770;
        Mon, 26 Oct 2020 23:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603756588;
        bh=PYSup8cJDclLG37QWwdOKGOB4WRiilxqiT29AB8MppQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZDvBsAlfU1tmDtgGXAA3Eju5Oe32xLJv1b97EcoM65oGKyLjm8n/7dk5Ac4kY/ObU
         +KLrOXbGT8zdacB9/t8Ev1cpFHBvEnjqTMbkE193rEn8sI2rdUOYvnsBHG8izWZsS/
         MYE1h0jtfXolSFc8SatpbY5dZgt+UTYJD4eagFdI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tero Kristo <t-kristo@ti.com>, Dan Murphy <dmurphy@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 60/80] clk: ti: clockdomain: fix static checker warning
Date:   Mon, 26 Oct 2020 19:54:56 -0400
Message-Id: <20201026235516.1025100-60-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201026235516.1025100-1-sashal@kernel.org>
References: <20201026235516.1025100-1-sashal@kernel.org>
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
index 423a99b9f10c7..8d0dea188a284 100644
--- a/drivers/clk/ti/clockdomain.c
+++ b/drivers/clk/ti/clockdomain.c
@@ -146,10 +146,12 @@ static void __init of_ti_clockdomain_setup(struct device_node *node)
 		if (!omap2_clk_is_hw_omap(clk_hw)) {
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

