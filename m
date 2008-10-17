From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] omap-keypad fixes for OMAP2
Date: Fri, 17 Oct 2008 15:02:19 -0700
Message-ID: <20081017220217.GF18573@atomide.com>
References: <1222925329-28117-1-git-send-email-peter.ujfalusi@nokia.com> <20081002061237.GB7942@atomide.com> <200810021601.18006.peter.ujfalusi@nokia.com> <20081003062530.GG23962@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:59194 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753820AbYJQWCV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Oct 2008 18:02:21 -0400
Content-Disposition: inline
In-Reply-To: <20081003062530.GG23962@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [081002 23:22]:
> * Peter Ujfalusi <peter.ujfalusi@nokia.com> [081002 16:03]:
> > 
> > Hello,
> > 
> > the diff between l-o and mainline are these commits regarding to omap-keypad.c:
> > 
> > commit fdee8764947cde1e6933e7d981ce5b9de00e83e6
> > Author: Tony Lindgren <tony@atomide.com>
> > Merge current mainline tree into linux-omap tree
> 
> This should not be needed, but it's always worth checking there was no
> automerge weirdness introduced by that patch.

OK, I'll push these two to l-o tree, hopefully you're still planning
to send them to the mainline kernel?

> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
