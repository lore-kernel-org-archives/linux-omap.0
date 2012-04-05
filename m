From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [GIT PULL] ARM: OMAP: clock, powerdomain, clockdomain, hwmod
 fixes for early v3.4-rc
Date: Thu, 5 Apr 2012 02:50:08 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204050246410.10302@utopia.booyaka.com>
References: <alpine.DEB.2.00.1204041658200.7161@utopia.booyaka.com> <20120405004139.GA10780@atomide.com> <alpine.DEB.2.00.1204042007140.10302@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49552 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753127Ab2DEIuK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Apr 2012 04:50:10 -0400
In-Reply-To: <alpine.DEB.2.00.1204042007140.10302@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, 4 Apr 2012, Paul Walmsley wrote:

> On Wed, 4 Apr 2012, Tony Lindgren wrote:
> 
> > Thanks, looks like two of these patches I already merged into
> > fixes yesterday from your earlier pull request. So merging this
> > in would cause duplicate commits. Can you please update your
> > branch to remove those two commits?
> 
> Do you happen to recall which ones they are?

Anyway, am guessing that you are planning to pull these into your 
'fixes' branch?  If so then probably the conflicts are with the 
misc_devel_3.4 branch patches.  Will post another pull request for you 
with those two patches dropped.  But if you're pulling these into a 
different branch, please let me know...


- Paul
