Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC10C3814E
	for <linux-omap@archiver.kernel.org>; Tue, 23 Aug 2022 16:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243985AbiHWQCg (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 23 Aug 2022 12:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244282AbiHWQAm (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 23 Aug 2022 12:00:42 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 269EE23DF38;
        Tue, 23 Aug 2022 05:12:14 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 8690C8125;
        Tue, 23 Aug 2022 11:45:41 +0000 (UTC)
Date:   Tue, 23 Aug 2022 14:52:47 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Romain Naour <romain.naour@smile.fr>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: ti: Fix reference imbalance in
 ti_find_clock_provider
Message-ID: <YwS/j5ATAfCb1U4l@atomide.com>
References: <63d9211f-d5ce-562e-358a-50f26c7caf35@siemens.com>
 <20220819212337.AECB9C433D6@smtp.kernel.org>
 <c62649f0-2be1-459c-bfa5-4c94a3e4300f@smile.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c62649f0-2be1-459c-bfa5-4c94a3e4300f@smile.fr>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Romain Naour <romain.naour@smile.fr> [220823 09:22]:
> Hello,
> 
> Le 19/08/2022 à 23:23, Stephen Boyd a écrit :
> > Quoting Jan Kiszka (2022-08-08 15:26:58)
> >> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>
> >> When a clock is found via clock-output-names, we need to reference it
> >> explicitly to match of_find_node_by_name behavior. Failing to do so
> >> causes warnings like this:
> >>
> > 
> > Is this superseeded by
> > https://lore.kernel.org/r/20220621091118.33930-1-tony@atomide.com?
> 
> I noticed the same issue and tested separately with both patches.
> 
> Indeed, this patch is not needed anymore with "[PATCH] clk: ti: Fix missing
> of_node_get() ti_find_clock_provider()" applied.

OK good to hear and thanks for testing.

Regards,

Tony
