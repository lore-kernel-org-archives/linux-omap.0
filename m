Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CC1C433DB
	for <linux-omap@archiver.kernel.org>; Wed, 31 Mar 2021 05:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A91D8619CF
	for <linux-omap@archiver.kernel.org>; Wed, 31 Mar 2021 05:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbhCaFvX (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 31 Mar 2021 01:51:23 -0400
Received: from muru.com ([72.249.23.125]:49042 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231315AbhCaFvK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Wed, 31 Mar 2021 01:51:10 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id C5FAA80C3;
        Wed, 31 Mar 2021 05:52:10 +0000 (UTC)
Date:   Wed, 31 Mar 2021 08:51:04 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Dario Binacchi <dariobin@libero.it>, linux-kernel@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Lee Jones <lee.jones@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH v3 0/4] clk: ti: add am33xx spread spectrum clock support
Message-ID: <YGQNyGDkAbUXRYtA@atomide.com>
References: <20210329164222.26794-1-dariobin@libero.it>
 <161707108197.3012082.13148389244272034996@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <161707108197.3012082.13148389244272034996@swboyd.mtv.corp.google.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Stephen Boyd <sboyd@kernel.org> [210330 02:25]:
> Quoting Dario Binacchi (2021-03-29 09:42:17)
> > 
> > As reported by the TI spruh73x RM, MPU and LCD modules support spread
> > spectrum clocking (SSC) on their output clocks. SSC is used to spread
> > the spectral peaking of the clock to reduce any electromagnetic
> > interference (EMI) that may be caused due to the clock’s fundamental
> > or any of its harmonics.
> > The series allows you to enable and adjust the spread spectrum clocking
> > for all am33xx PLLs for which it is supported.
> > 
> 
> What is your merge strategy? Should all the patches go through clk tree?
> Or you'll send via arm-soc?

Probably best to just merge all via the clk tree as that's where most of
the changes are.

Regards,

Tony
