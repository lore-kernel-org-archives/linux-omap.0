From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: l2c: squelch warning dump on power control
 setting
Date: Wed, 2 Jul 2014 01:11:43 -0700
Message-ID: <20140702081142.GU28884@atomide.com>
References: <3c3a7a4861df01d0163787a9c18f7b7ac821c5b9.1403000372.git.nsekhar@ti.com>
 <20140617131935.GB9070@saruman.home>
 <20140701194704.GG13396@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:44706 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074AbaGBILq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Jul 2014 04:11:46 -0400
Content-Disposition: inline
In-Reply-To: <20140701194704.GG13396@saruman.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Sekhar Nori <nsekhar@ti.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>

* Felipe Balbi <balbi@ti.com> [140701 12:49]:
> On Tue, Jun 17, 2014 at 08:19:35AM -0500, Felipe Balbi wrote:
> > On Tue, Jun 17, 2014 at 04:04:51PM +0530, Sekhar Nori wrote:
> > > ROM code on AM437x does not support writing to L2C-310 power control
> > > register. The L2C driver, however, tries writing to this register for
> > > all revisions >= r3p0.
> > > 
> > > This leads to a warning dump on boot which leads most users to believe
> > > that L2 cache is non-functional.
> > > 
> > > Since the problem is understood, and cannot be addressed through software,
> > > replace the warning with a pr_info() while maintaining the WARN_ON() for
> > > other truly unexpected scenarios.
> > > 
> > > Reported-by: Nishanth Menon <nm@ti.com>
> > > Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> > 
> > Tested with today's linux-next
> > (5f295cdf5c5dbbb0c40f10f2ddae02ff46bbf773) with am437x-sk, I can see
> > that the WARNING goes away.
> > 
> > Tested-by: Felipe Balbi <balbi@ti.com>
> 
> ping here, I can't see this patch onl linus/master or next/master yet.

Sorry I've been waiting for my pull request against -rc1 to get
merged first, no idea why that is still pending.

Regards,

Tony
