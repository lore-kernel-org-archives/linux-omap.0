From: Tony Lindgren <tony@atomide.com>
Subject: Re: About to tag v2.6.28-omap1 on Friday
Date: Thu, 8 Jan 2009 13:12:02 +0200
Message-ID: <20090108111201.GZ27566@atomide.com>
References: <1231410153.13843.46.camel@eenurkka-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56938 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752739AbZAHLME (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jan 2009 06:12:04 -0500
Content-Disposition: inline
In-Reply-To: <1231410153.13843.46.camel@eenurkka-desktop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Cc: linux-omap@vger.kernel.org

* Eero Nurkkala <ext-eero.nurkkala@nokia.com> [090108 12:25]:
> > Looks like we now have some McBSP clock issue probably related
> > to the custom clock:
> 
> Could you please try:
> http://marc.info/?l=linux-omap&m=122597514326263&w=2
> 
> And possibly ack the patch?

Well this has been on hold as we don't know yet if we should
use or not use custom clocks.

Custom clocks allow combining multiple clocks into a single clock,
which makes it easy to use in the drivers. However, custom clocks
have some problems that Paul has pointed out, like not knowing
the parent.

At this point I'd say that if Paul does not like custom clocks,
we should stop using them. Up to Paul to decide me thinks unless
somebody has better ideas.

> McBSP has a known spin-lock deadlock, why carry it around?

Would be nice to get rid of the spin-lock issue.. But this patch
still does not help with the McBSP clocks failing because the
parent is not known.

Regards,

Tony
