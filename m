From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap iommu fixes for v3.0-rc
Date: Fri, 1 Jul 2011 03:05:26 -0700
Message-ID: <20110701100525.GK23145@atomide.com>
References: <BANLkTi=vd2TE6JjueGmY=ydRQRygo8-Q1Q@mail.gmail.com>
 <20110701070056.GZ23145@atomide.com>
 <BANLkTikhZhUzyk=31cUOcV3Ygj=BHUrbew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:29148 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755074Ab1GAKF2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 06:05:28 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTikhZhUzyk=31cUOcV3Ygj=BHUrbew@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap@vger.kernel.org, linux-arm <linux-arm-kernel@lists.infradead.org>

* Ohad Ben-Cohen <ohad@wizery.com> [110701 00:46]:
> On Fri, Jul 1, 2011 at 10:00 AM, Tony Lindgren <tony@atomide.com> wrote:
> > These look like real fixes, but can you please update the commits
> > with something like "This fixes an issue with foo when doing bar".
> 
> Done, please tell me if it's OK now.

OK thanks!
 
> > Otherwise it's easy to claim that these are "fixes for features that
> > never worked" and it might be hard to justify them this late into
> > the -rc cycle.
> 
> It seems we did have these issues for quite some time, and these are not
> explicit 3.0 regressions. So they might vaguely fall into the "fixes
> for features that never worked" definition too in a sense.
> 
> If you prefer to take them into 3.1, that's OK too.

Let's do that then.

Regards,

Tony
