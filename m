From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP: hwmod/PMU/PRCM patches for 3.7
Date: Fri, 21 Sep 2012 16:10:40 -0700
Message-ID: <20120921231039.GN28835@atomide.com>
References: <alpine.DEB.2.00.1209210103140.6888@utopia.booyaka.com>
 <20120921205322.GK28835@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:30646 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758285Ab2IUXKm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Sep 2012 19:10:42 -0400
Content-Disposition: inline
In-Reply-To: <20120921205322.GK28835@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Tony Lindgren <tony@atomide.com> [120921 13:55]:
> * Paul Walmsley <paul@pwsan.com> [120920 18:05]:
> > Hi Tony
> > 
> > The following changes since commit c4dbc7c086ce96d17f18b7a4a965b01d54d45f46:
> > 
> >   Merge tag 'cleanup-fixes-for-v3.7' into test_merge_v3.6-rc6_cleanup-fixes (2012-09-19 13:54:08 -0600)
> > 
> > are available in the git repository at:
> > 
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-devel-b-for-3.7
> 
> Thanks pulling into devel-late.
> 
> Note that we're pretty much out of time for v3.7 merge window, so
> most likely this won't get merged until for v3.8. See message
> "Status of arm-soc for 3.7"  posted to LAKML for details.

I tried merging this into tmp-merge, but ran into all kinds of
merge conflicts with the am33xx code etc and ended up with a
result that booted with all kinds of warnings on 2430sdp and
did not boot at all on zoom3 :) So I probably did something
wrong..

Care to base this on something more mergeable? Maybe a merge
of cleanup-fixes-for-v3.7 + omap-devel-am33xx-for-v3.7?

Ideally it would be based on something that merges nicely
when pulled into arm-soc/for-next, but that might be a bit
hard to do right now.

Regards,

Tony
