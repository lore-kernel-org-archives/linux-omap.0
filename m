From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/7] Implement generic regulator constraints parsing for ACPI and OF
Date: Thu, 26 Jan 2017 11:35:55 +0100
Message-ID: <3026976.Qjk9AeF3Vr@aspire.rjw.lan>
References: <20170125124911.dxveow7bo3zw5jcc@sirena.org.uk> <8e10714e-1795-d5df-630e-8303bf36abfd@redhat.com> <20170126003342.GF36291@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170126003342.GF36291@dtor-ws>
Sender: linux-acpi-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Al Stone <ahs3@redhat.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Furquan Shaikh <furquan@chromium.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Tony Lindgren <tony@atomide.com>, Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh@kernel.org>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, ACPI
List-Id: linux-omap@vger.kernel.org

On Wednesday, January 25, 2017 04:33:42 PM Dmitry Torokhov wrote:
> On Wed, Jan 25, 2017 at 05:15:52PM -0700, Al Stone wrote:
> > On 01/25/2017 04:27 PM, Dmitry Torokhov wrote:
> > > On Wed, Jan 25, 2017 at 02:44:10PM -0700, Al Stone wrote:
> > >>
> > >> But, to the point of some of the other discussion on the thread, this ACPI sort
> > >> of power management is a very, very different model than DT so that intertwining
> > >> the two models is highly unlikely to work, IMHO.
> > > 
> > > And yet this is something that is sorely needed. If you look, for
> > > example, at drivers in drivers/input/*, then all non-SOC-specific
> > > devices can easily find their way onto both ACPI-based and DT-based
> > > systems (not mentioning legacy-style boards). Having two distinct power
> > > schemes implemented in drivers will lead to many problems.
> > 
> > I really can't speak to those sorts of systems; where I deal with ACPI
> > is on enterprise-class server systems which seldom have a graphics card,
> > much less input devices other than a keyboard. 
> 
> Yeah, so basically no power management except for CPU states ;)
> 
> > And in general, those
> > systems are required to use only ACPI.  If a vendor wants their device to
> > work on such a system, they need to provide a driver that works with ACPI.
> > It may also work with DT, but in this environment it doesn't matter.
> > 
> > Whether or not there are two power schemes is a moot point.  We have DT
> > and we have ACPI, and they have very different schemes for power management,
> > so we're already there.  And so far, my experience has been that as long as
> > the ACPI and DT parts of the driver are kept disjoint when the models diverge,
> > and share code when they are semantically absolutely identical, things work
> > pretty well.
> 
> As someone who's actually shipping both ACPI and DT-based devices
> reusing the same peripherals I can assure you that it is really PITA to
> have different PM behavior in a single driver and if we can converge on
> something sane that would be great.

Agreed.

However, the problem is that PM in ACPI and in the DT-based code is done at
different levels.

ACPI uses the power resource abstraction and D-states to be able to combine
HW control over regulators (think things like MWAIT on Intel CPUs or generally
C-state management done via register wrtites on the CPU) with something that
can be exposed to software.

On the other hand, doing PM at the regulator level pretty much requires that
regulators be only maniplulated directly by software.

The common abstraction can sort of be provided through PM domains, which in the
ACPI case basically map to ACPI power resources and in the OF case genpd is used,
but that doesn't work if drivers expect to be able to control regulators directly
(which BTW isn't an good idea overall IMO, because that may need to be done
differently on different platforms even without ACPI AFAICS).

> > 
> > > Having unified way of describing hardware is how _DSD came about, right?
> > > Nobody wanted to write and maintain and test two separate ways of
> > > describing properties when one was already implemented and working.

So technically, _DSD itself is just a simplified _DSM.  It provides a simplified
interface for what has been possible all the time already anyway.

On top of that, there are _DSD properties, which are defined by the special
UUIDs that we support, and here the idea was to be able to provide information
in a way that resembles DT to be able to avoid artificial code branching in
drivers among other things.

> > I can't speak for those that proposed _DSD to be part of the ACPI spec,
> > but no, it was not meant as a unified way of describing hardware, as far
> > as I can remember from the ASWG discussions I was part of.  The intent,
> > as I recall it, was to provide some of the same flexibility to ASL that
> > was available in DT.  At the time, power managment was even discussed as
> > one of the areas where the DT model and the ACPI model clashed.
> 
> That's not what I remember from discussions at Plumbers/KS... Binding
> compatibility, even if for simplest properties, was one of the points.

The idea was that in the cases in which ACPI didn't provide any specific
frameworks for the given use cases, that would simply help to handle things
in a unified fashion.

Power management is not one of those cases, though.

Thanks,
Rafael

