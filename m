From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] perf: Use raw_smp_processor_id insted of
	smp_processor_id
Date: Wed, 12 Sep 2012 13:05:11 +0100
Message-ID: <20120912120511.GD28448@n2100.arm.linux.org.uk>
References: <1347450610-4342-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:59364 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757637Ab2ILMG0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Sep 2012 08:06:26 -0400
Content-Disposition: inline
In-Reply-To: <1347450610-4342-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: khilman@deeprootsystems.com, linux-omap@vger.kernel.org, sboyd@codeaurora.org, jean.pihet@newoldbits.com, linux-arm-kernel@lists.infradead.org

On Wed, Sep 12, 2012 at 02:50:10PM +0300, Roger Quadros wrote:
> gets rid of below messages with CONFIG_DEBUG_PREEMPT enabled
> 
> [   28.832916] debug_smp_processor_id: 18 callbacks suppressed
> [   28.832946] BUG: using smp_processor_id() in preemptible [00000000] code: modprobe/1763
> [   28.841491] caller is pwrdm_set_next_pwrst+0x54/0x120
> 
> Tested with perf on OMAP4 Panda.

NAK.  Using a different function which doesn't have the warning isn't a
subsitute for fixing the problem properly.  What you're doing is papering
over the bug, making the warning go away without properly understanding
the problem.

The warning is there because something is being done wrong.  What that is
is exactly what is being said in the warning message.  You're getting a
CPU number in a context where preemptions can occur - and therefore the
CPU that you're running on can change.

Think about this sequence:

	- cpu = smp_processor_id(); /* returns 0 */
	- you are preempted
	- you resume on CPU 1
	- trace_clock_disable(clk->name, 0, 0);

If trace_clock_disable() uses the CPU number to access per-CPU data
without locking, that's going to cause corruption.

Please, if you're going to fix a warning, analyse it properly first and
don't just search for a function which appears to give you the same
functionality but without the warning message.
