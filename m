From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2: use early init hook
Date: Tue, 25 Jan 2011 11:29:22 -0800
Message-ID: <20110125192922.GQ13589@atomide.com>
References: <20110123171344.GH30094@n2100.arm.linux.org.uk>
 <20110123174814.GI30094@n2100.arm.linux.org.uk>
 <20110124201731.GC13589@atomide.com>
 <20110124202629.GE13589@atomide.com>
 <20110124215213.GA27044@n2100.arm.linux.org.uk>
 <20110125022119.GG13589@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:36532 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507Ab1AYT3l (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Jan 2011 14:29:41 -0500
Content-Disposition: inline
In-Reply-To: <20110125022119.GG13589@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Tony Lindgren <tony@atomide.com> [110124 18:20]:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [110124 13:51]:
> > On Mon, Jan 24, 2011 at 12:26:29PM -0800, Tony Lindgren wrote:
> > > * Tony Lindgren <tony@atomide.com> [110124 12:16]:
> > > > 
> > > > So far tested on zoom3 only, but the following gets it booting
> > > > on top of your patch.
> > > 
> > > Looks like there are some other patches needed too.. At least
> > > omap4 still fails with these.
> > 
> > From what I remember, the problem I saw on OMAP4 was hwmod related as
> > it seemed to be using ioremap() - which with its initialization moved
> > before memory allocators were up and running causes an oops.
> 
> To me it seems _find_mpu_rt_base should be moved to omap_hwmod_late_init
> as we don't want to have a static mapping for everything. AFAIK the
> oh->_mpu_rt_va should not be needed early.
> 
> Any comments on that Paul? See also the two patches I'll post as a reply
> to this thread make omap_hwmod_late_init a core_initcall.

Posted this patch also, now also omap4 boots.

Tony
