Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B50C433E0
	for <linux-omap@archiver.kernel.org>; Fri, 15 Jan 2021 08:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46F3F2072D
	for <linux-omap@archiver.kernel.org>; Fri, 15 Jan 2021 08:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbhAOIOU (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 15 Jan 2021 03:14:20 -0500
Received: from muru.com ([72.249.23.125]:44940 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727936AbhAOIOT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Fri, 15 Jan 2021 03:14:19 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 46C1F805C;
        Fri, 15 Jan 2021 08:12:38 +0000 (UTC)
Date:   Fri, 15 Jan 2021 10:12:33 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>,
        "rogerq@ti.com" <rogerq@ti.com>, "s-anna@ti.com" <s-anna@ti.com>,
        "bcousson@baylibre.com" <bcousson@baylibre.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "d-gerlach@ti.com" <d-gerlach@ti.com>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "t-kristo@ti.com" <t-kristo@ti.com>
Subject: Re: [PATCH 13/18] ARM: dts: Use simple-pm-bus for genpd for am3
 l4_wkup
Message-ID: <YAFOcS/l2TcQfdd7@atomide.com>
References: <20201026112222.56894-14-tony@atomide.com>
 <CAMuHMdWribr=eg1LkKce=Hamm+JwSz5UFEXLKUmKkqqz1RpL_w@mail.gmail.com>
 <X/8ei0o9ULpRdx7T@atomide.com>
 <CAMuHMdW+y5Y+0U1beebq7EGiarBKYdHszL+vW5r4xG6HBspVgQ@mail.gmail.com>
 <X/8kDzoADvcnNHxC@atomide.com>
 <X/8tz/2v4bnbF0TZ@atomide.com>
 <X//wx/oSTpXKpY75@atomide.com>
 <1c7301145600dabbb95402c7df0cf00b7bdd7fdd.camel@fi.rohmeurope.com>
 <X//799pSjH9bL39s@atomide.com>
 <CAMuHMdUhiFuE=mFbnOBWVZvJ1BhRMYGQmT4LeJLbfMCVUW=SmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUhiFuE=mFbnOBWVZvJ1BhRMYGQmT4LeJLbfMCVUW=SmA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Geert Uytterhoeven <geert@linux-m68k.org> [210114 08:52]:
> On Thu, Jan 14, 2021 at 9:08 AM Tony Lindgren <tony@atomide.com> wrote:
> > Can you guys check if adding CONFIG_SIMPLE_PM_BUS=y fixes the problem?
> 
> Thanks, that did the trick!
> Sorry for not realizing that myself.

OK thanks for testing, will send out a patch soon with both of you
in Cc.

Regards,

Tony
