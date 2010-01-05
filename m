From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap: make serial_in_override() address the right uart
 port
Date: Tue, 5 Jan 2010 10:16:31 -0800
Message-ID: <20100105181631.GE12378@atomide.com>
References: <1262710660-25376-1-git-send-email-virtuoso@slind.org>
 <20100105180300.GC12378@atomide.com>
 <20100105180905.GF29059@shisha.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:63915 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754730Ab0AESQd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jan 2010 13:16:33 -0500
Content-Disposition: inline
In-Reply-To: <20100105180905.GF29059@shisha.kicks-ass.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Mika Westerberg <ext-mika.1.westerberg@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>

* Alexander Shishkin <virtuoso@slind.org> [100105 10:08]:
> On Tue, Jan 05, 2010 at 10:03:01 -0800, Tony Lindgren wrote:
> > * Alexander Shishkin <virtuoso@slind.org> [100105 08:56]:
> > > Commit f62349ee9788b1d94c55eb6c291d74a1f69bdd9e makes it possible to
> > > have some other than first uart port as ttyS0, which breaks the workaround
> > > serial_in_override() function which will try to address the first uart
> > > port (for ttyS0) and not the one that was initialized.
> > 
> > Nothing wrong with this patch.. But so we're back to having the ports move
> > around again? That sucks. I wonder if we can initialize dummy 8250 ports
> > somehow to keep the order correct to avoid confusion.
> 
> It doesn't seem like any solution to this problem will suck less than the
> current one, but let's think about it. My patch only addresses the issue I'm
> having with the current solution.

Agreed, we need to fix the problem first.

Regards,

Tony
