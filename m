Return-Path: <SRS0=JveC=7L=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A49C433DF
	for <linux-omap@archiver.kernel.org>; Fri, 29 May 2020 20:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A03C2075A
	for <linux-omap@archiver.kernel.org>; Fri, 29 May 2020 20:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgE2UoK (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 29 May 2020 16:44:10 -0400
Received: from muru.com ([72.249.23.125]:56250 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726975AbgE2UoI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Fri, 29 May 2020 16:44:08 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 5A3ED8030;
        Fri, 29 May 2020 20:44:57 +0000 (UTC)
Date:   Fri, 29 May 2020 13:44:04 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Arnd Bergmann <arnd@arndb.de>
List-Id: <soc.lore.kernel.org>
Cc:     soc@kernel.org, Olof Johansson <olof@lixom.net>,
        Stefan Agner <stefan@agner.ch>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: omap2: fix omap5_realtime_timer_init definition
Message-ID: <20200529204404.GW37466@atomide.com>
References: <20200529201701.521933-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529201701.521933-1-arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [200529 20:18]:
> There is one more regression introduced by the last build fix:

Argh.. I did run make randconfig for like 10 builds
after the last fix.

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
> Address this by removing the now obsolete #ifdefs in that file and
> just building the entire file based on the flag that controls the
> omap5_realtime_timer_init function declaration.

I think this will introduce other randconfig build failures
as SOC_HAS_REALTIME_COUNTER is bool in Kconfig.

We still need to call omap5_realtime_timer_init() even if
SOC_HAS_REALTIME_COUNTER is not set.

Regards,

Tony
