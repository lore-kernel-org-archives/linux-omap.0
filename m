From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH OMAPZOOM] OMAP: DMA: Fix CCR programming for request
	line > 63
Date: Thu, 8 Jan 2009 15:52:33 +0200
Message-ID: <20090108135233.GL27566@atomide.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02DF30302E@dbde02.ent.ti.com> <FCCFB4CDC6E5564B9182F639FC356087024A0ADF11@dbde02.ent.ti.com> <20090108133119.GH27566@atomide.com> <dbdb2ea60901080540k740b7a9dscd940bcd0c9f6c01@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:52883 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756192AbZAHNwf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jan 2009 08:52:35 -0500
Content-Disposition: inline
In-Reply-To: <dbdb2ea60901080540k740b7a9dscd940bcd0c9f6c01@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: twebb <taliaferro62@gmail.com>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

* twebb <taliaferro62@gmail.com> [090108 15:40]:
> >
> > Sorry for the long delay with this. Pushing to l-o tree and
> > added to omap-fixes queue.
> >
> 
> Probably understood by most of you, but what is the difference between
> "pushing to l-o tree" and "adding to omap-fixes queue"?  What are the
> omap-fixes queued for if not the l-o tree?  I'm trying to understand
> the flow of fixes/changes in the l-o tree, but it's obviously not
> clear to me yet.

Well l-o tree is short for the linux-omap tree. Then I have various
queues of stuff going into the mainline kernel:

omap-fixes
omap-upstream
omap1-upstream
omap2-upstream
omap3-upstream
...

Out of these queues omap-fixes will be sent out as needed during the
-rc cycle, while omap*-upstream queues are stuff for the next merge
window.

These branches show up at the git web interface at the bottom:

http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=summary

Not that many patches in these queues right now, btw.

Tony
