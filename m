Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5CCC433EF
	for <linux-omap@archiver.kernel.org>; Mon, 23 May 2022 07:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbiEWHWv (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 23 May 2022 03:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiEWHWI (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Mon, 23 May 2022 03:22:08 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 05FFABE30;
        Mon, 23 May 2022 00:13:38 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id CEE0880C2;
        Mon, 23 May 2022 07:09:39 +0000 (UTC)
Date:   Mon, 23 May 2022 10:13:36 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 2/3] clocksource/drivers/timer-ti-dm: Make timer
 selectable for ARCH_K3
Message-ID: <Yos0IOkCd4R9a9YZ@atomide.com>
References: <20220408101715.43697-1-tony@atomide.com>
 <20220408101715.43697-3-tony@atomide.com>
 <156a53a2-c33b-7ec5-3584-41ef25cb9cdd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156a53a2-c33b-7ec5-3584-41ef25cb9cdd@linaro.org>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Hi,

* Daniel Lezcano <daniel.lezcano@linaro.org> [220520 15:24]:
> On 08/04/2022 12:17, Tony Lindgren wrote:
> > diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> > --- a/drivers/clocksource/Kconfig
> > +++ b/drivers/clocksource/Kconfig
> > @@ -22,7 +22,7 @@ config CLKEVT_I8253
> >   config I8253_LOCK
> >   	bool
> > -config OMAP_DM_TIMER
> > +config OMAP_DM_SYSTIMER
> >   	bool
> >   	select TIMER_OF
> > @@ -56,6 +56,12 @@ config DIGICOLOR_TIMER
> >   	help
> >   	  Enables the support for the digicolor timer driver.
> > +config OMAP_DM_TIMER
> > +	tristate "OMAP dual-mode timer driver" if ARCH_K3 || COMPILE_TEST
> 
> Actually, I missed this. Could you convert to a 'bool' there is no module in
> the timer drivers ATM.

OK sure will do.

Did you notice some loadable module usage issues for timers that are not
system timers? Just wondering if there are some issues that I did not
notice.

Regards,

Tony
