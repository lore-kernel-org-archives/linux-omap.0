From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [GIT PULL] omap changes for v2.6.39 merge window
Date: Wed, 30 Mar 2011 23:10:10 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1103302155270.22418@localhost6.localdomain6>
References: <20110317183048.GW7258@atomide.com>
	<AANLkTimWbb5DWiiCW821H6pRicbk1fS3PYcnGyUMznvM@mail.gmail.com>
	<20110318101512.GA15375@n2100.arm.linux.org.uk>
	<201103301906.42429.arnd@arndb.de>
	<AANLkTim578-kwM14SJd06RW_QiC4WVCmFuG+ASgGC4sq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <AANLkTim578-kwM14SJd06RW_QiC4WVCmFuG+ASgGC4sq@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, LKML <linux-kernel@vger.kernel.org>, David Brown <davidb@codeaurora.org>, linux-omap@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, 30 Mar 2011, Linus Torvalds wrote:
> On Wed, Mar 30, 2011 at 10:06 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > I'm still new to the ARM world, but I think one real problem is the way
> > that all platforms have their own trees with a very flat hierarchy --
> > a lot of people directly ask Linus to pull their trees, and the main
> > way to sort out conflicts is linux-next. The number of platforms in the
> > ARM arch is still increasing, so I assume that this only gets worse.
> 
> Because as far as I can tell, most of that board support really is
> about crazy details that the kernel shouldn't even care about. Come up
> with a table that describes them, have one common parsing routine, and
> push the table into a bootloader. And get rid of having to add a board
> file for every crazy random piece of hardware that nobody really cares
> about.

There is effort on the way to address that with device tree support,
but that wont solve the other problem Arnd mentioned.

Let me phrase it different.

The main problem is NOT that these things conflict, the main problem -
and I can tell you after working through all that irq/gpio/mfd
sh*tpile - is that these subarchs start a life on their own and find
tons of creative ways to work around shortcomings of infrastructure
code up to the point where infrastructure code cannot be changed
anymore w/o breaking the world and some more. There is a f*cking good
reason why I made myself run through all that horror. These
shortcomings are partially real, but most of the time the failure is
on those folks simply because they do not understand how it works. If
the shortcoming is real they fail to talk to the infrastructure
maintainers and just hack something which boots.

The ARM core code and CPU/TLB/CACHE abnominations handling which is in
Russell's hands is working very well. Piling the babysitting of
sub-arch support onto Russell as well simply cannot scale, as the
whole madness of inconsistency of the ARM core architecture itself is
a full time job on it's own.

Watching the rapidly increasing number of SoCs which are spilling out
in the ARM ecosystem and their totaly non-architected "glue together
random IP cores" philosophy, I' convinced that we need a full-time
gatekeeper who babysits the subarch stuff and keeps an eye on those
ever repeating failure patterns and works on resolving them.

The only problem is to find a person, who is willing to do that, has
enough experience, broad shoulders and a strong accepted voice. Not to
talk about finding someone who is willing to pay a large enough
compensation for pain and suffering.

This is getting worse now as there seems to be a strong incentive to
get all that vendor BSP crap into mainline and I did a couple of
reviews in the last months which were more than frustrating. Running
through a 10 rounds review for a 200 lines driver is not really
encouraging - though at least the review prevented that a 1000 lines
horror crap got merged. I don't blame those people too much as they
have been thrown into Linux development after dealing with black hole
OS cores for years and therefor being spoiled with the thought of
"work around the failure / missing feature" somehow w/o the ability to
talk to anyone about it. That's a system failure of the established
commercial OS world and it will take some time to show those people
that it can be solved different. But that takes quite some manpower.

So one person will be not enough, that needs to be a whole team of
experienced people in the very near future to deal with the massive
tsunami of crap which is targeted at mainline. If we fail to set that
up, then we run into a very ugly maintainability issue in no time.

Thanks,

	tglx
