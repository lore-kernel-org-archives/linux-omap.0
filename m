From: Tony Lindgren <tony@atomide.com>
Subject: Re: Suggestion regarding the ordering of GPIO MUX configurations
Date: Mon, 2 Mar 2009 09:47:10 -0800
Message-ID: <20090302174709.GE11864@atomide.com>
References: <4d34a0a70903011837k2a1467b5s9c3b56e065d4b5c8@mail.gmail.com> <20090302164008.GA11864@atomide.com> <1236015099.15937.79.camel@blackhole>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:51769 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752624AbZCBRrR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Mar 2009 12:47:17 -0500
Content-Disposition: inline
In-Reply-To: <1236015099.15937.79.camel@blackhole>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Barada <peterb@logicpd.com>
Cc: Kim Kyuwon <chammoru@gmail.com>, OMAP <linux-omap@vger.kernel.org>, David Brownell <david-b@pacbell.net>

* Peter Barada <peterb@logicpd.com> [090302 09:31]:
> On Mon, 2009-03-02 at 08:40 -0800, Tony Lindgren wrote:
> > * Kim Kyuwon <chammoru@gmail.com> [090301 18:37]:
> > > Hi All.
> > > 
> > > The current order of GPIO mux configurations is not sorted. It seems
> > > that all new GPIO MUX configurations are being inserted to the end as
> > > shown in next code
> > > 
> > > /* arch/arm/plat-omap/include/mach/mux.h */
> > > 791         AH8_34XX_GPIO29,
> > > 792         J25_34XX_GPIO170,
> > > 793         AF26_34XX_GPIO0,
> > > 794         AF22_34XX_GPIO9,
> > > 795         L8_34XX_GPIO63,
> > > 796         AF6_34XX_GPIO140_UP,
> > > 797         AE6_34XX_GPIO141,
> > > 798         AF5_34XX_GPIO142,
> > > 799         AE5_34XX_GPIO143,
> > > 800         AG4_34XX_GPIO134,
> > > 801         U8_34XX_GPIO54,
> > > 802         AE4_34XX_GPIO136,
> > > 
> > > 
> > > I wonder if we can sort the order of GPIO MUX configurations and then
> > > insert new MUXs at right position. Can I ask your opinions?
> > 
> > Yes, I was thinking about the same. I'll combine the pending mux patches
> > and merge them into a single patch for mainline tree. While doing that
> > I'll sort them by gpio number. Will post the patch here for testing
> > probably today.
> 
> Thinking about this, I wonder if it would be better to remove the enum
> entirely and just pass the pin name (as a string) to omap_cfg_reg() and
> have it search the table for a matching entry.
> 
> 1) This removes the necessary lockstep ordering in the enum and the
> pinmux table - hence grouping pins by use/name/gpio number is easy.
> 
> 2) allows for an optional mux table for each machine as part of the
> initialization to override arch/arm/mach-omap2/mux.c definitions (think
> of using external versus internal pullup/down registers) as well as
> extend the mux table for that board(per-board GPIO pin mux definitions).
> 
> 3) Setting up the pinmux is something that is done at startup, or rarely
> changed afterwards - as far as I can see, its not time-critical.

Well for omap3 and later, we should probably just switch to defining the
pin registers, then pass the desired value to the function. The current
mux code is unnecessary complicated for current hardware. It works for
omap1 where the mux registers need to be changed at several locations.

Regards,

Tony
