From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: arch/arm/mach-omap* organization
Date: Wed, 5 Aug 2009 11:39:35 +0300
Message-ID: <20090805083935.GB28674@nokia.com>
References: <4A776368.1010503@onid.oregonstate.edu>
 <20090804070526.GD24334@atomide.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:18751 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933326AbZHEIjF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Aug 2009 04:39:05 -0400
Content-Disposition: inline
In-Reply-To: <20090804070526.GD24334@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: Ben Goska <goskab@onid.oregonstate.edu>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Aug 04, 2009 at 09:05:27AM +0200, ext Tony Lindgren wrote:
> * Ben Goska <goskab@onid.oregonstate.edu> [090804 01:53]:
> > Is there a reason why omap2, omap3, and now omap4 files are all packed  
> > into the mach-omap2 directory?
> >
> > It seems like it would make more sense for each omap version to have  
> > it's own directory.
> 
> Majority of the mach-omap2 code is shared across them.
> 
> For example, the initial patch to add minimal omap3 support on top of
> the omap2 code was about 500 lines of diff. The situation was pretty
> much the same to add minimal omap4 support on top of omap3.
> 
> If we wanted to, in the long run we could move more of the shared
> code to plat-omap, and just keep board-*.c files under each mach-*
> directory.

I guess that will start to show as a necessary change since we would be
able to remove several "if (cpu_is_omapXXX())" from platform_device
registration code and related changes.

-- 
balbi
