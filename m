From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [GIT PULL]: linux-omap DSS
Date: Wed, 23 Feb 2011 09:43:17 +0200
Message-ID: <1298446997.3476.2.camel@deskari>
References: <1298369379.2590.41.camel@deskari>
	 <20110222190119.GN15225@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33592 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753992Ab1BWHnV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Feb 2011 02:43:21 -0500
In-Reply-To: <20110222190119.GN15225@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

On Tue, 2011-02-22 at 13:01 -0600, Tony Lindgren wrote:
> Hi,
> 
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [110222 02:07]:
> > Hi Tony,
> > 
> > The following mach-omap2 patches have been reviewed and are in DSS tree,
> > but cause easily conflicts with linux-omap tree.
> > 
> > Would it be possible for you to pull these into linux-omap? 
> 
> Sure, but see below.
>  
> > The patches are based on today's linux-omap/master.
> 
> Can you please base thes on current omap-for-linus at
> 04aa67dec63b61c1a8b9b6d001262250f1a92130? (Just pushed it
> with the omap4 hwmod fix for timer1)
> 
> I can't pull in the master branch into omap-for-linus as that
> contains years of history of temporary commits.

Ah, of course. I updated the branch

git://gitorious.org/linux-omap-dss2/linux.git for-tony

to be based on omap-for-linus. Minor conflicts in 3430sdp board file,
otherwise the commits are the same.

 Tomi


