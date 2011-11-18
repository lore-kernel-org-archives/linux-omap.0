From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP: hwmod fix for 3.2-rc3
Date: Fri, 18 Nov 2011 15:37:56 -0800
Message-ID: <20111118233756.GR31337@atomide.com>
References: <4EC3DE7D.9050609@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:20286 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753541Ab1KRXiA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Nov 2011 18:38:00 -0500
Content-Disposition: inline
In-Reply-To: <4EC3DE7D.9050609@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Cousson, Benoit <b-cousson@ti.com> [111116 07:27]:
> Hi Tony,
> 
> That bug is becoming annoying, and a bunch of folks are hitting that issue during DT dev for 3.3, so it will be cool to fix that ASAP.

OK pulling it in. BTW, next time, please try to base branches on some
recent tag like v3.2 or v3.2-rc2. Of course, that is assuming there's
no dependency to some recent fix :)

Regards,

Tony
 
> It might already be in Paul's queue for 3.2-rc3.
> 
> Thanks,
> Benoit
> 
> 
> The following changes since commit 6aaf05f472c97ebceff47d9eef464574f1a55727:
>   Linus Torvalds (1):
>         Merge branch 'for-linus' of git://git390.marist.edu/pub/scm/linux-2.6
> 
> are available in the git repository at:
> 
>   git://gitorious.org/omap-pm/linux.git for_3.2-rc/hwmod-fixes
> 
> sricharan (1):
>       ARM: OMAP: hwmod: Fix the addr space, irq, dma count APIs
> 
>  arch/arm/mach-omap2/omap_hwmod.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
