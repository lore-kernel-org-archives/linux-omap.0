Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6913CC4742C
	for <linux-omap@archiver.kernel.org>; Tue, 10 Nov 2020 12:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BA0420781
	for <linux-omap@archiver.kernel.org>; Tue, 10 Nov 2020 12:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730069AbgKJMRW (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 10 Nov 2020 07:17:22 -0500
Received: from muru.com ([72.249.23.125]:47854 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726706AbgKJMRW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Tue, 10 Nov 2020 07:17:22 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id D862A80BA;
        Tue, 10 Nov 2020 12:17:27 +0000 (UTC)
Date:   Tue, 10 Nov 2020 14:17:18 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: am437x-l4: fix compatible for cpsw switch dt
 node
Message-ID: <20201110121718.GF26857@atomide.com>
References: <20201001192023.6606-1-grygorii.strashko@ti.com>
 <d6dea06f-76f5-a29e-d4e3-eb0e65f29e9d@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6dea06f-76f5-a29e-d4e3-eb0e65f29e9d@ti.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko@ti.com> [201029 19:13]:
> Hi Tony,
> 
> On 01/10/2020 22:20, Grygorii Strashko wrote:
> > Fix compatible the new CPSW switchdev DT node to avoid probing of legacy
> > CPSW driver which fails:
> > [    2.781009] cpsw 4a100000.switch: invalid resource
> > 
> > Fixes: 7bf8f37aea82 ("ARM: dts: am437x-l4: add dt node for new cpsw switchdev driver")
> > Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> > ---
> > Hi Tony,
> > 
> > This is follow up patch for series [1], not critical.
> > [1] https://lore.kernel.org/patchwork/cover/1304085/
> 
> Could this be merged?

Sorry for the delay, applying into fixes.

Thanks,

Tony
