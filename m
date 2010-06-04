From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: suspend blockers & Android integration
Date: Fri, 04 Jun 2010 12:08:23 +0200
Message-ID: <1275646103.27810.39526.camel@twins>
References: <20100603193045.GA7188@elte.hu> <20100603231153.GA11302@elte.hu>
	 <20100603232302.GA16184@elte.hu> <1275644619.27810.39462.camel@twins>
	 <1275645245.27810.39493.camel@twins>  <20100604100306.GB3324@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100604100306.GB3324@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: tytso@mit.edu, Brian Swetland <swetland@google.com>, Neil Brown <neilb@suse.de>, Arve Hj?nnev?g <arve@android.com>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <felipe.balbi@nokia.com>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, James Bottomley <James.Bottomley@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, Kevin Hilman <khilman@deeprootsystems.com>, "H. Peter Anvin" <hpa@zytor.com>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-omap@vger.kernel.org

On Fri, 2010-06-04 at 12:03 +0200, Ingo Molnar wrote:

> > The only 'interesting' issue I can see here is that if you create 1000 
> > CLOCK_MONOTONIC namepaces, we'd need to have a tree of trees in order to 
> > efficiently find the leftmost timer.
> 
> Realistically Android userspace would create just a single such namespace for 
> all the untrusted/unknown/uncontrolled apps, right?

Possibly, yeah. 

But it might not stop someone else from create an insane amount of them.
So we do need to deal with that, and a linear loop over all timer bases,
which then will be a user controlled quantity, just doesn't sound
right :-)
