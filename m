From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/33] OMAPDSS: platform_enable/disable callback
 removal from panel drivers
Date: Mon, 15 Apr 2013 14:20:22 -0700
Message-ID: <20130415212022.GP10155@atomide.com>
References: <1360765345-19312-1-git-send-email-archit@ti.com>
 <20130213164647.GF7144@atomide.com>
 <515C2058.8030402@ti.com>
 <20130403154645.GV10155@atomide.com>
 <516BC897.5020802@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63700 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755007Ab3DOVUY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Apr 2013 17:20:24 -0400
Content-Disposition: inline
In-Reply-To: <516BC897.5020802@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [130415 02:34]:
> Hi Tony,
> 
> On 2013-04-03 18:46, Tony Lindgren wrote:
> 
> >> Tony, I've split these patches as follows:
> >>
> >> Platform data header file changes:
> >> git://gitorious.org/linux-omap-dss2/linux.git 3.10/0-dss-headers
> >>
> >> Board file changes (based on header changes):
> >> git://gitorious.org/linux-omap-dss2/linux.git 3.10-lo/board-cleanup
> >>
> >> DSS panel changes (based on header changes):
> >> git://gitorious.org/linux-omap-dss2/linux.git 3.10/1-panel-cleanup
> >>
> >> Removing unused fields from header files (based on panel changes):
> >> git://gitorious.org/linux-omap-dss2/linux.git 3.10/2-late-panel-cleanup
> >>
> >> The 2-late-panel-cleanup breaks compilation if the arch changes are not
> >> merged, so I'll leave that until they have been merged.
> >>
> >> Do you mind if I add the board-cleanup branch temporarily to omapdss's
> >> for-next, to simplify testing? When everything looks ok, I'll remove it
> >> and pass the branch to you to be handled through l-o.
> > 
> > Sure please go ahead. There are still some board-*.c related patches
> > that I have not merged, but we'll see those merge conflicts before
> > next as I usually do a merge with next before sending out pull reqs.
> 
> The code seems to work ok, so I think we can declare the branches
> stable. I've pushed new for-next branch that does not contain the arch
> files anymore. In fact, I removed all omapdss patches also, as omapdss
> should be merged through the drm tree, and I don't want to have
> conflicts with drm's for-next branch.
> 
> So, to recap, the common header changes are located in:
> 
> git://gitorious.org/linux-omap-dss2/linux.git 3.10/0-dss-headers
> 
> And the branch for linux-omap is:
> 
> git://gitorious.org/linux-omap-dss2/linux.git 3.10-lo/board-cleanup
> 
> After merging those, some displays won't start anymore until the omapdss
> changes are in, but things should still compile.

Sounds like it's best that you merge those branches via your
tree as the conflicts have been already resolved in linux next.

Regards,

Tony
