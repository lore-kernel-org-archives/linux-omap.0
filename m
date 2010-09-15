From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap3: Prevent SDRC deadlock when L3 is changing
 frequency
Date: Wed, 15 Sep 2010 15:40:07 -0700
Message-ID: <20100915224007.GJ4174@atomide.com>
References: <1279728155-2643-1-git-send-email-jon-hunter@ti.com>
 <alpine.DEB.2.00.1009151300190.458@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:63033 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809Ab0IOWkM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Sep 2010 18:40:12 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1009151300190.458@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Jon Hunter <jon-hunter@ti.com>, linux-omap <linux-omap@vger.kernel.org>, khilman@deeprootsystems.com

* Paul Walmsley <paul@pwsan.com> [100915 12:07]:
> > 
> > This change has been commited to both TI's android 2.6.29 and 2.6.32 kernels.
> > The commits can be viewed here:
> > http://git.omapzoom.org/?p=kernel/omap.git;a=commit;h=5679c7b1142f3cc2b9285181d53f6b40c4d0296d
> > http://git.omapzoom.org/?p=kernel/omap.git;a=commit;h=cf16e57823575d98e9d5165aa7a498ffb751c940
> > 
> > This patch has been rebased on the latest linux-omap tree and tested on
> > Kevin Hilman's pm branch.

Sounds like a very important fix. But also a good example of how
messed up things are with the TI Linux kernel development.

Why has this fix it been sitting in some TI internal tree since
Fri, 12 Mar 2010?

This same bug has been patched in three different trees? But not in
the mainline kernel?

And this is happening all the time with the TI fixes.

Tony
