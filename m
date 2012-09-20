From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: rcu self-detected stall messages on OMAP3, 4 boards
Date: Thu, 20 Sep 2012 16:21:14 -0700
Message-ID: <20120920232114.GO2449@linux.vnet.ibm.com>
References: <alpine.DEB.2.00.1209122237080.7275@utopia.booyaka.com>
 <20120913011208.GT4257@linux.vnet.ibm.com>
 <alpine.DEB.2.00.1209131839000.23318@utopia.booyaka.com>
 <20120920000351.GI2455@linux.vnet.ibm.com>
 <alpine.DEB.2.00.1209200753450.3801@utopia.booyaka.com>
 <F95344A7-3351-4E6B-BF61-37E591AF16A2@ti.com>
 <20120920220130.GN2449@linux.vnet.ibm.com>
 <alpine.DEB.2.00.1209202244470.32589@utopia.booyaka.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1209202244470.32589@utopia.booyaka.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "<snijsure@grid-net.com>" <snijsure@grid-net.com>, "Bruce,
 Becky" <bbruce@ti.com>, "<linux-kernel@vger.kernel.org>" <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paul.mckenney@linaro.org>, "Shilimkar,
 Santosh" <santosh.shilimkar@ti.com>, "Hunter, Jon" <jon-hunter@ti.com>, "<linux-omap@vger.kernel.org>" <linux-omap@vger.kernel.org>, "<linux-arm-kernel@lists.infradead.org>" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Sep 20, 2012 at 10:47:25PM +0000, Paul Walmsley wrote:
> On Thu, 20 Sep 2012, Paul E. McKenney wrote:
> 
> > On Thu, Sep 20, 2012 at 09:49:13PM +0000, Bruce, Becky wrote:
> >
> > > OK, people, you can stop heckling me about "sent from my iPhone" - I'm in the wilds of rural Louisiana with really bad internet service and was trying to work on my phone (but, alas, did not notice the CC list included the entire universe).   Shame on me.
> > > 
> > > With the above set, I don't seem to see any stalls with the RCU timeout set to 60s (the default).  I left the board running for 25 minutes; I will fire it up again later and let it run for a bit longer, but usually I end up seeing the problem pretty quickly so I don't expect that to result in anything.  I also didn't see any stalls on Paul's RCU tree as of a week ago at 60s, so as far as I can tell the CPU_IDLE stuff didn't have any impact (it wasn't on when I tested Paul's tree).
> > > 
> > > If I drop the timeout to 5s as Paul M. suggested for debug a while back, I do see stalls (both with CPU_IDLE stuff and without). 
> > > 
> > > I'm using the default omap2plus config, with RCU stall info enabled and the cpu idle stuff turned on (console dump below).  This is a Panda ES 1.1 (OMAP4460)
> > 
> > Thank you for the testing, Becky!
> > 
> > Paul Walmsley, please let me know if the config below doesn't clear things
> > up for you or if there is some reason why this config is infeasible.
> 
> Will certainly test it here once things settle down.  But I wouldn't 
> consider the use of CONFIG_CPU_IDLE to be a 'fix' until the problem can be 
> understood.  We use !CONFIG_CPU_IDLE kernels for testing here.

Fair point.  I am wondering whether there is some path into the idle
loop that somehow avoids telling RCU that the CPU has in face entered
idle.  There needs to be an rcu_idle_enter() call on the way to idle,
otherwise RCU CPU stall warnings are expected behavior.

							Thanx, Paul
