From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH arm 1/1] arm: Use _rcuidle tracepoint to allow use from
 idle
Date: Tue, 26 Apr 2016 14:26:30 -0700
Message-ID: <20160426212630.GV3715@linux.vnet.ibm.com>
References: <20160426193949.GP5995@atomide.com>
 <20160426154414.7bb33de4@gandalf.local.home>
 <20160426195158.GR5995@atomide.com>
 <20160426200613.GO3715@linux.vnet.ibm.com>
 <20160426201134.GA29779@linux.vnet.ibm.com>
 <20160426202538.GS5995@atomide.com>
 <20160426204148.GR3715@linux.vnet.ibm.com>
 <20160426204613.GT5995@atomide.com>
 <20160426210407.GT3715@linux.vnet.ibm.com>
 <20160426211259.GU5995@atomide.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160426211259.GU5995@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, linux-omap@vger.kernel.org, mingo@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, Apr 26, 2016 at 02:12:59PM -0700, Tony Lindgren wrote:
> * Paul E. McKenney <paulmck@linux.vnet.ibm.com> [160426 14:08]:
> > On Tue, Apr 26, 2016 at 01:46:15PM -0700, Tony Lindgren wrote:
> > > * Paul E. McKenney <paulmck@linux.vnet.ibm.com> [160426 13:42]:
> > > > On Tue, Apr 26, 2016 at 01:25:39PM -0700, Tony Lindgren wrote:
> > > > > * Paul E. McKenney <paulmck@linux.vnet.ibm.com> [160426 13:12]:
> > > > > > On Tue, Apr 26, 2016 at 01:06:13PM -0700, Paul E. McKenney wrote:
> > > > > > > On Tue, Apr 26, 2016 at 12:51:59PM -0700, Tony Lindgren wrote:
> > > > > > > > * Steven Rostedt <rostedt@goodmis.org> [160426 12:45]:
> > > > > > > > > *Whack* *Whack* *Whack*!!!
> > > > > > > > > 
> > > > > > > > > Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> > > > > > > > > ---
> > > > > > > > > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > > > > > > > > index fb74dc1f7520..4fa43c02d682 100644
> > > > > > > > > --- a/drivers/clk/clk.c
> > > > > > > > > +++ b/drivers/clk/clk.c
> > > > > > > > > @@ -682,12 +682,12 @@ static void clk_core_disable(struct clk_core *core)
> > > > > > > > >  	if (--core->enable_count > 0)
> > > > > > > > >  		return;
> > > > > > > > >  
> > > > > > > > > -	trace_clk_disable(core);
> > > > > > > > > +	trace_clk_disable_rcuidle(core);
> > > > > > > > >  
> > > > > > > > >  	if (core->ops->disable)
> > > > > > > > >  		core->ops->disable(core->hw);
> > > > > > > > >  
> > > > > > > > > -	trace_clk_disable_complete(core);
> > > > > > > > > +	trace_clk_disable_complete_rcuidle(core);
> > > > > > > > >  
> > > > > > > > >  	clk_core_disable(core->parent);
> > > > > > > > >  }
> > > > > > > > 
> > > > > > > > Now the mole shows up here!
> > > > > > > 
> > > > > > > And the patch shows up here!
> > > > > > 
> > > > > > And I bet you will need this one as well...
> > > > > 
> > > > > OK and now the mode is coming back after a short nap during idle:
> > > > 
> > > > Seems a bit unfair to whack it just after a short nap, but here goes!
> > > 
> > > This mode seems pretty hard headed :) Now clk_core_enable:
> > 
> > Nah, just a lot of heads...
> 
> OK that does it for me. Thanks for all the mole related whacks,
> please feel free to add:
> 
> Tested-by: Tony Lindgren <tony@atomide.com>

Done!  These are at -rcu:

6eeec2b4a50c (arm: Use _rcuidle tracepoint to allow use from idle)
0efee3da3b29 (arm: Use more _rcuidle tracepoints to allow use from idle)
b6cdf6d22f52 (arm: Additional _rcuidle tracepoints to allow use from idle)
70da6fb7275b (arm: Whack another event-trace-from-idle mole)
019db9102c6c (arm: Whack yet another event-trace-from-idle mole)
ebcd2861ae27 (arm: Whack an expected event-trace-from-idle mole)

So how would you like these handled?  I would be happy to send a fresh
patch series or git pull request if you would like to send them up your
tree, or I can send them up my usual path.  Just let me know!

And I would guess that other hardware and other configurations will
cause other moles to pop their heads up, but you never know.

							Thanx, Paul
