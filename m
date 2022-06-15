Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2B3C43334
	for <linux-omap@archiver.kernel.org>; Wed, 15 Jun 2022 08:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245205AbiFOIbp (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 15 Jun 2022 04:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245207AbiFOIbN (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Wed, 15 Jun 2022 04:31:13 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DE5AB49CB7
        for <linux-omap@vger.kernel.org>; Wed, 15 Jun 2022 01:31:09 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id ED38880FE;
        Wed, 15 Jun 2022 08:26:23 +0000 (UTC)
Date:   Wed, 15 Jun 2022 11:31:08 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Yegor Yefremov <yegorslists@googlemail.com>
Cc:     Drew Fustini <drew@beagleboard.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>
Subject: Re: am335x: GPIOs in userspace
Message-ID: <YqmYzFkO7NgRbbfp@atomide.com>
References: <CAGm1_ku2O3Z7OegxKpq4SnaycvzmgFR7SO1PoZJ3h4P7OHvQYg@mail.gmail.com>
 <CAPgEAj7wNtgf9sUrL1E14LgrPwiLv=bGcAyhdzns3ZnkH-Qqww@mail.gmail.com>
 <CAGm1_ksRcRBG+Ns+XJ4YvXyZmnMPXLqBiurhqkphSRR8orZbaw@mail.gmail.com>
 <CAGm1_kscjH-hQA+K6OcVJUiwCOrrfgjW5PHRw=Zdci788h9j1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGm1_kscjH-hQA+K6OcVJUiwCOrrfgjW5PHRw=Zdci788h9j1A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Yegor Yefremov <yegorslists@googlemail.com> [220614 12:32]:
> I found the problem. Between 5.10 and 5.11 gpiochip assignment has
> changed: gpiochip1 -> gpiochip4. Hence, I'll have to work with gpio
> labels.

OK good to hear you found the problem.

Tony
