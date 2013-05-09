From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL 1/2] omap fixes for v3.10 merge window part2
Date: Thu, 9 May 2013 13:30:58 -0700
Message-ID: <20130509203057.GJ31554@atomide.com>
References: <518bef23.e79f320a.5202.ffffc873SMTPIN_ADDED_BROKEN@mx.google.com>
 <20130509201504.GA21598@quad.lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:60157 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752638Ab3EIUbF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 May 2013 16:31:05 -0400
Content-Disposition: inline
In-Reply-To: <20130509201504.GA21598@quad.lixom.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Olof Johansson <olof@lixom.net> [130509 13:20]:
> On Thu, May 09, 2013 at 11:46:51AM -0700, Tony Lindgren wrote:
> > The following changes since commit 956e46efb2478ebff7a871138458fa8124fd18dd:
> > 
> >   mm/slab: Fix crash during slab init (2013-05-08 15:02:33 -0700)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.10/fixes-for-merge-window-part2
> > 
> > for you to fetch changes up to b1dd11d60e5357c13d3f3decfb69bd07dde159bd:
> > 
> >   ARM: OMAP2+: Remove bogus IS_ERR_OR_NULL checking from id.c (2013-05-09 09:06:27 -0700)
> 
> Pulled, thanks.
> 
> As Arnd mentioned on an ux500 pull request earlier, we usually don't like
> fixes branches on non-rc bases, but since this is targeting pre-rc1 but
> post-what-we-merged, there's not much else to do.

Yes, sorry I should have mentioned that the commit these were based
on is the one that fixed boot issues for me. So not a random commit
of the day, and some of these had dependencies to the patches already
merged.

Regards,

Tony
