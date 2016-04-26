From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH arm 1/1] arm: Use _rcuidle tracepoint to allow use from
 idle
Date: Tue, 26 Apr 2016 14:12:59 -0700
Message-ID: <20160426211259.GU5995@atomide.com>
References: <20160426190755.GK3715@linux.vnet.ibm.com>
 <20160426193949.GP5995@atomide.com>
 <20160426154414.7bb33de4@gandalf.local.home>
 <20160426195158.GR5995@atomide.com>
 <20160426200613.GO3715@linux.vnet.ibm.com>
 <20160426201134.GA29779@linux.vnet.ibm.com>
 <20160426202538.GS5995@atomide.com>
 <20160426204148.GR3715@linux.vnet.ibm.com>
 <20160426204613.GT5995@atomide.com>
 <20160426210407.GT3715@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160426210407.GT3715@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, linux-omap@vger.kernel.org, mingo@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Paul E. McKenney <paulmck@linux.vnet.ibm.com> [160426 14:08]:
> On Tue, Apr 26, 2016 at 01:46:15PM -0700, Tony Lindgren wrote:
> > * Paul E. McKenney <paulmck@linux.vnet.ibm.com> [160426 13:42]:
> > > On Tue, Apr 26, 2016 at 01:25:39PM -0700, Tony Lindgren wrote:
> > > > * Paul E. McKenney <paulmck@linux.vnet.ibm.com> [160426 13:12]:
> > > > > On Tue, Apr 26, 2016 at 01:06:13PM -0700, Paul E. McKenney wrote:
> > > > > > On Tue, Apr 26, 2016 at 12:51:59PM -0700, Tony Lindgren wrote:
> > > > > > > * Steven Rostedt <rostedt@goodmis.org> [160426 12:45]:
> > > > > > > > *Whack* *Whack* *Whack*!!!
> > > > > > > > 
> > > > > > > > Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> > > > > > > > ---
> > > > > > > > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > > > > > > > index fb74dc1f7520..4fa43c02d682 100644
> > > > > > > > --- a/drivers/clk/clk.c
> > > > > > > > +++ b/drivers/clk/clk.c
> > > > > > > > @@ -682,12 +682,12 @@ static void clk_core_disable(struct clk_core *core)
> > > > > > > >  	if (--core->enable_count > 0)
> > > > > > > >  		return;
> > > > > > > >  
> > > > > > > > -	trace_clk_disable(core);
> > > > > > > > +	trace_clk_disable_rcuidle(core);
> > > > > > > >  
> > > > > > > >  	if (core->ops->disable)
> > > > > > > >  		core->ops->disable(core->hw);
> > > > > > > >  
> > > > > > > > -	trace_clk_disable_complete(core);
> > > > > > > > +	trace_clk_disable_complete_rcuidle(core);
> > > > > > > >  
> > > > > > > >  	clk_core_disable(core->parent);
> > > > > > > >  }
> > > > > > > 
> > > > > > > Now the mole shows up here!
> > > > > > 
> > > > > > And the patch shows up here!
> > > > > 
> > > > > And I bet you will need this one as well...
> > > > 
> > > > OK and now the mode is coming back after a short nap during idle:
> > > 
> > > Seems a bit unfair to whack it just after a short nap, but here goes!
> > 
> > This mode seems pretty hard headed :) Now clk_core_enable:
> 
> Nah, just a lot of heads...

OK that does it for me. Thanks for all the mole related whacks,
please feel free to add:

Tested-by: Tony Lindgren <tony@atomide.com>
