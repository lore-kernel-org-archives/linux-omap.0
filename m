From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] suspend blockers & Android integration
Date: Thu, 10 Jun 2010 17:44:55 +0200
Message-ID: <201006101744.55754.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1006101043510.1702-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1006101043510.1702-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Neil Brown <neilb@suse.de>, Felipe Contreras <felipe.contreras@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, david@lang.hm, Florian Mickler <florian@mickler.org>, Vitaly Wool <vitalywool@gmail.com>, Brian Swetland <swetland@google.com>, Arve =?iso-8859-1?q?Hj=F8nnev=E5g?= <arve@android.com>, Arjan van de Ven <arjan@infradead.org>, tytso@mit.edu, Peter Zijlstra <peterz@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, James Bottomley <James.Bottomley@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux PM <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Felipe Balbi <felipe.balbi@nokia.com>
List-Id: linux-omap@vger.kernel.org

On Thursday, June 10, 2010, Alan Stern wrote:
> On Thu, 10 Jun 2010, Rafael J. Wysocki wrote:
> 
> > Moreover, having thought a bit more about the "power manager in user space"
> > concept I'm not sure if it really is that better than the original wakelocks
> > idea.  Namely, it only repaces a kernel-based mechanism with a user space
> > task doing basically the same thing, but the communication between that task
> > and the other cooperating user space tasks is arguably more complicated (it
> > also uses the kernel resources, although indirectly).
> 
> That is all true.  The "power manager in userspace" was meant to prove
> a point: that this _could_ be done without invasive changes to the
> kernel.  It wasn't necessarily meant to be a _better_ solution.
> 
> > So, for a phone-like system, where you'd generally want to simplify user space,
> > having a "power manager" in the kernel seems to make sense to me.
> 
> This is a judgment call.  Obviously different people have different 
> opinions.

Agreed.

Rafael
