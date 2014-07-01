From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP 3630 random crashes
Date: Tue, 1 Jul 2014 00:54:37 -0700
Message-ID: <20140701075437.GM28884@atomide.com>
References: <1403254242990.39117@grundfos.com>
 <20140620091431.GA28884@atomide.com>
 <1403272840480.35753@grundfos.com>
 <CAK8F28=pF=gy10Lar35q2-s=f0TxNJFZ6XpdTFvHYankXtzH4Q@mail.gmail.com>
 <1403274413159.44797@grundfos.com>
 <1404135826925.10774@grundfos.com>
 <CAOf5uwn_+P5JkU7szHZNj74fqk7ArskiZnYn=eCeamPZ_dWS+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:38809 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753188AbaGAHyi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jul 2014 03:54:38 -0400
Content-Disposition: inline
In-Reply-To: <CAOf5uwn_+P5JkU7szHZNj74fqk7ArskiZnYn=eCeamPZ_dWS+g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Casper Lyngesen Mogensen <clmogensen@grundfos.com>, Ash Charles <ash@gumstix.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Michael Trimarchi <michael@amarulasolutions.com> [140630 06:49]:
> 
> On Mon, Jun 30, 2014 at 3:43 PM, Casper Lyngesen Mogensen
> <clmogensen@grundfos.com> wrote:
> >
> > I got two new Overo AirStorm today, and they have same behavior. I tried disabling
> > the SMSC9xxx again and booted from MMC. This seems to make the backtrace a
> > little more consistent(Tried on both new and old). There is (almost) always something
> > about Alignment trap, the crash log itself differs every time. Also i get to allocate a lot
> > more memory before crash with these settings.
> 
> What kernel version are you using?

We should have v3.15 working fine, but PM features are not merged
in util for v3.16.

I would try dding calls to omap_sdrc_init to pdata-quirks.c
the same way board-over.c is doing:

omap_sdrc_init(mt46h32m32lf6_sdrc_params,
			mt46h32m32lf6_sdrc_params);

If the memory timings are not correctly set by the bootloader
that could explain the issues.

Regards,

Tony

