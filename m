From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 3/3] ARM: OMAP: omap_device: idle devices with no
 driver bound
Date: Fri, 17 Aug 2012 00:52:41 -0700
Message-ID: <20120817075240.GM11011@atomide.com>
References: <1344623953-26434-1-git-send-email-khilman@ti.com>
 <1344623953-26434-4-git-send-email-khilman@ti.com>
 <alpine.DEB.2.00.1208101658130.29149@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:43772 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754983Ab2HQHwo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Aug 2012 03:52:44 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1208101658130.29149@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [120810 15:59]:
> On Fri, 10 Aug 2012, Kevin Hilman wrote:
> 
> > Under some circumstances, drivers may leave an omap_device enabled due
> > to driver programming errors, or due to a failure in the drivers
> > probe method.
> > 
> > Using the recently added omap_device driver_status field, we can
> > detect conditions where an omap_device is enabled but has no driver
> > bound and then ensure that the device is properly idled until it can
> > be probed again.
> > 
> > The goal of this feature is not only to detect and warn on these error
> > conditions, but also to ensure that devices are properly put in
> > low-power states so they do not prevent SoC-wide low-power states.
> > 
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Signed-off-by: Kevin Hilman <khilman@ti.com>
> 
> Here's the queued version of this one.

Nice to see this happening :)

Tony
