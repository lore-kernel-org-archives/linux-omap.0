From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH omap v2 0/6] Fix OMAP uses of RCU from idle loop
Date: Mon, 16 May 2016 11:48:44 -0700
Message-ID: <20160516184844.GA20144@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-clk-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org
Cc: tony@atomide.com, mingo@kernel.org, linux@roeck-us.net, rostedt@goodmis.org
List-Id: linux-omap@vger.kernel.org

Hello!

The following series fixes a number of uses of RCU from the idle loop.
These are all due to tracing, so the fix is simply to append _rcuidle
to the event-tracing call.

Changes since v1: Fix commit-log subjects and add maintainers on CC.

							Thanx, Paul

------------------------------------------------------------------------

 arch/arm/kernel/smp.c             |    2 +-
 arch/arm/mach-omap2/powerdomain.c |    9 +++++----
 drivers/base/power/runtime.c      |   14 +++++++-------
 drivers/clk/clk.c                 |    8 ++++----
 4 files changed, 17 insertions(+), 16 deletions(-)

