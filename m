Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F99C433DB
	for <linux-omap@archiver.kernel.org>; Fri, 15 Jan 2021 09:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFDC5233CF
	for <linux-omap@archiver.kernel.org>; Fri, 15 Jan 2021 09:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbhAOJIL (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 15 Jan 2021 04:08:11 -0500
Received: from muru.com ([72.249.23.125]:44966 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbhAOJIL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Fri, 15 Jan 2021 04:08:11 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 99B57805C;
        Fri, 15 Jan 2021 09:07:31 +0000 (UTC)
Date:   Fri, 15 Jan 2021 11:07:26 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "open list:TI ETHERNET SWITCH DRIVER (CPSW)" 
        <linux-omap@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH] ARM: OMAP2+: Fix booting for am335x after moving to
 simple-pm-bus
Message-ID: <YAFbTosSwKpHDwkg@atomide.com>
References: <20210115082936.44923-1-tony@atomide.com>
 <CAMuHMdUtdMQwwP+k86mzavQVAq8EAHwwoOFM_yqT6zY7Mz-jOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUtdMQwwP+k86mzavQVAq8EAHwwoOFM_yqT6zY7Mz-jOw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Geert Uytterhoeven <geert@linux-m68k.org> [210115 08:59]:
> On Fri, Jan 15, 2021 at 9:29 AM Tony Lindgren <tony@atomide.com> wrote:
> > --- a/arch/arm/mach-omap2/Kconfig
> > +++ b/arch/arm/mach-omap2/Kconfig
> > @@ -105,8 +105,10 @@ config ARCH_OMAP2PLUS
> >         select OMAP_DM_TIMER
> >         select OMAP_GPMC
> >         select PINCTRL
> > +       select PM
> >         select PM_GENERIC_DOMAINS if PM
> >         select PM_GENERIC_DOMAINS_OF if PM
> > +       select SIMPLE_PM_BUS if OF && PM
> 
> PM is selected above, so those 3 dependencies on PM can be removed.
> ARCH_OMAP2PLUS depends on ARCH_MULTIPLATFORM, which
> selects USE_OF and thus OF?

Yeah OK I'll drop those. And fix the sorting issue I noticed for Kconfig :)

Regards,

Tony
