From: Tony Lindgren <tony@atomide.com>
Subject: Re: Preventing OMAP3 serial driver to take control of all UARTs
Date: Wed, 2 Dec 2009 17:00:52 -0800
Message-ID: <20091203010051.GP4348@atomide.com>
References: <20091130084651.GA17675@esdhcp04058.research.nokia.com>
 <1259599010.4649.51.camel@thunk>
 <fa686aa40911300901nd47259ar2e1beae7be447937@mail.gmail.com>
 <20091130194031.GV4348@atomide.com>
 <fa686aa40912020707p70eb693dp6fcd03facabb5892@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:50284 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759AbZLCBAu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Dec 2009 20:00:50 -0500
Content-Disposition: inline
In-Reply-To: <fa686aa40912020707p70eb693dp6fcd03facabb5892@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Peter Barada <peterb@logicpd.com>, Mika Westerberg <ext-mika.1.westerberg@nokia.com>, linux-omap@vger.kernel.org, Olof Johansson <olof@lixom.net>

* Grant Likely <grant.likely@secretlab.ca> [091202 07:06]:
> On Mon, Nov 30, 2009 at 12:40 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Grant Likely <grant.likely@secretlab.ca> [091130 09:01]:

<snip>

> >
> > maybe you've already thought through all this.. But would it be
> > possible to do lightweight device tree that we just use to populate
> > the platform data?
> 
> This is completely possible.  Just having the device tree available
> doesn't force the kernel to use it for everything.  I've found it
> useful to start small and add things as I need them.  Most important
> thing to remember is to follow the documented & established device
> tree conventions so that common code can understand it.

OK, sounds good to me.

Tony
