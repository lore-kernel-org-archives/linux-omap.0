From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [linux-pm] [PATCH 02/11] PM: extend PM QoS with per-device
 wake-up constraints
Date: Fri, 19 Aug 2011 12:11:04 +0900
Message-ID: <1313723464.19990.124.camel@finisterre.wolfsonmicro.main>
References: <1309446685-17502-1-git-send-email-j-pihet@ti.com>
	 <201108062146.20423.rjw@sisk.pl>
	 <20110807024712.GA5887@opensource.wolfsonmicro.com>
	 <201108082331.35853.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:39627 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751053Ab1HSEqV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Aug 2011 00:46:21 -0400
In-Reply-To: <201108082331.35853.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Kevin Hilman <khilman@ti.com>, markgross@thegnar.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

On Mon, 2011-08-08 at 23:31 +0200, Rafael J. Wysocki wrote:
> On Sunday, August 07, 2011, Mark Brown wrote:

> > OK, so this does sound like there's probably a genuine issue on PCs due
> > to limitations in the environment.  Is it possible to expose these
> > things to userspace in a way that's limited to the affected platforms?

> Well, in principle we could make it depend in CONFIG_ACPI or something like
> this, but I'm not sure that will be well-received. :-)

Or the drivers for the particular buses in use?

> > That does sound like a fair characterization for PCs.  For embedded
> > systems where we have a *much* better knowledge of the hardware we're
> > running on you're just working with the basics of what the hardware
> > needs to run - the hardware needs whatever it needs and no matter what
> > you think of the quality of the hardware there's an expectation that the
> > kernel is ging to be able to work.

> In the particular case in question, though, there's some freedom.  Namely,
> the hardware will work for many different QoS constraints and it's not
> precisely known in principle and upfront which one would be optimal for
> a given workload.

But are these tunings things that we can usefully represent in a generic
API or are they specific parameters of the subsystem in question? I
don't think anyone has suggested that having tuning for things where
there are genuine choices is a good thing.

> > As I've said it's not the fine tuning that I'm worried about, it's the
> > specific mechanism that's being suggested.  Being able to tune things in
> > a way that's relevant to the device being tuned seems entirely sensible.

> Do you know any better mechanism consistent accross all devices?
> Please be specific. :-)

Well, I'm suggesting that we shouldn't have a standard userspace API for
this in the first place but should instead be doing things on the
subsystem or driver level. I'm not sure we can sensibly do anything that
works usefully for all devices.

> > Realistically if you're in a position where you need to work at this
> > very low level on an embedded device you can replace the entire firmware
> > on the device.  We don't want to end up in the situation where we've got
> > kernel support for a device and the only way to get it to actually run
> > sensibly is to install the silicon vendor's proprietary userspace, and
> > we especially don't want to end up in the situation where that userspace
> > is using standard and supported kernel interfaces to do its thing.

> Well, the wakelocks example shows clearly that preventing certain interfaces
> from being merged into mainline doesn't actually prevent people from using
> them in actual products.  I claim it's way better if a vendor uses its
> proprietary user space with the mainline kernel than if that vendor patches
> the kernel and _then_ uses its proprietary user space with it.  Your
> argumentation seems to suggest that we encourage the latter.

We can't stop people doing questionable things out of tree but that
doesn't mean lowering standards in mainline is a good idea. Keeping
things out of tree creates a range of costs - the effort required to
write the code and update for new kernel releases, support issues when
the out of tree code causes problems and so on - and makes it clear to
people using the code where the costs came from. If the code looks like
it's standard code using standard interfaces much of that pressure goes
away.

This is similar to all the stuff that's going on in the ARM tree at the
minute - there's nothing we can do to prevent vendors shipping random
code of any quality in out of tree BSPs but we can set high standards
for the quality of code we accept into mainline and let the resulting
pressures push people towards mainline solutions.

