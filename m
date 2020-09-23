Return-Path: <SRS0=ZM0c=DA=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A630C4363D
	for <linux-omap@archiver.kernel.org>; Wed, 23 Sep 2020 06:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 092E4221E8
	for <linux-omap@archiver.kernel.org>; Wed, 23 Sep 2020 06:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgIWGgc (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 23 Sep 2020 02:36:32 -0400
Received: from muru.com ([72.249.23.125]:45088 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbgIWGgc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Wed, 23 Sep 2020 02:36:32 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 0517D80C1;
        Wed, 23 Sep 2020 06:36:32 +0000 (UTC)
Date:   Wed, 23 Sep 2020 09:37:26 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Drew Fustini <drew@beagleboard.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@gmail.com>,
        Trent Piepho <tpiepho@gmail.com>,
        Christina Quast <cquast@hanoverdisplays.com>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: am335x: guardian: switch to AM33XX_PADCONF
Message-ID: <20200923063726.GO7101@atomide.com>
References: <20200919195159.3126193-1-drew@beagleboard.org>
 <20200921064707.GN7101@atomide.com>
 <20200921095912.GA3752675@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921095912.GA3752675@x1>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Drew Fustini <drew@beagleboard.org> [200921 09:59]:
> On Mon, Sep 21, 2020 at 09:47:07AM +0300, Tony Lindgren wrote:
> > * Drew Fustini <drew@beagleboard.org> [200919 19:53]:
> > > Change the pin defintions from AM33XX_IOPAD to AM33XX_PADCONF macro so
> > > that it correctly handles changes to #pinctrl-cells.
> > 
> > Thanks for fixing this. I wonder if we should now also change the define
> > for the old AM33XX_IOPAD macro?
> > 
> > Or just remove it completely and mention that we've changed nr-pinctrl-cells
> > to use 3 now?
> > 
> > Otherwise the unknown number of out-of-tree boards will be hitting this
> > too.
> > 
> 
> Christina Quast commented in f1ff9be7652b ("ARM: dts: am33xx: Added 
> AM33XX_PADCONF macro") that AM33XX_IOPAD() was left in place to avoid
> breaking boards not in mainline.
> 
> If we follow that logic, then I think that fixing AM33XX_IOPAD() for
> #pinctrl-cells = <2> would be the correct solution.
> 
> Would this be acceptable?
> 
> #define AM33XX_IOPAD(pa, val)          OMAP_IOPAD_OFFSET((pa), 0x0800) (val) (0)

Makes sense to me yeah.

Tony
