From: David Brownell <david-b@pacbell.net>
Subject: Re: Suggestion regarding the ordering of GPIO MUX configurations
Date: Mon, 2 Mar 2009 11:41:33 -0800
Message-ID: <200903021141.33650.david-b@pacbell.net>
References: <4d34a0a70903011837k2a1467b5s9c3b56e065d4b5c8@mail.gmail.com> <20090302164008.GA11864@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n25.bullet.mail.mud.yahoo.com ([68.142.206.220]:39418 "HELO
	n25.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752479AbZCBTlh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Mar 2009 14:41:37 -0500
In-Reply-To: <20090302164008.GA11864@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kim Kyuwon <chammoru@gmail.com>, OMAP <linux-omap@vger.kernel.org>

On Monday 02 March 2009, Tony Lindgren wrote:
> 
> > I wonder if we can sort the order of GPIO MUX configurations and then
> > insert new MUXs at right position. Can I ask your opinions?
> 
> Yes, I was thinking about the same. I'll combine the pending mux patches
> and merge them into a single patch for mainline tree. While doing that
> I'll sort them by gpio number. Will post the patch here for testing
> probably today.

Another thing to consider is eliminating the bugs that can
come from having the mux.c MUX_CFG_*() entries not match the
mux.h order; accidents happen.  The simplest fix changes

	MUX_CFG_X("string", ...)

		==> {
			.name = string,
			...
		},

to MUX_CFG_X(enum, ...)

		==> [enum] = {
			.name = #enum,
			...
		},

and adds a smidgeon of logic to verify a given mux table entry
has been initialized before using it.

- Dave


