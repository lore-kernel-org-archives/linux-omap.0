From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH arm 1/1] arm: Use _rcuidle tracepoint to allow use from
 idle
Date: Tue, 26 Apr 2016 14:36:30 -0700
Message-ID: <20160426213630.GV5995@atomide.com>
References: <20160426154414.7bb33de4@gandalf.local.home>
 <20160426195158.GR5995@atomide.com>
 <20160426200613.GO3715@linux.vnet.ibm.com>
 <20160426201134.GA29779@linux.vnet.ibm.com>
 <20160426202538.GS5995@atomide.com>
 <20160426204148.GR3715@linux.vnet.ibm.com>
 <20160426204613.GT5995@atomide.com>
 <20160426210407.GT3715@linux.vnet.ibm.com>
 <20160426211259.GU5995@atomide.com>
 <20160426212630.GV3715@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160426212630.GV3715@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, linux-omap@vger.kernel.org, mingo@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Paul E. McKenney <paulmck@linux.vnet.ibm.com> [160426 14:27]:
> Done!  These are at -rcu:
> 
> 6eeec2b4a50c (arm: Use _rcuidle tracepoint to allow use from idle)
> 0efee3da3b29 (arm: Use more _rcuidle tracepoints to allow use from idle)
> b6cdf6d22f52 (arm: Additional _rcuidle tracepoints to allow use from idle)
> 70da6fb7275b (arm: Whack another event-trace-from-idle mole)
> 019db9102c6c (arm: Whack yet another event-trace-from-idle mole)
> ebcd2861ae27 (arm: Whack an expected event-trace-from-idle mole)
> 
> So how would you like these handled?  I would be happy to send a fresh
> patch series or git pull request if you would like to send them up your
> tree, or I can send them up my usual path.  Just let me know!

Probably best to keep them in your rcu tree, at least I'm not seeing
any conflicts with my for-next with these.

> And I would guess that other hardware and other configurations will
> cause other moles to pop their heads up, but you never know.

Heh yeah I'm sure we'll see some more :)

Tony
