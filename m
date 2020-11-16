Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B3BC55ABD
	for <linux-omap@archiver.kernel.org>; Mon, 16 Nov 2020 09:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB3BC2067C
	for <linux-omap@archiver.kernel.org>; Mon, 16 Nov 2020 09:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgKPJAi (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 16 Nov 2020 04:00:38 -0500
Received: from muru.com ([72.249.23.125]:48366 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726849AbgKPJAh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Mon, 16 Nov 2020 04:00:37 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id F2CD680C8;
        Mon, 16 Nov 2020 09:00:42 +0000 (UTC)
Date:   Mon, 16 Nov 2020 11:00:33 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Zhang Qilong <zhangqilong3@huawei.com>
Cc:     t-kristo@ti.com, mturquette@baylibre.com, sboyd@kernel.org,
        linux-omap@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH] clk: ti: Fix memleak in ti_fapll_synth_setup
Message-ID: <20201116090033.GA26857@atomide.com>
References: <20201113131623.2098222-1-zhangqilong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113131623.2098222-1-zhangqilong3@huawei.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Zhang Qilong <zhangqilong3@huawei.com> [201113 13:13]:
> If clk_register fails, we should goto free branch
> before function returns to prevent memleak.
> 
> Fixes: 163152cbbe321 ("clk: ti: Add support for FAPLL on dm816x")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>

Acked-by: Tony Lindgren <tony@atomide.com>
