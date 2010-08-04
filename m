From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] OMAP: clock, hwmod, omap_device, PM constraints:
 patches for 2.6.36
Date: Wed, 4 Aug 2010 08:51:24 +0300
Message-ID: <20100804055123.GD6840@atomide.com>
References: <alpine.DEB.2.00.1007031548010.16344@utopia.booyaka.com>
 <20100706110918.GJ3192@atomide.com>
 <877hk7nxfx.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:50258 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752613Ab0HDFvB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Aug 2010 01:51:01 -0400
Content-Disposition: inline
In-Reply-To: <877hk7nxfx.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Kevin Hilman <khilman@deeprootsystems.com> [100804 01:21]:
> Tony Lindgren <tony@atomide.com> writes:
> 
> > * Paul Walmsley <paul@pwsan.com> [100704 00:43]:
> >> 
> >> Hi Tony,
> >> 
> >> here's the pull request for some clock, hwmod, omap_device, PM constraints 
> >> patches for 2.6.36.
> >
> > Thanks, pulled into omap-for-linus.
> >
> 
> Hmm, I don't see this in current omap-for-linus.  Is it still planned
> for 2.6.36?  

Thanks for checking. Paul asked me to redo the pull after fixing some
credits, and looks like then I forgot to pull.
 
> Once this is merged, the all the hwmod/omap_device conversions will only
> have a dependency on the OMAP runtime PM core.

Yeah that's good!

Tony
