From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: rcu self-detected stall messages on OMAP3, 4 boards
Date: Fri, 21 Sep 2012 15:12:41 -0700
Message-ID: <20120921221241.GA7800@linux.vnet.ibm.com>
References: <20120920000351.GI2455@linux.vnet.ibm.com>
 <alpine.DEB.2.00.1209200753450.3801@utopia.booyaka.com>
 <F95344A7-3351-4E6B-BF61-37E591AF16A2@ti.com>
 <20120920220130.GN2449@linux.vnet.ibm.com>
 <alpine.DEB.2.00.1209202244470.32589@utopia.booyaka.com>
 <20120920232114.GO2449@linux.vnet.ibm.com>
 <alpine.DEB.2.00.1209211803290.8839@utopia.booyaka.com>
 <20120921185827.GC2454@linux.vnet.ibm.com>
 <alpine.DEB.2.00.1209211900520.8839@utopia.booyaka.com>
 <20120921195717.GD2454@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120921195717.GD2454@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Bruce, Becky" <bbruce@ti.com>, "Paul E. McKenney" <paul.mckenney@linaro.org>, "<linux-kernel@vger.kernel.org>" <linux-kernel@vger.kernel.org>, "<linux-omap@vger.kernel.org>" <linux-omap@vger.kernel.org>, "<linux-arm-kernel@lists.infradead.org>" <linux-arm-kernel@lists.infradead.org>, "Hilman, Kevin" <khilman@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Hunter, Jon" <jon-hunter@ti.com>, "<snijsure@grid-net.com>" <snijsure@grid-net.com>, fweisbec@gmail.com
List-Id: linux-omap@vger.kernel.org

On Fri, Sep 21, 2012 at 12:57:17PM -0700, Paul E. McKenney wrote:
> On Fri, Sep 21, 2012 at 07:11:14PM +0000, Paul Walmsley wrote:
> > On Fri, 21 Sep 2012, Paul E. McKenney wrote:

[ . . . ]

> > > I may take your advice of remote access to a Panda board, though that
> > > is likely to take a bit of time due to timezones.  Regardless of the
> > > underlying issue here, I clearly need to make the stall-warning messages
> > > do a better job of printing out needed information.
> > 
> > If you've got a patch in mind for that, I'll boot it here.
> 
> Hammering it out, will send it along when it is a bit less destructive.  ;-)

And I eventually decided to keep things simple, please see below.
This applies on top of https://lkml.org/lkml/2012/8/30/290.

							Thanx, Paul

------------------------------------------------------------------------

rcu: Add grace-period information to RCU CPU stall warnings

This commit causes the last grace period started and completed to be
printed on RCU CPU stall warning messages in order to aid diagnosis.

Signed-off-by: Paul E. McKenney <paul.mckenney@linaro.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

diff --git a/kernel/rcutree.c b/kernel/rcutree.c
index cdaa7aa..fdb6854 100644
--- a/kernel/rcutree.c
+++ b/kernel/rcutree.c
@@ -925,8 +925,9 @@ static void print_other_cpu_stall(struct rcu_state *rsp)
 	raw_spin_unlock_irqrestore(&rnp->lock, flags);
 
 	print_cpu_stall_info_end();
-	printk(KERN_CONT "(detected by %d, t=%ld jiffies)\n",
-	       smp_processor_id(), (long)(jiffies - rsp->gp_start));
+	pr_cont("(detected by %d, t=%ld jiffies, g=%lu, c=%lu)\n",
+	       smp_processor_id(), (long)(jiffies - rsp->gp_start),
+	       rsp->gpnum, rsp->completed);
 	if (ndetected == 0)
 		printk(KERN_ERR "INFO: Stall ended before state dump start\n");
 	else if (!trigger_all_cpu_backtrace())
@@ -953,7 +954,8 @@ static void print_cpu_stall(struct rcu_state *rsp)
 	print_cpu_stall_info_begin();
 	print_cpu_stall_info(rsp, smp_processor_id());
 	print_cpu_stall_info_end();
-	printk(KERN_CONT " (t=%lu jiffies)\n", jiffies - rsp->gp_start);
+	pr_cont(" (t=%lu jiffies g=%lu c=%lu)\n",
+		jiffies - rsp->gp_start, rsp->gpnum, rsp->completed);
 	if (!trigger_all_cpu_backtrace())
 		dump_stack();
 
