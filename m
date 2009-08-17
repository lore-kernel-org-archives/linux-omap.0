From: Tony Lindgren <tony@atomide.com>
Subject: Re: linux-omap-2.6 git not updated?
Date: Mon, 17 Aug 2009 10:24:49 +0300
Message-ID: <20090817072448.GH7278@atomide.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB03060505F9@dbde02.ent.ti.com> <20090812134839.GJ7278@atomide.com> <20090812174103.GO7278@atomide.com> <87hbwbhgpq.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50120 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752062AbZHQHYv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Aug 2009 03:24:51 -0400
Content-Disposition: inline
In-Reply-To: <87hbwbhgpq.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, linux-omap <linux-omap@vger.kernel.org>

* Kevin Hilman <khilman@deeprootsystems.com> [090813 18:32]:
> Tony Lindgren <tony@atomide.com> writes:
> 
> > * Tony Lindgren <tony@atomide.com> [090812 16:48]:
> >> * Gadiyar, Anand <gadiyar@ti.com> [090812 16:27]:
> >> > Tony,
> >> > 
> >> > Is something wrong with the kernel.org mirror? The last commit
> >> > I see is:
> >> > 
> >> > commit 4baadee6e2dd5228e1b17cb5f931c4e0ed8fcb96
> >> > Author: Anand Gadiyar <gadiyar@ti.com>
> >> > Date:   Wed Aug 5 16:22:59 2009 +0300
> >> > 
> >> > I do see that the other branches (upstream, omap4, ...)
> >> > are updated. Looks like only the master is not yet
> >> > reflecting the patches you applied in the last 7 days.
> >> 
> >> Yeah I have not updated master yet with the patches going upstream.
> >> Will reset arch/arm/*omap* in master, and merge in the posted
> >> upstream branches.
> >
> > Updated now with the patches queued for mainline.
> >
> 
> Tony,
> 
> Can you merge in the .31 fixes branches that RMK has already pulled
> in also?  These are the PM fixes from me and Paul's fixes branch.

Those should be all there now. Sounds like we need to rebase our
merge window branches after the fixes go into mainline.

Regards,

Tony
