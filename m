Return-Path: <SRS0=+36Y=5C=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85F5C5ACD6
	for <linux-omap@archiver.kernel.org>; Tue, 17 Mar 2020 17:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A97F20735
	for <linux-omap@archiver.kernel.org>; Tue, 17 Mar 2020 17:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgCQRe1 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 17 Mar 2020 13:34:27 -0400
Received: from muru.com ([72.249.23.125]:60660 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgCQRe0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Tue, 17 Mar 2020 13:34:26 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 56C60810D;
        Tue, 17 Mar 2020 17:35:12 +0000 (UTC)
Date:   Tue, 17 Mar 2020 10:34:22 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Dave Gerlach <d-gerlach@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Keerthy <j-keerthy@ti.com>,
        Ladislav Michl <ladis@linux-mips.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 0/3] Block idle in gpio-omap with cpu_pm
Message-ID: <20200317173422.GN37466@atomide.com>
References: <20200304225433.37336-1-tony@atomide.com>
 <CACRpkdYL5mZ7i6bEF0b_CUXaG-jHKz4KnSXsBNfs_9M054U3vQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdYL5mZ7i6bEF0b_CUXaG-jHKz4KnSXsBNfs_9M054U3vQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Hi Linus,

* Linus Walleij <linus.walleij@linaro.org> [200309 09:27]:
> On Wed, Mar 4, 2020 at 11:54 PM Tony Lindgren <tony@atomide.com> wrote:
> 
> > As discussed earlier, here's a series to use cpu_pm to block deeper SoC
> > idle states if a gpio interrupt is pending.
> 
> As you requested I queued these on an immutable branch
> based on v5.6-rc1:
> https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git/log/?h=ib-omap-block-idle
> 
> And merged into gpio-devel for v5.7.

Hmm I'm not seeing these in Linux next yet though, care to check?

Regards,

Tony
