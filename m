From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL arm] Use _rcuidle tracepoints to allow tracing from
 idle
Date: Wed, 8 Jun 2016 15:33:50 +0200
Message-ID: <20160608133350.GA18357@gmail.com>
References: <20160526162606.GA20023@linux.vnet.ibm.com>
 <20160526162727.GA21784@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160526162727.GA21784@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Russell King <linux@armlinux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, linux@roeck-us.net, tony@atomide.com, linux@arm.linux.org.uk, rostedt@goodmis.org, rjw@rjwysocki.net, pavel@ucw.cz, mturquette@baylibre.com, sboyd@codeaurora.org
List-Id: linux-omap@vger.kernel.org


* Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:

> On Thu, May 26, 2016 at 09:26:06AM -0700, Paul E. McKenney wrote:
> > Hello, Ingo,
> > 
> > This series changes a number of event tracepoints to their _rcuidle() form
> > to allow use from idle without lockdep-RCU complaints, a straightforward
> > modification that has been successfully applied many times.  These splats
> > were found in testing by Guenter Roeck and Tony Lindgren, who have
> > both successfully tested the full series.  Tony asked that I carry these
> > in -rcu:
> > 
> > 	http://lkml.kernel.org/g/20160426213630.GV5995@atomide.com
> > 
> > These have been posted to LKML, CCing relevant maintainers, who have
> > not objected to the proposed changes:
> > 
> > 	http://lkml.kernel.org/g/20160516184844.GA20144@linux.vnet.ibm.com
> > 
> > These maintainers are also CCed on this pull request.
> > 
> > They have also been subjected to 0day Test Robot and -next testing.
> 
> And this time actually including the pull request...  :-/
> 
> 							Thanx, Paul
> 
> These changes are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git for-mingo
> 
> for you to fetch changes up to e7c38dda94b23965a3eb46ef4656bb8cb921933d:
> 
>   arm: Use _rcuidle suffix to allow clk_core_enable() to used from idle (2016-05-18 11:55:29 -0700)
> 
> ----------------------------------------------------------------
> Paul E. McKenney (6):
>       arm: Use _rcuidle tracepoint to allow use from idle
>       arm: Use _rcuidle for suspend/resume tracepoints
>       arm: Add _rcuidle tracepoints to allow clk_core_disable() use from idle
>       arm: Add _rcuidle suffix to allow rpm_idle() use from idle
>       arm: Add _rcuidle suffix to allow rpm_resume() to be called from idle
>       arm: Use _rcuidle suffix to allow clk_core_enable() to used from idle
> 
>  arch/arm/kernel/smp.c             |  2 +-
>  arch/arm/mach-omap2/powerdomain.c |  9 +++++----
>  drivers/base/power/runtime.c      | 14 +++++++-------
>  drivers/clk/clk.c                 |  8 ++++----
>  4 files changed, 17 insertions(+), 16 deletions(-)

Just wondering, wouldn't it be better for Russell to pull/apply, as it appears to 
be a mostly ARM patch-set?

Thanks,

	Ingo
