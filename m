From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4] initialize omap SRAM later on with
 __arm_ioremap_exec()
Date: Fri, 7 Oct 2011 07:45:10 -0700
Message-ID: <20111007144510.GF6324@atomide.com>
References: <20111005004339.26980.31149.stgit@kaulin.local>
 <4E8C0125.1060300@ti.com>
 <20111006014219.GH6324@atomide.com>
 <4E8EA35E.6050100@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:35228 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965441Ab1JGOpO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Oct 2011 10:45:14 -0400
Content-Disposition: inline
In-Reply-To: <4E8EA35E.6050100@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [111006 23:25]:
> On Thursday 06 October 2011 07:12 AM, Tony Lindgren wrote:
> > * Santosh Shilimkar <santosh.shilimkar@ti.com> [111004 23:29]:
> >>
> >> Will look at this series in next couple of days and do some testing.
> > 
> > Thanks, turns out there were a few issues with early ioremap
> > that I fixed. Care to check the L4_IO_ADDRESS changes?
> >
> They look ok to me.

Thanks for testing.
 
> > It's all pushed now into sram-map-io branch at:
> > 
> > https://github.com/tmlind/linux/tree/sram-map-io
> > 
> > It seems it's booting now on all omaps I've tried, so will merge
> > it into linux-omap master branch as well for testing.
> > 
> I have reviewed and tested this series. No problems seen.
> As asked on other thread, if you are targeting this one for
> 3.2, then sram changes would have a small conflict with
> OMAP4 errata patch. If it is for 3.3, we should be able to
> sort out that conflict easily.

Yeah let's if we can map the errata fix page separately.

Regards,

Tony
