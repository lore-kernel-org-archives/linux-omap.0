Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DCDC433FE
	for <linux-omap@archiver.kernel.org>; Mon,  7 Dec 2020 13:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83AAC23436
	for <linux-omap@archiver.kernel.org>; Mon,  7 Dec 2020 13:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgLGNcg (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 7 Dec 2020 08:32:36 -0500
Received: from muru.com ([72.249.23.125]:49798 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbgLGNcg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Mon, 7 Dec 2020 08:32:36 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id B52F08057;
        Mon,  7 Dec 2020 13:32:01 +0000 (UTC)
Date:   Mon, 7 Dec 2020 15:31:50 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Tero Kristo <t-kristo@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com,
        David Shah <dave@ds0.me>
Subject: Re: [PATCH] clk: ti: omap5: Fix reboot DPLL lock failure when using
 ABE TIMERs
Message-ID: <20201207133150.GZ26857@atomide.com>
References: <1d3abe2512054866cc2ea7b2592238f4fa06502a.1607253531.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d3abe2512054866cc2ea7b2592238f4fa06502a.1607253531.git.hns@goldelico.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [201206 11:19]:
> From: David Shah <dave@ds0.me>
> 
> Having the ABE DPLL ref and bypass muxes set to different inputs was
> causing the DPLL not to lock when TIMER8 was used, as it is in the Pyra
> for the backlight.
> 
> This patch fixes this by setting abe_dpll_bypass_clk_mux to sys_32k_ck
> in omap5xxx_dt_clk_init.
> 
> A similar patch may also be needed for OMAP44xx which has similar code
> in omap4xxx_dt_clk_init, but I have not added this as I have no hardware
> to test on.

Acked-by: Tony Lindgren <tony@atomide.com>
