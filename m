Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D133C433B4
	for <linux-omap@archiver.kernel.org>; Fri,  7 May 2021 09:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE31261432
	for <linux-omap@archiver.kernel.org>; Fri,  7 May 2021 09:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236728AbhEGJgZ (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 7 May 2021 05:36:25 -0400
Received: from muru.com ([72.249.23.125]:52700 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236325AbhEGJgT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Fri, 7 May 2021 05:36:19 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 1FE2480E0;
        Fri,  7 May 2021 09:35:17 +0000 (UTC)
Date:   Fri, 7 May 2021 12:35:12 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkft-triage@lists.linaro.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        regressions@lists.linux.dev,
        Benoit Cousson <bcousson@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: #regzb introduced: 98feab31ac49 ("ARM: OMAP2+: Drop legacy
 platform data for dra7 sata")
Message-ID: <YJUJ0AMAWvNMaCRu@atomide.com>
References: <CA+G9fYtTN6ug3eBAW3wMcDeESUo+ebj7L5HBe5_fj4uqDExFQg@mail.gmail.com>
 <YJPYvsdkfx4JD4vT@atomide.com>
 <CA+G9fYv48aJ6tmSaf_HtRKHse4yN40hEYSPR5=A3W6HRoJ8p_g@mail.gmail.com>
 <YJTz+D9Sp8Eyp+iw@atomide.com>
 <e896704c-c13a-739d-0723-22fec35406ed@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e896704c-c13a-739d-0723-22fec35406ed@leemhuis.info>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Thorsten Leemhuis <linux@leemhuis.info> [210507 08:27]:
> Great to see that this is about to be fixed. And Naresh, many thx for
> giving the #regzb tag a try, even if regzbot (shameless plug for the
> unaware: https://linux-regtracking.leemhuis.info/post/regzbot-approach/
> ) is not up and running already, much appreciated!

Hmm so the link above does not show where to git clone the regzb program
from? Or is that not yet published? Just wondering.

Regards,

Tony
