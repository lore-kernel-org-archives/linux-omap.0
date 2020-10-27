Return-Path: <SRS0=J+Ql=EC=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221A8C55178
	for <linux-omap@archiver.kernel.org>; Tue, 27 Oct 2020 00:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D91DE20754
	for <linux-omap@archiver.kernel.org>; Tue, 27 Oct 2020 00:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603757623;
	bh=j9POj2r1nX6u9tvx+5LnA8GUke9H/R2gsqq2IPVpf7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zHB/87RZRbiD5dX5HRudXIF3jNHmkwc2arP6cKwS4KwAaPQCMBB8ncaMx6EmLtBnb
	 zCK5LL07LhX6EIAgeedPF2K0ZSJa5OGIYrYMNXh02LxgaIJFHrn36Doyz1xuJ0deJ1
	 +oU/9KkI6/uWdmx2tqIw4kj7ibVM1UWmhjzscwfk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439471AbgJ0ANf (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 26 Oct 2020 20:13:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:33668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411798AbgJ0ALp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Mon, 26 Oct 2020 20:11:45 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C3B720754;
        Tue, 27 Oct 2020 00:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603757504;
        bh=j9POj2r1nX6u9tvx+5LnA8GUke9H/R2gsqq2IPVpf7k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fZA8Tx7URoWced5EoMyr8fMwxqQ3gizlDmaqZ3lDtTL10IXJZumMSOnitQgUv3vJY
         Vq8nrPcgn+EqtomnqYgc6TMOdM9Uc3tDsmDfk+Kzjb3c0jJIm6JkqR8v+7rDZ1Ay81
         GJ4DEj7BLZX9iXBfhnFyJPtFDTGqP11HBx39YiIA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tero Kristo <t-kristo@ti.com>, Dan Murphy <dmurphy@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 17/25] clk: ti: clockdomain: fix static checker warning
Date:   Mon, 26 Oct 2020 20:11:15 -0400
Message-Id: <20201027001123.1027642-17-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201027001123.1027642-1-sashal@kernel.org>
References: <20201027001123.1027642-1-sashal@kernel.org>
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
index b9bc3b8df659d..4fde9767392e3 100644
--- a/drivers/clk/ti/clockdomain.c
+++ b/drivers/clk/ti/clockdomain.c
@@ -124,10 +124,12 @@ static void __init of_ti_clockdomain_setup(struct device_node *node)
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

