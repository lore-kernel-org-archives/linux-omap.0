From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap: Move omap_hwmod_late_init() to
 mdesc->timer->init() code
Date: Tue, 22 Feb 2011 08:49:02 -0800
Message-ID: <20110222164902.GJ15225@atomide.com>
References: <1298385449-27356-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:63091 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754509Ab1BVQtQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Feb 2011 11:49:16 -0500
Content-Disposition: inline
In-Reply-To: <1298385449-27356-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Benoit Cousson <b-cousson@ti.com>

* Santosh Shilimkar <santosh.shilimkar@ti.com> [110222 06:35]:
> To adhere to recent early_init changes, commit '44dc0' made
> omap_hwmod_late_init() to core_initcall to avoid ioremap() failures.
> 
> Later 'e7c7d7' removed _mpu_rt_va population omap_hwmod_late_init()
> 
> So now if we move the  omap_hwmod_late_init() to mdesc->timer->init(),
> timer1 should work with hwmod instead of any special hwmod settings.

There should be no need to have all hwmods initialized just to get
the system timer running. The system timer should be initialized
with minimal code needed.

Sure it can use hwmod functions as long as it makes sense, but
we certainly don't want the whole hwmod framework initialized
that early.

Tony
