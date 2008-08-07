From: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
Subject: RE: [PATCH] Enable SYSOFFMODE use
Date: Thu, 07 Aug 2008 10:11:15 +0300
Message-ID: <1218093075.31074.43.camel@kj-ubuntu>
References: <1216656125-5800-1-git-send-email-peter.de-schrijver@nokia.com>
	 <1216656125-5800-2-git-send-email-peter.de-schrijver@nokia.com>
	 <20080805105057.GQ7193@atomide.com> <1218021337.29799.60.camel@kj-ubuntu>
	 <13B9B4C6EF24D648824FF11BE89671620361F4E8CC@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:42043 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751822AbYHGHIv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Aug 2008 03:08:51 -0400
In-Reply-To: <13B9B4C6EF24D648824FF11BE89671620361F4E8CC@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Woodruff, Richard" <r-woodruff2@ti.com>
Cc: ext Tony Lindgren <tony@atomide.com>, "Nayak, Rajendra" <rnayak@ti.com>, Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>, linux-omap <linux-omap@vger.kernel.org>

On ke, 2008-08-06 at 12:12 -0500, ext Woodruff, Richard wrote:
> > I would say no, we don't need the CONFIG_SYSOFFMODE option.
> 
> One point is if you try an go to 0v on something under and ES2.1 you
> will end up with crashes after a while.  Some kind of conditional is
> needed unless we get to drop the non-production chip versions.

OK. We can replace the macros with run-time checks. But for ES2.1
suspending to 0V should be safe, right?

> 
> Before ES2.1 there is a ROM code bug which will trip up the context
> restore.

So ES2.0 is also affected, good to know.

> 
> Really, it would be good to schedule some time to kill ES1 support.
> The chip is so different its really just baggage.  With cheap and
> available OMAP3's out there they are really not viable.

I've got ES2.0, so no objections from me. Anyone want to confess still
using ES1.0? Tony, what do you think?

> 
> As to C state, I'm not sure, just yet.  If we end up with too many of
> them there is some overhead in determining thresholds, then trying to
> tweak a governor to choose them smartly?  It's a little while before
> this code get to that point, but the process seem to be a bit time
> consuming on internal.

OK, so I think we go with the user selectable "sysoff_while_idle" sysfs
interface and not mess up the C-states. I see Rajendra posted a
refreshed set of patches, so maybe we'll have the C-states in mainline
soon.

regards,
Kalle

> 
> Regards,
> Richard W.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
