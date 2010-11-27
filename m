From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH v2 1/4] drivers: hwspinlock: add generic framework
Date: Fri, 26 Nov 2010 17:24:47 -0800
Message-ID: <1290821087.2529.252.camel@helium>
References: <AANLkTi=JSuJCqceJ3iw3TnV5OeJd+e5T3CyHtWVzBRu_@mail.gmail.com>
	 <536589.12568.qm@web180310.mail.gq1.yahoo.com>
	 <AANLkTinQdNC0XaOqNyDbdYE6ZcP0QyzpN492j=Kovuea@mail.gmail.com>
	 <1290716548.2529.136.camel@helium>
	 <AANLkTi=sZ-4BBLAJNU5B41cAxtroGkpNomgEYO4vtx8z@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTi=sZ-4BBLAJNU5B41cAxtroGkpNomgEYO4vtx8z@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: MugdhaKamoolkar <mugdha@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>, Tony Lindgren <tony@atomide.com>, BenoitCousson <b-cousson@ti.com>, Grant Likely <grant.likely@secretlab.ca>, HariKanigeri <h-kanigeri2@ti.com>, SumanAnna <s-anna@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-omap@vger.kernel.org

On Fri, 2010-11-26 at 09:34 +0200, Ohad Ben-Cohen wrote:
> On Thu, Nov 25, 2010 at 10:22 PM, David Brownell <david-b@pacbell.net> wrote:
> > So there's no strong reason to think this is
> > actually "ggeneric".  Function names no longer
> > specify OMAP, but without other hardware under
> > the interface, calling it "generic" reflects
> > more optimism than reality.  (That was the
> > implication of my observations...)
> 
> Well, it's not omap-specific anymore.

You haven't (and evidently can't) show non-OMAP hardware under your
calls, though ... so in a practical sense, it's still OMAP-specific code
(since nothing else is working).  (And for that matter, what non-OMAP
code should try using these locks??)

Your intent "generic" is fine, but you've not achieved it and thus I
think you shouldn't imply that you have.   Dropping the word "generic"
should  suffice; it _is_ a framework, and maybe the next person working
with hardware spinlocks can finish generalizing (and add use cases).

> > To find other hardware spinlocks, you might be
> > able to look at fault tolerant multiprocessors.

(For much the same reasons as the various ASMP chips care
about HW spinlocks:...  SMP can use pure software spinlocks, but when
there are special hardware (or system) circumstances, they may not
be sufficiently robust/ or reliable.  (Consider just the impact of
differeent memory and caching models, ARM vs DSP in the OMAP case.

Non-Academic specs on fault tolerant computers may be hard to
come by, unfortunately ... They're very specialized and often
 have lots of funky proprietary logic that vendors don't want
reverse-engineered.  Hardware voting is just the start.  The
software to make the fault tolerance robust/reliable gets to
be very tricky ... and without it, why bother with expensive
hardware mechanisms.

The same issues come up with aerospace and some industrial
systems, where reliability affects mission-readiness and, for
industrial apps, safety.

> > Ages ago I worked with one of those, where any
> > spinlock failures integrated with CPU/OS fault
> > detection; HW cwould yank (checkpointed) CPU boards
> > off the bus so they could be recovered (some
> > might continue later from checkpoints, etc.)...
> 
> Is that HW supported by Linux today ?

Not mainline, and unlikely any branch.  Fault tolerant
operating systems can't be as simple as Linux, and I think
that trying to add fault tolerance to it would not only turn it
into a very different animal, but would lose most developers.

(The mantra I recall was "No single Point Failures".  Linux
has lots of such failure modes, and removing them would be a
multi-year effort, even just inside the kernel.  (How would you
recover from a bus failure?  Fan failure?  Power supply death?
(All such hardware must be duplicated, with recovery supported
by both hardware and software...)  (Where "recover" includes
 "keep running without losing data or other computations.)
(Last I knew, Linux didn't even have much support for checkpoint
and restore of kernel state ... hibernation is related, but
seems to be constantly in flux.  (Don't think it's aiming to
tolerate CPU failures after a hibernation checkpoint either.

(Heck ... on my Ubuntu, "Network Manager" isn't even competent to
switch over cleanly from Ethernet to WLAN (and don't get me talking
about other ways it's broken.  LOTS of stupid fault handling, and
that's arguably mission-critical for the whole system ... multiple
single point failure modes.  That's FAR from fault-tolerant.

> Any chance you can share a link or any other info about it ?

I googled for "sequoia systems fault tolerance" and found some stuff
that looked like it summarized some of the original hardware.

I can't think, off the top of my head, of other kinds of system that
need and use hardware spinlocks, but likely they do exist. (Mainframe
tech might use them too, as part of the subset of fault-tolerant HW
tech they build on. If you want to provide a "generic" framework you
should find and support some (or Tom-Sawyer such support... :)
> 
> >
> > I seem to recall some iterations of the real-time patches doing a lot of
> > work to generalize spinlocks, since they needed multiple variants.  It
> > might be worth following in those footsteps.  (Though I'm not sure they
> > were thinking much about hardware support .
> 
> Any chance you can point me at a specific discussion or patchset that
> you feel may be relevant ?

Haven't looked at RT in a long time.  Just look at the current RT
patchset to see if it still has several spinlock variants.  ISTR the
"raw" spinlock stuff came from there not long ago.  Much compile-time
magic was involved in switching between variants.

- Dave
