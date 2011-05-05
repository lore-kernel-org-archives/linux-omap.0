From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/8] OMAP PM: create a PM layer plugin for per-device
 constraints
Date: Thu, 5 May 2011 09:00:13 +0300
Message-ID: <20110505060013.GJ27860@atomide.com>
References: <1304516117-9334-1-git-send-email-j-pihet@ti.com>
 <1304516117-9334-2-git-send-email-j-pihet@ti.com>
 <20110504135930.GE2092@atomide.com>
 <87vcxqv8fp.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:35351 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751443Ab1EEGAR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 May 2011 02:00:17 -0400
Content-Disposition: inline
In-Reply-To: <87vcxqv8fp.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: jean.pihet@newoldbits.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com, Jean Pihet <j-pihet@ti.com>, Vishwanath BS <vishwanath.bs@ti.com>

* Kevin Hilman <khilman@ti.com> [110504 17:33]:
> Tony,
> 
> Tony Lindgren <tony@atomide.com> writes:
> 
> > * jean.pihet@newoldbits.com <jean.pihet@newoldbits.com> [110504 06:32]:
> >>
> >> +int omap_pm_set_max_mpu_wakeup_lat(struct device *dev, long t)
> > ...
> >
> >> +int omap_pm_set_max_dev_wakeup_lat(struct device *req_dev, struct device *dev,
> > ...
> >
> >> +int omap_pm_set_min_clk_rate(struct device *dev, struct clk *c, long r)
> > ...
> >
> > You should implement this as a Linux generic framework, we don't
> > want to add more omap specific frameworks.
> 
> This series isn't adding any new OMAP-specific frameworks.  The OMAP PM
> layer is already in place, and has been there for awhile.  OMAP PM is a
> layer which can have "plugins" so we can experiment with ways of
> handling constraints without changing the driver interface, and this
> series is just implementing a new plugin.

But in this case the plugin is just stubs. The only function that does
something is omap_pm_get_dev_context_loss_count. And then patch 8 in
this series starts adding a new omap specific features for constraints.

So the problem is patches 1 & 8 in this series. The rest is just fine
as it's the necessary omap hardware specific implementation.

> Once we are happy with a constraint layer, and can prove it will work,
> the plan is to get rid of the (existing) OMAP-specific APIs and propose
> a generic interface.

Well I don't think we should start building new omap specific layer on
an omap specific framework.

Instead, the constraint layer should be made generic to start with, even
if it's just a minimal implementation initially.

Maybe it could be just a generic header file to start with?

Regards,

Tony
