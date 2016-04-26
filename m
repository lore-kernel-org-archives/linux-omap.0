From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH arm 1/1] arm: Use _rcuidle tracepoint to allow use from
 idle
Date: Tue, 26 Apr 2016 13:11:34 -0700
Message-ID: <20160426201134.GA29779@linux.vnet.ibm.com>
References: <1461617335-22372-1-git-send-email-paulmck@linux.vnet.ibm.com>
 <20160426150031.GP5995@atomide.com>
 <20160426175214.GJ3715@linux.vnet.ibm.com>
 <20160426182939.GO5995@atomide.com>
 <20160426190755.GK3715@linux.vnet.ibm.com>
 <20160426193949.GP5995@atomide.com>
 <20160426154414.7bb33de4@gandalf.local.home>
 <20160426195158.GR5995@atomide.com>
 <20160426200613.GO3715@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160426200613.GO3715@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, mingo@kernel.org, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, Apr 26, 2016 at 01:06:13PM -0700, Paul E. McKenney wrote:
> On Tue, Apr 26, 2016 at 12:51:59PM -0700, Tony Lindgren wrote:
> > * Steven Rostedt <rostedt@goodmis.org> [160426 12:45]:
> > > *Whack* *Whack* *Whack*!!!
> > > 
> > > Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> > > ---
> > > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > > index fb74dc1f7520..4fa43c02d682 100644
> > > --- a/drivers/clk/clk.c
> > > +++ b/drivers/clk/clk.c
> > > @@ -682,12 +682,12 @@ static void clk_core_disable(struct clk_core *core)
> > >  	if (--core->enable_count > 0)
> > >  		return;
> > >  
> > > -	trace_clk_disable(core);
> > > +	trace_clk_disable_rcuidle(core);
> > >  
> > >  	if (core->ops->disable)
> > >  		core->ops->disable(core->hw);
> > >  
> > > -	trace_clk_disable_complete(core);
> > > +	trace_clk_disable_complete_rcuidle(core);
> > >  
> > >  	clk_core_disable(core->parent);
> > >  }
> > 
> > Now the mole shows up here!
> 
> And the patch shows up here!

And I bet you will need this one as well...

							Thanx, Paul

------------------------------------------------------------------------

commit 95dc0699fbaebdb507e8222257ed3b50a13093bf
Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Date:   Tue Apr 26 13:10:21 2016 -0700

    Merge with 718aeef4b4f2 (arm: Use more _rcuidle tracepoints to allow use from idle)
    
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index af4c38d41aff..e4c2b8fdeff3 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -549,7 +549,7 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 	}
 
  out:
-	trace_rpm_return_int(dev, _THIS_IP_, retval);
+	trace_rpm_return_int_rcuidle(dev, _THIS_IP_, retval);
 
 	return retval;
 
