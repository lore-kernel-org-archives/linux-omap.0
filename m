From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-pm] suspend blockers & Android integration
Date: Thu, 10 Jun 2010 21:21:39 -0700 (PDT)
Message-ID: <527264.20535.qm@web180316.mail.gq1.yahoo.com>
References: <20100610135844.GH4514@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n5.bullet.mail.gq1.yahoo.com ([67.195.9.85]:46683 "HELO
	n5.bullet.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750932Ab0FKEVk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Jun 2010 00:21:40 -0400
In-Reply-To: <20100610135844.GH4514@ucw.cz>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brian Swetland <swetland@google.com>, Pavel Machek <pavel@ucw.cz>
Cc: tytso@mit.edu, Peter Zijlstra <a.p.zijlstra@chello.nl>, Florian Mickler <florian@mickler.org>, Neil Brown <neilb@suse.de>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, James Bottomley <James.Bottomley@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux PM <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Felipe Balbi <felipe.balbi@nokia.com>

This is a bit off the topic of Android
flamage, but I thought it would be worth
highlighting an example where the current
frameworks may still have a deficiency...
one that likewise relates to needing to
block entry ot a system suspend state, but
in this case user-space isn't very involved
(just drivers coping with hardware).

The example I wanted to re-post (I've done so
in the past) is one where drivers ouldn't really
do the right thing, since driver.suspend() wasn't
quite powerful enough as a programming interface.

The example works with USB on many ARM SoCs,
and similar non-USB examples aren't rare.

 - Want to enter a system suspend state, with
   some USB wakeup sources.  USB peripheral
   waken up by the host, or vice versa.

   NOTE ASSUMPTION:  there are multiple suspend
   states supported by the hardware, significantly
   different in hardware configuration Linux should
   be able to use more than one such state... (if
   only because their power savings differ.)  This
can mean driver-specific knowledge about those
various states.

 - The wakeup requires a particular clock to be active, so the USB controller can detect that the
wakeup should trigger,  then issue the right signals
triggering the non-USB parts of the system.

Problem:  how does the device driver suspend()
          method block entry to a suspend state
          when it can't ensure that clock is
          going to be active.  Magic return code?

 There are other issues here too.  (Is the target
 system suspend state one of the ones which doesn't
allow that clock to be active?  SoC-specific calls
might suffice for this issue.

 

A number of years ago, this problem was insoluble
with the then-current Linux PM and clock frameworks.
I've been away from this issue for quite a while
now, but don't recall seeing its sub-problems get
solved ... If they're now solved, I'll be glad.
(I know Kevin's recent OMAP stuff addresses similar
issues, but It's OMAP-specific...) 

After all these thousands and thousands of emails...
I'm not sure how much forward motion has happened.

Do we at least have a clean way that a driver can
reject a system suspend?  I've lost track of many
issues, but maybe this could be phrased as a QOS
constraint:  the current config of driver X needs
clock Y active to enter the  target system suspend
state, driver's suspend() method reports as much.  Then the entry to that system state gets blocked
if the clock isn't enabled.

(That QOS constraint should be removed when that
driver no longer needs to issue wakeups; that's
not quite the same as "removed by driver.resume().




