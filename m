Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43E5C433EF
	for <linux-omap@archiver.kernel.org>; Fri,  1 Jul 2022 10:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235436AbiGAK3q (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 1 Jul 2022 06:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235420AbiGAK3p (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2022 06:29:45 -0400
X-Greylist: delayed 517 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 01 Jul 2022 03:29:44 PDT
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 21FDA76942
        for <linux-omap@vger.kernel.org>; Fri,  1 Jul 2022 03:29:43 -0700 (PDT)
Received: from [10.251.0.6] (unknown [176.126.217.202])
        by mail.bugwerft.de (Postfix) with ESMTPSA id 34A63504869;
        Fri,  1 Jul 2022 10:21:03 +0000 (UTC)
Message-ID: <b8372253-abf6-5eee-f9cd-788bc5f24be2@zonque.org>
Date:   Fri, 1 Jul 2022 12:21:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: Scheduling (unused) board file removal for linux-6.x
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>,
        Aswath Govindraju <a-govindraju@ti.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Marek Vasut <marek.vasut@gmail.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        linux-omap <linux-omap@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Lennert Buytenhek <kernel@wantstofly.org>,
        Marc Zyngier <maz@kernel.org>,
        Mauri Sandberg <maukka@ext.kapsi.fi>
References: <CAK8P3a0Z9vGEQbVRBo84bSyPFM-LF+hs5w8ZA51g2Z+NsdtDQA@mail.gmail.com>
 <CACRpkdY2_ZbmcSuuMB9t5bB-tGE0iAc-nE26JwxidRFocRahSw@mail.gmail.com>
From:   Daniel Mack <daniel@zonque.org>
In-Reply-To: <CACRpkdY2_ZbmcSuuMB9t5bB-tGE0iAc-nE26JwxidRFocRahSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

On 6/30/22 13:32, Linus Walleij wrote:
> This looks like something that would be interesting to pick up and maintain
> with DT support, if and only if there are devices with enough memory.
> 
> However I doubt there is interest.
> 
> I think the palmtops/PDAs are a bit outdated as enthusiast/hobbyist platforms
> with screens because those people will use PostmarketOS with
> cheap old tablets and phones these days.

It should be totally possible to port the remaining board-file powered
PXA boards over to DT. Some drivers will need DT amendments, and some
board files apply some rather exotic approaches, but with access to such
hardware, they can certainly be made work again.

I would be in favor of removing the board files, and help enthusiasts in
their efforts to to the switch to DT. In fact I would feel better to
bring back support with actual hardware testing than blindly patching
things.


Thanks,
Daniel
