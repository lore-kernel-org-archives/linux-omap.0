From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 22:03:14 +0100
Message-ID: <20100527220314.312d9e3c@lxorguk.ukuu.org.uk>
References: <20100527171644.GA2468@srcf.ucam.org>
	<1274980856.27810.5582.camel@twins>
	<20100527172510.GC2468@srcf.ucam.org>
	<1274981288.27810.5609.camel@twins>
	<20100527173218.GF2468@srcf.ucam.org>
	<1274981750.27810.5641.camel@twins>
	<20100527174140.GB3187@srcf.ucam.org>
	<1274982397.27810.5679.camel@twins>
	<20100527175258.GB3543@srcf.ucam.org>
	<1274982981.27810.5719.camel@twins>
	<20100527175920.GE3543@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100527175920.GE3543@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux@smtp1.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>, List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, felipe.balbi@nokia.com
List-Id: linux-omap@vger.kernel.org

On Thu, 27 May 2010 18:59:20 +0100
Matthew Garrett <mjg59@srcf.ucam.org> wrote:

> On Thu, May 27, 2010 at 07:56:21PM +0200, Peter Zijlstra wrote:
> > On Thu, 2010-05-27 at 18:52 +0100, Matthew Garrett wrote:
> > 
> > > If that's what you're aiming for then you don't need to block 
> > > applications on hardware access because they should all already have 
> > > idled themselves.
> > 
> > Correct, a well behaved app would have. I thought we all agreed that
> > well behaved apps weren't the problem?
> 
> Ok. So the existing badly-behaved application ignores your request and 
> then gets blocked. And now it no longer responds to wakeup events. So 
> you penalise well-behaved applications without providing any benefits to 
> badly-behaved ones.

I don't see how you put the first two sentences together and get the
final one.

When you beat up badly behaved apps that doesn't penalise well behaved
ones.

Forcing "well behaved apps" to make hundreds of extra calls to a complex
blocker interface that also requires tons of kernel code and requires the
application know platform policy and be recompiled if it changes - now
that is punishing well behaved apps.

A well behaved app should just work using standard existing APIs because
that is how all the standard current well behaved apps are written [1].

Alan
--
[1] I'm dying to see the suspend blocker patch for evolution ;)
