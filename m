From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] perf: Use raw_smp_processor_id insted of
	smp_processor_id
Date: Wed, 12 Sep 2012 21:52:47 +0100
Message-ID: <20120912205247.GG28448@n2100.arm.linux.org.uk>
References: <1347450610-4342-1-git-send-email-rogerq@ti.com> <20120912120511.GD28448@n2100.arm.linux.org.uk> <5050D80D.90002@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:59848 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753688Ab2ILUyH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Sep 2012 16:54:07 -0400
Content-Disposition: inline
In-Reply-To: <5050D80D.90002@codeaurora.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Roger Quadros <rogerq@ti.com>, khilman@deeprootsystems.com, linux-omap@vger.kernel.org, jean.pihet@newoldbits.com, linux-arm-kernel@lists.infradead.org

On Wed, Sep 12, 2012 at 11:44:29AM -0700, Stephen Boyd wrote:
> On 09/12/12 05:05, Russell King - ARM Linux wrote:
> > NAK.  Using a different function which doesn't have the warning isn't a
> > subsitute for fixing the problem properly.  What you're doing is papering
> > over the bug, making the warning go away without properly understanding
> > the problem.
> >
> > The warning is there because something is being done wrong.  What that is
> > is exactly what is being said in the warning message.  You're getting a
> > CPU number in a context where preemptions can occur - and therefore the
> > CPU that you're running on can change.
> >
> > Think about this sequence:
> >
> > 	- cpu = smp_processor_id(); /* returns 0 */
> > 	- you are preempted
> > 	- you resume on CPU 1
> > 	- trace_clock_disable(clk->name, 0, 0);
> >
> > If trace_clock_disable() uses the CPU number to access per-CPU data
> > without locking, that's going to cause corruption.
> >
> > Please, if you're going to fix a warning, analyse it properly first and
> > don't just search for a function which appears to give you the same
> > functionality but without the warning message.
> 
> Is anyone actually using the CPU field in this tracepoint?

No idea, but for the point I'm raising, that's rather irrelevant... we
need to nip these things in the bud before they become more common
through allowing the misunderstanding to propagate.

> I don't see
> any usecase for it except for the case where you have a percpu clock,

Which actually makes it all the more important to get the right CPU
number, and to have atomicity between reading the CPU number and reading
the percpu clock... without that the results may well be meaningless.

If the use of a CPU number can be eliminated, then it should be.  If not,
the proper fix for this is to use interfaces which prevent pre-emption
occuring during the critical region - so get_cpu() and put_cpu().
