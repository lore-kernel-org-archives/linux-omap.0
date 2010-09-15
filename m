From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] omap3: Prevent SDRC deadlock when L3 is changing
 frequency
Date: Wed, 15 Sep 2010 17:10:21 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1009151707370.458@utopia.booyaka.com>
References: <1279728155-2643-1-git-send-email-jon-hunter@ti.com> <alpine.DEB.2.00.1009151300190.458@utopia.booyaka.com> <20100915224007.GJ4174@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36205 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809Ab0IOXKW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Sep 2010 19:10:22 -0400
In-Reply-To: <20100915224007.GJ4174@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jon Hunter <jon-hunter@ti.com>, linux-omap <linux-omap@vger.kernel.org>, khilman@deeprootsystems.com

On Wed, 15 Sep 2010, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [100915 12:07]:
> > > 
> > > This change has been commited to both TI's android 2.6.29 and 2.6.32 kernels.
> > > The commits can be viewed here:
> > > http://git.omapzoom.org/?p=kernel/omap.git;a=commit;h=5679c7b1142f3cc2b9285181d53f6b40c4d0296d
> > > http://git.omapzoom.org/?p=kernel/omap.git;a=commit;h=cf16e57823575d98e9d5165aa7a498ffb751c940
> > > 
> > > This patch has been rebased on the latest linux-omap tree and tested on
> > > Kevin Hilman's pm branch.
> 
> Sounds like a very important fix. But also a good example of how
> messed up things are with the TI Linux kernel development.
> 
> Why has this fix it been sitting in some TI internal tree since
> Fri, 12 Mar 2010?

About two months of it is my fault, since it was posted to l-o on July 21.  
But all the time between 12 March and 21 July is up to TI to answer.
This really could have been a useful patch for certain vendors to have 
that are using CORE DVFS on their currently-shipping OMAP3 devices.

> This same bug has been patched in three different trees? But not in
> the mainline kernel?
> 
> And this is happening all the time with the TI fixes.

Yeah.


- Paul
