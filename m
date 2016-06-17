From: Tony Lindgren <tony@atomide.com>
Subject: Re: ARM and OMAP patches to avoid lockdep complaints
Date: Thu, 16 Jun 2016 21:07:09 -0700
Message-ID: <20160617040708.GA22406@atomide.com>
References: <20160615210926.GA30957@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20160615210926.GA30957@linux.vnet.ibm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, rostedt@goodmis.org, linux@roeck-us.net
List-Id: linux-omap@vger.kernel.org

Hi,

* Paul E. McKenney <paulmck@linux.vnet.ibm.com> [160615 14:11]:
> Hello!
> 
> Ingo was not comfortable taking these through -tip, which is understandable,
> given that they don't depend on each other or on anything else not already
> in mainline, and that they don't have anything to do with -tip.
> 
> So what would you guys like to do with these?

I'll merge it into omap-for-v4.7/fixes thanks.

Regards,

Tony

> They may be pulled from 7c64cc0531fa (arm: Use _rcuidle for
> smp_cross_call() tracepoints) in my -rcu tree:
> 
> 	git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
> 
> 							Thanx, Paul
> 
