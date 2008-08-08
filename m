From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH] Enable SYSOFFMODE use
Date: Thu, 7 Aug 2008 20:18:12 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE89671620361FBB894@dlee02.ent.ti.com>
References: <1216656125-5800-1-git-send-email-peter.de-schrijver@nokia.com>
	 <1216656125-5800-2-git-send-email-peter.de-schrijver@nokia.com>
	 <20080805105057.GQ7193@atomide.com> <1218021337.29799.60.camel@kj-ubuntu>
	 <13B9B4C6EF24D648824FF11BE89671620361F4E8CC@dlee02.ent.ti.com>
 <1218093075.31074.43.camel@kj-ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:47059 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752660AbYHHBS2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Aug 2008 21:18:28 -0400
In-Reply-To: <1218093075.31074.43.camel@kj-ubuntu>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
Cc: ext Tony Lindgren <tony@atomide.com>, "Nayak, Rajendra" <rnayak@ti.com>, Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>, linux-omap <linux-omap@vger.kernel.org>

> On ke, 2008-08-06 at 12:12 -0500, ext Woodruff, Richard wrote:
> > > I would say no, we don't need the CONFIG_SYSOFFMODE option.
> >
> > One point is if you try an go to 0v on something under and ES2.1 you
> > will end up with crashes after a while.  Some kind of conditional is
> > needed unless we get to drop the non-production chip versions.
>
> OK. We can replace the macros with run-time checks. But for ES2.1
> suspending to 0V should be safe, right?

It has been ok in our tests so far.

Regards,
Richard W.
