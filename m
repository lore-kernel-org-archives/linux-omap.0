From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] omap changes for v2.6.39 merge window
Date: Fri, 1 Apr 2011 13:22:44 +0200
Message-ID: <201104011322.44729.arnd@arndb.de>
References: <201103301906.42429.arnd@arndb.de>
	<201103311723.02301.arnd@arndb.de>
	<1301643157.3393.17.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1301643157.3393.17.camel@deskari>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, david@lang.hm, Russell King - ARM Linux <linux@arm.linux.org.uk>, Nicolas Pitre <nico@fluxnic.net>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, lkml <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, linux-arm-kernel@lists.infradead.org, David Brown <davidb@codeaurora.org>
List-Id: linux-omap@vger.kernel.org

On Friday 01 April 2011, Tomi Valkeinen wrote:
> On Thu, 2011-03-31 at 17:23 +0200, Arnd Bergmann wrote:
> 
> > * The DSS display drivers introduce new infrastructure include new bus
> >   types that have the complexity to make them completely generic, but
> >   in practice can only work on OMAP, and are clearly not written with
> >   cross-vendor abstractions in mind.
> 
> If you mean the panel drivers, then I disagree. They are currently OMAP
> specific, but they are designed so that making them generic shouldn't be
> too difficult. It's been my aim for a long time already to make the
> panel drivers generic, but I've never had time and it's never been quite
> clear to me what would be the best way to do that.
> 
> The core DSS driver is OMAP specific, and while the DSS IP could in
> theory be used in some other platform, that is not currently the case
> and I wouldn't want to needlessly start abstracting things for just the
> sake of abstracting.

Ok, fair enough. I haven't looked at the OMAP DSS code in detail, so
I apologise if I did it injustice. What I did review is the ST Ericsson
MCDE code which was written by taking the OMAP code as an example.

The symptom I'm describing is that infrastructure is getting added
to platform specific code without making clear that it is mean to
be generic. I.e. the code is hidded away in the drivers/video/omap
directory, where other people would not go looking for it.

What I would have hoped you to do is to tell the ST Ericsson people
when they posted their code that they should instead work with you
to integrate the two implementations. As far as I remember (I may be
wrong again), that did not happen.

	Arnd
