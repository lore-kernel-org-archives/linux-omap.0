Return-Path: <SRS0=9V6K=7B=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39150C433E0
	for <linux-omap@archiver.kernel.org>; Tue, 19 May 2020 16:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 195AE20756
	for <linux-omap@archiver.kernel.org>; Tue, 19 May 2020 16:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbgESQ2F (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 19 May 2020 12:28:05 -0400
Received: from muru.com ([72.249.23.125]:55086 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729118AbgESQ2F (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Tue, 19 May 2020 12:28:05 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 12A9380FA;
        Tue, 19 May 2020 16:28:55 +0000 (UTC)
Date:   Tue, 19 May 2020 09:28:02 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] clocksource/drivers/timer-ti-dm: Fix warning for set but
 not used
Message-ID: <20200519162802.GW37466@atomide.com>
References: <20200519155157.12804-1-tony@atomide.com>
 <2f67a110-e52f-94fc-fae2-c3171a67bb8a@linaro.org>
 <20200519160630.GV37466@atomide.com>
 <552325fe-e759-6b22-ceee-2d0a4b3b4b2f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <552325fe-e759-6b22-ceee-2d0a4b3b4b2f@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Daniel Lezcano <daniel.lezcano@linaro.org> [200519 16:27]:
> On 19/05/2020 18:06, Tony Lindgren wrote:
> > * Daniel Lezcano <daniel.lezcano@linaro.org> [200519 16:01]:
> >> On 19/05/2020 17:51, Tony Lindgren wrote:
> >>> We can get a warning for dmtimer_clocksource_init() with 'pa' set but
> >>> not used. This was used in the earlier revisions of the code but no
> >>> longer needed, so let's remove the unused pa and of_translate_address().
> >>> Let's also do it for dmtimer_clockevent_init() that has a similar issue.
> >>>
> >>> Reported-by: kbuild test robot <lkp@intel.com>
> >>> Signed-off-by: Tony Lindgren <tony@atomide.com>
> >>> ---
> >>
> >> Applied, thanks
> > 
> > Thanks! Do you already have some immutable commit I can use
> > as the base for the SoC and dts changes? Or do you want to
> > wait a bit for that?
> 
> Hi Tony,
> 
> https://git.linaro.org/people/daniel.lezcano/linux.git/log/?h=timers/drivers/timer-ti
> 
> it contains the two patches + the warning fix

OK thanks a lot! Will use that as the base then.

Regards,

Tony
