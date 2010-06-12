From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [linux-pm] suspend blockers & Android integration
Date: Sat, 12 Jun 2010 18:10:13 +0100
Message-ID: <20100612171013.GA3151@sirena.org.uk>
References: <1276268539.2862.92.camel@mulgrave.site>
 <Pine.LNX.4.44L0.1006111638040.19894-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1006111638040.19894-100000@netrider.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: James Bottomley <James.Bottomley@suse.de>, David Brownell <david-b@pacbell.net>, tytso@mit.edu, Peter Zijlstra <a.p.zijlstra@chello.nl>, Neil Brown <neilb@suse.de>, Brian Swetland <swetland@google.com>, Felipe Balbi <felipe.balbi@nokia.com>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Linux PM <linux-pm@lists.linux-foundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-omap@vger.kernel.org

On Fri, Jun 11, 2010 at 04:48:15PM -0400, Alan Stern wrote:
> On Fri, 11 Jun 2010, Mark Brown wrote:

> > The clock framework is implemented independantly for each CPU.

> That's not an impediment, since drivers' requirements regarding which 
> clocks remain running in which power states are necessarily 
> platform-dependent also.

It does mean that you can't make any general statements about what the
clock framework does and doesn't do which is what the person I was
replying to (the quoting you did as you cut'n'pasted replies to multiple
messages seems more than a little confused, sorry) seemed to want.
