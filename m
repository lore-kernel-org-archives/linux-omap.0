Return-Path: <SRS0=LAuK=77=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC3CC433DF
	for <linux-omap@archiver.kernel.org>; Thu, 18 Jun 2020 02:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1369A214DB
	for <linux-omap@archiver.kernel.org>; Thu, 18 Jun 2020 02:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592445683;
	bh=gEt8NogzQywn3uywtnxX7bgCdgWhFora7R/87tWIrwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iOonu1q6m56aUuK9Q1uok5Zf+VjA7ZnxtFbELsDfRRhP7qh2ThvQU4nsxf2DQ2Nma
	 aidq3t5Q8z1t59IENHPrdta0zVo4/0LUnqzYKjvEoFkbKQLL8g4msyQ8iABjXqKgqq
	 fb6x/67KJWFdzRY0bBaEKQNVhxRqaYcu0yy4qfQU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387445AbgFRCA6 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:00:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:58524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731142AbgFRBYL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Wed, 17 Jun 2020 21:24:11 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 564EC221F0;
        Thu, 18 Jun 2020 01:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443451;
        bh=gEt8NogzQywn3uywtnxX7bgCdgWhFora7R/87tWIrwc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O/CwJy9YMvh09BF6bdYiUDCp5Qr5LnJ4lyVLg3p536LhWZnbDvu70aM/ZhyFs6iig
         mHUqRjUD5jgKSrCi6PQc/Ogwr0GEKqTdEtMGVeBxx0s4lljmehADD6Y8CMK+8BSD23
         tm8va08v/hsuBukxSJkTxUwkX03bkxmS8wNtkbXo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tero Kristo <t-kristo@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 086/172] clk: ti: composite: fix memory leak
Date:   Wed, 17 Jun 2020 21:20:52 -0400
Message-Id: <20200618012218.607130-86-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618012218.607130-1-sashal@kernel.org>
References: <20200618012218.607130-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

From: Tero Kristo <t-kristo@ti.com>

[ Upstream commit c7c1cbbc9217ebb5601b88d138d4a5358548de9d ]

The parent_names is never released for a component clock definition,
causing some memory leak. Fix by releasing it once it is no longer
needed.

Reported-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
Link: https://lkml.kernel.org/r/20200429131341.4697-2-t-kristo@ti.com
Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/ti/composite.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/ti/composite.c b/drivers/clk/ti/composite.c
index 030e8b2c1050..c6478d0b996b 100644
--- a/drivers/clk/ti/composite.c
+++ b/drivers/clk/ti/composite.c
@@ -196,6 +196,7 @@ static void __init _register_composite(void *user,
 		if (!cclk->comp_clks[i])
 			continue;
 		list_del(&cclk->comp_clks[i]->link);
+		kfree(cclk->comp_clks[i]->parent_names);
 		kfree(cclk->comp_clks[i]);
 	}
 
-- 
2.25.1

