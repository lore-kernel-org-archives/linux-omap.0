Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1695C77B73
	for <linux-omap@archiver.kernel.org>; Thu, 27 Apr 2023 07:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243024AbjD0HDP (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 27 Apr 2023 03:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243086AbjD0HDM (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Thu, 27 Apr 2023 03:03:12 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E34A0422B;
        Thu, 27 Apr 2023 00:03:09 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id C06EA80A4;
        Thu, 27 Apr 2023 07:03:08 +0000 (UTC)
Date:   Thu, 27 Apr 2023 10:03:07 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andreas Kemnade <andreas@kemnade.info>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [BISECTED REGRESSION] OMAP1 GPIO breakage
Message-ID: <20230427070307.GF14287@atomide.com>
References: <20230425173241.GF444508@darkstar.musicnaut.iki.fi>
 <20230425201117.457f224c@aktux>
 <20230425183857.GG444508@darkstar.musicnaut.iki.fi>
 <20230425212040.5a4d5b09@aktux>
 <20230425193637.GH444508@darkstar.musicnaut.iki.fi>
 <20230425215848.247a936a@aktux>
 <20230426071910.GE14287@atomide.com>
 <CACRpkdb7a32Ny=JR7=pAW_QRMj-S5QuhcSN8U6_f4PhAXj5pRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdb7a32Ny=JR7=pAW_QRMj-S5QuhcSN8U6_f4PhAXj5pRA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Linus Walleij <linus.walleij@linaro.org> [230426 20:36]:
> On Wed, Apr 26, 2023 at 9:19 AM Tony Lindgren <tony@atomide.com> wrote:
> 
> > Not sure what the best way to fix this might be, adding Linus W to Cc too.
> > Maybe using gpio line names in the legacy platform data instead of numbers?
> 
> I sent a fat invasive fix which, if it works, will fix the problem once and
> for all on OSK1.
> 
> If it works, I can write the same fix for Nokia 770 or whatever.
> 
> I think it is best to just get rid of the static GPIO numbers from these
> boards so I took a stab at that.

OK makes sense to me thanks!

Tony
