From: James Bottomley <James.Bottomley@suse.de>
Subject: Re: [linux-pm] suspend blockers & Android integration
Date: Fri, 11 Jun 2010 09:28:22 -0500
Message-ID: <1276266502.2862.74.camel@mulgrave.site>
References: <527264.20535.qm@web180316.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <527264.20535.qm@web180316.mail.gq1.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Brian Swetland <swetland@google.com>, Pavel Machek <pavel@ucw.cz>, tytso@mit.edu, Peter Zijlstra <a.p.zijlstra@chello.nl>, Florian Mickler <florian@mickler.org>, Neil Brown <neilb@suse.de>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux PM <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Felipe Balbi <felipe.balbi@nokia.com>
List-Id: linux-omap@vger.kernel.org

On Thu, 2010-06-10 at 21:21 -0700, David Brownell wrote:
> Do we at least have a clean way that a driver can
> reject a system suspend?  I've lost track of many
> issues, but maybe this could be phrased as a QOS
> constraint:  the current config of driver X needs
> clock Y active to enter the  target system suspend
> state, driver's suspend() method reports as much.  Then the entry to
> that system state gets blocked
> if the clock isn't enabled.

So in QoS modifications to android patches, the answer is "yes" ...
except that the current android patch set didn't actually have this type
of wakelock in it.

Android wants an idleness suspend block (or pm qos constraint) that a
driver can set to prevent the system idleness power govenor from
dropping into a power state too low for the driver, so in USB terms this
would prevent the states that shut down the clock.  For android, it
prevented shutdown of an internal i2c bus.

The one thing that does look difficult is that these power constraints
are device (and sometimes SoC) specific.  Expressing them in a generic
way for the cpu govenors to make sense of might be hard.

> (That QOS constraint should be removed when that
> driver no longer needs to issue wakeups; that's
> not quite the same as "removed by driver.resume().

The USB one needs user input, doesn't it, since user hot plug might (or
might not) be one of the wakeup sources.

James
