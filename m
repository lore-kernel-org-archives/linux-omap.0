Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75122C4332F
	for <linux-omap@archiver.kernel.org>; Thu,  9 Dec 2021 07:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbhLIHr0 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 9 Dec 2021 02:47:26 -0500
Received: from muru.com ([72.249.23.125]:36400 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230154AbhLIHr0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Thu, 9 Dec 2021 02:47:26 -0500
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 4D12F80A3;
        Thu,  9 Dec 2021 07:44:34 +0000 (UTC)
Date:   Thu, 9 Dec 2021 09:43:51 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Colin Ian King <colin.i.king@googlemail.com>
Cc:     Tero Kristo <kristo@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk/ti/adpll: Make const pointer error a static const
 array
Message-ID: <YbGzt03LZfOzAZcH@atomide.com>
References: <20211127173036.150535-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211127173036.150535-1-colin.i.king@gmail.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Colin Ian King <colin.i.king@googlemail.com> [211127 19:33]:
> Make const pointer error a static const array, removes a dereference
> and shrinks object code a little.

Acked-by: Tony Lindgren <tony@atomide.com>
