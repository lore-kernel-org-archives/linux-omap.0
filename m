From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] OMAP: SoC data/core: cleanups for 3.1
Date: Tue, 12 Jul 2011 23:49:50 -0700
Message-ID: <20110713064949.GI5783@atomide.com>
References: <alpine.DEB.2.00.1107092031400.15984@utopia.booyaka.com>
 <20110711083225.GO5783@atomide.com>
 <alpine.DEB.2.00.1107130037140.30229@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:25964 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758127Ab1GMGtx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jul 2011 02:49:53 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1107130037140.30229@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [110712 23:33]:
> Hi Tony,
> 
> On Mon, 11 Jul 2011, Tony Lindgren wrote:
> 
> > Paul, please use the mainline tags or linux-omap static branches
> > instead of the arm-soc branches. In this case there's only the extra
> > merge commit there, so not a problem. Now it just makes it a bit
> > harder for me to do pull requests and diffs to other branches.
> > 
> > In general, we want to keep the dependencies between branches and
> > other trees to minimum.
> 
> Sorry about that.  It was a misunderstanding on my part.

No problem, we should probably document that in the wiki page..
 
> Would you like me to rebase the prcm-fixes-3.1 and prcm-devel-3.1 branches 
> on a different branch/commit?

No need to, they're already all pulled in and in arm-soc waiting
for the merge window.

Regards,

Tony
