Return-Path: <SRS0=ZH5a=DH=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF41FC4742C
	for <linux-omap@archiver.kernel.org>; Wed, 30 Sep 2020 09:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 995A320738
	for <linux-omap@archiver.kernel.org>; Wed, 30 Sep 2020 09:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbgI3JPg (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 30 Sep 2020 05:15:36 -0400
Received: from muru.com ([72.249.23.125]:45746 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729470AbgI3JPe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Wed, 30 Sep 2020 05:15:34 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 59D8C810D;
        Wed, 30 Sep 2020 09:15:33 +0000 (UTC)
Date:   Wed, 30 Sep 2020 12:15:26 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Trent Piepho <tpiepho@gmail.com>
Cc:     Drew Fustini <drew@beagleboard.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@gmail.com>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Christina Quast <cquast@hanoverdisplays.com>
Subject: Re: [PATCH] ARM: dts: document pinctrl-single,pins when
 #pinctrl-cells = 2
Message-ID: <20200930091526.GQ9471@atomide.com>
References: <20200923065755.GR7101@atomide.com>
 <CA+7tXigeNhQQVuAu0toZrvBKvMYkDU-8EWTpJR29HLTAMgoOBA@mail.gmail.com>
 <20200924054324.GB9471@atomide.com>
 <CA+7tXigg+h3v61AVMaYRKa_ZwznehOUPEESMqXKsNDNCrFph3w@mail.gmail.com>
 <20200924060645.GD9471@atomide.com>
 <CA+7tXijkS8UMFk4t=DuKjZZNnThbRarPQvxwxjg-uJFTKJRsXA@mail.gmail.com>
 <20200924070443.GF9471@atomide.com>
 <CA+7tXihBdw9AOGL7Hp2cH9+ii8fUXaaZZDUP3icyeOkMuGm4qA@mail.gmail.com>
 <20200930051521.GN9471@atomide.com>
 <CA+7tXig=3hbFXfmYMC5Hd1Zc2n-6uGXbMePPw_Cr4bOsyt7QQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+7tXig=3hbFXfmYMC5Hd1Zc2n-6uGXbMePPw_Cr4bOsyt7QQA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Trent Piepho <tpiepho@gmail.com> [200930 08:35]:
> The closest thing would be the generic pin config type bindings, which
> go in the pinctrl driver's nodes, and look like this:
> &am335x_pinmux {
>     pinctrl_yoyo_reset: yoyogrp {
>         pins = "foo";
>         function = "gpio";
>         bias-pull-up;
>     };
> };

There's a bit of a dtb size and boot time issue for adding properties
for each pin where that needs to be done for several hundred pins :)

> Is "some additional property for specifying generic conf flags"
> different from the existing pinctrl-single,bias-pullup, etc.
> properties?  Because splitting the data cell into two parts doesn't
> make any difference to those.

So with an interrupt style binding with generic pinconf flags we can
leave out the parsing of multiple properties for each pin. Sure the
pin is only referenced by the controller like you pointed out but the
pinconf flags could be generic.

Regards,

Tony
