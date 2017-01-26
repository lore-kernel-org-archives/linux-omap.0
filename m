From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/7] Implement generic regulator constraints parsing for
 ACPI and OF
Date: Wed, 25 Jan 2017 16:33:42 -0800
Message-ID: <20170126003342.GF36291@dtor-ws>
References: <20170125124911.dxveow7bo3zw5jcc@sirena.org.uk>
 <CAJZ5v0hHSadH1KLOGg029VU2qrY900ak0=NnH5HPBKZ=FpB7HQ@mail.gmail.com>
 <CAEGmHFG1d24k3+qT_aoqRmPFzciAbNObCnzY1d8pQWjEW+3HxA@mail.gmail.com>
 <20170125182319.GB25470@leverpostej>
 <20170125182955.uznr5ehpx4dabcon@sirena.org.uk>
 <20170125184432.GA27255@dtor-ws>
 <20170125192711.GB27255@dtor-ws>
 <572bcaff-7b17-0614-0cd2-0887ae33eb65@redhat.com>
 <20170125232755.GC36291@dtor-ws>
 <8e10714e-1795-d5df-630e-8303bf36abfd@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8e10714e-1795-d5df-630e-8303bf36abfd@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Stone <ahs3@redhat.com>
Cc: Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Furquan Shaikh <furquan@chromium.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Liam Girdwood <lgirdwood@gmail.com>, Tony Lindgren <tony@atomide.com>, Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh@kernel.org>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 25, 2017 at 05:15:52PM -0700, Al Stone wrote:
> On 01/25/2017 04:27 PM, Dmitry Torokhov wrote:
> > On Wed, Jan 25, 2017 at 02:44:10PM -0700, Al Stone wrote:
> >>
> >> But, to the point of some of the other discussion on the thread, this ACPI sort
> >> of power management is a very, very different model than DT so that intertwining
> >> the two models is highly unlikely to work, IMHO.
> > 
> > And yet this is something that is sorely needed. If you look, for
> > example, at drivers in drivers/input/*, then all non-SOC-specific
> > devices can easily find their way onto both ACPI-based and DT-based
> > systems (not mentioning legacy-style boards). Having two distinct power
> > schemes implemented in drivers will lead to many problems.
> 
> I really can't speak to those sorts of systems; where I deal with ACPI
> is on enterprise-class server systems which seldom have a graphics card,
> much less input devices other than a keyboard. 

Yeah, so basically no power management except for CPU states ;)

> And in general, those
> systems are required to use only ACPI.  If a vendor wants their device to
> work on such a system, they need to provide a driver that works with ACPI.
> It may also work with DT, but in this environment it doesn't matter.
> 
> Whether or not there are two power schemes is a moot point.  We have DT
> and we have ACPI, and they have very different schemes for power management,
> so we're already there.  And so far, my experience has been that as long as
> the ACPI and DT parts of the driver are kept disjoint when the models diverge,
> and share code when they are semantically absolutely identical, things work
> pretty well.

As someone who's actually shipping both ACPI and DT-based devices
reusing the same peripherals I can assure you that it is really PITA to
have different PM behavior in a single driver and if we can converge on
something sane that would be great.

> 
> > Having unified way of describing hardware is how _DSD came about, right?
> > Nobody wanted to write and maintain and test two separate ways of
> > describing properties when one was already implemented and working.
> 
> I can't speak for those that proposed _DSD to be part of the ACPI spec,
> but no, it was not meant as a unified way of describing hardware, as far
> as I can remember from the ASWG discussions I was part of.  The intent,
> as I recall it, was to provide some of the same flexibility to ASL that
> was available in DT.  At the time, power managment was even discussed as
> one of the areas where the DT model and the ACPI model clashed.

That's not what I remember from discussions at Plumbers/KS... Binding
compatibility, even if for simplest properties, was one of the points.

Thanks.

-- 
Dmitry
