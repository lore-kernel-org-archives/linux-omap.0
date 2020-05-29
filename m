Return-Path: <SRS0=JveC=7L=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33940C433DF
	for <linux-omap@archiver.kernel.org>; Fri, 29 May 2020 22:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1467820776
	for <linux-omap@archiver.kernel.org>; Fri, 29 May 2020 22:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgE2WL2 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 29 May 2020 18:11:28 -0400
Received: from muru.com ([72.249.23.125]:56320 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726975AbgE2WL2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Fri, 29 May 2020 18:11:28 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 5A7778030;
        Fri, 29 May 2020 22:12:18 +0000 (UTC)
Date:   Fri, 29 May 2020 15:11:24 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        Tero Kristo <t-kristo@ti.com>, Olof Johansson <olof@lixom.net>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] ARM: omap2: fix omap5_realtime_timer_init definition
Message-ID: <20200529221124.GA37466@atomide.com>
References: <20200529220029.589078-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529220029.589078-1-arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [200529 22:01]:
> There is one more regression introduced by the last build fix:
> 
> arch/arm/mach-omap2/timer.c:170:6: error: attribute declaration must precede definition [-Werror,-Wignored-attributes]
> void __init omap5_realtime_timer_init(void)
>      ^
> arch/arm/mach-omap2/common.h:118:20: note: previous definition is here
> static inline void omap5_realtime_timer_init(void)
>                    ^
> arch/arm/mach-omap2/timer.c:170:13: error: redefinition of 'omap5_realtime_timer_init'
> void __init omap5_realtime_timer_init(void)
>             ^
> arch/arm/mach-omap2/common.h:118:20: note: previous definition is here
> static inline void omap5_realtime_timer_init(void)
> 
> As it turns out, the CONFIG_SOC_HAS_REALTIME_COUNTER option
> should never be disabled for OMAP5 as we realy on this to initialize
> the clocks and the timer. Just remove it here and make it the default.
> 
> Removing the guard around the set_cntfreq() definition, I noticed that
> this is not properly namespaced, so fix that as well.

Looks good to me, thanks for fixing it:

Acked-by: Tony Lindgren <tony@atomide.com>
