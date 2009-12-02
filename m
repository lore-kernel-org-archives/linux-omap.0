From: Olof Johansson <olof@lixom.net>
Subject: Re: Preventing OMAP3 serial driver to take control of all UARTs
Date: Wed, 2 Dec 2009 10:16:57 -0600
Message-ID: <20091202161657.GA3903@lixom.net>
References: <20091130084651.GA17675@esdhcp04058.research.nokia.com> <1259599010.4649.51.camel@thunk> <fa686aa40911300901nd47259ar2e1beae7be447937@mail.gmail.com> <20091130194031.GV4348@atomide.com> <fa686aa40912020707p70eb693dp6fcd03facabb5892@mail.gmail.com> <20091202155319.GA3628@lixom.net> <fa686aa40912020804g34e1258k626349d711cfadd4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lixom.net ([66.141.50.11]:59691 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751824AbZLBQOv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 Dec 2009 11:14:51 -0500
Content-Disposition: inline
In-Reply-To: <fa686aa40912020804g34e1258k626349d711cfadd4@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Tony Lindgren <tony@atomide.com>, Peter Barada <peterb@logicpd.com>, Mika Westerberg <ext-mika.1.westerberg@nokia.com>, linux-omap@vger.kernel.org

On Wed, Dec 02, 2009 at 09:04:49AM -0700, Grant Likely wrote:

> Ah, you're talking about pin muxing configuration, right?  Yes, that
> GPIO binding deals with controllers, not pin mux.  Pin mux is very
> much an SoC specific thing that isn't mapped easily to a generic
> binding.

Yep.

> On the 5200, I haven't attempted to describe pin-mux in the device
> tree at all, and have either expected firmware to set it up correctly,
> or fixed it up in the platform code.

Yeah. And it's one of the things Tony commented on that firmware tends
to get wrong, seems like people aren't doing complete mux configs in
u-boot, etc.

So, if it needs to be fixed up in platform code, there will (likely) be
need for board-specific code there anyway. A bummer, since the device
tree would otherwise make it real easy to bring up new boards without
kernel code changes.


-Olof
