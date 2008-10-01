From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/3] [RFC] clk: introduce clk_associate
Date: Wed, 1 Oct 2008 09:15:45 -0700
Message-ID: <200810010915.46032.david-b@pacbell.net>
References: <1222857363-25055-1-git-send-email-felipe.balbi@nokia.com> <200810010851.47774.david-b@pacbell.net> <20081001155755.GG7412@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:48725 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751864AbYJAQPv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Oct 2008 12:15:51 -0400
In-Reply-To: <20081001155755.GG7412@gandalf.research.nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>

On Wednesday 01 October 2008, Felipe Balbi wrote:
> > So mirroring "at91_clock_associate()" ... maybe this
> > should be "omap_clock_associate()" not "clk_associate()".
> 
> Well, I'm ok with that but I'd rather see clk_associate() moving to
> clk api so anyone who needs that, could use it.

Seems like that's an "implementor's interface" rather
than a "user's interface".

So something like a "clock library" (duck!) might be
a good place for such a call... ;)

- dave

