From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: Future of resource framework?
Date: Fri, 4 Jun 2010 08:31:49 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0321623820@dbde02.ent.ti.com>
References: <AANLkTilpHjef3xbxB9QN9bj6MFmJA1jMwVxNQyZQcSKy@mail.gmail.com>
	<871vd5kxqg.fsf@deeprootsystems.com>
	<AANLkTinSB0bIorWTwLuNhWC9g4oQArAhx-WdY-K-aadS@mail.gmail.com>,<87hbljisi1.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41405 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756749Ab0FDDB6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jun 2010 23:01:58 -0400
In-Reply-To: <87hbljisi1.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, Mike Chan <mike@android.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>

Kevin Hilman wrote:
> Mike Chan <mike@android.com> writes:
> 
> > On Fri, May 21, 2010 at 9:47 AM, Kevin Hilman
> > <khilman@deeprootsystems.com> wrote:
> >> Mike Chan <mike@android.com> writes:
> >>
> >>> I'm not sure if this has been discussed, yet but since it seems that
> >>> the resource framework will not be making it upstream, I am curious
> >>> what are the replacements under consideration. I am starting to see
> >>> similar issues on other platforms (msm / tegra) so more generic
> >>> (non-omap) solution might be something to consider.
> >>
> >> Hi Mike,
> >>
> >> Which parts of the SRF do you currently use and find useful?  It would
> >> be helpful for us to to understand the parts you see as useful and
> >> potentially helpful to generalize.
> >>
> >
> > Off the top of my head, for Droid specifically, OPP values are useful,
> > although in theory if you changed OPP requests to cpu throughput that
> > might give the equivalent functionality.
> >
> > Memory bus speeds / bandwidth, although its tied to CPU, which
> > ultimately ends up in a cpu speed bump.
> >
> > Although most of the usage I've seen are just hacks, ie: the driver
> > knows it needs 550mhz from the cpu so it will request some bogus
> > value.
> >
> >
> >> As you know, the current implementation has a several layers
> >> and attempts to manage several things: OPPs, latencies etc.
> >>
> >> Our current plans are essentially to break up the "one framework to
> >> rule them all" philosophy and design of SRF and manage the various
> >> pieces by exending other layers such as the new OPP layer and voltage
> >> layers.  Latencies are being managed by the omap_device layer and we
> >> will hopefully have some discussions with the broader linux-pm
> >> community about generalizing that more into the generic driver model
> >> over this year.
> >>
> >
> > Bus speed is a common resource I see for omap / msm / tegra. Clocks
> > for devices also.
> >
> > ie: If I'm doing heavy mem operation and need max memory bus, I might
> > need to request higher performance. (which might mean 600mhz on
> > omap34030, on msm it might mean AXI clock running at 128mhz, and
> > something else on tegra).
> >
> > Or if I'm doing graphics, I may need to up the gfx clock rate, or
> > swich which pll its sourcing etc.. etc..
> >
> > It doesn't look like pm qos has bus support, or even clock support,
> > and this gets tricky if you want something semi-general.
> 
> What we're hoping to work towards (and has come up in the suspend
> blocker related discussions) is moving towards a way to track
> per-device (or per-subsystem) constraints like latency and throughput
> in real world terms (usecs, bytes/sec, etc.) that would be general
> way.
> 
> These constraints would then be visible to the bus- or
> platform-specific code that could make intelligent decisions with them
> (i.e whether or not to raise/lower OPP or bus speed, or whether or not
> to power down a powerdomain etc.)
> 


What if a driver knows that it cannot afford to let the PM layer
turn off the power domain at certain points of time (maybe as long
as a USB cable is connected). How can this be specified in terms
of a latency or throughput constraint?

Just curious, since I don't understand current OMAP3 PM code
as well as I would like to.

- Anand
