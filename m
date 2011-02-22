From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL]: linux-omap DSS
Date: Tue, 22 Feb 2011 11:01:19 -0800
Message-ID: <20110222190119.GN15225@atomide.com>
References: <1298369379.2590.41.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61115 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753386Ab1BVTBb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Feb 2011 14:01:31 -0500
Content-Disposition: inline
In-Reply-To: <1298369379.2590.41.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Hi,

* Tomi Valkeinen <tomi.valkeinen@ti.com> [110222 02:07]:
> Hi Tony,
> 
> The following mach-omap2 patches have been reviewed and are in DSS tree,
> but cause easily conflicts with linux-omap tree.
> 
> Would it be possible for you to pull these into linux-omap? 

Sure, but see below.
 
> The patches are based on today's linux-omap/master.

Can you please base thes on current omap-for-linus at
04aa67dec63b61c1a8b9b6d001262250f1a92130? (Just pushed it
with the omap4 hwmod fix for timer1)

I can't pull in the master branch into omap-for-linus as that
contains years of history of temporary commits.

Regards,

Tony
