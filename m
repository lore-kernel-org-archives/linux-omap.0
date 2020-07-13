Return-Path: <SRS0=HJjW=AY=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3762C433DF
	for <linux-omap@archiver.kernel.org>; Mon, 13 Jul 2020 15:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D88520578
	for <linux-omap@archiver.kernel.org>; Mon, 13 Jul 2020 15:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbgGMPCY (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 13 Jul 2020 11:02:24 -0400
Received: from muru.com ([72.249.23.125]:36594 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729027AbgGMPCY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Mon, 13 Jul 2020 11:02:24 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 1B5F58106;
        Mon, 13 Jul 2020 15:02:21 +0000 (UTC)
Date:   Mon, 13 Jul 2020 08:02:20 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Drew Fustini <drew@beagleboard.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@gmail.com>
Subject: Re: gpio-omap: handle bias flag for gpio line
Message-ID: <20200713150220.GJ5849@atomide.com>
References: <20200625002736.GA24954@x1>
 <CACRpkdYze_6cM0R=rr7RF8h5WO4GoCcz4=K1_XLt0PJNxCYtbw@mail.gmail.com>
 <20200712215630.GA1298162@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200712215630.GA1298162@x1>
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Hi,

* Drew Fustini <drew@beagleboard.org> [200712 21:56]:
> P2.03 header pin on PocketBeagle maps to gpiochip 0 line 23. It is PIN9
> which value on boot: 0x37 (input [0x20] pull-up [0x10] gpio mode [0x7])
> 
> $ cat /sys/kernel/debug/pinctrl/44e10800.pinmux-pinctrl-single/pins |grep ^'pin 9' |head -1
> pin 9 (PIN9) 44e10824 00000037 pinctrl-single
> 
> $ gpiomon -B pull-down 0 23

Nice it's getting quite close to a user usable feature :)

I think we really should have an easy way to use the dts configured
GPIO line names here though. Can we make the dts configured GPIO
line name show up in the pinctrl output directly?

This would allow grepping for the device specific GPIO line name
directly in from the debugfs "pins" output.

But Ideally this should be done with the gpio sysfs interface though
somehow rather than rely on pinctrl debugfs. The debugfs interface
should be optional, and can change.

Regards,

Tony
