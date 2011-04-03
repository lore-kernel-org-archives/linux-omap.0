From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] omap changes for v2.6.39 merge window
Date: Sun, 3 Apr 2011 17:26:37 +0200
Message-ID: <201104031726.37420.arnd@arndb.de>
References: <alpine.LFD.2.00.1103310145390.28032@xanadu.home> <201104020008.16795.arnd@arndb.de> <alpine.LFD.2.00.1104012129320.28032@xanadu.home>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.1104012129320.28032@xanadu.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Detlef Vollmann <dv@vollmann.ch>, Ingo Molnar <mingo@elte.hu>, david@lang.hm, Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, lkml <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, David Brown <davidb@codeaurora.org>, linux-omap@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Saturday 02 April 2011, Nicolas Pitre wrote:
> On Sat, 2 Apr 2011, Arnd Bergmann wrote:
> > On Friday 01 April 2011 21:54:47 Nicolas Pitre wrote:
> > > I however don't think it is practical to go off in a separate 
> > > mach-nocrap space and do things in parallel.  Taking OMAP as an example, 
> > > there is already way too big of an infrastructure in place to simply 
> > > rewrite it in parallel to new OMAP versions coming up.
> > >
> > > It would be more useful and scalable to simply sit down, look at the 
> > > current mess, and identify common patterns that can be easily factored 
> > > out into some shared library code, and all that would be left in the 
> > > board or SOC specific files eventually is the data to register with that 
> > > library code.  Nothing so complicated as grand plans or planification 
> > > that makes it look like a mountain.
> > 
> > This is exactly the question it comes down to. So far, we have focused
> > on cleaning up platforms bit by bit. Given sufficient resources, I'm
> > sure this can work. You assume that continuing on this path is the
> > fastest way to clean up the whole mess, while my suggestion is based
> > on the assumption that we can do better by starting a small fork.
> 
> I don't think any fork would gain any traction.  That would only, heh, 
> fork the work force into two suboptimal branches for quite a while, and 
> given that we're talking about platform code, by the time the new branch 
> is usable and useful the hardware will probably be obsolete.  The only 
> way this may work is for totally new platforms but we're not talking 
> about a fork in that case.

Doing it just for new platforms could be an option if we decide not
to do a fork. The potential danger there is that new platform maintainers
could feel being treated unfairly because they'd have to do much more
work than the existing ones in order to get merged.

> > The things that I see as harder to do are where we need to change the
> > way that parts of the platform code interact with each other:
> > 
> > * platform specific IOMMU interfaces that need to be migrated to common
> >   interfaces
> 
> This can be done by actually forking the platform specific IOMMU code 
> only, just for the time required to migrate drivers to the common 
> interface.

True.

> > * duplicated but slightly different header files in include/mach/
> 
> Oh, actually that's part of the easy problems.  This simply require time 
> to progressively do the boring work.
> 
> With CONFIG_ARM_PATCH_PHYS_VIRT turned on we can get rid of almost all 
> instances of arch/arm/mach-*/include/mach/memory.h already.
> 
> Getting rid of all instances of arch/arm/mach-*/include/mach/vmalloc.h 
> can be trivially achieved by simply moving the VMALLOC_END values into 
> the corresponding struct machine_desc instances.
> 
> And so on for many other files.  This is all necessary for the 
> single-binary multi-SOC kernel work anyway.

I would phrase that differently: There are multiple good reaons why we
want to get rid of conflicting mach/*.h files, but there are at least
two ways to get there.

> > * static platform device definitions that get migrated to device tree
> >   definitions.
> 
> That require some kind of compatibility layer to make the transition 
> transparent to users.  I think Grant had some good ideas for this.

Yes, there are a number of good ideas (device tree fragments,
platform_data constructors, gradually replacing platform data
with properties, and possibly some more things). We'll probably
use a combination of these, and they something is needed either
way. 

> > The example that I have in mind is the time when we had a powerpc and a
> > ppc architecture in parallel, with ppc supporting a lot of hardware
> > that powerpc did not, but all new development getting done on powerpc.
> > 
> > This took years longer than we had expected at first, but I still think
> > it was a helpful fork. On ARM, we are in a much better shape in the
> > core code than what arch/ppc was, so there would be no point forking
> > that, but the problem on the platform code is quite similar.
> 
> Nah, I don't think we want to go there at all. The problem on the 
> platform code is probably much worse on ARM due to the greater diversity 
> of supported hardware.  If on PPC moving stuff across the fork took more 
> time on a year scale than expected, I think that on ARM we would simply 
> never see the end of it.  And the incentive would not really be there 
> either, unlike when the core code is concerned and everyone is affected.

What actually took really long was getting to the point where we
could completely delete the old arch/ppc directory, and we might
never want to do the equivalent here and move all existing platforms
over to common code.

There are a few other examples that were done in a similar way:
* The drivers/ide code still serves a few hardware platforms that
  never had anyone write a new libata code. Libata itself has
  been in a good shape for a long time though.
* Same thing with ALSA: sound/oss is still there for some really
  odd hardware, while ALSA is used everywhere else
* Many of the drivers getting into drivers/staging are so bad that
  they simply get rewritten into a new driver and then deleted,
  like arch/ppc.

We generally try to do gradual cleanups to any kernel code that is
worth keeping, because as you say the duplication itself causes a
lot of friction. For particularly hard cases, doing a replacement
implementation is an exceptional way out. What we need to find a
consensus on is how bad the problem in arch/arm/mach-*/ is:

1. No fundamental problem, just needs some care to clean up (your
   position, I guess), so we do do what we always do and keep doing
   gradual improvements, including treewide API changes.
2. Bad enough that starting a new competing implementation is easier
   because it lets us try different things more easily and reduce
   the number of treewide changes to all existing platforms.
   (this is where I think we are) Like IDE and OSS, the old code
   can still get improved and bug fixed, but concentrating on new
   code gives us better freedom to make progress more quickly.
3. In need of a complete replacement, like arch/ppc and a lot of
   drivers/staging. I'm not arguing that it's that bad.

	Arnd

	Arnd
