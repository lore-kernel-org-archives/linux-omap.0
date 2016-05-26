From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [GIT PULL arm] Use _rcuidle tracepoints to allow tracing from idle
Date: Thu, 26 May 2016 09:26:06 -0700
Message-ID: <20160526162606.GA20023@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, linux@roeck-us.net, tony@atomide.com, linux@arm.linux.org.uk, rostedt@goodmis.org, rjw@rjwysocki.net, pavel@ucw.cz, mturquette@baylibre.com, sboyd@codeaurora.org
List-Id: linux-omap@vger.kernel.org

Hello, Ingo,

This series changes a number of event tracepoints to their _rcuidle() form
to allow use from idle without lockdep-RCU complaints, a straightforward
modification that has been successfully applied many times.  These splats
were found in testing by Guenter Roeck and Tony Lindgren, who have
both successfully tested the full series.  Tony asked that I carry these
in -rcu:

	http://lkml.kernel.org/g/20160426213630.GV5995@atomide.com

These have been posted to LKML, CCing relevant maintainers, who have
not objected to the proposed changes:

	http://lkml.kernel.org/g/20160516184844.GA20144@linux.vnet.ibm.com

These maintainers are also CCed on this pull request.

They have also been subjected to 0day Test Robot and -next testing.

							Thanx, Paul
