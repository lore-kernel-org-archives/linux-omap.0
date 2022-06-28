Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DBEC433EF
	for <linux-omap@archiver.kernel.org>; Tue, 28 Jun 2022 05:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244701AbiF1FWM (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 28 Jun 2022 01:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244978AbiF1FVr (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 28 Jun 2022 01:21:47 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 00E1F286C2;
        Mon, 27 Jun 2022 22:20:26 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 8F5CD8106;
        Tue, 28 Jun 2022 05:15:14 +0000 (UTC)
Date:   Tue, 28 Jun 2022 08:20:25 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Tero Kristo <kristo@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: ti: dra7-atl: Fix reference leak in
 of_dra7_atl_clk_probe
Message-ID: <YrqPmS/cvTbrXz9P@atomide.com>
References: <20220602030838.52057-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602030838.52057-1-linmq006@gmail.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Miaoqian Lin <linmq006@gmail.com> [220602 06:04]:
> pm_runtime_get_sync() will increment pm usage counter.
> Forgetting to putting operation will result in reference leak.
> Add missing pm_runtime_put_sync in some error paths.
> 
> Fixes: 9ac33b0ce81f ("CLK: TI: Driver for DRA7 ATL (Audio Tracking Logic)")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Reviewed-by: Tony Lindgren <tony@atomide.com>
