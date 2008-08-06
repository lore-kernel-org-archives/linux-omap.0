From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH] Enable SYSOFFMODE use
Date: Wed, 6 Aug 2008 12:12:51 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE89671620361F4E8CC@dlee02.ent.ti.com>
References: <1216656125-5800-1-git-send-email-peter.de-schrijver@nokia.com>
	 <1216656125-5800-2-git-send-email-peter.de-schrijver@nokia.com>
	 <20080805105057.GQ7193@atomide.com> <1218021337.29799.60.camel@kj-ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:56246 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755686AbYHFRNL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Aug 2008 13:13:11 -0400
In-Reply-To: <1218021337.29799.60.camel@kj-ubuntu>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>, ext Tony Lindgren <tony@atomide.com>, "Nayak, Rajendra" <rnayak@ti.com>
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>, linux-omap <linux-omap@vger.kernel.org>

> I would say no, we don't need the CONFIG_SYSOFFMODE option.

One point is if you try an go to 0v on something under and ES2.1 you will end up with crashes after a while.  Some kind of conditional is needed unless we get to drop the non-production chip versions.

Before ES2.1 there is a ROM code bug which will trip up the context restore.

Really, it would be good to schedule some time to kill ES1 support.  The chip is so different its really just baggage.  With cheap and available OMAP3's out there they are really not viable.

As to C state, I'm not sure, just yet.  If we end up with too many of them there is some overhead in determining thresholds, then trying to tweak a governor to choose them smartly?  It's a little while before this code get to that point, but the process seem to be a bit time consuming on internal.

Regards,
Richard W.

