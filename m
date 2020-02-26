Return-Path: <SRS0=PuJa=4O=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A71C4BA13
	for <linux-omap@archiver.kernel.org>; Wed, 26 Feb 2020 16:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2B8C2467B
	for <linux-omap@archiver.kernel.org>; Wed, 26 Feb 2020 16:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbgBZQQG (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 26 Feb 2020 11:16:06 -0500
Received: from muru.com ([72.249.23.125]:57718 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728734AbgBZQQG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Wed, 26 Feb 2020 11:16:06 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 08CCD8022;
        Wed, 26 Feb 2020 16:16:49 +0000 (UTC)
Date:   Wed, 26 Feb 2020 08:16:02 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Suman Anna <s-anna@ti.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tero Kristo <t-kristo@ti.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Keerthy <j-keerthy@ti.com>,
        Ladislav Michl <ladis@linux-mips.org>,
        Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] clocksource: timer-ti-dm: Drop bogus
 omap_dm_timer_of_set_source()
Message-ID: <20200226161602.GO37466@atomide.com>
References: <20200213053504.22638-1-s-anna@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213053504.22638-1-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Suman Anna <s-anna@ti.com> [200212 21:36]:
> Hi Tony,
> 
> Do you have the history of why the 32 KHz source is set as parent during
> prepare? One of the current side-affects of this patch is that now instead
> of bailing out, the 32 KHz source is set, and consumers will still need
> to select their appropriate parent. Dropping that call should actually
> allow us to select the parents in the consumer nodes in dts files using
> the assigned-clocks and assigned-clock-parents properties. I prefer to
> drop it if you do not foresee any issues. For now, I do not anticipate
> any issues with omap-pwm-dmtimer with this patch.

Using the 32 KiHz source works better for PM. But yeah the
machine specific source clock should be configured with
assigned-clocks and assigned-clock-parents properites.

Things seem to behave just fine for me with this patch for both
pwm-leds and PM. Good to see this function gone:

Tested-by: Tony Lindgren <tony@atomide.com>
