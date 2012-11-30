From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL 2/3] omap late prcm changes for v3.8 merge window
Date: Fri, 30 Nov 2012 09:30:43 -0800
Message-ID: <20121130173043.GK5312@atomide.com>
References: <pull-1353978372-642963>
 <50b41208.4989e50a.26c2.ffffba54SMTPIN_ADDED_MISSING@mx.google.com>
 <20121130065417.GC6899@quad.lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:40622 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754143Ab2K3Rat (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Nov 2012 12:30:49 -0500
Content-Disposition: inline
In-Reply-To: <20121130065417.GC6899@quad.lixom.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Olof Johansson <olof@lixom.net> [121129 22:56]:
> On Mon, Nov 26, 2012 at 05:06:12PM -0800, Tony Lindgren wrote:
> > The following changes since commit 558a0780b0a04862a678f7823215424b4e5501f9:
> > 
> >   Merge tag 'omap-cleanup-c-for-3.8' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into omap-for-v3.8/clock (2012-11-13 13:32:24 -0800)
> > 
> > are available in the git repository at:
> > 
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.8/devel-prcm-signed
> > 
> > for you to fetch changes up to 8b9c1ac2e11a9fb3a5a8860fb7570ff7633aa7f7:
> > 
> >   Merge tag 'omap-devel-a-for-3.8' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into omap-for-v3.8/devel-pcrm (2012-11-26 12:32:50 -0800)
> 
> Thanks, pulled. Dependencies are getting to be a bit complex for omap stuff at
> this point, so I merged it into a new next/pm2 branch. It's not unlikely that
> we will combine next/pm, next/clock and next/pm2 into one branch before merging
> upstream, since there are lots of internal dependencies between those.

Yes thanks, only fixes coming up for omaps until -rc1 is tagged.

Regards,

Tony
