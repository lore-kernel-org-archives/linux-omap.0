From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] ARM/hw_breakpoint: Fix possible recursive locking for
 arch_hw_breakpoint_init
Date: Fri, 16 Jun 2017 17:42:45 +0200
Message-ID: <20170616154245.5fry4lclgmp3gfdi@linutronix.de>
References: <20170616082238.15553-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170616082238.15553-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Russell King <linux@armlinux.org.uk>
List-Id: linux-omap@vger.kernel.org

On 2017-06-16 01:22:38 [-0700], Tony Lindgren wrote:
> Recent change to use cpuhp_setup_state_cpuslocked() with commit
> fe2a5cd8aa03 ("ARM/hw_breakpoint: Use cpuhp_setup_state_cpuslocked()")
> missed to change the related paired cpuhp_remove_state_nocalls_cpuslocked().
> 
> Now if arch_hw_breakpoint_init() fails, we get "WARNING: possible recursive
> locking detected" on the exit path.
> 
> Fixes: fe2a5cd8aa03 ("ARM/hw_breakpoint: Use
> cpuhp_setup_state_cpuslocked()")
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Thank you.

Sebastian
