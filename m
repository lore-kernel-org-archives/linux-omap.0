Return-Path: <SRS0=olK2=BH=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B264C433E0
	for <linux-omap@archiver.kernel.org>; Tue, 28 Jul 2020 08:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20CC5206D7
	for <linux-omap@archiver.kernel.org>; Tue, 28 Jul 2020 08:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbgG1Ims (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 28 Jul 2020 04:42:48 -0400
Received: from muru.com ([72.249.23.125]:38306 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727950AbgG1Ims (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Tue, 28 Jul 2020 04:42:48 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id EE86B8105;
        Tue, 28 Jul 2020 08:42:46 +0000 (UTC)
Date:   Tue, 28 Jul 2020 01:42:57 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     David Shah <dave@ds0.me>
Cc:     Linux-OMAP <linux-omap@vger.kernel.org>,
        Tero Kristo <t-kristo@ti.com>
Subject: Re: Understanding OMAP5 DPLL_ABE and CM_CLKSEL_WKUPAON
Message-ID: <20200728084257.GF2811@atomide.com>
References: <c077ece056713ad120b3d2fd59916aab1248cd1c.camel@ds0.me>
 <20200727082833.GB2811@atomide.com>
 <ac19052a552660c86838709f071cffe0f3e65932.camel@ds0.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac19052a552660c86838709f071cffe0f3e65932.camel@ds0.me>
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* David Shah <dave@ds0.me> [200727 08:58]:
> On Mon, 2020-07-27 at 01:28 -0700, Tony Lindgren wrote:
> > If it only needs to be configured to 1 for reboot, sounds like it
> > should
> > be set in omap44xx_restart(). And we should also set it to 1 for
> > omap4
> > too.
> 
> omap44xx_restart doesn't seem like the right place to me, as the bug
> also affects hard resets (i.e. NRESWARM assertion) and it would be nice
> to have these working, too.

Ah right, the device reboots fine, but the rebooted kernel
won't initialize properly.

> Would a better solution be to set it early during startup (the first
> part of clock init), and then clear it when the DPLLs are set up and
> locked?

Yes sounds like then the place to configure this is in the
drivers/clk/ti/clk-54xx.c omap5xxx_dt_clk_init(). Maybe add
a comment to the patch description that a similar patch may
be also needed for omap4 on some devices.

Regards,

Tony
